sub_F42 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    push    rax
    xor     eax, eax
    jz      short loc_F62
    add     rsp, 4
loc_F62:
    pop     rax
    mov     [rbp+var_C], 0
    jmp     loc_FF1
loc_F6F:
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_FED
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    mov     eax, [rax]
    test    eax, eax
    jnz     short loc_FED
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     eax, [rbp+var_C]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     qword ptr [rdx+rax], 0
    mov     eax, cs:dword_20202C
    sub     eax, 1
    mov     cs:dword_20202C, eax
loc_FED:
    add     [rbp+var_C], 1
loc_FF1:
    cmp     [rbp+var_C], 63h ; 'c'
    jbe     loc_F6F
    lea     rdi, aDone; "Done!"
    call    puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_101C
    call    __stack_chk_fail
locret_101C:
    leave
    retn
sub_F42 endp

