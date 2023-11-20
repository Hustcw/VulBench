sub_BD5 proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     rax, cs:stdout
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    mov     rax, cs:stdin
    mov     ecx, 0; n
    mov     edx, 1; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    mov     rax, cs:stderr
    mov     ecx, 0; n
    mov     edx, 1; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    lea     rsi, handler; handler
    mov     edi, 0Eh; sig
    call    signal
    mov     edi, 1Eh; seconds
    call    alarm
    mov     esi, 28h ; '('; size
    mov     edi, 1; nmemb
    call    calloc
    mov     cs:ptr, rax
    mov     rbx, cs:ptr
    mov     esi, 50h ; 'P'; size
    mov     edi, 1; nmemb
    call    calloc
    mov     [rbx+20h], rax
    lea     rdi, format; "name> "
    mov     eax, 0
    call    printf
    mov     rax, cs:ptr
    mov     esi, 18h
    mov     rdi, rax
    call    sub_B41
    nop
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_CCC
    call    __stack_chk_fail
loc_CCC:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
sub_BD5 endp

