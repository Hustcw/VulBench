HeadlessPrintManager::GetPrintParamsFromSettings(
    const HeadlessPrintSettings& settings) {
  printing::PrintSettings print_settings;
  print_settings.set_dpi(printing::kPointsPerInch);
  print_settings.set_should_print_backgrounds(
      settings.should_print_backgrounds);
  print_settings.set_scale_factor(settings.scale);
  print_settings.SetOrientation(settings.landscape);

  print_settings.set_display_header_footer(settings.display_header_footer);
  if (print_settings.display_header_footer()) {
    url::Replacements<char> url_sanitizer;
    url_sanitizer.ClearUsername();
    url_sanitizer.ClearPassword();
    std::string url = printing_rfh_->GetLastCommittedURL()
                          .ReplaceComponents(url_sanitizer)
                          .spec();
    print_settings.set_url(base::UTF8ToUTF16(url));
  }

  print_settings.set_margin_type(printing::CUSTOM_MARGINS);
  print_settings.SetCustomMargins(settings.margins_in_points);

  gfx::Rect printable_area_device_units(settings.paper_size_in_points);
  print_settings.SetPrinterPrintableArea(settings.paper_size_in_points,
                                         printable_area_device_units, true);

  auto print_params = std::make_unique<PrintMsg_PrintPages_Params>();
   printing::RenderParamsFromPrintSettings(print_settings,
                                           &print_params->params);
   print_params->params.document_cookie = printing::PrintSettings::NewCookie();
   return print_params;
 }
