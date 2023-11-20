static void ptrace_hbptriggered(struct perf_event *bp, int unused,
static void ptrace_hbptriggered(struct perf_event *bp,
 				     struct perf_sample_data *data,
 				     struct pt_regs *regs)
 {
	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
	long num;
	int i;
	siginfo_t info;

	for (i = 0; i < ARM_MAX_HBP_SLOTS; ++i)
		if (current->thread.debug.hbp[i] == bp)
			break;

	num = (i == ARM_MAX_HBP_SLOTS) ? 0 : ptrace_hbp_idx_to_num(i);

	info.si_signo	= SIGTRAP;
	info.si_errno	= (int)num;
	info.si_code	= TRAP_HWBKPT;
	info.si_addr	= (void __user *)(bkpt->trigger);

	force_sig_info(SIGTRAP, &info, current);
}
