sub_4008C5 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aInputTheUserId; "Input the user id:"
    call    puts
    mov     [rbp+var_20], 0
    mov     [rbp+var_1C], 0
    lea     rax, [rbp+var_20]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_20]
    test    eax, eax
    js      loc_400A31
    mov     eax, [rbp+var_20]
    cmp     eax, 5
    jg      loc_400A31
    mov     edx, [rbp+var_20]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    test    rax, rax
    jnz     loc_400A23
    lea     rdi, aInputThePasswo; "Input the password length:"
    call    puts
    lea     rax, [rbp+var_1C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_1C]
    cmp     eax, 100h
    jg      short loc_400974
    mov     eax, [rbp+var_1C]
    test    eax, eax
    jns     short loc_400985
loc_400974:
    lea     rdi, aIllegalLength; "Illegal length!"
    call    puts
    jmp     loc_400A3D
loc_400985:
    mov     eax, [rbp+var_1C]
    cdqe
    mov     rdi, rax; size
    call    malloc
    mov     [rbp+buf], rax
    cmp     [rbp+buf], 0
    jz      short loc_400A15
    lea     rdi, aInputPassword; "Input password:"
    call    puts
    mov     eax, [rbp+var_1C]
    movsxd  rdx, eax; nbytes
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     edi, 18h; size
    call    malloc
    mov     [rbp+var_10], rax
    mov     rax, [rbp+var_10]
    lea     rdx, sub_40089E
    mov     [rax+8], rdx
    mov     rax, [rbp+var_10]
    mov     rdx, [rbp+buf]
    mov     [rax], rdx
    mov     edx, [rbp+var_1C]
    mov     rax, [rbp+var_10]
    mov     [rax+10h], edx
    mov     edx, [rbp+var_20]
    lea     rax, qword_602040
    movsxd  rdx, edx
    mov     rcx, [rbp+var_10]
    mov     [rax+rdx*8], rcx
    lea     rdi, aRegisterSucces; "Register success!"
    call    puts
    jmp     short loc_400A3D
loc_400A15:
    lea     rdi, aMallocError; "malloc error!"
    call    puts
    jmp     short loc_400A3D
loc_400A23:
    lea     rdi, aUserAlreadyExi; "User already exists!"
    call    puts
    jmp     short loc_400A3D
loc_400A31:
    lea     rdi, aWrongId; "Wrong id!"
    call    puts
loc_400A3D:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400A52
    call    __stack_chk_fail
locret_400A52:
    leave
    retn
sub_4008C5 endp

