OMX_ERRORTYPE SoftFlacEncoder::internalGetParameter(
        OMX_INDEXTYPE index, OMX_PTR params) {
    ALOGV("SoftFlacEncoder::internalGetParameter(index=0x%x)", index);

 switch (index) {
 case OMX_IndexParamAudioPcm:
 {

             OMX_AUDIO_PARAM_PCMMODETYPE *pcmParams =
                 (OMX_AUDIO_PARAM_PCMMODETYPE *)params;
 
             if (pcmParams->nPortIndex > 1) {
                 return OMX_ErrorUndefined;
             }

            pcmParams->eNumData = OMX_NumericalDataSigned;
            pcmParams->eEndian = OMX_EndianBig;
            pcmParams->bInterleaved = OMX_TRUE;
            pcmParams->nBitPerSample = 16;
            pcmParams->ePCMMode = OMX_AUDIO_PCMModeLinear;
            pcmParams->eChannelMapping[0] = OMX_AUDIO_ChannelLF;
            pcmParams->eChannelMapping[1] = OMX_AUDIO_ChannelRF;

            pcmParams->nChannels = mNumChannels;
            pcmParams->nSamplingRate = mSampleRate;

 return OMX_ErrorNone;
 }


         case OMX_IndexParamAudioFlac:
         {
             OMX_AUDIO_PARAM_FLACTYPE *flacParams = (OMX_AUDIO_PARAM_FLACTYPE *)params;
             flacParams->nCompressionLevel = mCompressionLevel;
             flacParams->nChannels = mNumChannels;
             flacParams->nSampleRate = mSampleRate;
 return OMX_ErrorNone;
 }

 default:
 return SimpleSoftOMXComponent::internalGetParameter(index, params);
 }
}
