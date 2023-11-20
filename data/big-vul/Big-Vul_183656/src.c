 void SessionModelAssociator::PopulateSessionTabFromSpecifics(
     const sync_pb::SessionTab& specifics,
    const base::Time& mtime,
     SessionTab* tab) {
   if (specifics.has_tab_id())
     tab->tab_id.set_id(specifics.tab_id());
  if (specifics.has_window_id())
    tab->window_id.set_id(specifics.window_id());
  if (specifics.has_tab_visual_index())
    tab->tab_visual_index = specifics.tab_visual_index();
  if (specifics.has_current_navigation_index())
    tab->current_navigation_index = specifics.current_navigation_index();
  if (specifics.has_pinned())
     tab->pinned = specifics.pinned();
   if (specifics.has_extension_app_id())
     tab->extension_app_id = specifics.extension_app_id();
  tab->timestamp = mtime;
   tab->navigations.clear();  // In case we are reusing a previous SessionTab.
   for (int i = 0; i < specifics.navigation_size(); i++) {
     AppendSessionTabNavigation(specifics.navigation(i), &tab->navigations);
  }
}
