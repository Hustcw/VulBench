void ExtensionServiceBackend::OnExtensionInstalled(
     const scoped_refptr<const Extension>& extension) {
   CHECK(BrowserThread::CurrentlyOn(BrowserThread::UI));
   if (frontend_.get())
    frontend_->OnExtensionInstalled(extension);
 }
