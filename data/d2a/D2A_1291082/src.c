void avfilter_unref_buffer(AVFilterBufferRef *ref)
{
    if (!ref)
        return;
    if (!(--ref->buf->refcount)) {
        if (!ref->buf->free) {
            store_in_pool(ref);
            return;
        }
        ref->buf->free(ref->buf);
    }
    av_freep(&ref->video);
    av_freep(&ref->audio);
    av_free(ref);
}