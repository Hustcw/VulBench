main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+argc], edi
    mov     [rbp+argv], rsi
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     edi, 20h ; ' '; sz
    call    secure_malloc
    mov     [rbp+ws], rax
    mov     rax, [rbp+ws]
    mov     edx, 20h ; ' '; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rdi, prompt_str; "type (plain, encoded, encrypted)"
    call    prompt
    mov     [rbp+type], rax
    mov     rax, [rbp+type]
    mov     rsi, rax; s2
    lea     rdi, s1; "plain"
    call    _strcmp
    test    eax, eax
    jnz     short loc_12DF
    mov     rax, [rbp+ws]
    mov     dword ptr [rax], 1
    jmp     short loc_133B
loc_12DF:
    mov     rax, [rbp+type]
    mov     rsi, rax; s2
    lea     rdi, aEncoded; "encoded"
    call    _strcmp
    test    eax, eax
    jnz     short loc_1302
    mov     rax, [rbp+ws]
    mov     dword ptr [rax], 2
    jmp     short loc_133B
loc_1302:
    mov     rax, [rbp+type]
    mov     rsi, rax; s2
    lea     rdi, aEncrypted; "encrypted"
    call    _strcmp
    test    eax, eax
    jnz     short loc_1325
    mov     rax, [rbp+ws]
    mov     dword ptr [rax], 3
    jmp     short loc_133B
loc_1325:
    lea     rdi, s; "Invalid type!"
    call    _puts
    mov     eax, 1
    jmp     locret_14CE
loc_133B:
    mov     rax, [rbp+ws]
    mov     eax, [rax]
    mov     edi, eax; type
    call    print_menu
    lea     rdi, aCommand; "command"
    call    prompt
    mov     [rbp+cmd], rax
    cmp     [rbp+cmd], 0
    jnz     short loc_1375
    lea     rdi, aExiting; "Exiting!"
    call    _puts
    mov     eax, 0
    jmp     locret_14CE
loc_1375:
    mov     rax, [rbp+cmd]
    lea     rsi, s2; "quit"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jz      short loc_13A3
    mov     rax, [rbp+cmd]
    lea     rsi, aExit_0; "exit"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_13AD
loc_13A3:
    mov     eax, 0
    jmp     locret_14CE
loc_13AD:
    mov     rax, [rbp+cmd]
    lea     rsi, cmd; "set_input"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_13D5
    mov     rax, [rbp+ws]
    mov     rdi, rax; ws
    call    set_input
    jmp     loc_14C9
loc_13D5:
    mov     rax, [rbp+cmd]
    lea     rsi, aSetEncoding; "set_encoding"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_141C
    mov     rax, [rbp+ws]
    mov     eax, [rax]
    and     eax, 3
    cmp     eax, 3
    jnz     short loc_140B
    lea     rdi, aNoEncodingForE; "No encoding for encrypted type!"
    call    _puts
    jmp     loc_14C9
loc_140B:
    mov     rax, [rbp+ws]
    mov     rdi, rax; ws
    call    set_encoding
    jmp     loc_14C9
loc_141C:
    mov     rax, [rbp+cmd]
    lea     rsi, aPrint; "print"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_1444
    mov     rax, [rbp+ws]
    mov     rdi, rax; ws
    call    print_state
    jmp     loc_14C9
loc_1444:
    mov     rax, [rbp+cmd]
    lea     rsi, aSetKey; "set_key"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_1485
    mov     rax, [rbp+ws]
    mov     eax, [rax]
    and     eax, 3
    cmp     eax, 3
    jz      short loc_1477
    lea     rdi, aCanOnlySetKeyF; "Can only set key for encrypted type."
    call    _puts
    jmp     short loc_14C9
loc_1477:
    mov     rax, [rbp+ws]
    mov     rdi, rax; ws
    call    set_key
    jmp     short loc_14C9
loc_1485:
    mov     rax, [rbp+cmd]
    lea     rsi, aEncrypt; "encrypt"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     loc_133B
    mov     rax, [rbp+ws]
    mov     eax, [rax]
    and     eax, 3
    cmp     eax, 3
    jz      short loc_14BC
    lea     rdi, aCanOnlyEncrypt; "Can only encrypt for encrypted type."
    call    _puts
    jmp     short loc_14C9
loc_14BC:
    mov     rax, [rbp+ws]
    mov     rdi, rax; ws
    call    do_encrypt
    nop
loc_14C9:
    jmp     loc_133B
locret_14CE:
    leave
    retn
main endp

