InputMethodStatusConnection* ChromeOSMonitorInputMethodStatus(
    void* language_library,
    LanguageCurrentInputMethodMonitorFunction current_input_method_changed,
    LanguageRegisterImePropertiesFunction register_ime_properties,
    LanguageUpdateImePropertyFunction update_ime_property,
    LanguageConnectionChangeMonitorFunction connection_changed) {
  DLOG(INFO) << "MonitorInputMethodStatus";
  return InputMethodStatusConnection::GetConnection(
      language_library,
      current_input_method_changed,
      register_ime_properties,
      update_ime_property,
      connection_changed);
}
