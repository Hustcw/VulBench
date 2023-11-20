sub_400A22 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 110h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aOhManPlayWithT; "Oh,man.Play with the stack is really da"...
    call    puts
    mov     eax, cs:dword_602060
    test    eax, eax
    jnz     short loc_400A84
    mov     cs:dword_602060, 1
    lea     rax, [rbp+buf]
    mov     edx, 1000h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+buf]
    mov     rdi, rax; s
    call    puts
    jmp     short loc_400A85
loc_400A84:
    nop
loc_400A85:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400A99
    call    __stack_chk_fail
locret_400A99:
    leave
    retn
sub_400A22 endp

