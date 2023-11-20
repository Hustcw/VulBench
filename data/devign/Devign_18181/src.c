static int img_map(int argc, char **argv)

{

    int c;

    OutputFormat output_format = OFORMAT_HUMAN;

    BlockBackend *blk;

    BlockDriverState *bs;

    const char *filename, *fmt, *output;

    int64_t length;

    MapEntry curr = { .length = 0 }, next;

    int ret = 0;

    bool image_opts = false;



    fmt = NULL;

    output = NULL;

    for (;;) {

        int option_index = 0;

        static const struct option long_options[] = {

            {"help", no_argument, 0, 'h'},

            {"format", required_argument, 0, 'f'},

            {"output", required_argument, 0, OPTION_OUTPUT},

            {"object", required_argument, 0, OPTION_OBJECT},

            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},

            {0, 0, 0, 0}

        };

        c = getopt_long(argc, argv, "f:h",

                        long_options, &option_index);

        if (c == -1) {

            break;

        }

        switch (c) {

        case '?':

        case 'h':

            help();

            break;

        case 'f':

            fmt = optarg;

            break;

        case OPTION_OUTPUT:

            output = optarg;

            break;

        case OPTION_OBJECT: {

            QemuOpts *opts;

            opts = qemu_opts_parse_noisily(&qemu_object_opts,

                                           optarg, true);

            if (!opts) {

                return 1;

            }

        }   break;

        case OPTION_IMAGE_OPTS:

            image_opts = true;

            break;

        }

    }

    if (optind != argc - 1) {

        error_exit("Expecting one image file name");

    }

    filename = argv[optind];



    if (output && !strcmp(output, "json")) {

        output_format = OFORMAT_JSON;

    } else if (output && !strcmp(output, "human")) {

        output_format = OFORMAT_HUMAN;

    } else if (output) {

        error_report("--output must be used with human or json as argument.");

        return 1;

    }



    if (qemu_opts_foreach(&qemu_object_opts,

                          user_creatable_add_opts_foreach,

                          NULL, NULL)) {

        return 1;

    }



    blk = img_open(image_opts, filename, fmt, 0, false, false);

    if (!blk) {

        return 1;

    }

    bs = blk_bs(blk);



    if (output_format == OFORMAT_HUMAN) {

        printf("%-16s%-16s%-16s%s\n", "Offset", "Length", "Mapped to", "File");

    }



    length = blk_getlength(blk);

    while (curr.start + curr.length < length) {

        int64_t nsectors_left;

        int64_t sector_num;

        int n;



        sector_num = (curr.start + curr.length) >> BDRV_SECTOR_BITS;



        /* Probe up to 1 GiB at a time.  */

        nsectors_left = DIV_ROUND_UP(length, BDRV_SECTOR_SIZE) - sector_num;

        n = MIN(1 << (30 - BDRV_SECTOR_BITS), nsectors_left);

        ret = get_block_status(bs, sector_num, n, &next);



        if (ret < 0) {

            error_report("Could not read file metadata: %s", strerror(-ret));

            goto out;

        }



        if (entry_mergeable(&curr, &next)) {

            curr.length += next.length;

            continue;

        }



        if (curr.length > 0) {

            dump_map_entry(output_format, &curr, &next);

        }

        curr = next;

    }



    dump_map_entry(output_format, &curr, NULL);



out:

    blk_unref(blk);

    return ret < 0;

}
