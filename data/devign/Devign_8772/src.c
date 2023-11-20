int kvm_arch_init(KVMState *s)

{

    uint64_t identity_base = 0xfffbc000;

    int ret;

    struct utsname utsname;



    ret = kvm_get_supported_msrs(s);

    if (ret < 0) {

        return ret;

    }



    uname(&utsname);

    lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;



    /*

     * On older Intel CPUs, KVM uses vm86 mode to emulate 16-bit code directly.

     * In order to use vm86 mode, an EPT identity map and a TSS  are needed.

     * Since these must be part of guest physical memory, we need to allocate

     * them, both by setting their start addresses in the kernel and by

     * creating a corresponding e820 entry. We need 4 pages before the BIOS.

     *

     * Older KVM versions may not support setting the identity map base. In

     * that case we need to stick with the default, i.e. a 256K maximum BIOS

     * size.

     */

#ifdef KVM_CAP_SET_IDENTITY_MAP_ADDR

    if (kvm_check_extension(s, KVM_CAP_SET_IDENTITY_MAP_ADDR)) {

        /* Allows up to 16M BIOSes. */

        identity_base = 0xfeffc000;



        ret = kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);

        if (ret < 0) {

            return ret;

        }

    }

#endif

    /* Set TSS base one page after EPT identity map. */

    ret = kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, identity_base + 0x1000);

    if (ret < 0) {

        return ret;

    }



    /* Tell fw_cfg to notify the BIOS to reserve the range. */

    ret = e820_add_entry(identity_base, 0x4000, E820_RESERVED);

    if (ret < 0) {

        fprintf(stderr, "e820_add_entry() table is full\n");

        return ret;

    }




    return 0;

}