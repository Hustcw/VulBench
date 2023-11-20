void MojoVideoEncodeAcceleratorService::UseOutputBitstreamBuffer(
    int32_t bitstream_buffer_id,
    mojo::ScopedSharedBufferHandle buffer) {
  DVLOG(2) << __func__ << " bitstream_buffer_id=" << bitstream_buffer_id;
  DCHECK_CALLED_ON_VALID_SEQUENCE(sequence_checker_);

  if (!encoder_)
    return;
  if (!buffer.is_valid()) {
    DLOG(ERROR) << __func__ << " invalid |buffer|.";
    NotifyError(::media::VideoEncodeAccelerator::kInvalidArgumentError);
    return;
  }
  if (bitstream_buffer_id < 0) {
    DLOG(ERROR) << __func__ << " bitstream_buffer_id=" << bitstream_buffer_id
                << " must be >= 0";
    NotifyError(::media::VideoEncodeAccelerator::kInvalidArgumentError);
    return;
  }
 
   base::SharedMemoryHandle handle;
   size_t memory_size = 0;
  bool read_only = false;
   auto result = mojo::UnwrapSharedMemoryHandle(std::move(buffer), &handle,
                                               &memory_size, &read_only);
   if (result != MOJO_RESULT_OK || memory_size == 0u) {
     DLOG(ERROR) << __func__ << " mojo::UnwrapSharedMemoryHandle() failed";
     NotifyError(::media::VideoEncodeAccelerator::kPlatformFailureError);
    return;
  }

  if (memory_size < output_buffer_size_) {
    DLOG(ERROR) << __func__ << " bitstream_buffer_id=" << bitstream_buffer_id
                << " has a size of " << memory_size
                << "B, different from expected " << output_buffer_size_ << "B";
    NotifyError(::media::VideoEncodeAccelerator::kInvalidArgumentError);
    return;
  }

  encoder_->UseOutputBitstreamBuffer(
      BitstreamBuffer(bitstream_buffer_id, handle, memory_size));
}
