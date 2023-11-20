MigrationState *tcp_start_outgoing_migration(Monitor *mon,

                                             const char *host_port,

                                             int64_t bandwidth_limit,

                                             int detach,

					     int blk,

					     int inc)

{

    struct sockaddr_in addr;

    FdMigrationState *s;

    int ret;



    if (parse_host_port(&addr, host_port) < 0)

        return NULL;



    s = qemu_mallocz(sizeof(*s));



    s->get_error = socket_errno;

    s->write = socket_write;

    s->close = tcp_close;

    s->mig_state.cancel = migrate_fd_cancel;

    s->mig_state.get_status = migrate_fd_get_status;

    s->mig_state.release = migrate_fd_release;



    s->mig_state.blk = blk;

    s->mig_state.shared = inc;



    s->state = MIG_STATE_ACTIVE;

    s->mon = NULL;

    s->bandwidth_limit = bandwidth_limit;

    s->fd = socket(PF_INET, SOCK_STREAM, 0);

    if (s->fd == -1) {

        qemu_free(s);

        return NULL;

    }



    socket_set_nonblock(s->fd);



    if (!detach) {

        migrate_fd_monitor_suspend(s, mon);

    }



    do {

        ret = connect(s->fd, (struct sockaddr *)&addr, sizeof(addr));

        if (ret == -1)

            ret = -(s->get_error(s));



        if (ret == -EINPROGRESS || ret == -EWOULDBLOCK)

            qemu_set_fd_handler2(s->fd, NULL, NULL, tcp_wait_for_connect, s);

    } while (ret == -EINTR);



    if (ret < 0 && ret != -EINPROGRESS && ret != -EWOULDBLOCK) {

        dprintf("connect failed\n");

        close(s->fd);

        qemu_free(s);

        return NULL;

    } else if (ret >= 0)

        migrate_fd_connect(s);



    return &s->mig_state;

}
