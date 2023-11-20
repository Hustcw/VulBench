static int decode_header(EXRContext *s)

{

    int magic_number, version, i, flags, sar = 0;

    int layer_match = 0;



    s->current_channel_offset = 0;

    s->xmin               = ~0;

    s->xmax               = ~0;

    s->ymin               = ~0;

    s->ymax               = ~0;

    s->xdelta             = ~0;

    s->ydelta             = ~0;

    s->channel_offsets[0] = -1;

    s->channel_offsets[1] = -1;

    s->channel_offsets[2] = -1;

    s->channel_offsets[3] = -1;

    s->pixel_type         = EXR_UNKNOWN;

    s->compression        = EXR_UNKN;

    s->nb_channels        = 0;

    s->w                  = 0;

    s->h                  = 0;

    s->tile_attr.xSize    = -1;

    s->tile_attr.ySize    = -1;

    s->is_tile            = 0;

    s->is_luma            = 0;



    if (bytestream2_get_bytes_left(&s->gb) < 10) {

        av_log(s->avctx, AV_LOG_ERROR, "Header too short to parse.\n");

        return AVERROR_INVALIDDATA;

    }



    magic_number = bytestream2_get_le32(&s->gb);

    if (magic_number != 20000630) {

        /* As per documentation of OpenEXR, it is supposed to be

         * int 20000630 little-endian */

        av_log(s->avctx, AV_LOG_ERROR, "Wrong magic number %d.\n", magic_number);

        return AVERROR_INVALIDDATA;

    }



    version = bytestream2_get_byte(&s->gb);

    if (version != 2) {

        avpriv_report_missing_feature(s->avctx, "Version %d", version);

        return AVERROR_PATCHWELCOME;

    }



    flags = bytestream2_get_le24(&s->gb);



    if (flags == 0x00)

        s->is_tile = 0;

    else if (flags & 0x02)

        s->is_tile = 1;

    else{

        avpriv_report_missing_feature(s->avctx, "flags %d", flags);

        return AVERROR_PATCHWELCOME;

    }



    // Parse the header

    while (bytestream2_get_bytes_left(&s->gb) > 0 && *s->gb.buffer) {

        int var_size;

        if ((var_size = check_header_variable(s, "channels",

                                              "chlist", 38)) >= 0) {

            GetByteContext ch_gb;

            if (!var_size)

                return AVERROR_INVALIDDATA;



            bytestream2_init(&ch_gb, s->gb.buffer, var_size);



            while (bytestream2_get_bytes_left(&ch_gb) >= 19) {

                EXRChannel *channel;

                enum ExrPixelType current_pixel_type;

                int channel_index = -1;

                int xsub, ysub;



                if (strcmp(s->layer, "") != 0) {

                    if (strncmp(ch_gb.buffer, s->layer, strlen(s->layer)) == 0) {

                        layer_match = 1;

                        av_log(s->avctx, AV_LOG_INFO,

                               "Channel match layer : %s.\n", ch_gb.buffer);

                        ch_gb.buffer += strlen(s->layer);

                        if (*ch_gb.buffer == '.')

                            ch_gb.buffer++;         /* skip dot if not given */

                    } else {

                        av_log(s->avctx, AV_LOG_INFO,

                               "Channel doesn't match layer : %s.\n", ch_gb.buffer);

                    }

                } else {

                    layer_match = 1;

                }



                if (layer_match) { /* only search channel if the layer match is valid */

                    if (!strcmp(ch_gb.buffer, "R") ||

                        !strcmp(ch_gb.buffer, "X") ||

                        !strcmp(ch_gb.buffer, "U")) {

                        channel_index = 0;

                        s->is_luma = 0;

                    } else if (!strcmp(ch_gb.buffer, "G") ||

                               !strcmp(ch_gb.buffer, "V")) {

                        channel_index = 1;

                        s->is_luma = 0;

                    } else if (!strcmp(ch_gb.buffer, "Y")) {

                        channel_index = 1;

                        s->is_luma = 1;

                    } else if (!strcmp(ch_gb.buffer, "B") ||

                               !strcmp(ch_gb.buffer, "Z") ||

                               !strcmp(ch_gb.buffer, "W")){

                               channel_index = 2;

                        s->is_luma = 0;

                    } else if (!strcmp(ch_gb.buffer, "A")) {

                        channel_index = 3;

                    } else {

                        av_log(s->avctx, AV_LOG_WARNING,

                               "Unsupported channel %.256s.\n", ch_gb.buffer);

                    }

                }



                /* skip until you get a 0 */

                while (bytestream2_get_bytes_left(&ch_gb) > 0 &&

                       bytestream2_get_byte(&ch_gb))

                    continue;



                if (bytestream2_get_bytes_left(&ch_gb) < 4) {

                    av_log(s->avctx, AV_LOG_ERROR, "Incomplete header.\n");

                    return AVERROR_INVALIDDATA;

                }



                current_pixel_type = bytestream2_get_le32(&ch_gb);

                if (current_pixel_type >= EXR_UNKNOWN) {

                    avpriv_report_missing_feature(s->avctx, "Pixel type %d",

                                                  current_pixel_type);

                    return AVERROR_PATCHWELCOME;

                }



                bytestream2_skip(&ch_gb, 4);

                xsub = bytestream2_get_le32(&ch_gb);

                ysub = bytestream2_get_le32(&ch_gb);



                if (xsub != 1 || ysub != 1) {

                    avpriv_report_missing_feature(s->avctx,

                                                  "Subsampling %dx%d",

                                                  xsub, ysub);

                    return AVERROR_PATCHWELCOME;

                }



                if (s->channel_offsets[channel_index] == -1){/* channel have not been previously assign */

                    if (channel_index >= 0) {

                        if (s->pixel_type != EXR_UNKNOWN &&

                            s->pixel_type != current_pixel_type) {

                            av_log(s->avctx, AV_LOG_ERROR,

                                   "RGB channels not of the same depth.\n");

                            return AVERROR_INVALIDDATA;

                        }

                        s->pixel_type                     = current_pixel_type;

                        s->channel_offsets[channel_index] = s->current_channel_offset;

                    }

                }



                s->channels = av_realloc(s->channels,

                                         ++s->nb_channels * sizeof(EXRChannel));

                if (!s->channels)

                    return AVERROR(ENOMEM);

                channel             = &s->channels[s->nb_channels - 1];

                channel->pixel_type = current_pixel_type;

                channel->xsub       = xsub;

                channel->ysub       = ysub;



                s->current_channel_offset += 1 << current_pixel_type;

            }



            /* Check if all channels are set with an offset or if the channels

             * are causing an overflow  */

            if (!s->is_luma){/* if we expected to have at least 3 channels */

                if (FFMIN3(s->channel_offsets[0],

                           s->channel_offsets[1],

                           s->channel_offsets[2]) < 0) {

                    if (s->channel_offsets[0] < 0)

                        av_log(s->avctx, AV_LOG_ERROR, "Missing red channel.\n");

                    if (s->channel_offsets[1] < 0)

                        av_log(s->avctx, AV_LOG_ERROR, "Missing green channel.\n");

                    if (s->channel_offsets[2] < 0)

                        av_log(s->avctx, AV_LOG_ERROR, "Missing blue channel.\n");

                    return AVERROR_INVALIDDATA;

                }

            }



            // skip one last byte and update main gb

            s->gb.buffer = ch_gb.buffer + 1;

            continue;

        } else if ((var_size = check_header_variable(s, "dataWindow", "box2i",

                                                     31)) >= 0) {

            if (!var_size)

                return AVERROR_INVALIDDATA;



            s->xmin   = bytestream2_get_le32(&s->gb);

            s->ymin   = bytestream2_get_le32(&s->gb);

            s->xmax   = bytestream2_get_le32(&s->gb);

            s->ymax   = bytestream2_get_le32(&s->gb);

            s->xdelta = (s->xmax - s->xmin) + 1;

            s->ydelta = (s->ymax - s->ymin) + 1;



            continue;

        } else if ((var_size = check_header_variable(s, "displayWindow",

                                                     "box2i", 34)) >= 0) {

            if (!var_size)

                return AVERROR_INVALIDDATA;



            bytestream2_skip(&s->gb, 8);

            s->w = bytestream2_get_le32(&s->gb) + 1;

            s->h = bytestream2_get_le32(&s->gb) + 1;



            continue;

        } else if ((var_size = check_header_variable(s, "lineOrder",

                                                     "lineOrder", 25)) >= 0) {

            int line_order;

            if (!var_size)

                return AVERROR_INVALIDDATA;



            line_order = bytestream2_get_byte(&s->gb);

            av_log(s->avctx, AV_LOG_DEBUG, "line order: %d.\n", line_order);

            if (line_order > 2) {

                av_log(s->avctx, AV_LOG_ERROR, "Unknown line order.\n");

                return AVERROR_INVALIDDATA;

            }



            continue;

        } else if ((var_size = check_header_variable(s, "pixelAspectRatio",

                                                     "float", 31)) >= 0) {

            if (!var_size)

                return AVERROR_INVALIDDATA;



            sar = bytestream2_get_le32(&s->gb);



            continue;

        } else if ((var_size = check_header_variable(s, "compression",

                                                     "compression", 29)) >= 0) {

            if (!var_size)

                return AVERROR_INVALIDDATA;



            if (s->compression == EXR_UNKN)

                s->compression = bytestream2_get_byte(&s->gb);

            else

                av_log(s->avctx, AV_LOG_WARNING,

                       "Found more than one compression attribute.\n");



            continue;

        } else if ((var_size = check_header_variable(s, "tiles",

                                                     "tiledesc", 22)) >= 0) {

            char tileLevel;



            if (!s->is_tile)

                av_log(s->avctx, AV_LOG_WARNING,

                       "Found tile attribute and scanline flags. Exr will be interpreted as scanline.\n");



            s->tile_attr.xSize = bytestream2_get_le32(&s->gb);

            s->tile_attr.ySize = bytestream2_get_le32(&s->gb);



            tileLevel = bytestream2_get_byte(&s->gb);

            s->tile_attr.level_mode = tileLevel & 0x0f;

            s->tile_attr.level_round = (tileLevel >> 4) & 0x0f;



            if (s->tile_attr.level_mode >= EXR_TILE_LEVEL_UNKNOWN){

                avpriv_report_missing_feature(s->avctx, "Tile level mode %d",

                                              s->tile_attr.level_mode);

                return AVERROR_PATCHWELCOME;

            }



            if (s->tile_attr.level_round >= EXR_TILE_ROUND_UNKNOWN) {

                avpriv_report_missing_feature(s->avctx, "Tile level round %d",

                                              s->tile_attr.level_round);

                return AVERROR_PATCHWELCOME;

            }



            continue;

        }



        // Check if there are enough bytes for a header

        if (bytestream2_get_bytes_left(&s->gb) <= 9) {

            av_log(s->avctx, AV_LOG_ERROR, "Incomplete header\n");

            return AVERROR_INVALIDDATA;

        }



        // Process unknown variables

        for (i = 0; i < 2; i++) // value_name and value_type

            while (bytestream2_get_byte(&s->gb) != 0);



        // Skip variable length

        bytestream2_skip(&s->gb, bytestream2_get_le32(&s->gb));

    }



    ff_set_sar(s->avctx, av_d2q(av_int2float(sar), 255));



    if (s->compression == EXR_UNKN) {

        av_log(s->avctx, AV_LOG_ERROR, "Missing compression attribute.\n");

        return AVERROR_INVALIDDATA;

    }



    if (s->is_tile) {

        if (s->tile_attr.xSize < 1 || s->tile_attr.ySize < 1) {

            av_log(s->avctx, AV_LOG_ERROR, "Invalid tile attribute.\n");

            return AVERROR_INVALIDDATA;

        }

    }



    if (bytestream2_get_bytes_left(&s->gb) <= 0) {

        av_log(s->avctx, AV_LOG_ERROR, "Incomplete frame.\n");

        return AVERROR_INVALIDDATA;

    }



    // aaand we are done

    bytestream2_skip(&s->gb, 1);

    return 0;

}
