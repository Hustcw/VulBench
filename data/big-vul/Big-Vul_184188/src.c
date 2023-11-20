 void SaveCCInfoConfirmInfoBar::ViewHierarchyChanged(bool is_add,
                                                     views::View* parent,
                                                     views::View* child) {
  InfoBar::ViewHierarchyChanged(is_add, parent, child);
   if (is_add && child == this && !initialized_) {
     Init();
     initialized_ = true;
  }
}
