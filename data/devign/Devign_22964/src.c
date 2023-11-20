static target_long monitor_get_xer (const struct MonitorDef *md, int val)

{

    CPUState *env = mon_get_cpu();

    if (!env)

        return 0;

    return env->xer;

}
