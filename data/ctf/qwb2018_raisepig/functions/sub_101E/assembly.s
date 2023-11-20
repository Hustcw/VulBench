sub_101E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    push    rax
    xor     eax, eax
    jz      short loc_103E
    add     rsp, 4
loc_103E:
    pop     rax
    mov     eax, cs:dword_20202C
    test    eax, eax
    jnz     short loc_105A
    lea     rdi, aNoPigInTheGard; "No pig in the garden !"
    call    puts
    jmp     loc_110B
loc_105A:
    mov     [rbp+var_C], 0
    jmp     loc_1101
loc_1066:
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_10FD
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    mov     eax, [rax]
    test    eax, eax
    jz      short loc_10FD
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    mov     rdx, [rax+8]
    mov     eax, [rbp+var_C]
    mov     esi, eax
    lea     rdi, aNameUS; "Name[%u] :%s\n"
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    lea     rdx, [rax+10h]
    mov     eax, [rbp+var_C]
    mov     esi, eax
    lea     rdi, aTypeUS; "Type[%u] :%s\n"
    mov     eax, 0
    call    printf
loc_10FD:
    add     [rbp+var_C], 1
loc_1101:
    cmp     [rbp+var_C], 63h ; 'c'
    jbe     loc_1066
loc_110B:
    mov     eax, 0
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_1124
    call    __stack_chk_fail
locret_1124:
    leave
    retn
sub_101E endp

