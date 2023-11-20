void PrintPreviewDataService::RemoveEntry(
    const std::string& preview_ui_addr_str) {
  PreviewDataStoreMap::iterator it = data_store_map_.find(preview_ui_addr_str);
  if (it != data_store_map_.end())
    data_store_map_.erase(it);
 }
