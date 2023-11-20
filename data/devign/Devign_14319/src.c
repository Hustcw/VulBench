inline static void RENAME(hcscale)(uint16_t *dst, long dstWidth, uint8_t *src1, uint8_t *src2,

                                   int srcW, int xInc, int flags, int canMMX2BeUsed, int16_t *hChrFilter,

                                   int16_t *hChrFilterPos, int hChrFilterSize, void *funnyUVCode,

                                   int srcFormat, uint8_t *formatConvBuffer, int16_t *mmx2Filter,

                                   int32_t *mmx2FilterPos, uint8_t *pal)

{

    if (srcFormat==PIX_FMT_YUYV422)

    {

        RENAME(yuy2ToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (srcFormat==PIX_FMT_UYVY422)

    {

        RENAME(uyvyToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (srcFormat==PIX_FMT_RGB32)

    {

        RENAME(bgr32ToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (srcFormat==PIX_FMT_BGR24)

    {

        RENAME(bgr24ToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (srcFormat==PIX_FMT_BGR565)

    {

        RENAME(bgr16ToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (srcFormat==PIX_FMT_BGR555)

    {

        RENAME(bgr15ToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (srcFormat==PIX_FMT_BGR32)

    {

        RENAME(rgb32ToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (srcFormat==PIX_FMT_RGB24)

    {

        RENAME(rgb24ToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (srcFormat==PIX_FMT_RGB565)

    {

        RENAME(rgb16ToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (srcFormat==PIX_FMT_RGB555)

    {

        RENAME(rgb15ToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }

    else if (isGray(srcFormat))

    {

        return;

    }

    else if (srcFormat==PIX_FMT_RGB8 || srcFormat==PIX_FMT_BGR8 || srcFormat==PIX_FMT_PAL8 || srcFormat==PIX_FMT_BGR4_BYTE  || srcFormat==PIX_FMT_RGB4_BYTE)

    {

        RENAME(palToUV)(formatConvBuffer, formatConvBuffer+2048, src1, src2, srcW, pal);

        src1= formatConvBuffer;

        src2= formatConvBuffer+2048;

    }



#ifdef HAVE_MMX

    // use the new MMX scaler if the mmx2 can't be used (it is faster than the x86 ASM one)

    if (!(flags&SWS_FAST_BILINEAR) || (!canMMX2BeUsed))

#else

    if (!(flags&SWS_FAST_BILINEAR))

#endif

    {

        RENAME(hScale)(dst     , dstWidth, src1, srcW, xInc, hChrFilter, hChrFilterPos, hChrFilterSize);

        RENAME(hScale)(dst+2048, dstWidth, src2, srcW, xInc, hChrFilter, hChrFilterPos, hChrFilterSize);

    }

    else // Fast Bilinear upscale / crap downscale

    {

#if defined(ARCH_X86)

#ifdef HAVE_MMX2

        int i;

#if defined(PIC)

        uint64_t ebxsave __attribute__((aligned(8)));

#endif

        if (canMMX2BeUsed)

        {

            asm volatile(

#if defined(PIC)

            "mov          %%"REG_b", %6         \n\t"

#endif

            "pxor             %%mm7, %%mm7      \n\t"

            "mov                 %0, %%"REG_c"  \n\t"

            "mov                 %1, %%"REG_D"  \n\t"

            "mov                 %2, %%"REG_d"  \n\t"

            "mov                 %3, %%"REG_b"  \n\t"

            "xor          %%"REG_a", %%"REG_a"  \n\t" // i

            PREFETCH"   (%%"REG_c")             \n\t"

            PREFETCH" 32(%%"REG_c")             \n\t"

            PREFETCH" 64(%%"REG_c")             \n\t"



#ifdef ARCH_X86_64



#define FUNNY_UV_CODE \

            "movl       (%%"REG_b"), %%esi      \n\t"\

            "call               *%4             \n\t"\

            "movl (%%"REG_b", %%"REG_a"), %%esi \n\t"\

            "add          %%"REG_S", %%"REG_c"  \n\t"\

            "add          %%"REG_a", %%"REG_D"  \n\t"\

            "xor          %%"REG_a", %%"REG_a"  \n\t"\



#else



#define FUNNY_UV_CODE \

            "movl       (%%"REG_b"), %%esi      \n\t"\

            "call               *%4             \n\t"\

            "addl (%%"REG_b", %%"REG_a"), %%"REG_c" \n\t"\

            "add          %%"REG_a", %%"REG_D"  \n\t"\

            "xor          %%"REG_a", %%"REG_a"  \n\t"\



#endif /* ARCH_X86_64 */



FUNNY_UV_CODE

FUNNY_UV_CODE

FUNNY_UV_CODE

FUNNY_UV_CODE

            "xor          %%"REG_a", %%"REG_a"  \n\t" // i

            "mov                 %5, %%"REG_c"  \n\t" // src

            "mov                 %1, %%"REG_D"  \n\t" // buf1

            "add              $4096, %%"REG_D"  \n\t"

            PREFETCH"   (%%"REG_c")             \n\t"

            PREFETCH" 32(%%"REG_c")             \n\t"

            PREFETCH" 64(%%"REG_c")             \n\t"



FUNNY_UV_CODE

FUNNY_UV_CODE

FUNNY_UV_CODE

FUNNY_UV_CODE



#if defined(PIC)

            "mov %6, %%"REG_b"    \n\t"

#endif

            :: "m" (src1), "m" (dst), "m" (mmx2Filter), "m" (mmx2FilterPos),

            "m" (funnyUVCode), "m" (src2)

#if defined(PIC)

            ,"m" (ebxsave)

#endif

            : "%"REG_a, "%"REG_c, "%"REG_d, "%"REG_S, "%"REG_D

#if !defined(PIC)

             ,"%"REG_b

#endif

            );

            for (i=dstWidth-1; (i*xInc)>>16 >=srcW-1; i--)

            {

                //printf("%d %d %d\n", dstWidth, i, srcW);

                dst[i] = src1[srcW-1]*128;

                dst[i+2048] = src2[srcW-1]*128;

            }

        }

        else

        {

#endif /* HAVE_MMX2 */

            long xInc_shr16 = (long) (xInc >> 16);

            uint16_t xInc_mask = xInc & 0xffff;

            asm volatile(

            "xor %%"REG_a", %%"REG_a"               \n\t" // i

            "xor %%"REG_d", %%"REG_d"               \n\t" // xx

            "xorl    %%ecx, %%ecx                   \n\t" // 2*xalpha

            ASMALIGN(4)

            "1:                                     \n\t"

            "mov        %0, %%"REG_S"               \n\t"

            "movzbl  (%%"REG_S", %%"REG_d"), %%edi  \n\t" //src[xx]

            "movzbl 1(%%"REG_S", %%"REG_d"), %%esi  \n\t" //src[xx+1]

            "subl    %%edi, %%esi                   \n\t" //src[xx+1] - src[xx]

            "imull   %%ecx, %%esi                   \n\t" //(src[xx+1] - src[xx])*2*xalpha

            "shll      $16, %%edi                   \n\t"

            "addl    %%edi, %%esi                   \n\t" //src[xx+1]*2*xalpha + src[xx]*(1-2*xalpha)

            "mov        %1, %%"REG_D"               \n\t"

            "shrl       $9, %%esi                   \n\t"

            "movw     %%si, (%%"REG_D", %%"REG_a", 2)   \n\t"



            "movzbl    (%5, %%"REG_d"), %%edi       \n\t" //src[xx]

            "movzbl   1(%5, %%"REG_d"), %%esi       \n\t" //src[xx+1]

            "subl    %%edi, %%esi                   \n\t" //src[xx+1] - src[xx]

            "imull   %%ecx, %%esi                   \n\t" //(src[xx+1] - src[xx])*2*xalpha

            "shll      $16, %%edi                   \n\t"

            "addl    %%edi, %%esi                   \n\t" //src[xx+1]*2*xalpha + src[xx]*(1-2*xalpha)

            "mov        %1, %%"REG_D"               \n\t"

            "shrl       $9, %%esi                   \n\t"

            "movw     %%si, 4096(%%"REG_D", %%"REG_a", 2)   \n\t"



            "addw       %4, %%cx                    \n\t" //2*xalpha += xInc&0xFF

            "adc        %3, %%"REG_d"               \n\t" //xx+= xInc>>8 + carry

            "add        $1, %%"REG_a"               \n\t"

            "cmp        %2, %%"REG_a"               \n\t"

            " jb        1b                          \n\t"



/* GCC-3.3 makes MPlayer crash on IA-32 machines when using "g" operand here,

   which is needed to support GCC-4.0 */

#if defined(ARCH_X86_64) && ((__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4))

            :: "m" (src1), "m" (dst), "g" ((long)dstWidth), "m" (xInc_shr16), "m" (xInc_mask),

#else

            :: "m" (src1), "m" (dst), "m" ((long)dstWidth), "m" (xInc_shr16), "m" (xInc_mask),

#endif

            "r" (src2)

            : "%"REG_a, "%"REG_d, "%ecx", "%"REG_D, "%esi"

            );

#ifdef HAVE_MMX2

        } //if MMX2 can't be used

#endif

#else

        int i;

        unsigned int xpos=0;

        for (i=0;i<dstWidth;i++)

        {

            register unsigned int xx=xpos>>16;

            register unsigned int xalpha=(xpos&0xFFFF)>>9;

            dst[i]=(src1[xx]*(xalpha^127)+src1[xx+1]*xalpha);

            dst[i+2048]=(src2[xx]*(xalpha^127)+src2[xx+1]*xalpha);

            /* slower

            dst[i]= (src1[xx]<<7) + (src1[xx+1] - src1[xx])*xalpha;

            dst[i+2048]=(src2[xx]<<7) + (src2[xx+1] - src2[xx])*xalpha;

            */

            xpos+=xInc;

        }

#endif /* defined(ARCH_X86) */

    }

}
