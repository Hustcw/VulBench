OffscreenCanvasSurfaceImpl::~OffscreenCanvasSurfaceImpl() {
  if (!GetSurfaceManager()) {
    if (surface_factory_)
        surface_factory_->DidDestroySurfaceManager();
  } else {
    GetSurfaceManager()->InvalidateSurfaceClientId(id_allocator_->client_id());
  }
  surface_factory_->Destroy(surface_id_);
}
