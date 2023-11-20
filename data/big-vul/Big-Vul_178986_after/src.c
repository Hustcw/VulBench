int do_mathemu(struct pt_regs *regs, struct task_struct *fpt)
{
	/* regs->pc isn't necessarily the PC at which the offending insn is sitting.
	 * The FPU maintains a queue of FPops which cause traps.
	 * When it hits an instruction that requires that the trapped op succeeded
	 * (usually because it reads a reg. that the trapped op wrote) then it
	 * causes this exception. We need to emulate all the insns on the queue
	 * and then allow the op to proceed.
	 * This code should also handle the case where the trap was precise,
	 * in which case the queue length is zero and regs->pc points at the
	 * single FPop to be emulated. (this case is untested, though :->)
	 * You'll need this case if you want to be able to emulate all FPops
	 * because the FPU either doesn't exist or has been software-disabled.
	 * [The UltraSPARC makes FP a precise trap; this isn't as stupid as it
	 * might sound because the Ultra does funky things with a superscalar
	 * architecture.]
	 */

	/* You wouldn't believe how often I typed 'ftp' when I meant 'fpt' :-> */

	int i;
 	int retcode = 0;                               /* assume all succeed */
 	unsigned long insn;
 
	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
 
 #ifdef DEBUG_MATHEMU
 	printk("In do_mathemu()... pc is %08lx\n", regs->pc);
	printk("fpqdepth is %ld\n", fpt->thread.fpqdepth);
	for (i = 0; i < fpt->thread.fpqdepth; i++)
		printk("%d: %08lx at %08lx\n", i, fpt->thread.fpqueue[i].insn,
		       (unsigned long)fpt->thread.fpqueue[i].insn_addr);
#endif

	if (fpt->thread.fpqdepth == 0) {                   /* no queue, guilty insn is at regs->pc */
#ifdef DEBUG_MATHEMU
		printk("precise trap at %08lx\n", regs->pc);
#endif
		if (!get_user(insn, (u32 __user *) regs->pc)) {
			retcode = do_one_mathemu(insn, &fpt->thread.fsr, fpt->thread.float_regs);
			if (retcode) {
				/* in this case we need to fix up PC & nPC */
				regs->pc = regs->npc;
				regs->npc += 4;
			}
		}
		return retcode;
	}

	/* Normal case: need to empty the queue... */
	for (i = 0; i < fpt->thread.fpqdepth; i++) {
		retcode = do_one_mathemu(fpt->thread.fpqueue[i].insn, &(fpt->thread.fsr), fpt->thread.float_regs);
		if (!retcode)                               /* insn failed, no point doing any more */
			break;
	}
	/* Now empty the queue and clear the queue_not_empty flag */
	if (retcode)
		fpt->thread.fsr &= ~(0x3000 | FSR_CEXC_MASK);
	else
		fpt->thread.fsr &= ~0x3000;
	fpt->thread.fpqdepth = 0;

	return retcode;
}
