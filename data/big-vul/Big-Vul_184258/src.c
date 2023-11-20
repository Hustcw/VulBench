void ThreadableBlobRegistry::registerBlobURL(const KURL& url, PassOwnPtr<BlobData> blobData)
 {
    if (isMainThread())
        blobRegistry().registerBlobURL(url, blobData);
    else {
         OwnPtr<BlobRegistryContext> context = adoptPtr(new BlobRegistryContext(url, blobData));
         callOnMainThread(&registerBlobURLTask, context.leakPtr());
     }
}
