prompt proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+prompt_str], rdi
    mov     rax, [rbp+prompt_str]
    mov     rsi, rax
    lea     rdi, aS; "%s> "
    mov     eax, 0
    call    _printf
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     rdx, rax; stream
    mov     esi, 1000h; n
    lea     rdi, buf_3753; s
    call    _fgets
    mov     [rbp+rv], rax
    cmp     [rbp+rv], 0
    jnz     short loc_19FE
    mov     eax, 0
    jmp     short locret_1A3A
loc_19FE:
    mov     rax, [rbp+rv]
    mov     rdi, rax; s
    call    _strlen
    mov     [rbp+l], rax
    mov     rax, [rbp+l]
    lea     rdx, [rax-1]
    mov     rax, [rbp+rv]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_1A36
    mov     rax, [rbp+l]
    lea     rdx, [rax-1]
    mov     rax, [rbp+rv]
    add     rax, rdx
    mov     byte ptr [rax], 0
loc_1A36:
    mov     rax, [rbp+rv]
locret_1A3A:
    leave
    retn
prompt endp

