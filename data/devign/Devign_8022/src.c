static int openfile(char *name, int flags, QDict *opts)

{

    Error *local_err = NULL;




    if (qemuio_blk) {

        fprintf(stderr, "file open already, try 'help close'\n");

        QDECREF(opts);

        return 1;

    }



    qemuio_blk = blk_new_open("hda", name, NULL, opts, flags, &local_err);

    if (!qemuio_blk) {

        fprintf(stderr, "%s: can't open%s%s: %s\n", progname,

                name ? " device " : "", name ?: "",

                error_get_pretty(local_err));

        error_free(local_err);

        return 1;

    }



    bs = blk_bs(qemuio_blk);

    if (bdrv_is_encrypted(bs)) {

        char password[256];

        printf("Disk image '%s' is encrypted.\n", name);

        if (qemu_read_password(password, sizeof(password)) < 0) {

            error_report("No password given");

            goto error;

        }

        if (bdrv_set_key(bs, password) < 0) {

            error_report("invalid password");

            goto error;

        }

    }





    return 0;



 error:

    blk_unref(qemuio_blk);

    qemuio_blk = NULL;

    return 1;

}