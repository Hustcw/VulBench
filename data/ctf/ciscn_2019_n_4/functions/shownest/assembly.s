shownest proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aIndex; "Index :"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 4; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_14], eax
    cmp     [rbp+var_14], 0
    js      short loc_400BB4
    cmp     [rbp+var_14], 9
    jle     short loc_400BC8
loc_400BB4:
    mov     edi, offset aOobMyBoy; "OOB!My Boy!"
    call    _puts
    mov     edi, 0; status
    call    __exit
loc_400BC8:
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:nests[rax*8]
    test    rax, rax
    jz      short loc_400C19
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:nests[rax*8]
    mov     rdx, [rax+8]
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:nests[rax*8]
    mov     rax, [rax]
    mov     rsi, rax
    mov     edi, offset aSizeLdDecorati; "Size : %ld\nDecorations : %s\n"
    mov     eax, 0
    call    _printf
    mov     edi, offset aDone; "Done !"
    call    _puts
    jmp     short loc_400C23
loc_400C19:
    mov     edi, offset aNoSuchNest; "No such nest !"
    call    _puts
loc_400C23:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400C38
    call    ___stack_chk_fail
locret_400C38:
    leave
    retn
shownest endp

