MediaStreamImpl::~MediaStreamImpl() {
  DCHECK(!peer_connection_handler_);
  if (dependency_factory_.get())
    dependency_factory_->ReleasePeerConnectionFactory();
  if (network_manager_) {
    if (chrome_worker_thread_.IsRunning()) {
       chrome_worker_thread_.message_loop()->PostTask(FROM_HERE, base::Bind(
           &MediaStreamImpl::DeleteIpcNetworkManager,
           base::Unretained(this)));
     } else {
       NOTREACHED() << "Worker thread not running.";
     }
  }
}
