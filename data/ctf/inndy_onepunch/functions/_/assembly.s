_ proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, loc_4006D1
    and     rdi, 0FFFFFFFFFFFFF000h; start
    mov     rsi, 1000h; len
    mov     rdx, 7; prot
    mov     rax, 0Ah
    syscall; LINUX - sys_mprotect
    nop
    pop     rbp
    retn
_ endp

