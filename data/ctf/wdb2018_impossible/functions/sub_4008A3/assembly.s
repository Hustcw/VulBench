sub_4008A3 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edx, 8; n
    mov     esi, 0; c
    mov     edi, offset unk_602068; s
    call    memset
    mov     esi, 0; oflag
    mov     edi, offset file; "/dev/urandom"
    mov     eax, 0
    call    open
    mov     [rbp+fd], eax
    mov     eax, [rbp+fd]
    mov     edx, 8; nbytes
    mov     esi, offset unk_602068; buf
    mov     edi, eax; fd
    call    read
    mov     edi, offset format; "Input your secret code:"
    mov     eax, 0
    call    printf
    lea     rax, [rbp+buf]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+buf]
    mov     edx, 8; n
    mov     rsi, rax; s2
    mov     edi, offset unk_602068; s1
    call    memcmp
    test    eax, eax
    jnz     short loc_400982
    mov     edi, offset s; "Amazing! How can u know the secret code"...
    call    puts
    mov     edi, offset aOkUAreTheBossU; "Ok,u are the boss, u can do anything u "...
    call    puts
    mov     edi, offset aButUShouldBeQu; "But u should be quiet about this, becau"...
    call    puts
    mov     edi, offset aSoCloseUrMouth; "So...Close ur mouth..."
    call    puts
    mov     edi, 0; fd
    call    close
    lea     rax, [rbp+buf]
    mov     esi, offset unk_602080
    mov     edx, 200h
    mov     rdi, rax
    mov     rcx, rdx
    rep movsq
    nop
loc_400982:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400997
    call    __stack_chk_fail
locret_400997:
    leave
    retn
sub_4008A3 endp

