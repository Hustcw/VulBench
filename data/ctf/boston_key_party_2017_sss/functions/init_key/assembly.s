init_key proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     esi, offset modes; "rb"
    mov     edi, offset filename; "flag"
    call    _fopen
    mov     [rbp+stream], rax
    mov     rax, [rbp+stream]
    mov     edx, 2; whence
    mov     esi, 0; off
    mov     rdi, rax; stream
    call    _fseek
    mov     rax, [rbp+stream]
    mov     rdi, rax; stream
    call    _ftell
    mov     [rbp+size], rax
    mov     rax, [rbp+stream]
    mov     edx, 0; whence
    mov     esi, 0; off
    mov     rdi, rax; stream
    call    _fseek
    mov     rax, [rbp+size]
    add     rax, 1
    mov     rsi, rax; size
    mov     edi, 1; nmemb
    call    _calloc
    mov     [rbp+ptr], rax
    cmp     [rbp+ptr], 0
    jnz     short loc_400DF7
    mov     edi, 1; status
    call    _exit
loc_400DF7:
    mov     rsi, [rbp+size]; size
    mov     rdx, [rbp+stream]
    mov     rax, [rbp+ptr]
    mov     rcx, rdx; stream
    mov     edx, 1; n
    mov     rdi, rax; ptr
    call    _fread
    mov     rax, [rbp+stream]
    mov     rdi, rax; stream
    call    _fclose
    mov     rdx, [rbp+size]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     rax, [rbp+ptr]
    mov     rdi, rax; s
    call    _strdup
    mov     cs:key, rax
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    nop
    leave
    retn
init_key endp

