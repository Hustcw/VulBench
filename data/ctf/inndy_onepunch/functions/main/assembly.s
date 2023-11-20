main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:__bss_start
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     edi, offset format; "Where What?"
    mov     eax, 0
    call    _printf
    lea     rdx, [rbp+var_18]
    lea     rax, [rbp+var_10]
    mov     rsi, rax
    mov     edi, offset aLlxD; "%llx %d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     [rbp+var_14], eax
    cmp     [rbp+var_14], 2
    jz      short loc_400756
    mov     eax, 0
    jmp     short loc_400778
loc_400756:
    mov     rax, [rbp+var_10]
    mov     edx, [rbp+var_18]
    mov     [rax], dl
    mov     eax, [rbp+var_18]
    cmp     eax, 0FFh
    jnz     short loc_400773
    mov     edi, offset s; "No flag for you"
    call    _puts
loc_400773:
    mov     eax, 0
loc_400778:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_40078C
    call    ___stack_chk_fail
locret_40078C:
    leave
    retn
main endp

