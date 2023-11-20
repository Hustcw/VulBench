void gicv3_cpuif_update(GICv3CPUState *cs)
{
    /* Tell the CPU about its highest priority pending interrupt */
    int irqlevel = 0;
    int fiqlevel = 0;
    ARMCPU *cpu = ARM_CPU(cs->cpu);
    CPUARMState *env = &cpu->env;
    trace_gicv3_cpuif_update(gicv3_redist_affid(cs), cs->hppi.irq,
                             cs->hppi.grp, cs->hppi.prio);
    if (cs->hppi.grp == GICV3_G1 && !arm_feature(env, ARM_FEATURE_EL3)) {
        /* If a Security-enabled GIC sends a G1S interrupt to a
         * Security-disabled CPU, we must treat it as if it were G0.
         */
        cs->hppi.grp = GICV3_G0;
    }
    if (icc_hppi_can_preempt(cs)) {
        /* We have an interrupt: should we signal it as IRQ or FIQ?
         * This is described in the GICv3 spec section 4.6.2.
         */
        bool isfiq;
        switch (cs->hppi.grp) {
        case GICV3_G0:
            isfiq = true;
            break;
        case GICV3_G1:
            isfiq = (!arm_is_secure(env) ||
                     (arm_current_el(env) == 3 && arm_el_is_aa64(env, 3)));
            break;
        case GICV3_G1NS:
            isfiq = arm_is_secure(env);
            break;
        default:
            g_assert_not_reached();
        }
        if (isfiq) {
            fiqlevel = 1;
        } else {
            irqlevel = 1;
        }
    }
    trace_gicv3_cpuif_set_irqs(gicv3_redist_affid(cs), fiqlevel, irqlevel);
    qemu_set_irq(cs->parent_fiq, fiqlevel);
    qemu_set_irq(cs->parent_irq, irqlevel);
}