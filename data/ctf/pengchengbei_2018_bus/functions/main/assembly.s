main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    sub_AEB
    lea     rdi, aWelcomeToTheNe; "Welcome to the Ne0's bus!"
    call    _puts
loc_107A:
    mov     eax, 0
    call    sub_BEF
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 2
    jz      short loc_10C8
    cmp     eax, 2
    jg      short loc_10B0
    cmp     eax, 1
    jz      short loc_10BC
    jmp     short loc_10EA
loc_10B0:
    cmp     eax, 3
    jz      short loc_10D4
    cmp     eax, 4
    jz      short loc_10E0
    jmp     short loc_10EA
loc_10BC:
    mov     eax, 0
    call    sub_CAA
    jmp     short loc_1100
loc_10C8:
    mov     eax, 0
    call    sub_E0B
    jmp     short loc_1100
loc_10D4:
    mov     eax, 0
    call    sub_E9E
    jmp     short loc_1100
loc_10E0:
    mov     edi, 0; status
    call    _exit
loc_10EA:
    lea     rdi, aInvalidChoice; "Invalid choice!"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_1100:
    jmp     loc_107A
main endp

