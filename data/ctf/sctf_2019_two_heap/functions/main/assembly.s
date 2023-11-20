main proc
    push    rbx
    sub     rsp, 30h
    mov     [rsp+38h+var_30], rsi
    lea     rbx, [rsp+38h+var_1C]
    mov     rax, fs:28h
    mov     [rsp+38h+var_10], rax
    xor     eax, eax
    mov     [rsp+38h+var_30], 0
    mov     [rsp+38h+arg_E8], 0
    call    sub_12D0
    lea     rdi, s; "Welcome to SCTF:"
    mov     [rsp+38h+var_1C], 0
    mov     [rsp+38h+var_14], 0
    call    _puts
    mov     esi, 0Bh
    mov     rdi, rbx
    call    sub_1350
    push    0FFFFFFFFFFFFFFFFh
    mov     r9d, 0FFFFFFFFh
    mov     rsi, rbx
    push    0FFFFFFFFFFFFFFFFh
    mov     r8d, r9d
    mov     ecx, r9d
    mov     edx, r9d
    push    0FFFFFFFFFFFFFFFFh
    mov     edi, 1
    xor     eax, eax
    push    0FFFFFFFFFFFFFFFFh
    push    0FFFFFFFFFFFFFFFFh
    push    0FFFFFFFFFFFFFFFFh
    push    0FFFFFFFFFFFFFFFFh
    push    0FFFFFFFFFFFFFFFFh
    push    0FFFFFFFFFFFFFFFFh
    push    0FFFFFFFFFFFFFFFFh
    push    0FFFFFFFFFFFFFFFFh
    push    0FFFFFFFFFFFFFFFFh
    call    ___printf_chk
    add     rsp, 60h
loc_117D:
    xor     eax, eax
    call    sub_1440
    cmp     eax, 1
    jz      short loc_11A8
    cmp     eax, 2
    jz      short loc_11B8
    lea     rdi, aExit_0; "exit."
    call    _puts
    xor     edi, edi; status
    call    _exit
loc_11A8:
    xor     eax, eax
    call    sub_14A0
    jmp     short loc_117D
loc_11B8:
    xor     eax, eax
    call    sub_15A0
    jmp     short loc_117D
main endp

