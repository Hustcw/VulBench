NavigationPolicy GetNavigationPolicy(const WebInputEvent* current_event,
                                     const WebWindowFeatures& features) {
//// Check that the desired NavigationPolicy |policy| is compatible with the
//// observed input event |current_event|.
   bool as_popup = !features.tool_bar_visible || !features.status_bar_visible ||
                   !features.scrollbars_visible || !features.menu_bar_visible ||
                   !features.resizable;
  NavigationPolicy policy =
       as_popup ? kNavigationPolicyNewPopup : kNavigationPolicyNewForegroundTab;
  UpdatePolicyForEvent(current_event, &policy);
  return policy;
}
