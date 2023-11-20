sub_D95 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 120h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, format; "Pls give me the string id you want to d"...
    mov     eax, 0
    call    _printf
    call    sub_B65
    mov     [rbp+var_114], eax
    cmp     [rbp+var_114], 0
    js      short loc_DDD
    cmp     [rbp+var_114], 10h
    jle     short loc_DE9
loc_DDD:
    lea     rdi, aInvalidId; "Invalid id"
    call    _puts
loc_DE9:
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_114]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax+8]
    test    rax, rax
    jz      loc_EB2
    lea     rdi, aAreYouSure; "Are you sure?:"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 100h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     edx, 3; n
    lea     rsi, aYes; "yes"
    mov     rdi, rax; s1
    call    _strncmp
    test    eax, eax
    jnz     short loc_EB2
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_114]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax+8]
    mov     rax, [rax+18h]
    lea     rdx, unk_2020C0
    mov     ecx, [rbp+var_114]
    movsxd  rcx, ecx
    shl     rcx, 4
    add     rdx, rcx
    mov     rdx, [rdx+8]
    mov     rdi, rdx
    call    rax
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_114]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     dword ptr [rax], 0
loc_EB2:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_EC6
    call    ___stack_chk_fail
locret_EC6:
    leave
    retn
sub_D95 endp

