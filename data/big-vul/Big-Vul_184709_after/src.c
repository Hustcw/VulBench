RenderProcessImpl::RenderProcessImpl()
     : ALLOW_THIS_IN_INITIALIZER_LIST(shared_mem_cache_cleaner_(
           FROM_HERE, base::TimeDelta::FromSeconds(5),
           this, &RenderProcessImpl::ClearTransportDIBCache)),
      transport_dib_next_sequence_number_(0),
      enabled_bindings_(0) {
   in_process_plugins_ = InProcessPlugins();
   for (size_t i = 0; i < arraysize(shared_mem_cache_); ++i)
     shared_mem_cache_[i] = NULL;

#if defined(OS_WIN)
  if (GetModuleHandle(L"LPK.DLL") == NULL) {
    typedef BOOL (__stdcall *GdiInitializeLanguagePack)(int LoadedShapingDLLs);
    GdiInitializeLanguagePack gdi_init_lpk =
        reinterpret_cast<GdiInitializeLanguagePack>(GetProcAddress(
            GetModuleHandle(L"GDI32.DLL"),
            "GdiInitializeLanguagePack"));
    DCHECK(gdi_init_lpk);
    if (gdi_init_lpk) {
      gdi_init_lpk(0);
    }
  }
#endif

  webkit_glue::SetJavaScriptFlags(
      "--debugger-auto-break"
      " --prof --prof-lazy");

  const CommandLine& command_line = *CommandLine::ForCurrentProcess();
  if (command_line.HasSwitch(switches::kJavaScriptFlags)) {
    webkit_glue::SetJavaScriptFlags(
        command_line.GetSwitchValueASCII(switches::kJavaScriptFlags));
  }
}
