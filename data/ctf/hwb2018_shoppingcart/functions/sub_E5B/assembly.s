sub_E5B proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
loc_E72:
    lea     rdi, aEmmmmmYouWillB; "EMMmmm, you will be a rich man!"
    call    _puts
    mov     rdx, cs:stdin; stream
    lea     rax, [rbp+s]
    mov     esi, 18h; n
    mov     rdi, rax; s
    call    _fgets
    lea     rax, [rbp+s]
    mov     edx, 0; base
    mov     esi, 0; endptr
    mov     rdi, rax; nptr
    call    _strtoul
    mov     [rbp+var_28], rax
    mov     rax, [rbp+var_28]
    cmp     rax, 2
    jz      short loc_ED2
    cmp     rax, 3
    jz      short loc_EDF
    cmp     rax, 1
    jnz     short loc_EDD
    mov     eax, 0
    call    sub_D81
    jmp     short loc_EDD
loc_ED2:
    mov     eax, 0
    call    sub_E48
    nop
loc_EDD:
    jmp     short loc_E72
loc_EDF:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_EF4
    call    ___stack_chk_fail
locret_EF4:
    leave
    retn
sub_E5B endp

