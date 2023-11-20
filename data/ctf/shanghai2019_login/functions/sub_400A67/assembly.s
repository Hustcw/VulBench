sub_400A67 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 120h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aInputTheUserId; "Input the user id:"
    call    puts
    mov     [rbp+var_118], 0
    lea     rax, [rbp+var_118]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_118]
    test    eax, eax
    js      loc_400C07
    mov     eax, [rbp+var_118]
    cmp     eax, 9
    jg      loc_400C07
    mov     edx, [rbp+var_118]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jz      loc_400BF9
    lea     rdi, aInputThePasswo_0; "Input the passwords length:"
    call    puts
    mov     [rbp+var_114], 0
    lea     rax, [rbp+var_114]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_114]
    cmp     eax, 0FFh
    jg      loc_400BEB
    lea     rax, [rbp+s]
    mov     edx, 100h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    lea     rdi, aInputThePasswo_1; "Input the password:"
    call    puts
    mov     eax, [rbp+var_114]
    movsxd  rdx, eax; nbytes
    lea     rax, [rbp+s]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     edx, [rbp+var_118]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rdx, [rax]
    lea     rax, [rbp+s]
    mov     rsi, rdx; s2
    mov     rdi, rax; s1
    call    strcmp
    test    eax, eax
    jz      short loc_400BAB
    lea     rdi, aWrongPassword; "Wrong password!"
    call    puts
    jmp     short loc_400C13
loc_400BAB:
    mov     eax, 0
    call    sub_400A54
    mov     edx, [rbp+var_118]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rax, [rax+8]
    mov     ecx, [rbp+var_118]
    lea     rdx, qword_602040
    movsxd  rcx, ecx
    mov     rdx, [rdx+rcx*8]
    mov     rdx, [rdx]
    mov     rdi, rdx
    call    rax
    jmp     short loc_400C13
loc_400BEB:
    lea     rdi, aIllegalLength; "Illegal length!"
    call    puts
    jmp     short loc_400C13
loc_400BF9:
    lea     rdi, aNoSuchUser; "No such user!"
    call    puts
    jmp     short loc_400C13
loc_400C07:
    lea     rdi, aWrongId; "Wrong id!"
    call    puts
loc_400C13:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400C28
    call    __stack_chk_fail
locret_400C28:
    leave
    retn
sub_400A67 endp

