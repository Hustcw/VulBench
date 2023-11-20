void DownloadItemImpl::OnDownloadCompleting(DownloadFileManager* file_manager) {
  DCHECK(BrowserThread::CurrentlyOn(BrowserThread::UI));

  VLOG(20) << __FUNCTION__ << "()"
           << " needs rename = " << NeedsRename()
           << " " << DebugString(true);
  DCHECK(!GetTargetName().empty());
   DCHECK_NE(DANGEROUS, GetSafetyState());
   DCHECK(file_manager);
 
     bool should_overwrite =
         (GetTargetDisposition() != DownloadItem::TARGET_DISPOSITION_UNIQUIFY);
     DownloadFileManager::RenameCompletionCallback callback =
        base::Bind(&DownloadItemImpl::OnDownloadRenamedToFinalName,
                   weak_ptr_factory_.GetWeakPtr(),
                    base::Unretained(file_manager));
     BrowserThread::PostTask(
         BrowserThread::FILE, FROM_HERE,
        base::Bind(&DownloadFileManager::RenameCompletingDownloadFile,
                    file_manager, GetGlobalId(), GetTargetFilePath(),
                    should_overwrite, callback));
   } else {
    Completed();
     BrowserThread::PostTask(
         BrowserThread::FILE, FROM_HERE,
         base::Bind(&DownloadFileManager::CompleteDownload,
                   file_manager, download_id_));
   }
 }
