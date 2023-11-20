sub_4008FD proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+buf], rdi
    mov     [rbp+file], rsi
    mov     [rbp+offset], rdx
    mov     [rbp+nbytes], rcx
    mov     rax, [rbp+file]
    mov     esi, 0; oflag
    mov     rdi, rax; file
    mov     eax, 0
    call    open
    mov     [rbp+fd], eax
    cmp     [rbp+fd], 0FFFFFFFFh
    jnz     short loc_400940
    mov     edi, offset s; "You can't read this file..."
    call    puts
    jmp     short locret_400984
loc_400940:
    mov     rcx, [rbp+offset]
    mov     eax, [rbp+fd]
    mov     edx, 0; whence
    mov     rsi, rcx; offset
    mov     edi, eax; fd
    call    lseek
    mov     rdx, [rbp+nbytes]; nbytes
    mov     rcx, [rbp+buf]
    mov     eax, [rbp+fd]
    mov     rsi, rcx; buf
    mov     edi, eax; fd
    call    read
    test    rax, rax
    jle     short loc_40097A
    mov     edi, offset aLoadFileComple; "Load file complete!"
    call    puts
loc_40097A:
    mov     eax, [rbp+fd]
    mov     edi, eax; fd
    call    close
locret_400984:
    leave
    retn
sub_4008FD endp

