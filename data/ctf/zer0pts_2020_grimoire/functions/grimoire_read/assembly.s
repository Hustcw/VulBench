grimoire_read proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 220h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:fp
    test    rax, rax
    jnz     short loc_1123
    lea     rdi, aYouDonTEvenOpe; "You don't even open the book."
    call    _puts
    jmp     loc_1224
loc_1123:
    mov     eax, cs:init
    test    eax, eax
    jnz     loc_11F4
    mov     cs:init, 1
    mov     rax, cs:fp
    mov     edx, 2; whence
    mov     esi, 0; off
    mov     rdi, rax; stream
    call    _fseek
    mov     rax, cs:fp
    mov     rdi, rax; stream
    call    _ftell
    mov     [rbp+var_212], ax
    mov     rax, cs:fp
    mov     edx, 0; whence
    mov     esi, 0; off
    mov     rdi, rax; stream
    call    _fseek
    lea     rax, [rbp+s]
    mov     edx, 200h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    mov     rcx, cs:fp; stream
    movzx   edx, [rbp+var_212]; n
    lea     rax, [rbp+s]
    mov     esi, 1; size
    mov     rdi, rax; ptr
    call    _fread
    test    rax, rax
    jnz     short loc_11D8
    lea     rsi, aEmptyFileStrea; "Empty file stream"
    lea     rdi, aFread_0; "fread"
    call    error
    jmp     short loc_1224
loc_11D8:
    lea     rax, text
    lea     rdx, [rbp+s]
    mov     ecx, 40h ; '@'
    mov     rdi, rax
    mov     rsi, rdx
    rep movsq
loc_11F4:
    lea     rdi, asc_16F8; "*--------------------------------------"...
    call    _puts
    lea     rsi, text
    lea     rdi, aS; "%s"
    mov     eax, 0
    call    _printf
    lea     rdi, asc_16F8; "*--------------------------------------"...
    call    _puts
loc_1224:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1238
    call    ___stack_chk_fail
locret_1238:
    leave
    retn
grimoire_read endp

