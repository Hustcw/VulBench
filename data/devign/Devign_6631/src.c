static int bdrv_qed_open(BlockDriverState *bs, int flags)

{

    BDRVQEDState *s = bs->opaque;

    QEDHeader le_header;

    int64_t file_size;

    int ret;



    s->bs = bs;

    QSIMPLEQ_INIT(&s->allocating_write_reqs);



    ret = bdrv_pread(bs->file, 0, &le_header, sizeof(le_header));

    if (ret < 0) {

        return ret;

    }

    ret = 0; /* ret should always be 0 or -errno */

    qed_header_le_to_cpu(&le_header, &s->header);



    if (s->header.magic != QED_MAGIC) {

        return -EINVAL;

    }

    if (s->header.features & ~QED_FEATURE_MASK) {

        /* image uses unsupported feature bits */

        char buf[64];

        snprintf(buf, sizeof(buf), "%" PRIx64,

            s->header.features & ~QED_FEATURE_MASK);

        qerror_report(QERR_UNKNOWN_BLOCK_FORMAT_FEATURE,

            bs->device_name, "QED", buf);

        return -ENOTSUP;

    }

    if (!qed_is_cluster_size_valid(s->header.cluster_size)) {

        return -EINVAL;

    }



    /* Round down file size to the last cluster */

    file_size = bdrv_getlength(bs->file);

    if (file_size < 0) {

        return file_size;

    }

    s->file_size = qed_start_of_cluster(s, file_size);



    if (!qed_is_table_size_valid(s->header.table_size)) {

        return -EINVAL;

    }

    if (!qed_is_image_size_valid(s->header.image_size,

                                 s->header.cluster_size,

                                 s->header.table_size)) {

        return -EINVAL;

    }

    if (!qed_check_table_offset(s, s->header.l1_table_offset)) {

        return -EINVAL;

    }



    s->table_nelems = (s->header.cluster_size * s->header.table_size) /

                      sizeof(uint64_t);

    s->l2_shift = ffs(s->header.cluster_size) - 1;

    s->l2_mask = s->table_nelems - 1;

    s->l1_shift = s->l2_shift + ffs(s->table_nelems) - 1;



    if ((s->header.features & QED_F_BACKING_FILE)) {

        if ((uint64_t)s->header.backing_filename_offset +

            s->header.backing_filename_size >

            s->header.cluster_size * s->header.header_size) {

            return -EINVAL;

        }



        ret = qed_read_string(bs->file, s->header.backing_filename_offset,

                              s->header.backing_filename_size, bs->backing_file,

                              sizeof(bs->backing_file));

        if (ret < 0) {

            return ret;

        }



        if (s->header.features & QED_F_BACKING_FORMAT_NO_PROBE) {

            pstrcpy(bs->backing_format, sizeof(bs->backing_format), "raw");

        }

    }



    /* Reset unknown autoclear feature bits.  This is a backwards

     * compatibility mechanism that allows images to be opened by older

     * programs, which "knock out" unknown feature bits.  When an image is

     * opened by a newer program again it can detect that the autoclear

     * feature is no longer valid.

     */

    if ((s->header.autoclear_features & ~QED_AUTOCLEAR_FEATURE_MASK) != 0 &&

        !bdrv_is_read_only(bs->file)) {

        s->header.autoclear_features &= QED_AUTOCLEAR_FEATURE_MASK;



        ret = qed_write_header_sync(s);

        if (ret) {

            return ret;

        }



        /* From here on only known autoclear feature bits are valid */

        bdrv_flush(bs->file);

    }



    s->l1_table = qed_alloc_table(s);

    qed_init_l2_cache(&s->l2_cache);



    ret = qed_read_l1_table_sync(s);

    if (ret) {

        goto out;

    }



    /* If image was not closed cleanly, check consistency */

    if (s->header.features & QED_F_NEED_CHECK) {

        /* Read-only images cannot be fixed.  There is no risk of corruption

         * since write operations are not possible.  Therefore, allow

         * potentially inconsistent images to be opened read-only.  This can

         * aid data recovery from an otherwise inconsistent image.

         */

        if (!bdrv_is_read_only(bs->file)) {

            BdrvCheckResult result = {0};



            ret = qed_check(s, &result, true);

            if (!ret && !result.corruptions && !result.check_errors) {

                /* Ensure fixes reach storage before clearing check bit */

                bdrv_flush(s->bs);



                s->header.features &= ~QED_F_NEED_CHECK;

                qed_write_header_sync(s);

            }

        }

    }



out:

    if (ret) {

        qed_free_l2_cache(&s->l2_cache);

        qemu_vfree(s->l1_table);

    }

    return ret;

}
