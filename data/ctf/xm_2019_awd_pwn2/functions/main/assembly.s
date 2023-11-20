main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    sub_11D5
loc_165F:
    mov     eax, 0
    call    sub_15C0
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 2
    jz      short loc_169A
    cmp     [rbp+var_C], 2
    jg      short loc_1680
    cmp     [rbp+var_C], 1
    jz      short loc_168E
    jmp     short loc_16BC
loc_1680:
    cmp     [rbp+var_C], 3
    jz      short loc_16A6
    cmp     [rbp+var_C], 4
    jz      short loc_16B2
    jmp     short loc_16BC
loc_168E:
    mov     eax, 0
    call    sub_134D
    jmp     short loc_16BC
loc_169A:
    mov     eax, 0
    call    sub_1470
    jmp     short loc_16BC
loc_16A6:
    mov     eax, 0
    call    sub_151E
    jmp     short loc_16BC
loc_16B2:
    mov     edi, 0; status
    call    _exit
loc_16BC:
    jmp     short loc_165F
main endp

