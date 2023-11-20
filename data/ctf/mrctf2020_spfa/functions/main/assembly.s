main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    lea     rax, dword_206CE0
    mov     cs:flag, rax
    mov     rax, cs:flag
    mov     dword ptr [rax], 0FFFFFFFFh
    mov     eax, 0
    call    menu
loc_EA4:
    mov     eax, 0
    call    ask
    lea     rax, [rbp+var_18]
    mov     rsi, rax
    lea     rdi, aD_0; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_18]
    cmp     eax, 2
    jz      loc_F6E
    cmp     eax, 2
    jg      short loc_EE1
    cmp     eax, 1
    jz      short loc_EF8
    jmp     loc_FE9
loc_EE1:
    cmp     eax, 3
    jz      loc_FD3
    cmp     eax, 4
    jz      loc_FDF
    jmp     loc_FE9
loc_EF8:
    lea     rdi, aInputFromToAnd; "input from to and length:"
    call    _puts
    lea     rcx, [rbp+var_C]
    lea     rdx, [rbp+var_10]
    lea     rax, [rbp+var_14]
    mov     rsi, rax
    lea     rdi, aDDD; "%d%d%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     edx, [rbp+var_C]
    mov     ecx, [rbp+var_10]
    mov     eax, [rbp+var_14]
    mov     esi, ecx
    mov     edi, eax
    call    check
    test    eax, eax
    jz      short loc_F5D
    mov     edx, [rbp+var_C]
    mov     ecx, [rbp+var_10]
    mov     eax, [rbp+var_14]
    mov     esi, ecx
    mov     edi, eax
    call    add
    lea     rdi, aAddSucceed; "add succeed"
    call    _puts
    jmp     loc_FF3
loc_F5D:
    lea     rdi, aDonTThinkThat; "don't think that"
    call    _puts
    jmp     loc_FF3
loc_F6E:
    lea     rdi, aInputFromAndTo; "input from and to:"
    call    _puts
    lea     rdx, [rbp+var_10]
    lea     rax, [rbp+var_14]
    mov     rsi, rax
    lea     rdi, aDD; "%d%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_14]
    cmp     eax, 1Dh
    jg      short loc_FC5
    mov     eax, [rbp+var_14]
    test    eax, eax
    js      short loc_FC5
    mov     eax, [rbp+var_10]
    cmp     eax, 1Dh
    jg      short loc_FC5
    mov     eax, [rbp+var_10]
    test    eax, eax
    js      short loc_FC5
    mov     edx, [rbp+var_10]
    mov     eax, [rbp+var_14]
    mov     esi, edx
    mov     edi, eax
    call    SPFA
    jmp     short loc_FF3
loc_FC5:
    lea     rdi, aDonTThinkThat; "don't think that"
    call    _puts
    jmp     short loc_FF3
loc_FD3:
    mov     eax, 0
    call    getflag
    jmp     short loc_FF3
loc_FDF:
    mov     edi, 0; status
    call    _exit
loc_FE9:
    mov     edi, 0; status
    call    _exit
loc_FF3:
    jmp     loc_EA4
main endp

