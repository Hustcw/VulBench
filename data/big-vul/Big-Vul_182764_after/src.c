WandExport MagickBooleanType MogrifyImageList(ImageInfo *image_info,
  const int argc,const char **argv,Image **images,ExceptionInfo *exception)
{
  ChannelType
    channel;

  const char
    *option;

  ImageInfo
    *mogrify_info;

  MagickStatusType
    status;

  QuantizeInfo
    *quantize_info;

  register ssize_t
    i;

  ssize_t
    count,
    index;

  /*
    Apply options to the image list.
  */
  assert(image_info != (ImageInfo *) NULL);
  assert(image_info->signature == MagickCoreSignature);
  assert(images != (Image **) NULL);
  assert((*images)->previous == (Image *) NULL);
  assert((*images)->signature == MagickCoreSignature);
  if ((*images)->debug != MagickFalse)
    (void) LogMagickEvent(TraceEvent,GetMagickModule(),"%s",
      (*images)->filename);
  if ((argc <= 0) || (*argv == (char *) NULL))
    return(MagickTrue);
  mogrify_info=CloneImageInfo(image_info);
  quantize_info=AcquireQuantizeInfo(mogrify_info);
  channel=mogrify_info->channel;
  status=MagickTrue;
  for (i=0; i < (ssize_t) argc; i++)
  {
    if (*images == (Image *) NULL)
      break;
    option=argv[i];
    if (IsCommandOption(option) == MagickFalse)
      continue;
    count=ParseCommandOption(MagickCommandOptions,MagickFalse,option);
    count=MagickMax(count,0L);
    if ((i+count) >= (ssize_t) argc)
      break;
    status=MogrifyImageInfo(mogrify_info,(int) count+1,argv+i,exception);
    switch (*(option+1))
    {
      case 'a':
      {
        if (LocaleCompare("affinity",option+1) == 0)
          {
            (void) SyncImagesSettings(mogrify_info,*images);
            if (*option == '+')
              {
                (void) RemapImages(quantize_info,*images,(Image *) NULL);
                InheritException(exception,&(*images)->exception);
                break;
              }
            i++;
            break;
          }
        if (LocaleCompare("append",option+1) == 0)
          {
            Image
              *append_image;

            (void) SyncImagesSettings(mogrify_info,*images);
            append_image=AppendImages(*images,*option == '-' ? MagickTrue :
              MagickFalse,exception);
            if (append_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=append_image;
            break;
          }
        if (LocaleCompare("average",option+1) == 0)
          {
            Image
              *average_image;

            /*
              Average an image sequence (deprecated).
            */
            (void) SyncImagesSettings(mogrify_info,*images);
            average_image=EvaluateImages(*images,MeanEvaluateOperator,
              exception);
            if (average_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=average_image;
            break;
          }
        break;
      }
      case 'c':
      {
        if (LocaleCompare("channel",option+1) == 0)
          {
            if (*option == '+')
              {
                channel=DefaultChannels;
                break;
              }
            channel=(ChannelType) ParseChannelOption(argv[i+1]);
            break;
          }
        if (LocaleCompare("clut",option+1) == 0)
          {
            Image
              *clut_image,
              *image;

            (void) SyncImagesSettings(mogrify_info,*images);
            image=RemoveFirstImageFromList(images);
            clut_image=RemoveFirstImageFromList(images);
            if (clut_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            (void) ClutImageChannel(image,channel,clut_image);
            clut_image=DestroyImage(clut_image);
            InheritException(exception,&image->exception);
            *images=DestroyImageList(*images);
            *images=image;
            break;
          }
        if (LocaleCompare("coalesce",option+1) == 0)
          {
            Image
              *coalesce_image;

            (void) SyncImagesSettings(mogrify_info,*images);
            coalesce_image=CoalesceImages(*images,exception);
            if (coalesce_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=coalesce_image;
            break;
          }
        if (LocaleCompare("combine",option+1) == 0)
          {
            Image
              *combine_image;

            (void) SyncImagesSettings(mogrify_info,*images);
            combine_image=CombineImages(*images,channel,exception);
            if (combine_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=combine_image;
            break;
          }
        if (LocaleCompare("compare",option+1) == 0)
          {
            const char
              *option;

            double
              distortion;

            Image
              *difference_image,
              *image,
              *reconstruct_image;

            MetricType
              metric;

            /*
              Mathematically and visually annotate the difference between an
              image and its reconstruction.
            */
            (void) SyncImagesSettings(mogrify_info,*images);
            image=RemoveFirstImageFromList(images);
            reconstruct_image=RemoveFirstImageFromList(images);
            if (reconstruct_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            metric=UndefinedMetric;
            option=GetImageOption(image_info,"metric");
            if (option != (const char *) NULL)
              metric=(MetricType) ParseCommandOption(MagickMetricOptions,
                MagickFalse,option);
            difference_image=CompareImageChannels(image,reconstruct_image,
               channel,metric,&distortion,exception);
             if (difference_image == (Image *) NULL)
               break;
            reconstruct_image=DestroyImage(reconstruct_image);
            image=DestroyImage(image);
             if (*images != (Image *) NULL)
               *images=DestroyImageList(*images);
             *images=difference_image;
            break;
          }
        if (LocaleCompare("complex",option+1) == 0)
          {
            ComplexOperator
              op;

            Image
              *complex_images;

            (void) SyncImageSettings(mogrify_info,*images);
            op=(ComplexOperator) ParseCommandOption(MagickComplexOptions,
              MagickFalse,argv[i+1]);
            complex_images=ComplexImages(*images,op,exception);
            if (complex_images == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=complex_images;
            break;
          }
        if (LocaleCompare("composite",option+1) == 0)
          {
            Image
              *mask_image,
              *composite_image,
              *image;

            RectangleInfo
              geometry;

            (void) SyncImagesSettings(mogrify_info,*images);
            image=RemoveFirstImageFromList(images);
            composite_image=RemoveFirstImageFromList(images);
            if (composite_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            (void) TransformImage(&composite_image,(char *) NULL,
              composite_image->geometry);
            SetGeometry(composite_image,&geometry);
            (void) ParseAbsoluteGeometry(composite_image->geometry,&geometry);
            GravityAdjustGeometry(image->columns,image->rows,image->gravity,
              &geometry);
            mask_image=RemoveFirstImageFromList(images);
            if (mask_image != (Image *) NULL)
              {
                if ((image->compose == DisplaceCompositeOp) ||
                    (image->compose == DistortCompositeOp))
                  {
                    /*
                      Merge Y displacement into X displacement image.
                    */
                    (void) CompositeImage(composite_image,CopyGreenCompositeOp,
                      mask_image,0,0);
                    mask_image=DestroyImage(mask_image);
                  }
                else
                  {
                    /*
                      Set a blending mask for the composition.
                    */
                    if (image->mask != (Image *) NULL)
                      image->mask=DestroyImage(image->mask);
                    image->mask=mask_image;
                    (void) NegateImage(image->mask,MagickFalse);
                  }
              }
            (void) CompositeImageChannel(image,channel,image->compose,
              composite_image,geometry.x,geometry.y);
            if (mask_image != (Image *) NULL)
              {
                image->mask=DestroyImage(image->mask);
                mask_image=image->mask;
              }
            composite_image=DestroyImage(composite_image);
            InheritException(exception,&image->exception);
            *images=DestroyImageList(*images);
            *images=image;
            break;
          }
        if (LocaleCompare("copy",option+1) == 0)
          {
            Image
              *source_image;

            OffsetInfo
              offset;

            RectangleInfo
              geometry;

            /*
              Copy image pixels.
            */
            (void) SyncImageSettings(mogrify_info,*images);
            (void) ParsePageGeometry(*images,argv[i+2],&geometry,exception);
            offset.x=geometry.x;
            offset.y=geometry.y;
            source_image=(*images);
            if (source_image->next != (Image *) NULL)
              source_image=source_image->next;
            (void) ParsePageGeometry(source_image,argv[i+1],&geometry,
              exception);
            status=CopyImagePixels(*images,source_image,&geometry,&offset,
              exception);
            break;
          }
        break;
      }
      case 'd':
      {
        if (LocaleCompare("deconstruct",option+1) == 0)
          {
            Image
              *deconstruct_image;

            (void) SyncImagesSettings(mogrify_info,*images);
            deconstruct_image=DeconstructImages(*images,exception);
            if (deconstruct_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=deconstruct_image;
            break;
          }
        if (LocaleCompare("delete",option+1) == 0)
          {
            if (*option == '+')
              DeleteImages(images,"-1",exception);
            else
              DeleteImages(images,argv[i+1],exception);
            break;
          }
        if (LocaleCompare("dither",option+1) == 0)
          {
            if (*option == '+')
              {
                quantize_info->dither=MagickFalse;
                break;
              }
            quantize_info->dither=MagickTrue;
            quantize_info->dither_method=(DitherMethod) ParseCommandOption(
              MagickDitherOptions,MagickFalse,argv[i+1]);
            break;
          }
        if (LocaleCompare("duplicate",option+1) == 0)
          {
            Image
              *duplicate_images;

            if (*option == '+')
              duplicate_images=DuplicateImages(*images,1,"-1",exception);
            else
              {
                const char
                  *p;

                size_t
                  number_duplicates;

                number_duplicates=(size_t) StringToLong(argv[i+1]);
                p=strchr(argv[i+1],',');
                if (p == (const char *) NULL)
                  duplicate_images=DuplicateImages(*images,number_duplicates,
                    "-1",exception);
                else
                  duplicate_images=DuplicateImages(*images,number_duplicates,p,
                    exception);
              }
            AppendImageToList(images, duplicate_images);
            (void) SyncImagesSettings(mogrify_info,*images);
            break;
          }
        break;
      }
      case 'e':
      {
        if (LocaleCompare("evaluate-sequence",option+1) == 0)
          {
            Image
              *evaluate_image;

            MagickEvaluateOperator
              op;

            (void) SyncImageSettings(mogrify_info,*images);
            op=(MagickEvaluateOperator) ParseCommandOption(
              MagickEvaluateOptions,MagickFalse,argv[i+1]);
            evaluate_image=EvaluateImages(*images,op,exception);
            if (evaluate_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=evaluate_image;
            break;
          }
        break;
      }
      case 'f':
      {
        if (LocaleCompare("fft",option+1) == 0)
          {
            Image
              *fourier_image;

            /*
              Implements the discrete Fourier transform (DFT).
            */
            (void) SyncImageSettings(mogrify_info,*images);
            fourier_image=ForwardFourierTransformImage(*images,*option == '-' ?
              MagickTrue : MagickFalse,exception);
            if (fourier_image == (Image *) NULL)
              break;
            *images=DestroyImageList(*images);
            *images=fourier_image;
            break;
          }
        if (LocaleCompare("flatten",option+1) == 0)
          {
            Image
              *flatten_image;

            (void) SyncImagesSettings(mogrify_info,*images);
            flatten_image=MergeImageLayers(*images,FlattenLayer,exception);
            if (flatten_image == (Image *) NULL)
              break;
            *images=DestroyImageList(*images);
            *images=flatten_image;
            break;
          }
        if (LocaleCompare("fx",option+1) == 0)
          {
            Image
              *fx_image;

            (void) SyncImagesSettings(mogrify_info,*images);
            fx_image=FxImageChannel(*images,channel,argv[i+1],exception);
            if (fx_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=fx_image;
            break;
          }
        break;
      }
      case 'h':
      {
        if (LocaleCompare("hald-clut",option+1) == 0)
          {
            Image
              *hald_image,
              *image;

            (void) SyncImagesSettings(mogrify_info,*images);
            image=RemoveFirstImageFromList(images);
            hald_image=RemoveFirstImageFromList(images);
            if (hald_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            (void) HaldClutImageChannel(image,channel,hald_image);
            hald_image=DestroyImage(hald_image);
            InheritException(exception,&image->exception);
            if (*images != (Image *) NULL)
              *images=DestroyImageList(*images);
            *images=image;
            break;
          }
        break;
      }
      case 'i':
      {
        if (LocaleCompare("ift",option+1) == 0)
          {
            Image
              *fourier_image,
              *magnitude_image,
              *phase_image;

            /*
              Implements the inverse fourier discrete Fourier transform (DFT).
            */
            (void) SyncImagesSettings(mogrify_info,*images);
            magnitude_image=RemoveFirstImageFromList(images);
            phase_image=RemoveFirstImageFromList(images);
            if (phase_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            fourier_image=InverseFourierTransformImage(magnitude_image,
              phase_image,*option == '-' ? MagickTrue : MagickFalse,exception);
            if (fourier_image == (Image *) NULL)
              break;
            if (*images != (Image *) NULL)
              *images=DestroyImageList(*images);
            *images=fourier_image;
            break;
          }
        if (LocaleCompare("insert",option+1) == 0)
          {
            Image
              *p,
              *q;

            index=0;
            if (*option != '+')
              index=(ssize_t) StringToLong(argv[i+1]);
            p=RemoveLastImageFromList(images);
            if (p == (Image *) NULL)
              {
                (void) ThrowMagickException(exception,GetMagickModule(),
                  OptionError,"NoSuchImage","`%s'",argv[i+1]);
                status=MagickFalse;
                break;
              }
            q=p;
            if (index == 0)
              PrependImageToList(images,q);
            else
              if (index == (ssize_t) GetImageListLength(*images))
                AppendImageToList(images,q);
              else
                {
                    q=GetImageFromList(*images,index-1);
                    if (q == (Image *) NULL)
                      {
                       p=DestroyImage(p);
                        (void) ThrowMagickException(exception,GetMagickModule(),
                          OptionError,"NoSuchImage","`%s'",argv[i+1]);
                        status=MagickFalse;
                       break;
                     }
                  InsertImageInList(&q,p);
                }
            *images=GetFirstImageInList(q);
            break;
          }
        break;
      }
      case 'l':
      {
        if (LocaleCompare("layers",option+1) == 0)
          {
            Image
              *layers;

            ImageLayerMethod
              method;

            (void) SyncImagesSettings(mogrify_info,*images);
            layers=(Image *) NULL;
            method=(ImageLayerMethod) ParseCommandOption(MagickLayerOptions,
              MagickFalse,argv[i+1]);
            switch (method)
            {
              case CoalesceLayer:
              {
                layers=CoalesceImages(*images,exception);
                break;
              }
              case CompareAnyLayer:
              case CompareClearLayer:
              case CompareOverlayLayer:
              default:
              {
                layers=CompareImageLayers(*images,method,exception);
                break;
              }
              case MergeLayer:
              case FlattenLayer:
              case MosaicLayer:
              case TrimBoundsLayer:
              {
                layers=MergeImageLayers(*images,method,exception);
                break;
              }
              case DisposeLayer:
              {
                layers=DisposeImages(*images,exception);
                break;
              }
              case OptimizeImageLayer:
              {
                layers=OptimizeImageLayers(*images,exception);
                break;
              }
              case OptimizePlusLayer:
              {
                layers=OptimizePlusImageLayers(*images,exception);
                break;
              }
              case OptimizeTransLayer:
              {
                OptimizeImageTransparency(*images,exception);
                break;
              }
              case RemoveDupsLayer:
              {
                RemoveDuplicateLayers(images,exception);
                break;
              }
              case RemoveZeroLayer:
              {
                RemoveZeroDelayLayers(images,exception);
                break;
              }
              case OptimizeLayer:
              {
                /*
                  General Purpose, GIF Animation Optimizer.
                */
                layers=CoalesceImages(*images,exception);
                if (layers == (Image *) NULL)
                  {
                    status=MagickFalse;
                    break;
                  }
                InheritException(exception,&layers->exception);
                *images=DestroyImageList(*images);
                *images=layers;
                layers=OptimizeImageLayers(*images,exception);
                if (layers == (Image *) NULL)
                  {
                    status=MagickFalse;
                    break;
                  }
                InheritException(exception,&layers->exception);
                *images=DestroyImageList(*images);
                *images=layers;
                layers=(Image *) NULL;
                OptimizeImageTransparency(*images,exception);
                InheritException(exception,&(*images)->exception);
                (void) RemapImages(quantize_info,*images,(Image *) NULL);
                break;
              }
              case CompositeLayer:
              {
                CompositeOperator
                  compose;

                Image
                  *source;

                RectangleInfo
                  geometry;

                /*
                  Split image sequence at the first 'NULL:' image.
                */
                source=(*images);
                while (source != (Image *) NULL)
                {
                  source=GetNextImageInList(source);
                  if ((source != (Image *) NULL) &&
                      (LocaleCompare(source->magick,"NULL") == 0))
                    break;
                }
                if (source != (Image *) NULL)
                  {
                    if ((GetPreviousImageInList(source) == (Image *) NULL) ||
                        (GetNextImageInList(source) == (Image *) NULL))
                      source=(Image *) NULL;
                    else
                      {
                        /*
                          Separate the two lists, junk the null: image.
                        */
                        source=SplitImageList(source->previous);
                        DeleteImageFromList(&source);
                      }
                  }
                if (source == (Image *) NULL)
                  {
                    (void) ThrowMagickException(exception,GetMagickModule(),
                      OptionError,"MissingNullSeparator","layers Composite");
                    status=MagickFalse;
                    break;
                  }
                /*
                  Adjust offset with gravity and virtual canvas.
                */
                SetGeometry(*images,&geometry);
                (void) ParseAbsoluteGeometry((*images)->geometry,&geometry);
                geometry.width=source->page.width != 0 ?
                  source->page.width : source->columns;
                geometry.height=source->page.height != 0 ?
                 source->page.height : source->rows;
                GravityAdjustGeometry((*images)->page.width != 0 ?
                  (*images)->page.width : (*images)->columns,
                  (*images)->page.height != 0 ? (*images)->page.height :
                  (*images)->rows,(*images)->gravity,&geometry);
                compose=OverCompositeOp;
                option=GetImageOption(mogrify_info,"compose");
                if (option != (const char *) NULL)
                  compose=(CompositeOperator) ParseCommandOption(
                    MagickComposeOptions,MagickFalse,option);
                CompositeLayers(*images,compose,source,geometry.x,geometry.y,
                  exception);
                source=DestroyImageList(source);
                break;
              }
            }
            if (layers == (Image *) NULL)
              break;
            InheritException(exception,&layers->exception);
            *images=DestroyImageList(*images);
            *images=layers;
            break;
          }
        break;
      }
      case 'm':
      {
        if (LocaleCompare("map",option+1) == 0)
          {
            (void) SyncImagesSettings(mogrify_info,*images);
            if (*option == '+')
              {
                (void) RemapImages(quantize_info,*images,(Image *) NULL);
                InheritException(exception,&(*images)->exception);
                break;
              }
            i++;
            break;
          }
        if (LocaleCompare("maximum",option+1) == 0)
          {
            Image
              *maximum_image;

            /*
              Maximum image sequence (deprecated).
            */
            (void) SyncImagesSettings(mogrify_info,*images);
            maximum_image=EvaluateImages(*images,MaxEvaluateOperator,exception);
            if (maximum_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=maximum_image;
            break;
          }
        if (LocaleCompare("minimum",option+1) == 0)
          {
            Image
              *minimum_image;

            /*
              Minimum image sequence (deprecated).
            */
            (void) SyncImagesSettings(mogrify_info,*images);
            minimum_image=EvaluateImages(*images,MinEvaluateOperator,exception);
            if (minimum_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=minimum_image;
            break;
          }
        if (LocaleCompare("morph",option+1) == 0)
          {
            Image
              *morph_image;

            (void) SyncImagesSettings(mogrify_info,*images);
            morph_image=MorphImages(*images,StringToUnsignedLong(argv[i+1]),
              exception);
            if (morph_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=morph_image;
            break;
          }
        if (LocaleCompare("mosaic",option+1) == 0)
          {
            Image
              *mosaic_image;

            (void) SyncImagesSettings(mogrify_info,*images);
            mosaic_image=MergeImageLayers(*images,MosaicLayer,exception);
            if (mosaic_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=mosaic_image;
            break;
          }
        break;
      }
      case 'p':
      {
        if (LocaleCompare("poly",option+1) == 0)
          {
            char
              *args,
              token[MaxTextExtent];

            const char
              *p;

            double
              *arguments;

            Image
              *polynomial_image;

            register ssize_t
              x;

            size_t
              number_arguments;

            /*
              Polynomial image.
            */
            (void) SyncImageSettings(mogrify_info,*images);
            args=InterpretImageProperties(mogrify_info,*images,argv[i+1]);
            InheritException(exception,&(*images)->exception);
            if (args == (char *) NULL)
              break;
            p=(char *) args;
            for (x=0; *p != '\0'; x++)
            {
              GetNextToken(p,&p,MaxTextExtent,token);
              if (*token == ',')
                GetNextToken(p,&p,MaxTextExtent,token);
            }
            number_arguments=(size_t) x;
            arguments=(double *) AcquireQuantumMemory(number_arguments,
              sizeof(*arguments));
            if (arguments == (double *) NULL)
              ThrowWandFatalException(ResourceLimitFatalError,
                "MemoryAllocationFailed",(*images)->filename);
            (void) memset(arguments,0,number_arguments*
              sizeof(*arguments));
            p=(char *) args;
            for (x=0; (x < (ssize_t) number_arguments) && (*p != '\0'); x++)
            {
              GetNextToken(p,&p,MaxTextExtent,token);
              if (*token == ',')
                GetNextToken(p,&p,MaxTextExtent,token);
              arguments[x]=StringToDouble(token,(char **) NULL);
            }
            args=DestroyString(args);
            polynomial_image=PolynomialImageChannel(*images,channel,
              number_arguments >> 1,arguments,exception);
            arguments=(double *) RelinquishMagickMemory(arguments);
            if (polynomial_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=polynomial_image;
            break;
          }
        if (LocaleCompare("print",option+1) == 0)
          {
            char
              *string;

            (void) SyncImagesSettings(mogrify_info,*images);
            string=InterpretImageProperties(mogrify_info,*images,argv[i+1]);
            if (string == (char *) NULL)
              break;
            InheritException(exception,&(*images)->exception);
            (void) FormatLocaleFile(stdout,"%s",string);
            string=DestroyString(string);
          }
        if (LocaleCompare("process",option+1) == 0)
          {
            char
              **arguments;

            int
              j,
              number_arguments;

            (void) SyncImagesSettings(mogrify_info,*images);
            arguments=StringToArgv(argv[i+1],&number_arguments);
            if (arguments == (char **) NULL)
              break;
            if ((argc > 1) && (strchr(arguments[1],'=') != (char *) NULL))
              {
                char
                  breaker,
                  quote,
                  *token;

                const char
                  *arguments;

                int
                  next,
                  status;

                size_t
                  length;

                TokenInfo
                  *token_info;

                /*
                  Support old style syntax, filter="-option arg".
                */
                length=strlen(argv[i+1]);
                token=(char *) NULL;
                if (~length >= (MaxTextExtent-1))
                  token=(char *) AcquireQuantumMemory(length+MaxTextExtent,
                    sizeof(*token));
                if (token == (char *) NULL)
                  break;
                next=0;
                arguments=argv[i+1];
                token_info=AcquireTokenInfo();
                status=Tokenizer(token_info,0,token,length,arguments,"","=",
                  "\"",'\0',&breaker,&next,&quote);
                token_info=DestroyTokenInfo(token_info);
                if (status == 0)
                  {
                    const char
                      *argv;

                    argv=(&(arguments[next]));
                    (void) InvokeDynamicImageFilter(token,&(*images),1,&argv,
                      exception);
                  }
                token=DestroyString(token);
                break;
              }
            (void) SubstituteString(&arguments[1],"-","");
            (void) InvokeDynamicImageFilter(arguments[1],&(*images),
              number_arguments-2,(const char **) arguments+2,exception);
            for (j=0; j < number_arguments; j++)
              arguments[j]=DestroyString(arguments[j]);
            arguments=(char **) RelinquishMagickMemory(arguments);
            break;
          }
        break;
      }
      case 'r':
      {
        if (LocaleCompare("reverse",option+1) == 0)
          {
            ReverseImageList(images);
            InheritException(exception,&(*images)->exception);
            break;
          }
        break;
      }
      case 's':
      {
        if (LocaleCompare("smush",option+1) == 0)
          {
            Image
              *smush_image;

            ssize_t
              offset;

            (void) SyncImagesSettings(mogrify_info,*images);
            offset=(ssize_t) StringToLong(argv[i+1]);
            smush_image=SmushImages(*images,*option == '-' ? MagickTrue :
              MagickFalse,offset,exception);
            if (smush_image == (Image *) NULL)
              {
                status=MagickFalse;
                break;
              }
            *images=DestroyImageList(*images);
            *images=smush_image;
            break;
          }
        if (LocaleCompare("swap",option+1) == 0)
          {
            Image
              *p,
              *q,
              *u,
              *v;

            ssize_t
              swap_index;

            index=(-1);
            swap_index=(-2);
            if (*option != '+')
              {
                GeometryInfo
                  geometry_info;

                MagickStatusType
                  flags;

                swap_index=(-1);
                flags=ParseGeometry(argv[i+1],&geometry_info);
                index=(ssize_t) geometry_info.rho;
                if ((flags & SigmaValue) != 0)
                  swap_index=(ssize_t) geometry_info.sigma;
              }
            p=GetImageFromList(*images,index);
            q=GetImageFromList(*images,swap_index);
            if ((p == (Image *) NULL) || (q == (Image *) NULL))
              {
                (void) ThrowMagickException(exception,GetMagickModule(),
                  OptionError,"NoSuchImage","`%s'",(*images)->filename);
                status=MagickFalse;
                break;
              }
            if (p == q)
              break;
            u=CloneImage(p,0,0,MagickTrue,exception);
            if (u == (Image *) NULL)
              break;
            v=CloneImage(q,0,0,MagickTrue,exception);
            if (v == (Image *) NULL)
              {
                u=DestroyImage(u);
                break;
              }
            ReplaceImageInList(&p,v);
            ReplaceImageInList(&q,u);
            *images=GetFirstImageInList(q);
            break;
          }
        break;
      }
      case 'w':
      {
        if (LocaleCompare("write",option+1) == 0)
          {
            char
              key[MaxTextExtent];

            Image
              *write_images;

            ImageInfo
              *write_info;

            (void) SyncImagesSettings(mogrify_info,*images);
            (void) FormatLocaleString(key,MaxTextExtent,"cache:%s",argv[i+1]);
            (void) DeleteImageRegistry(key);
            write_images=(*images);
            if (*option == '+')
              write_images=CloneImageList(*images,exception);
            write_info=CloneImageInfo(mogrify_info);
            status&=WriteImages(write_info,write_images,argv[i+1],exception);
            write_info=DestroyImageInfo(write_info);
            if (*option == '+')
              write_images=DestroyImageList(write_images);
            break;
          }
        break;
      }
      default:
        break;
    }
    i+=count;
  }
  quantize_info=DestroyQuantizeInfo(quantize_info);
  mogrify_info=DestroyImageInfo(mogrify_info);
  status&=MogrifyImageInfo(image_info,argc,argv,exception);
  return(status != 0 ? MagickTrue : MagickFalse);
}
