sub_400FB7 proc
    push    rbp
    mov     rbp, rsp
    lea     rsi, aDatabaseToWrit; "database to write to: "
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
    jnz     short loc_401054
    mov     esi, 2Ah ; '*'; c
    lea     rdi, name; s
    call    _strchr
    test    rax, rax
    jnz     short loc_401054
    mov     esi, 3Fh ; '?'; c
    lea     rdi, name; s
    call    _strchr
    test    rax, rax
    jz      short loc_40105E
loc_401054:
    mov     eax, cs:dword_6020FC
    test    eax, eax
    jz      short loc_40108F
loc_40105E:
    mov     cs:dword_6020FC, 1
    mov     esi, 0; type
    lea     rdi, name; name
    call    _access
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_4010AA
    lea     rdi, aTriedToOpenNon; "Tried to open non-existing database"
    call    _puts
    jmp     loc_40115D
loc_40108F:
    lea     rdi, aYouAreNotAllow; "You are not allowed access to that data"...
    call    _puts
    mov     cs:dword_6020FC, 0
    jmp     loc_40115D
loc_4010AA:
    lea     rsi, aDatabaseToWrit_0; "Database to write to: "
    lea     rdi, aS; "%s"
    mov     eax, 0
    call    _printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    _fflush
    mov     rax, cs:stdin
    mov     rdx, rax; stream
    mov     esi, 8; n
    lea     rdi, nptr; s
    call    _fgets
    lea     rsi, aDataToWrite; "Data to write: "
    lea     rdi, aS; "%s"
    mov     eax, 0
    call    _printf
    mov     rax, cs:stdout
    mov     rdi, rax; stream
    call    _fflush
    mov     rax, cs:stdin
    mov     rdx, rax; stream
    mov     esi, 0C8h; n
    lea     rdi, byte_602120; s
    call    _fgets
    lea     rdi, nptr; nptr
    call    _atoi
    mov     cs:dword_6022A0, eax
    mov     ecx, 0; arg
    lea     rdx, sub_400CE0; start_routine
    mov     esi, 0; attr
    lea     rdi, newthread; newthread
    call    _pthread_create
loc_40115D:
    pop     rbp
    retn
sub_400FB7 endp

