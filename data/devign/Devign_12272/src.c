int net_init_tap(const NetClientOptions *opts, const char *name,
                 NetClientState *peer)
{
    const NetdevTapOptions *tap;
    int fd, vnet_hdr = 0, i = 0, queues;
    /* for the no-fd, no-helper case */
    const char *script = NULL; /* suppress wrong "uninit'd use" gcc warning */
    const char *downscript = NULL;
    const char *vhostfdname;
    char ifname[128];
    assert(opts->kind == NET_CLIENT_OPTIONS_KIND_TAP);
    tap = opts->tap;
    queues = tap->has_queues ? tap->queues : 1;
    vhostfdname = tap->has_vhostfd ? tap->vhostfd : NULL;
    if (tap->has_fd) {
        if (tap->has_ifname || tap->has_script || tap->has_downscript ||
            tap->has_vnet_hdr || tap->has_helper || tap->has_queues ||
            tap->has_fds) {
            error_report("ifname=, script=, downscript=, vnet_hdr=, "
                         "helper=, queues=, and fds= are invalid with fd=");
        fd = monitor_handle_fd_param(cur_mon, tap->fd);
        if (fd == -1) {
        fcntl(fd, F_SETFL, O_NONBLOCK);
        vnet_hdr = tap_probe_vnet_hdr(fd);
        if (net_init_tap_one(tap, peer, "tap", name, NULL,
                             script, downscript,
                             vhostfdname, vnet_hdr, fd)) {
    } else if (tap->has_fds) {
        char *fds[MAX_TAP_QUEUES];
        char *vhost_fds[MAX_TAP_QUEUES];
        int nfds, nvhosts;
        if (tap->has_ifname || tap->has_script || tap->has_downscript ||
            tap->has_vnet_hdr || tap->has_helper || tap->has_queues ||
            tap->has_fd) {
            error_report("ifname=, script=, downscript=, vnet_hdr=, "
                         "helper=, queues=, and fd= are invalid with fds=");
        nfds = get_fds(tap->fds, fds, MAX_TAP_QUEUES);
        if (tap->has_vhostfds) {
            nvhosts = get_fds(tap->vhostfds, vhost_fds, MAX_TAP_QUEUES);
            if (nfds != nvhosts) {
                error_report("The number of fds passed does not match the "
                             "number of vhostfds passed");
        for (i = 0; i < nfds; i++) {
            fd = monitor_handle_fd_param(cur_mon, fds[i]);
            if (fd == -1) {
            fcntl(fd, F_SETFL, O_NONBLOCK);
            if (i == 0) {
                vnet_hdr = tap_probe_vnet_hdr(fd);
            } else if (vnet_hdr != tap_probe_vnet_hdr(fd)) {
                error_report("vnet_hdr not consistent across given tap fds");
            if (net_init_tap_one(tap, peer, "tap", name, ifname,
                                 script, downscript,
                                 tap->has_vhostfds ? vhost_fds[i] : NULL,
                                 vnet_hdr, fd)) {
    } else if (tap->has_helper) {
        if (tap->has_ifname || tap->has_script || tap->has_downscript ||
            tap->has_vnet_hdr || tap->has_queues || tap->has_fds) {
            error_report("ifname=, script=, downscript=, and vnet_hdr= "
                         "queues=, and fds= are invalid with helper=");
        fd = net_bridge_run_helper(tap->helper, DEFAULT_BRIDGE_INTERFACE);
        if (fd == -1) {
        fcntl(fd, F_SETFL, O_NONBLOCK);
        vnet_hdr = tap_probe_vnet_hdr(fd);
        if (net_init_tap_one(tap, peer, "bridge", name, ifname,
                             script, downscript, vhostfdname,
                             vnet_hdr, fd)) {
    } else {
        script = tap->has_script ? tap->script : DEFAULT_NETWORK_SCRIPT;
        downscript = tap->has_downscript ? tap->downscript :
            DEFAULT_NETWORK_DOWN_SCRIPT;
        if (tap->has_ifname) {
            pstrcpy(ifname, sizeof ifname, tap->ifname);
        } else {
            ifname[0] = '\0';
        for (i = 0; i < queues; i++) {
            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
                              ifname, sizeof ifname, queues > 1);
            if (fd == -1) {
            if (queues > 1 && i == 0 && !tap->has_ifname) {
                if (tap_fd_get_ifname(fd, ifname)) {
                    error_report("Fail to get ifname");
            if (net_init_tap_one(tap, peer, "tap", name, ifname,
                                 i >= 1 ? "no" : script,
                                 i >= 1 ? "no" : downscript,
                                 vhostfdname, vnet_hdr, fd)) {
    return 0;