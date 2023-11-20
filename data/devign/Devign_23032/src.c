static void tcp_wait_for_connect(void *opaque)

{

    MigrationState *s = opaque;

    int val, ret;

    socklen_t valsize = sizeof(val);



    DPRINTF("connect completed\n");

    do {

        ret = getsockopt(s->fd, SOL_SOCKET, SO_ERROR, (void *) &val, &valsize);

    } while (ret == -1 && (socket_error()) == EINTR);



    if (ret < 0) {

        migrate_fd_error(s);

        return;

    }



    qemu_set_fd_handler2(s->fd, NULL, NULL, NULL, NULL);



    if (val == 0)

        migrate_fd_connect(s);

    else {

        DPRINTF("error connecting %d\n", val);

        migrate_fd_error(s);

    }

}
