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
    mov     rax, cs:stderr@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     edi, 1Eh; seconds
    mov     eax, 0
    call    _alarm
loc_11AB:
    mov     eax, 0
    call    menu
    lea     rax, [rbp+i]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+i]
    cmp     eax, 3
    jz      short loc_120C
    cmp     eax, 3
    jg      short loc_11E6
    cmp     eax, 1
    jz      short loc_11F4
    cmp     eax, 2
    jz      short loc_1200
    jmp     short loc_1230
loc_11E6:
    cmp     eax, 4
    jz      short loc_1218
    cmp     eax, 29Ah
    jz      short loc_1224
    jmp     short loc_1230
loc_11F4:
    mov     eax, 0
    call    add
    jmp     short loc_123A
loc_1200:
    mov     eax, 0
    call    edit
    jmp     short loc_123A
loc_120C:
    mov     eax, 0
    call    show
    jmp     short loc_123A
loc_1218:
    mov     eax, 0
    call    del
    jmp     short loc_123A
loc_1224:
    mov     eax, 0
    call    magic
    jmp     short loc_123A
loc_1230:
    mov     edi, 0; status
    call    _exit
loc_123A:
    jmp     loc_11AB
main endp

