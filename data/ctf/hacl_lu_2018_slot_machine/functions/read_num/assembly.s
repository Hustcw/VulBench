read_num proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rdx, cs:stdin@@GLIBC_2_2_5; stream
    lea     rax, [rbp+s]
    mov     esi, 20h ; ' '; n
    mov     rdi, rax; s
    call    _fgets
    lea     rax, [rbp+s]
    mov     rdi, rax; nptr
    call    _atol
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_1218
    call    ___stack_chk_fail
locret_1218:
    leave
    retn
read_num endp

