get_data proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 50h
    mov     [rbp+var_48], rdi
    mov     eax, esi
    mov     [rbp+var_4C], al
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_34], 0
    jmp     short loc_159C
loc_155E:
    mov     edx, [rbp+var_34]
    lea     rax, [rbp+s]
    mov     ecx, edx
    lea     rdx, aLongD; "long %d"
    mov     esi, 20h ; ' '; maxlen
    mov     rdi, rax; s
    mov     eax, 0
    call    _snprintf
    lea     rax, [rbp+s]
    mov     rdi, rax
    call    get_long
    mov     rdx, [rbp+var_48]
    mov     [rdx], rax
    add     [rbp+var_48], 8
    add     [rbp+var_34], 1
loc_159C:
    movzx   eax, [rbp+var_4C]
    cmp     [rbp+var_34], eax
    jl      short loc_155E
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_15BA
    call    ___stack_chk_fail
locret_15BA:
    leave
    retn
get_data endp

