  void MaybeRestoreIBusConfig() {
    if (!ibus_) {
      return;
    }

    MaybeDestroyIBusConfig();

     if (!ibus_config_) {
       GDBusConnection* ibus_connection = ibus_bus_get_connection(ibus_);
       if (!ibus_connection) {
        LOG(INFO) << "Couldn't create an ibus config object since "
                  << "IBus connection is not ready.";
         return;
       }
       const gboolean disconnected
          = g_dbus_connection_is_closed(ibus_connection);
      if (disconnected) {
        LOG(ERROR) << "Couldn't create an ibus config object since "
                   << "IBus connection is closed.";
        return;
      }
      ibus_config_ = ibus_config_new(ibus_connection,
                                     NULL /* do not cancel the operation */,
                                     NULL /* do not get error information */);
      if (!ibus_config_) {
        LOG(ERROR) << "ibus_config_new() failed. ibus-memconf is not ready?";
        return;
      }

       g_object_ref(ibus_config_);
      LOG(INFO) << "ibus_config_ is ready.";
     }
   }
