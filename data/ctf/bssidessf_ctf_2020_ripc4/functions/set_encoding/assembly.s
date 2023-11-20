set_encoding proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+ws], rdi
    lea     rdi, aEncodingBase64; "encoding (base64, hex)"
    call    prompt
    mov     [rbp+enc], rax
    mov     rax, [rbp+enc]
    mov     rsi, rax; s2
    lea     rdi, aBase64; "base64"
    call    _strcasecmp
    test    eax, eax
    jnz     short loc_18F3
    mov     rax, [rbp+ws]
    lea     rdx, print_base64
    mov     [rax+18h], rdx
    jmp     short loc_1927
loc_18F3:
    mov     rax, [rbp+enc]
    mov     rsi, rax; s2
    lea     rdi, aHex; "hex"
    call    _strcasecmp
    test    eax, eax
    jnz     short loc_191B
    mov     rax, [rbp+ws]
    lea     rdx, print_hex
    mov     [rax+18h], rdx
    jmp     short loc_1927
loc_191B:
    lea     rdi, aInvalidEncodin; "Invalid encoding!"
    call    _puts
loc_1927:
    nop
    leave
    retn
set_encoding endp

