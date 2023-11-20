sub_40117C proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+s1], rdi
    mov     rax, [rbp+s1]
    mov     esi, offset s2; "fireball"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_4011BC
    mov     rax, [rbp+s1]
    add     rax, 28h ; '('
    mov     rdi, rax
    call    sub_400CEC
    mov     edi, 1; seconds
    call    _sleep
    jmp     loc_40132B
loc_4011BC:
    mov     rax, [rbp+s1]
    mov     esi, offset aIceball; "iceball"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_4011F0
    mov     edi, 0; seconds
    call    _sleep
    mov     rax, [rbp+s1]
    add     rax, 28h ; '('
    mov     rdi, rax
    call    sub_400D58
    jmp     loc_40132B
loc_4011F0:
    mov     rax, [rbp+s1]
    mov     esi, offset aMagicball; "magicball"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_401224
    mov     edi, 0; seconds
    call    _sleep
    mov     rax, [rbp+s1]
    add     rax, 28h ; '('
    mov     rdi, rax
    call    sub_400DA0
    jmp     loc_40132B
loc_401224:
    mov     rax, [rbp+s1]
    mov     esi, offset aLightning; "lightning"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_401258
    mov     rax, [rbp+s1]
    add     rax, 28h ; '('
    mov     rdi, rax
    call    sub_400E40
    mov     edi, 0; seconds
    call    _sleep
    jmp     loc_40132B
loc_401258:
    mov     rax, [rbp+s1]
    mov     esi, offset aHellfire; "hellfire"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_40128C
    mov     rax, [rbp+s1]
    add     rax, 28h ; '('
    mov     rdi, rax
    call    sub_400EC8
    mov     edi, 0; seconds
    call    _sleep
    jmp     loc_40132B
loc_40128C:
    mov     rax, [rbp+s1]
    mov     esi, offset aIcesword; "icesword"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_4012BD
    mov     rax, [rbp+s1]
    add     rax, 28h ; '('
    mov     rdi, rax
    call    sub_400F46
    mov     edi, 1; seconds
    call    _sleep
    jmp     short loc_40132B
loc_4012BD:
    mov     rax, [rbp+s1]
    mov     esi, offset aMagicsword; "magicsword"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_4012EE
    mov     rax, [rbp+s1]
    add     rax, 28h ; '('
    mov     rdi, rax
    call    sub_400FA6
    mov     edi, 0; seconds
    call    _sleep
    jmp     short loc_40132B
loc_4012EE:
    mov     rax, [rbp+s1]
    mov     esi, offset aHollylight; "hollylight"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_40131F
    mov     rax, [rbp+s1]
    add     rax, 28h ; '('
    mov     rdi, rax
    call    sub_40105E
    mov     edi, 0; seconds
    call    _sleep
    jmp     short loc_40132B
loc_40131F:
    mov     rax, [rbp+s1]
    mov     rdi, rax
    call    sub_4010EE
loc_40132B:
    nop
    leave
    retn
sub_40117C endp

