sub_400999 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aOkAsURBoredDoS; "Ok, as u r bored, do something boring t"...
    call    puts
    mov     edx, 1000h; nbytes
    mov     esi, offset unk_602080; buf
    mov     edi, 0; fd
    call    read
    mov     edi, offset aSatisfiedYN; "Satisfied?y/n"
    call    puts
    lea     rax, [rbp+buf]
    mov     edx, 2; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    movzx   eax, [rbp+buf]
    cmp     al, 6Eh ; 'n'
    jnz     short loc_400A0B
    mov     edi, offset aYouRTroublesom; "You r troublesome...Why do this boring "...
    call    puts
    mov     eax, 0
    call    sub_400999
    nop
loc_400A0B:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400A20
    call    __stack_chk_fail
locret_400A20:
    leave
    retn
sub_400999 endp

