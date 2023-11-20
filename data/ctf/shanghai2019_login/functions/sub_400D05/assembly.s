sub_400D05 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aInputTheUserId; "Input the user id:"
    call    puts
    mov     [rbp+var_C], 0
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    test    eax, eax
    js      short loc_400DC0
    mov     eax, [rbp+var_C]
    cmp     eax, 5
    jg      short loc_400DC0
    mov     edx, [rbp+var_C]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jz      short loc_400DB2
    lea     rdi, aInputNewPass; "Input new pass:"
    call    puts
    mov     edx, [rbp+var_C]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     eax, [rax+10h]
    movsxd  rdx, eax; nbytes
    mov     ecx, [rbp+var_C]
    lea     rax, qword_602040
    movsxd  rcx, ecx
    mov     rax, [rax+rcx*8]
    mov     rax, [rax]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    jmp     short loc_400DCC
loc_400DB2:
    lea     rdi, aNoSuchUser; "No such user!"
    call    puts
    jmp     short loc_400DCC
loc_400DC0:
    lea     rdi, aWrongId; "Wrong id!"
    call    puts
loc_400DCC:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400DE1
    call    __stack_chk_fail
locret_400DE1:
    leave
    retn
sub_400D05 endp

