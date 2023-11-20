sub_1160 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    push    rax
    xor     eax, eax
    jz      short loc_1180
    add     rsp, 4
loc_1180:
    pop     rax
    mov     esi, 0; oflag
    lea     rdi, file; "/dev/urandom"
    mov     eax, 0
    call    open
    mov     [rbp+fd], eax
    mov     eax, [rbp+fd]
    mov     edi, eax; fd
    call    close
    mov     rax, cs:stdout
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setvbuf
    lea     rsi, handler; handler
    mov     edi, 0Eh; sig
    call    signal
    mov     edi, 3Ch ; '<'; seconds
    call    alarm
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_11F2
    call    __stack_chk_fail
locret_11F2:
    leave
    retn
sub_1160 endp

