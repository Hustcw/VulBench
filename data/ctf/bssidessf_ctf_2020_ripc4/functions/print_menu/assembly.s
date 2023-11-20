print_menu proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+type], edi
    lea     rdi, byte_3118; s
    call    _puts
    lea     rsi, desc; "Set the input value"
    lea     rdi, cmd; "set_input"
    call    print_menu_line
    cmp     [rbp+type], 1
    jnz     short loc_1544
    lea     rsi, aPrintTheOutput; "Print the output value"
    lea     rdi, aPrint; "print"
    call    print_menu_line
    jmp     short loc_159E
loc_1544:
    cmp     [rbp+type], 2
    jnz     short loc_1572
    lea     rsi, aPrintTheOutput; "Print the output value"
    lea     rdi, aPrint; "print"
    call    print_menu_line
    lea     rsi, aSetTheEncoding; "Set the encoding scheme."
    lea     rdi, aSetEncoding; "set_encoding"
    call    print_menu_line
    jmp     short loc_159E
loc_1572:
    cmp     [rbp+type], 3
    jnz     short loc_159E
    lea     rsi, aSetTheRc4Key; "Set the RC4 key."
    lea     rdi, aSetKey; "set_key"
    call    print_menu_line
    lea     rsi, aPerformEncrypt; "Perform encryption."
    lea     rdi, aEncrypt; "encrypt"
    call    print_menu_line
loc_159E:
    lea     rsi, aQuitTheProgram; "Quit the Program"
    lea     rdi, s2; "quit"
    call    print_menu_line
    lea     rdi, byte_3118; s
    call    _puts
    nop
    leave
    retn
print_menu endp

