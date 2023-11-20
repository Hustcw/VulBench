main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:__bss_start
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
loc_400D76:
    mov     eax, 0
    call    menu
    lea     rax, [rbp+buf]
    mov     edx, 4; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    cmp     eax, 5; switch 6 cases
    ja      short def_400DB1; jumptable 0000000000400DB1 default case, case 0
    mov     eax, eax
    mov     rax, ds:jpt_400DB1[rax*8]
def_400DB1:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000400DB1 case 1
    call    buildnest
    jmp     short loc_400DF8
    mov     eax, 0; jumptable 0000000000400DB1 case 2
    call    decoratenest
    jmp     short loc_400DF8
    mov     eax, 0; jumptable 0000000000400DB1 case 3
    call    shownest
    jmp     short loc_400DF8
    mov     eax, 0; jumptable 0000000000400DB1 case 4
    call    crash_nest
    jmp     short loc_400DF8
    mov     edi, 0; jumptable 0000000000400DB1 case 5
    call    _exit
    mov     edi, offset aInvalidChoice; jumptable 0000000000400DB1 default case, case 0
    call    _puts
    nop
loc_400DF8:
    jmp     loc_400D76
main endp

