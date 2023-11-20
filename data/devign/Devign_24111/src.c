int attribute_align_arg avresample_convert(AVAudioResampleContext *avr,

                                           uint8_t **output, int out_plane_size,

                                           int out_samples, uint8_t **input,

                                           int in_plane_size, int in_samples)

{

    AudioData input_buffer;

    AudioData output_buffer;

    AudioData *current_buffer;

    int ret, direct_output;



    /* reset internal buffers */

    if (avr->in_buffer) {

        avr->in_buffer->nb_samples = 0;

        ff_audio_data_set_channels(avr->in_buffer,

                                   avr->in_buffer->allocated_channels);

    }

    if (avr->resample_out_buffer) {

        avr->resample_out_buffer->nb_samples = 0;

        ff_audio_data_set_channels(avr->resample_out_buffer,

                                   avr->resample_out_buffer->allocated_channels);

    }

    if (avr->out_buffer) {

        avr->out_buffer->nb_samples = 0;

        ff_audio_data_set_channels(avr->out_buffer,

                                   avr->out_buffer->allocated_channels);

    }



    av_dlog(avr, "[start conversion]\n");



    /* initialize output_buffer with output data */

    direct_output = output && av_audio_fifo_size(avr->out_fifo) == 0;

    if (output) {

        ret = ff_audio_data_init(&output_buffer, output, out_plane_size,

                                 avr->out_channels, out_samples,

                                 avr->out_sample_fmt, 0, "output");

        if (ret < 0)

            return ret;

        output_buffer.nb_samples = 0;

    }



    if (input) {

        /* initialize input_buffer with input data */

        ret = ff_audio_data_init(&input_buffer, input, in_plane_size,

                                 avr->in_channels, in_samples,

                                 avr->in_sample_fmt, 1, "input");

        if (ret < 0)

            return ret;

        current_buffer = &input_buffer;



        if (avr->upmix_needed && !avr->in_convert_needed && !avr->resample_needed &&

            !avr->out_convert_needed && direct_output && out_samples >= in_samples) {

            /* in some rare cases we can copy input to output and upmix

               directly in the output buffer */

            av_dlog(avr, "[copy] %s to output\n", current_buffer->name);

            ret = ff_audio_data_copy(&output_buffer, current_buffer,

                                     avr->remap_point == REMAP_OUT_COPY ?

                                     &avr->ch_map_info : NULL);

            if (ret < 0)

                return ret;

            current_buffer = &output_buffer;

        } else if (avr->remap_point == REMAP_OUT_COPY &&

                   (!direct_output || out_samples < in_samples)) {

            /* if remapping channels during output copy, we may need to

             * use an intermediate buffer in order to remap before adding

             * samples to the output fifo */

            av_dlog(avr, "[copy] %s to out_buffer\n", current_buffer->name);

            ret = ff_audio_data_copy(avr->out_buffer, current_buffer,

                                     &avr->ch_map_info);

            if (ret < 0)

                return ret;

            current_buffer = avr->out_buffer;

        } else if (avr->in_copy_needed || avr->in_convert_needed) {

            /* if needed, copy or convert input to in_buffer, and downmix if

               applicable */

            if (avr->in_convert_needed) {

                ret = ff_audio_data_realloc(avr->in_buffer,

                                            current_buffer->nb_samples);

                if (ret < 0)

                    return ret;

                av_dlog(avr, "[convert] %s to in_buffer\n", current_buffer->name);

                ret = ff_audio_convert(avr->ac_in, avr->in_buffer,

                                       current_buffer);

                if (ret < 0)

                    return ret;

            } else {

                av_dlog(avr, "[copy] %s to in_buffer\n", current_buffer->name);

                ret = ff_audio_data_copy(avr->in_buffer, current_buffer,

                                         avr->remap_point == REMAP_IN_COPY ?

                                         &avr->ch_map_info : NULL);

                if (ret < 0)

                    return ret;

            }

            ff_audio_data_set_channels(avr->in_buffer, avr->in_channels);

            if (avr->downmix_needed) {

                av_dlog(avr, "[downmix] in_buffer\n");

                ret = ff_audio_mix(avr->am, avr->in_buffer);

                if (ret < 0)

                    return ret;

            }

            current_buffer = avr->in_buffer;

        }

    } else {

        /* flush resampling buffer and/or output FIFO if input is NULL */

        if (!avr->resample_needed)

            return handle_buffered_output(avr, output ? &output_buffer : NULL,

                                          NULL);

        current_buffer = NULL;

    }



    if (avr->resample_needed) {

        AudioData *resample_out;



        if (!avr->out_convert_needed && direct_output && out_samples > 0)

            resample_out = &output_buffer;

        else

            resample_out = avr->resample_out_buffer;

        av_dlog(avr, "[resample] %s to %s\n", current_buffer->name,

                resample_out->name);

        ret = ff_audio_resample(avr->resample, resample_out,

                                current_buffer);

        if (ret < 0)

            return ret;



        /* if resampling did not produce any samples, just return 0 */

        if (resample_out->nb_samples == 0) {

            av_dlog(avr, "[end conversion]\n");

            return 0;

        }



        current_buffer = resample_out;

    }



    if (avr->upmix_needed) {

        av_dlog(avr, "[upmix] %s\n", current_buffer->name);

        ret = ff_audio_mix(avr->am, current_buffer);

        if (ret < 0)

            return ret;

    }



    /* if we resampled or upmixed directly to output, return here */

    if (current_buffer == &output_buffer) {

        av_dlog(avr, "[end conversion]\n");

        return current_buffer->nb_samples;

    }



    if (avr->out_convert_needed) {

        if (direct_output && out_samples >= current_buffer->nb_samples) {

            /* convert directly to output */

            av_dlog(avr, "[convert] %s to output\n", current_buffer->name);

            ret = ff_audio_convert(avr->ac_out, &output_buffer, current_buffer);

            if (ret < 0)

                return ret;



            av_dlog(avr, "[end conversion]\n");

            return output_buffer.nb_samples;

        } else {

            ret = ff_audio_data_realloc(avr->out_buffer,

                                        current_buffer->nb_samples);

            if (ret < 0)

                return ret;

            av_dlog(avr, "[convert] %s to out_buffer\n", current_buffer->name);

            ret = ff_audio_convert(avr->ac_out, avr->out_buffer,

                                   current_buffer);

            if (ret < 0)

                return ret;

            current_buffer = avr->out_buffer;

        }

    }



    return handle_buffered_output(avr, output ? &output_buffer : NULL,

                                  current_buffer);

}
