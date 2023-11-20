sub_40115F proc
    push    rbp
    mov     rbp, rsp
loc_401163:
    lea     rsi, aQuery; "Query: "
    lea     rdi, aS; "%s"
    mov     eax, 0
    call    _printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    _fflush
    mov     rax, cs:stdin
    mov     rdx, rax; stream
    mov     esi, 14h; n
    lea     rdi, haystack; s
    call    _fgets
    lea     rsi, aRead; "read"
    lea     rdi, haystack; haystack
    call    _strstr
    test    rax, rax
    jz      short loc_401203
    mov     eax, cs:dword_602100
    add     eax, 1
    mov     cs:dword_602100, eax
    mov     eax, cs:dword_602100
    cmp     eax, 2
    jle     short loc_4011F9
    lea     rdi, aYouHaveExhaust; "You have exhausted the request limit fo"...
    mov     eax, 0
    call    _printf
    push    qword ptr ds:_gets
    push    0
    push    qword ptr ds:handler
    retn
loc_4011F9:
    call    sub_400E30
    jmp     loc_401163
loc_401203:
    lea     rsi, aWrite; "write"
    lea     rdi, haystack; haystack
    call    _strstr
    test    rax, rax
    jz      short loc_401265
    call    sub_400FB7
    mov     eax, cs:dword_602100
    add     eax, 1
    mov     cs:dword_602100, eax
    mov     eax, cs:dword_602100
    cmp     eax, 2
    jle     loc_401163
    lea     rdi, aYouHaveExhaust; "You have exhausted the request limit fo"...
    mov     eax, 0
    call    _printf
    push    qword ptr ds:_gets
    push    0
    push    qword ptr ds:handler
    retn
    jmp     loc_401163
loc_401265:
    lea     rdi, aUnrecognisedCo; "Unrecognised command!"
    call    _puts
    jmp     loc_401163
sub_40115F endp

