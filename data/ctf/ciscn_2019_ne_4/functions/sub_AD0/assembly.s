sub_AD0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdin
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    mov     rax, cs:stdout
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    mov     edx, 140h; n
    mov     esi, 0; c
    lea     rdi, unk_202040; s
    call    memset
    mov     edi, 3Ch ; '<'; seconds
    call    alarm
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_B58
    call    __stack_chk_fail
locret_B58:
    leave
    retn
sub_AD0 endp

