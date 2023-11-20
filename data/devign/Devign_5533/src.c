void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)

{

    Error *err = NULL;



    qmp_block_set_io_throttle(qdict_get_str(qdict, "device"),

                              qdict_get_int(qdict, "bps"),

                              qdict_get_int(qdict, "bps_rd"),

                              qdict_get_int(qdict, "bps_wr"),

                              qdict_get_int(qdict, "iops"),

                              qdict_get_int(qdict, "iops_rd"),

                              qdict_get_int(qdict, "iops_wr"), &err);

    hmp_handle_error(mon, &err);

}
