OMX_ERRORTYPE SoftFlacEncoder::internalSetParameter(
        OMX_INDEXTYPE index, const OMX_PTR params) {
 switch (index) {
 case OMX_IndexParamAudioPcm:
 {

             ALOGV("SoftFlacEncoder::internalSetParameter(OMX_IndexParamAudioPcm)");
             OMX_AUDIO_PARAM_PCMMODETYPE *pcmParams = (OMX_AUDIO_PARAM_PCMMODETYPE *)params;
 
             if (pcmParams->nPortIndex != 0 && pcmParams->nPortIndex != 1) {
                 ALOGE("SoftFlacEncoder::internalSetParameter() Error #1");
                 return OMX_ErrorUndefined;
 }

 if (pcmParams->nChannels < 1 || pcmParams->nChannels > 2) {
 return OMX_ErrorUndefined;
 }

            mNumChannels = pcmParams->nChannels;
            mSampleRate = pcmParams->nSamplingRate;
            ALOGV("will encode %d channels at %dHz", mNumChannels, mSampleRate);

 return configureEncoder();
 }

 case OMX_IndexParamStandardComponentRole:
 {
            ALOGV("SoftFlacEncoder::internalSetParameter(OMX_IndexParamStandardComponentRole)");

             const OMX_PARAM_COMPONENTROLETYPE *roleParams =
                 (const OMX_PARAM_COMPONENTROLETYPE *)params;
 
             if (strncmp((const char *)roleParams->cRole,
                     "audio_encoder.flac",
                     OMX_MAX_STRINGNAME_SIZE - 1)) {
                ALOGE("SoftFlacEncoder::internalSetParameter(OMX_IndexParamStandardComponentRole)"
 "error");
 return OMX_ErrorUndefined;
 }

 return OMX_ErrorNone;
 }

 case OMX_IndexParamAudioFlac:

         {
             OMX_AUDIO_PARAM_FLACTYPE *flacParams = (OMX_AUDIO_PARAM_FLACTYPE *)params;
             mCompressionLevel = flacParams->nCompressionLevel; // range clamping done inside encoder
             return OMX_ErrorNone;
         }

 case OMX_IndexParamPortDefinition:
 {

             OMX_PARAM_PORTDEFINITIONTYPE *defParams =
                 (OMX_PARAM_PORTDEFINITIONTYPE *)params;
 
             if (defParams->nPortIndex == 0) {
                 if (defParams->nBufferSize > kMaxInputBufferSize) {
                     ALOGE("Input buffer size must be at most %d bytes",
                        kMaxInputBufferSize);
 return OMX_ErrorUnsupportedSetting;
 }
 }

 }

 default:
            ALOGV("SoftFlacEncoder::internalSetParameter(default)");
 return SimpleSoftOMXComponent::internalSetParameter(index, params);
 }
}
