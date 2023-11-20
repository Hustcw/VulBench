SwsContext *sws_getContext(int srcW, int srcH, enum PixelFormat srcFormat, int dstW, int dstH, enum PixelFormat dstFormat, int flags,
                           SwsFilter *srcFilter, SwsFilter *dstFilter, const double *param)
{

    SwsContext *c;
    int i;
    int usesVFilter, usesHFilter;
    int unscaled, needsDither;
    int srcRange, dstRange;
    SwsFilter dummyFilter= {NULL, NULL, NULL, NULL};
#if ARCH_X86
    if (flags & SWS_CPU_CAPS_MMX)
        __asm__ volatile("emms\n\t"::: "memory");
#endif

#if !CONFIG_RUNTIME_CPUDETECT //ensure that the flags match the compiled variant if cpudetect is off
    flags &= ~(SWS_CPU_CAPS_MMX|SWS_CPU_CAPS_MMX2|SWS_CPU_CAPS_3DNOW|SWS_CPU_CAPS_ALTIVEC|SWS_CPU_CAPS_BFIN);
#if   COMPILE_TEMPLATE_MMX2
    flags |= SWS_CPU_CAPS_MMX|SWS_CPU_CAPS_MMX2;
#elif COMPILE_TEMPLATE_AMD3DNOW
    flags |= SWS_CPU_CAPS_MMX|SWS_CPU_CAPS_3DNOW;
#elif COMPILE_TEMPLATE_MMX
    flags |= SWS_CPU_CAPS_MMX;
#elif COMPILE_TEMPLATE_ALTIVEC
    flags |= SWS_CPU_CAPS_ALTIVEC;
#elif ARCH_BFIN
    flags |= SWS_CPU_CAPS_BFIN;
#endif
#endif /* CONFIG_RUNTIME_CPUDETECT */
    if (clip_table[512] != 255) globalInit();
    if (!rgb15to16) sws_rgb2rgb_init(flags);

    unscaled = (srcW == dstW && srcH == dstH);
    needsDither= (isBGR(dstFormat) || isRGB(dstFormat))
        && (fmt_depth(dstFormat))<24
        && ((fmt_depth(dstFormat))<(fmt_depth(srcFormat)) || (!(isRGB(srcFormat) || isBGR(srcFormat))));

    srcRange = handle_jpeg(&srcFormat);
    dstRange = handle_jpeg(&dstFormat);

    if (!isSupportedIn(srcFormat)) {
        av_log(NULL, AV_LOG_ERROR, "swScaler: %s is not supported as input pixel format\n", sws_format_name(srcFormat));
        return NULL;
    }
    if (!isSupportedOut(dstFormat)) {
        av_log(NULL, AV_LOG_ERROR, "swScaler: %s is not supported as output pixel format\n", sws_format_name(dstFormat));
        return NULL;
    }

    i= flags & ( SWS_POINT
                |SWS_AREA
                |SWS_BILINEAR
                |SWS_FAST_BILINEAR
                |SWS_BICUBIC
                |SWS_X
                |SWS_GAUSS
                |SWS_LANCZOS
                |SWS_SINC
                |SWS_SPLINE
                |SWS_BICUBLIN);
    if(!i || (i & (i-1))) {
        av_log(NULL, AV_LOG_ERROR, "swScaler: Exactly one scaler algorithm must be chosen\n");
        return NULL;
    }

    /* sanity check */
    if (srcW<4 || srcH<1 || dstW<8 || dstH<1) { //FIXME check if these are enough and try to lowwer them after fixing the relevant parts of the code
        av_log(NULL, AV_LOG_ERROR, "swScaler: %dx%d -> %dx%d is invalid scaling dimension\n",
               srcW, srcH, dstW, dstH);
        return NULL;
    }
    if(srcW > VOFW || dstW > VOFW) {
        av_log(NULL, AV_LOG_ERROR, "swScaler: Compile-time maximum width is "AV_STRINGIFY(VOFW)" change VOF/VOFW and recompile\n");
        return NULL;
    }

    if (!dstFilter) dstFilter= &dummyFilter;
    if (!srcFilter) srcFilter= &dummyFilter;

    c= av_mallocz(sizeof(SwsContext));

    c->av_class = &sws_context_class;
    c->srcW= srcW;
    c->srcH= srcH;
    c->dstW= dstW;
    c->dstH= dstH;
    c->lumXInc= ((srcW<<16) + (dstW>>1))/dstW;
    c->lumYInc= ((srcH<<16) + (dstH>>1))/dstH;
    c->flags= flags;
    c->dstFormat= dstFormat;
    c->srcFormat= srcFormat;
    c->vRounder= 4* 0x0001000100010001ULL;

    usesHFilter= usesVFilter= 0;
    if (dstFilter->lumV && dstFilter->lumV->length>1) usesVFilter=1;
    if (dstFilter->lumH && dstFilter->lumH->length>1) usesHFilter=1;
    if (dstFilter->chrV && dstFilter->chrV->length>1) usesVFilter=1;
    if (dstFilter->chrH && dstFilter->chrH->length>1) usesHFilter=1;
    if (srcFilter->lumV && srcFilter->lumV->length>1) usesVFilter=1;
    if (srcFilter->lumH && srcFilter->lumH->length>1) usesHFilter=1;
    if (srcFilter->chrV && srcFilter->chrV->length>1) usesVFilter=1;
    if (srcFilter->chrH && srcFilter->chrH->length>1) usesHFilter=1;

    getSubSampleFactors(&c->chrSrcHSubSample, &c->chrSrcVSubSample, srcFormat);
    getSubSampleFactors(&c->chrDstHSubSample, &c->chrDstVSubSample, dstFormat);

    // reuse chroma for 2 pixels RGB/BGR unless user wants full chroma interpolation
    if ((isBGR(dstFormat) || isRGB(dstFormat)) && !(flags&SWS_FULL_CHR_H_INT)) c->chrDstHSubSample=1;

    // drop some chroma lines if the user wants it
    c->vChrDrop= (flags&SWS_SRC_V_CHR_DROP_MASK)>>SWS_SRC_V_CHR_DROP_SHIFT;
    c->chrSrcVSubSample+= c->vChrDrop;

    // drop every other pixel for chroma calculation unless user wants full chroma
    if ((isBGR(srcFormat) || isRGB(srcFormat)) && !(flags&SWS_FULL_CHR_H_INP)
      && srcFormat!=PIX_FMT_RGB8      && srcFormat!=PIX_FMT_BGR8
      && srcFormat!=PIX_FMT_RGB4      && srcFormat!=PIX_FMT_BGR4
      && srcFormat!=PIX_FMT_RGB4_BYTE && srcFormat!=PIX_FMT_BGR4_BYTE
      && ((dstW>>c->chrDstHSubSample) <= (srcW>>1) || (flags&(SWS_FAST_BILINEAR|SWS_POINT))))
        c->chrSrcHSubSample=1;

    if (param) {
        c->param[0] = param[0];
        c->param[1] = param[1];
    } else {
        c->param[0] =
        c->param[1] = SWS_PARAM_DEFAULT;
    }

    // Note the -((-x)>>y) is so that we always round toward +inf.
    c->chrSrcW= -((-srcW) >> c->chrSrcHSubSample);
    c->chrSrcH= -((-srcH) >> c->chrSrcVSubSample);
    c->chrDstW= -((-dstW) >> c->chrDstHSubSample);
    c->chrDstH= -((-dstH) >> c->chrDstVSubSample);

    sws_setColorspaceDetails(c, ff_yuv2rgb_coeffs[SWS_CS_DEFAULT], srcRange, ff_yuv2rgb_coeffs[SWS_CS_DEFAULT] /* FIXME*/, dstRange, 0, 1<<16, 1<<16);

    /* unscaled special cases */
    if (unscaled && !usesHFilter && !usesVFilter && (srcRange == dstRange || isBGR(dstFormat) || isRGB(dstFormat))) {
        /* yv12_to_nv12 */
        if ((srcFormat == PIX_FMT_YUV420P || srcFormat == PIX_FMT_YUVA420P) && (dstFormat == PIX_FMT_NV12 || dstFormat == PIX_FMT_NV21)) {
            c->swScale= PlanarToNV12Wrapper;
        }
        /* yuv2bgr */
        if ((srcFormat==PIX_FMT_YUV420P || srcFormat==PIX_FMT_YUV422P || srcFormat==PIX_FMT_YUVA420P) && (isBGR(dstFormat) || isRGB(dstFormat))
            && !(flags & SWS_ACCURATE_RND) && !(dstH&1)) {
            c->swScale= ff_yuv2rgb_get_func_ptr(c);
        }

        if (srcFormat==PIX_FMT_YUV410P && (dstFormat==PIX_FMT_YUV420P || dstFormat==PIX_FMT_YUVA420P) && !(flags & SWS_BITEXACT)) {
            c->swScale= yvu9toyv12Wrapper;
        }

        /* bgr24toYV12 */
        if (srcFormat==PIX_FMT_BGR24 && (dstFormat==PIX_FMT_YUV420P || dstFormat==PIX_FMT_YUVA420P) && !(flags & SWS_ACCURATE_RND))
            c->swScale= bgr24toyv12Wrapper;

        /* RGB/BGR -> RGB/BGR (no dither needed forms) */
        if (  (isBGR(srcFormat) || isRGB(srcFormat))
           && (isBGR(dstFormat) || isRGB(dstFormat))
           && srcFormat != PIX_FMT_BGR8      && dstFormat != PIX_FMT_BGR8
           && srcFormat != PIX_FMT_RGB8      && dstFormat != PIX_FMT_RGB8
           && srcFormat != PIX_FMT_BGR4      && dstFormat != PIX_FMT_BGR4
           && srcFormat != PIX_FMT_RGB4      && dstFormat != PIX_FMT_RGB4
           && srcFormat != PIX_FMT_BGR4_BYTE && dstFormat != PIX_FMT_BGR4_BYTE
           && srcFormat != PIX_FMT_RGB4_BYTE && dstFormat != PIX_FMT_RGB4_BYTE
           && srcFormat != PIX_FMT_MONOBLACK && dstFormat != PIX_FMT_MONOBLACK
           && srcFormat != PIX_FMT_MONOWHITE && dstFormat != PIX_FMT_MONOWHITE
                                             && dstFormat != PIX_FMT_RGB32_1
                                             && dstFormat != PIX_FMT_BGR32_1
           && srcFormat != PIX_FMT_RGB48LE   && dstFormat != PIX_FMT_RGB48LE
           && srcFormat != PIX_FMT_RGB48BE   && dstFormat != PIX_FMT_RGB48BE
           && (!needsDither || (c->flags&(SWS_FAST_BILINEAR|SWS_POINT))))
             c->swScale= rgb2rgbWrapper;

        if ((usePal(srcFormat) && (
                 dstFormat == PIX_FMT_RGB32   ||
                 dstFormat == PIX_FMT_RGB32_1 ||
                 dstFormat == PIX_FMT_RGB24   ||
                 dstFormat == PIX_FMT_BGR32   ||
                 dstFormat == PIX_FMT_BGR32_1 ||
                 dstFormat == PIX_FMT_BGR24)))
             c->swScale= pal2rgbWrapper;

        if (srcFormat == PIX_FMT_YUV422P) {
            if (dstFormat == PIX_FMT_YUYV422)
                c->swScale= YUV422PToYuy2Wrapper;
            else if (dstFormat == PIX_FMT_UYVY422)
                c->swScale= YUV422PToUyvyWrapper;
        }

        /* LQ converters if -sws 0 or -sws 4*/
        if (c->flags&(SWS_FAST_BILINEAR|SWS_POINT)) {
            /* yv12_to_yuy2 */
            if (srcFormat == PIX_FMT_YUV420P || srcFormat == PIX_FMT_YUVA420P) {
                if (dstFormat == PIX_FMT_YUYV422)
                    c->swScale= PlanarToYuy2Wrapper;
                else if (dstFormat == PIX_FMT_UYVY422)
                    c->swScale= PlanarToUyvyWrapper;
            }
        }
        if(srcFormat == PIX_FMT_YUYV422 && (dstFormat == PIX_FMT_YUV420P || dstFormat == PIX_FMT_YUVA420P))
            c->swScale= YUYV2YUV420Wrapper;
        if(srcFormat == PIX_FMT_UYVY422 && (dstFormat == PIX_FMT_YUV420P || dstFormat == PIX_FMT_YUVA420P))
            c->swScale= UYVY2YUV420Wrapper;
        if(srcFormat == PIX_FMT_YUYV422 && dstFormat == PIX_FMT_YUV422P)
            c->swScale= YUYV2YUV422Wrapper;
        if(srcFormat == PIX_FMT_UYVY422 && dstFormat == PIX_FMT_YUV422P)
            c->swScale= UYVY2YUV422Wrapper;

#ifdef COMPILE_ALTIVEC
        if ((c->flags & SWS_CPU_CAPS_ALTIVEC) &&
            !(c->flags & SWS_BITEXACT) &&
            srcFormat == PIX_FMT_YUV420P) {
          // unscaled YV12 -> packed YUV, we want speed
          if (dstFormat == PIX_FMT_YUYV422)
              c->swScale= yv12toyuy2_unscaled_altivec;
          else if (dstFormat == PIX_FMT_UYVY422)
              c->swScale= yv12touyvy_unscaled_altivec;
        }
#endif

        /* simple copy */
        if (  srcFormat == dstFormat
            || (srcFormat == PIX_FMT_YUVA420P && dstFormat == PIX_FMT_YUV420P)
            || (srcFormat == PIX_FMT_YUV420P && dstFormat == PIX_FMT_YUVA420P)
            || (isPlanarYUV(srcFormat) && isGray(dstFormat))
            || (isPlanarYUV(dstFormat) && isGray(srcFormat))
            || (isGray(dstFormat) && isGray(srcFormat))
            || (isPlanarYUV(srcFormat) && isPlanarYUV(dstFormat)
                && c->chrDstHSubSample == c->chrSrcHSubSample
                && c->chrDstVSubSample == c->chrSrcVSubSample
                && dstFormat != PIX_FMT_NV12 && dstFormat != PIX_FMT_NV21
                && srcFormat != PIX_FMT_NV12 && srcFormat != PIX_FMT_NV21))
        {
            if (isPacked(c->srcFormat))
                c->swScale= packedCopy;
            else /* Planar YUV or gray */
                c->swScale= planarCopy;
        }
#if ARCH_BFIN
        if (flags & SWS_CPU_CAPS_BFIN)
            ff_bfin_get_unscaled_swscale (c);
#endif

        if (c->swScale) {
            if (flags&SWS_PRINT_INFO)
                av_log(c, AV_LOG_INFO, "using unscaled %s -> %s special converter\n",
                       sws_format_name(srcFormat), sws_format_name(dstFormat));
            return c;
        }
    }

    if (flags & SWS_CPU_CAPS_MMX2) {
        c->canMMX2BeUsed= (dstW >=srcW && (dstW&31)==0 && (srcW&15)==0) ? 1 : 0;
        if (!c->canMMX2BeUsed && dstW >=srcW && (srcW&15)==0 && (flags&SWS_FAST_BILINEAR)) {
            if (flags&SWS_PRINT_INFO)
                av_log(c, AV_LOG_INFO, "output width is not a multiple of 32 -> no MMX2 scaler\n");
        }
        if (usesHFilter) c->canMMX2BeUsed=0;
    }
    else
        c->canMMX2BeUsed=0;

    c->chrXInc= ((c->chrSrcW<<16) + (c->chrDstW>>1))/c->chrDstW;
    c->chrYInc= ((c->chrSrcH<<16) + (c->chrDstH>>1))/c->chrDstH;

    // match pixel 0 of the src to pixel 0 of dst and match pixel n-2 of src to pixel n-2 of dst
    // but only for the FAST_BILINEAR mode otherwise do correct scaling
    // n-2 is the last chrominance sample available
    // this is not perfect, but no one should notice the difference, the more correct variant
    // would be like the vertical one, but that would require some special code for the
    // first and last pixel
    if (flags&SWS_FAST_BILINEAR) {
        if (c->canMMX2BeUsed) {
            c->lumXInc+= 20;
            c->chrXInc+= 20;
        }
        //we don't use the x86 asm scaler if MMX is available
        else if (flags & SWS_CPU_CAPS_MMX) {
            c->lumXInc = ((srcW-2)<<16)/(dstW-2) - 20;
            c->chrXInc = ((c->chrSrcW-2)<<16)/(c->chrDstW-2) - 20;
        }
    }

    /* precalculate horizontal scaler filter coefficients */
    {
        const int filterAlign=
            (flags & SWS_CPU_CAPS_MMX) ? 4 :
            (flags & SWS_CPU_CAPS_ALTIVEC) ? 8 :
            1;

        initFilter(&c->hLumFilter, &c->hLumFilterPos, &c->hLumFilterSize, c->lumXInc,
                   srcW      ,       dstW, filterAlign, 1<<14,
                   (flags&SWS_BICUBLIN) ? (flags|SWS_BICUBIC)  : flags,
                   srcFilter->lumH, dstFilter->lumH, c->param);
        initFilter(&c->hChrFilter, &c->hChrFilterPos, &c->hChrFilterSize, c->chrXInc,
                   c->chrSrcW, c->chrDstW, filterAlign, 1<<14,
                   (flags&SWS_BICUBLIN) ? (flags|SWS_BILINEAR) : flags,
                   srcFilter->chrH, dstFilter->chrH, c->param);

#if defined(COMPILE_MMX2)
// can't downscale !!!
        if (c->canMMX2BeUsed && (flags & SWS_FAST_BILINEAR)) {
            c->lumMmx2FilterCodeSize = initMMX2HScaler(      dstW, c->lumXInc, NULL, NULL, NULL, 8);
            c->chrMmx2FilterCodeSize = initMMX2HScaler(c->chrDstW, c->chrXInc, NULL, NULL, NULL, 4);

#ifdef MAP_ANONYMOUS
            c->lumMmx2FilterCode = mmap(NULL, c->lumMmx2FilterCodeSize, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
            c->chrMmx2FilterCode = mmap(NULL, c->chrMmx2FilterCodeSize, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
#elif HAVE_VIRTUALALLOC
            c->lumMmx2FilterCode = VirtualAlloc(NULL, c->lumMmx2FilterCodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
            c->chrMmx2FilterCode = VirtualAlloc(NULL, c->chrMmx2FilterCodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
#else
            c->lumMmx2FilterCode = av_malloc(c->lumMmx2FilterCodeSize);
            c->chrMmx2FilterCode = av_malloc(c->chrMmx2FilterCodeSize);
#endif

            c->lumMmx2Filter   = av_malloc((dstW        /8+8)*sizeof(int16_t));
            c->chrMmx2Filter   = av_malloc((c->chrDstW  /4+8)*sizeof(int16_t));
            c->lumMmx2FilterPos= av_malloc((dstW      /2/8+8)*sizeof(int32_t));
            c->chrMmx2FilterPos= av_malloc((c->chrDstW/2/4+8)*sizeof(int32_t));

            initMMX2HScaler(      dstW, c->lumXInc, c->lumMmx2FilterCode, c->lumMmx2Filter, c->lumMmx2FilterPos, 8);
            initMMX2HScaler(c->chrDstW, c->chrXInc, c->chrMmx2FilterCode, c->chrMmx2Filter, c->chrMmx2FilterPos, 4);

#ifdef MAP_ANONYMOUS
            mprotect(c->lumMmx2FilterCode, c->lumMmx2FilterCodeSize, PROT_EXEC | PROT_READ);
            mprotect(c->chrMmx2FilterCode, c->chrMmx2FilterCodeSize, PROT_EXEC | PROT_READ);
#endif
        }
#endif /* defined(COMPILE_MMX2) */
    } // initialize horizontal stuff



    /* precalculate vertical scaler filter coefficients */
    {
        const int filterAlign=
            (flags & SWS_CPU_CAPS_MMX) && (flags & SWS_ACCURATE_RND) ? 2 :
            (flags & SWS_CPU_CAPS_ALTIVEC) ? 8 :
            1;

        initFilter(&c->vLumFilter, &c->vLumFilterPos, &c->vLumFilterSize, c->lumYInc,
                   srcH      ,        dstH, filterAlign, (1<<12),
                   (flags&SWS_BICUBLIN) ? (flags|SWS_BICUBIC)  : flags,
                   srcFilter->lumV, dstFilter->lumV, c->param);
        initFilter(&c->vChrFilter, &c->vChrFilterPos, &c->vChrFilterSize, c->chrYInc,
                   c->chrSrcH, c->chrDstH, filterAlign, (1<<12),
                   (flags&SWS_BICUBLIN) ? (flags|SWS_BILINEAR) : flags,
                   srcFilter->chrV, dstFilter->chrV, c->param);

#ifdef COMPILE_ALTIVEC
        c->vYCoeffsBank = av_malloc(sizeof (vector signed short)*c->vLumFilterSize*c->dstH);
        c->vCCoeffsBank = av_malloc(sizeof (vector signed short)*c->vChrFilterSize*c->chrDstH);

        for (i=0;i<c->vLumFilterSize*c->dstH;i++) {
            int j;
            short *p = (short *)&c->vYCoeffsBank[i];
            for (j=0;j<8;j++)
                p[j] = c->vLumFilter[i];
        }

        for (i=0;i<c->vChrFilterSize*c->chrDstH;i++) {
            int j;
            short *p = (short *)&c->vCCoeffsBank[i];
            for (j=0;j<8;j++)
                p[j] = c->vChrFilter[i];
        }
#endif
    }

    // calculate buffer sizes so that they won't run out while handling these damn slices
    c->vLumBufSize= c->vLumFilterSize;
    c->vChrBufSize= c->vChrFilterSize;
    for (i=0; i<dstH; i++) {
        int chrI= i*c->chrDstH / dstH;
        int nextSlice= FFMAX(c->vLumFilterPos[i   ] + c->vLumFilterSize - 1,
                           ((c->vChrFilterPos[chrI] + c->vChrFilterSize - 1)<<c->chrSrcVSubSample));

        nextSlice>>= c->chrSrcVSubSample;
        nextSlice<<= c->chrSrcVSubSample;
        if (c->vLumFilterPos[i   ] + c->vLumBufSize < nextSlice)
            c->vLumBufSize= nextSlice - c->vLumFilterPos[i];
        if (c->vChrFilterPos[chrI] + c->vChrBufSize < (nextSlice>>c->chrSrcVSubSample))
            c->vChrBufSize= (nextSlice>>c->chrSrcVSubSample) - c->vChrFilterPos[chrI];
    }

    // allocate pixbufs (we use dynamic allocation because otherwise we would need to
    // allocate several megabytes to handle all possible cases)
    c->lumPixBuf= av_malloc(c->vLumBufSize*2*sizeof(int16_t*));
    c->chrPixBuf= av_malloc(c->vChrBufSize*2*sizeof(int16_t*));
    if (CONFIG_SWSCALE_ALPHA && isALPHA(c->srcFormat) && isALPHA(c->dstFormat))
        c->alpPixBuf= av_malloc(c->vLumBufSize*2*sizeof(int16_t*));
    //Note we need at least one pixel more at the end because of the MMX code (just in case someone wanna replace the 4000/8000)
    /* align at 16 bytes for AltiVec */
    for (i=0; i<c->vLumBufSize; i++)
        c->lumPixBuf[i]= c->lumPixBuf[i+c->vLumBufSize]= av_mallocz(VOF+1);
    for (i=0; i<c->vChrBufSize; i++)
        c->chrPixBuf[i]= c->chrPixBuf[i+c->vChrBufSize]= av_malloc((VOF+1)*2);
    if (CONFIG_SWSCALE_ALPHA && c->alpPixBuf)
        for (i=0; i<c->vLumBufSize; i++)
            c->alpPixBuf[i]= c->alpPixBuf[i+c->vLumBufSize]= av_mallocz(VOF+1);

    //try to avoid drawing green stuff between the right end and the stride end
    for (i=0; i<c->vChrBufSize; i++) memset(c->chrPixBuf[i], 64, (VOF+1)*2);

    assert(2*VOFW == VOF);

    assert(c->chrDstH <= dstH);

    if (flags&SWS_PRINT_INFO) {
#ifdef DITHER1XBPP
        const char *dither= " dithered";
#else
        const char *dither= "";
#endif
        if (flags&SWS_FAST_BILINEAR)
            av_log(c, AV_LOG_INFO, "FAST_BILINEAR scaler, ");
        else if (flags&SWS_BILINEAR)
            av_log(c, AV_LOG_INFO, "BILINEAR scaler, ");
        else if (flags&SWS_BICUBIC)
            av_log(c, AV_LOG_INFO, "BICUBIC scaler, ");
        else if (flags&SWS_X)
            av_log(c, AV_LOG_INFO, "Experimental scaler, ");
        else if (flags&SWS_POINT)
            av_log(c, AV_LOG_INFO, "Nearest Neighbor / POINT scaler, ");
        else if (flags&SWS_AREA)
            av_log(c, AV_LOG_INFO, "Area Averageing scaler, ");
        else if (flags&SWS_BICUBLIN)
            av_log(c, AV_LOG_INFO, "luma BICUBIC / chroma BILINEAR scaler, ");
        else if (flags&SWS_GAUSS)
            av_log(c, AV_LOG_INFO, "Gaussian scaler, ");
        else if (flags&SWS_SINC)
            av_log(c, AV_LOG_INFO, "Sinc scaler, ");
        else if (flags&SWS_LANCZOS)
            av_log(c, AV_LOG_INFO, "Lanczos scaler, ");
        else if (flags&SWS_SPLINE)
            av_log(c, AV_LOG_INFO, "Bicubic spline scaler, ");
        else
            av_log(c, AV_LOG_INFO, "ehh flags invalid?! ");

        if (dstFormat==PIX_FMT_BGR555 || dstFormat==PIX_FMT_BGR565)
            av_log(c, AV_LOG_INFO, "from %s to%s %s ",
                   sws_format_name(srcFormat), dither, sws_format_name(dstFormat));
        else
            av_log(c, AV_LOG_INFO, "from %s to %s ",
                   sws_format_name(srcFormat), sws_format_name(dstFormat));

        if (flags & SWS_CPU_CAPS_MMX2)
            av_log(c, AV_LOG_INFO, "using MMX2\n");
        else if (flags & SWS_CPU_CAPS_3DNOW)
            av_log(c, AV_LOG_INFO, "using 3DNOW\n");
        else if (flags & SWS_CPU_CAPS_MMX)
            av_log(c, AV_LOG_INFO, "using MMX\n");
        else if (flags & SWS_CPU_CAPS_ALTIVEC)
            av_log(c, AV_LOG_INFO, "using AltiVec\n");
        else
            av_log(c, AV_LOG_INFO, "using C\n");
    }

    if (flags & SWS_PRINT_INFO) {
        if (flags & SWS_CPU_CAPS_MMX) {
            if (c->canMMX2BeUsed && (flags&SWS_FAST_BILINEAR))
                av_log(c, AV_LOG_VERBOSE, "using FAST_BILINEAR MMX2 scaler for horizontal scaling\n");
            else {
                if (c->hLumFilterSize==4)
                    av_log(c, AV_LOG_VERBOSE, "using 4-tap MMX scaler for horizontal luminance scaling\n");
                else if (c->hLumFilterSize==8)
                    av_log(c, AV_LOG_VERBOSE, "using 8-tap MMX scaler for horizontal luminance scaling\n");
                else
                    av_log(c, AV_LOG_VERBOSE, "using n-tap MMX scaler for horizontal luminance scaling\n");

                if (c->hChrFilterSize==4)
                    av_log(c, AV_LOG_VERBOSE, "using 4-tap MMX scaler for horizontal chrominance scaling\n");
                else if (c->hChrFilterSize==8)
                    av_log(c, AV_LOG_VERBOSE, "using 8-tap MMX scaler for horizontal chrominance scaling\n");
                else
                    av_log(c, AV_LOG_VERBOSE, "using n-tap MMX scaler for horizontal chrominance scaling\n");
            }
        } else {
#if ARCH_X86
            av_log(c, AV_LOG_VERBOSE, "using x86 asm scaler for horizontal scaling\n");
#else
            if (flags & SWS_FAST_BILINEAR)
                av_log(c, AV_LOG_VERBOSE, "using FAST_BILINEAR C scaler for horizontal scaling\n");
            else
                av_log(c, AV_LOG_VERBOSE, "using C scaler for horizontal scaling\n");
#endif
        }
        if (isPlanarYUV(dstFormat)) {
            if (c->vLumFilterSize==1)
                av_log(c, AV_LOG_VERBOSE, "using 1-tap %s \"scaler\" for vertical scaling (YV12 like)\n", (flags & SWS_CPU_CAPS_MMX) ? "MMX" : "C");
            else
                av_log(c, AV_LOG_VERBOSE, "using n-tap %s scaler for vertical scaling (YV12 like)\n", (flags & SWS_CPU_CAPS_MMX) ? "MMX" : "C");
        } else {
            if (c->vLumFilterSize==1 && c->vChrFilterSize==2)
                av_log(c, AV_LOG_VERBOSE, "using 1-tap %s \"scaler\" for vertical luminance scaling (BGR)\n"
                       "      2-tap scaler for vertical chrominance scaling (BGR)\n", (flags & SWS_CPU_CAPS_MMX) ? "MMX" : "C");
            else if (c->vLumFilterSize==2 && c->vChrFilterSize==2)
                av_log(c, AV_LOG_VERBOSE, "using 2-tap linear %s scaler for vertical scaling (BGR)\n", (flags & SWS_CPU_CAPS_MMX) ? "MMX" : "C");
            else
                av_log(c, AV_LOG_VERBOSE, "using n-tap %s scaler for vertical scaling (BGR)\n", (flags & SWS_CPU_CAPS_MMX) ? "MMX" : "C");
        }

        if (dstFormat==PIX_FMT_BGR24)
            av_log(c, AV_LOG_VERBOSE, "using %s YV12->BGR24 converter\n",
                   (flags & SWS_CPU_CAPS_MMX2) ? "MMX2" : ((flags & SWS_CPU_CAPS_MMX) ? "MMX" : "C"));
        else if (dstFormat==PIX_FMT_RGB32)
            av_log(c, AV_LOG_VERBOSE, "using %s YV12->BGR32 converter\n", (flags & SWS_CPU_CAPS_MMX) ? "MMX" : "C");
        else if (dstFormat==PIX_FMT_BGR565)
            av_log(c, AV_LOG_VERBOSE, "using %s YV12->BGR16 converter\n", (flags & SWS_CPU_CAPS_MMX) ? "MMX" : "C");
        else if (dstFormat==PIX_FMT_BGR555)
            av_log(c, AV_LOG_VERBOSE, "using %s YV12->BGR15 converter\n", (flags & SWS_CPU_CAPS_MMX) ? "MMX" : "C");

        av_log(c, AV_LOG_VERBOSE, "%dx%d -> %dx%d\n", srcW, srcH, dstW, dstH);
    }
    if (flags & SWS_PRINT_INFO) {
        av_log(c, AV_LOG_DEBUG, "lum srcW=%d srcH=%d dstW=%d dstH=%d xInc=%d yInc=%d\n",
               c->srcW, c->srcH, c->dstW, c->dstH, c->lumXInc, c->lumYInc);
        av_log(c, AV_LOG_DEBUG, "chr srcW=%d srcH=%d dstW=%d dstH=%d xInc=%d yInc=%d\n",
               c->chrSrcW, c->chrSrcH, c->chrDstW, c->chrDstH, c->chrXInc, c->chrYInc);
    }

    c->swScale= getSwsFunc(c);
    return c;
}