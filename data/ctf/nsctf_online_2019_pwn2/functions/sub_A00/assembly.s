sub_A00 proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    lea     rdi, s; "Welcome to notebook system"
    call    puts
    lea     rdi, aPleaseInputYou; "Please input your name"
    call    puts
    mov     edx, 30h ; '0'; nbytes
    lea     rax, unk_202060
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    nop
    pop     rbp
    retn
sub_A00 endp

