static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)

{

    M68kCPU *cpu = M68K_CPU(dev);

    M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);



    m68k_cpu_init_gdb(cpu);



    cpu_reset(CPU(cpu));



    mcc->parent_realize(dev, errp);

}
