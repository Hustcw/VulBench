sub_400C2A proc
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
    js      short loc_400CE2
    mov     eax, [rbp+var_C]
    cmp     eax, 5
    jg      short loc_400CE2
    mov     edx, [rbp+var_C]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jz      short loc_400CD4
    mov     edx, [rbp+var_C]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    free
    mov     edx, [rbp+var_C]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rdi, rax; ptr
    call    free
    lea     rdi, aDeleteSuccess; "Delete success!"
    call    puts
    jmp     short loc_400CEE
loc_400CD4:
    lea     rdi, aNoSuchUser; "No such user!"
    call    puts
    jmp     short loc_400CEE
loc_400CE2:
    lea     rdi, aWrongId; "Wrong id!"
    call    puts
loc_400CEE:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400D03
    call    __stack_chk_fail
locret_400D03:
    leave
    retn
sub_400C2A endp

