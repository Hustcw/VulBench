PP_Flash_Menu* ReadMenu(int depth,
                        const IPC::Message* m,
                        PickleIterator* iter) {
  if (depth > kMaxMenuDepth)
    return NULL;
  ++depth;

  PP_Flash_Menu* menu = new PP_Flash_Menu;
  menu->items = NULL;

  if (!m->ReadUInt32(iter, &menu->count)) {
    FreeMenu(menu);
    return NULL;
  }

   if (menu->count == 0)
     return menu;
 
  if (menu->count > kMaxMenuEntries) {
    FreeMenu(menu);
    return NULL;
  }

   menu->items = new PP_Flash_MenuItem[menu->count];
   memset(menu->items, 0, sizeof(PP_Flash_MenuItem) * menu->count);
   for (uint32_t i = 0; i < menu->count; ++i) {
    if (!ReadMenuItem(depth, m, iter, menu->items + i)) {
      FreeMenu(menu);
      return NULL;
    }
  }
  return menu;
}
