sub_400E30 proc
    push    rbp
    mov     rbp, rsp
    lea     rsi, aDatabaseToRead; "database to read from: "
    lea     rdi, aS; "%s"
    mov     eax, 0
    call    _printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    _fflush
    mov     rax, cs:stdin
    mov     rdx, rax; stream
    mov     esi, 64h ; 'd'; n
    lea     rdi, name; s
    call    _fgets
    lea     rsi, delim; "\n"
    lea     rdi, name; s
    call    _strtok
    lea     rsi, needle; "flag"
    lea     rdi, name; haystack
    call    _strstr
    test    rax, rax
    jnz     short loc_400ECD
    mov     esi, 2Ah ; '*'; c
    lea     rdi, name; s
    call    _strchr
    test    rax, rax
    jnz     short loc_400ECD
    mov     esi, 3Fh ; '?'; c
    lea     rdi, name; s
    call    _strchr
    test    rax, rax
    jz      short loc_400ED7
loc_400ECD:
    mov     eax, cs:dword_6020FC
    test    eax, eax
    jz      short loc_400F08
loc_400ED7:
    mov     cs:dword_6020FC, 1
    mov     esi, 0; type
    lea     rdi, name; name
    call    _access
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_400F23
    lea     rdi, aTriedToOpenNon; "Tried to open non-existing database"
    call    _puts
    jmp     loc_400FB5
loc_400F08:
    lea     rdi, aYouAreNotAllow; "You are not allowed access to that data"...
    call    _puts
    mov     cs:dword_6020FC, 0
    jmp     loc_400FB5
loc_400F23:
    lea     rsi, aDatabaseToRead_0; "database to read: "
    lea     rdi, aS; "%s"
    mov     eax, 0
    call    _printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    _fflush
    mov     rax, cs:stdin
    mov     rdx, rax; stream
    mov     esi, 7; n
    lea     rdi, nptr; s
    call    _fgets
    lea     rdi, nptr; nptr
    call    _atoi
    add     eax, 1
    mov     cs:dword_6022A0, eax
    mov     ecx, 0; arg
    lea     rdx, start_routine; start_routine
    mov     esi, 0; attr
    lea     rdi, th; newthread
    call    _pthread_create
    mov     rax, cs:th
    mov     esi, 0; thread_return
    mov     rdi, rax; th
    call    _pthread_join
    mov     cs:dword_6020FC, 0
loc_400FB5:
    pop     rbp
    retn
sub_400E30 endp

