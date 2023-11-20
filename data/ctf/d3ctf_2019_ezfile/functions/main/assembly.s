main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, 0
    call    initProc
    mov     esi, 1; newline
    lea     rdi, asc_1481; "---------------------------"
    call    myputs
    mov     esi, 1; newline
    lea     rdi, aWelcomeToD3Ctf; "welcome to D^3 CTF"
    call    myputs
    mov     esi, 1; newline
    lea     rdi, asc_1481; "---------------------------"
    call    myputs
    mov     esi, 0; newline
    lea     rdi, aYourName; "your name: "
    call    myputs
    mov     esi, 0; oflag
    lea     rdi, file; "/dev/urandom"
    mov     eax, 0
    call    _open
    mov     cs:fd, eax
    mov     eax, cs:fd
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_117D
    mov     esi, 1; newline
    lea     rdi, aErrorInOpening; "error in opening /dev/urandom"
    call    myputs
    mov     edi, 0; status
    call    _exit
loc_117D:
    lea     rsi, name
    lea     rdi, a90s; "%90s"
    mov     eax, 0
    call    ___isoc99_scanf
    lea     rsi, name
    lea     rdi, format; "welcome!%s.\n"
    mov     eax, 0
    call    _printf
    mov     edi, 300h; size
    call    _malloc
    mov     cs:key, rax
    mov     rax, cs:key
    test    rax, rax
    jnz     short loc_11E5
    mov     esi, 1; newline
    lea     rdi, aErrorInMallocK; "error in malloc key"
    call    myputs
    mov     edi, 0; status
    call    _exit
loc_11E5:
    mov     eax, cs:re_entry
    test    eax, eax
    jnz     short loc_121F
    mov     cs:re_entry, 1
    mov     rcx, cs:key
    mov     eax, cs:fd
    mov     edx, 300h; nbytes
    mov     rsi, rcx; buf
    mov     edi, eax; fd
    call    _read
    cmp     rax, 300h
    jz      short loc_1255
    jmp     short loc_123A
loc_121F:
    mov     esi, 1; newline
    lea     rdi, aReEntryDetecte; "re_entry detected!"
    call    myputs
    mov     edi, 0; status
    call    _exit
loc_123A:
    mov     esi, 1; newline
    lea     rdi, aErrorInReading; "error in reading /deb/urandom"
    call    myputs
    mov     edi, 0; status
    call    _exit
loc_1255:
    mov     eax, cs:fd
    mov     edi, eax; fd
    call    _close
loc_1262:
    mov     eax, 0
    call    putsMenu
    mov     eax, 0
    call    getNumber
    mov     [rbp+choice], eax
    mov     eax, [rbp+choice]
    cmp     eax, 2
    jz      short loc_1299
    cmp     eax, 3
    jz      short loc_12A5
    cmp     eax, 1
    jz      short loc_128D
    jmp     short loc_12B0
loc_128D:
    mov     eax, 0
    call    addNote
    jmp     short loc_12B0
loc_1299:
    mov     eax, 0
    call    deleteNote
    jmp     short loc_12B0
loc_12A5:
    mov     eax, 0
    call    encryptNode
    nop
loc_12B0:
    jmp     short loc_1262
main endp

