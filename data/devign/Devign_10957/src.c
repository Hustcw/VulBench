#define ERRNO_TABLE_SIZE 1200

/* target_to_host_errno_table[] is initialized from
 * host_to_target_errno_table[] in syscall_init(). */
static uint16_t target_to_host_errno_table[ERRNO_TABLE_SIZE] = {
};

static inline int target_to_host_errno(int err)
{
    if (target_to_host_errno_table[err])
        return target_to_host_errno_table[err];
    return err;
}

char *target_strerror(int err)
{
    return strerror(target_to_host_errno(err));
}
print_syscall_ret(int num, abi_long ret)

{

    int i;



    for(i=0;i<nsyscalls;i++)

        if( scnames[i].nr == num ) {

            if( scnames[i].result != NULL ) {

                scnames[i].result(&scnames[i],ret);

            } else {

                if( ret < 0 ) {

                    gemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n", -ret, target_strerror(-ret));

                } else {

                    gemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);

                }

            }

            break;

        }

}
