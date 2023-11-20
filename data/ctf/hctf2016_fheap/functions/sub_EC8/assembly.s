sub_EC8 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 1030h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, 20h ; ' '; size
    call    _malloc
    mov     [rbp+ptr], rax
    mov     [rbp+dest], 0
    lea     rdi, aPlsGiveStringS; "Pls give string size:"
    mov     eax, 0
    call    _printf
    call    sub_B65
    cdqe
    mov     [rbp+nbytes], rax
    cmp     [rbp+nbytes], 1000h
    jbe     short loc_F4A
    lea     rdi, aInvalidSize; "Invalid size"
    call    _puts
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    jmp     loc_1135
loc_F4A:
    lea     rdi, aStr; "str:"
    mov     eax, 0
    call    _printf
    mov     rdx, [rbp+nbytes]; nbytes
    lea     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    cmp     rax, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_F92
    lea     rdi, aGotElf; "got elf!!"
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_F92:
    lea     rax, [rbp+buf]
    mov     rdi, rax; s
    call    _strlen
    mov     [rbp+nbytes], rax
    cmp     [rbp+nbytes], 0Fh
    ja      short loc_FE6
    mov     rax, [rbp+ptr]
    mov     rdx, [rbp+nbytes]; n
    lea     rcx, [rbp+buf]
    mov     rsi, rcx; src
    mov     rdi, rax; dest
    call    _strncpy
    mov     rax, [rbp+ptr]
    lea     rdx, sub_D52
    mov     [rax+18h], rdx
    jmp     short loc_105F
loc_FE6:
    mov     rax, [rbp+nbytes]
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+dest], rax
    cmp     [rbp+dest], 0
    jnz     short loc_101C
    lea     rdi, aMallocFaild; "malloc faild!"
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_101C:
    mov     rdx, [rbp+nbytes]; n
    lea     rcx, [rbp+buf]
    mov     rax, [rbp+dest]
    mov     rsi, rcx; src
    mov     rdi, rax; dest
    call    _strncpy
    mov     rax, [rbp+ptr]
    mov     rdx, [rbp+dest]
    mov     [rax], rdx
    mov     rax, [rbp+ptr]
    lea     rdx, sub_D6C
    mov     [rax+18h], rdx
loc_105F:
    mov     rax, [rbp+nbytes]
    mov     edx, eax
    mov     rax, [rbp+ptr]
    mov     [rax+10h], edx
    mov     [rbp+var_102C], 0
    jmp     short loc_10FC
loc_107E:
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_102C]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     eax, [rax]
    test    eax, eax
    jnz     short loc_10F5
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_102C]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     dword ptr [rax], 1
    lea     rax, unk_2020C0
    mov     edx, [rbp+var_102C]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rdx, rax
    mov     rax, [rbp+ptr]
    mov     [rdx+8], rax
    mov     eax, [rbp+var_102C]
    mov     esi, eax
    lea     rdi, aTheStringIdIsD; "The string id is %d\n"
    mov     eax, 0
    call    _printf
    jmp     short loc_1109
loc_10F5:
    add     [rbp+var_102C], 1
loc_10FC:
    cmp     [rbp+var_102C], 0Fh
    jle     loc_107E
loc_1109:
    cmp     [rbp+var_102C], 10h
    jnz     short loc_1135
    lea     rdi, aTheStringListI; "The string list is full"
    call    _puts
    mov     rax, [rbp+ptr]
    mov     rax, [rax+18h]
    mov     rdx, [rbp+ptr]
    mov     rdi, rdx
    call    rax
loc_1135:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1149
    call    ___stack_chk_fail
locret_1149:
    leave
    retn
sub_EC8 endp

