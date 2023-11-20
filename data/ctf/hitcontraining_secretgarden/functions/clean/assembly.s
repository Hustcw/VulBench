clean proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], 0
    jmp     loc_400D07
loc_400C85:
    mov     eax, [rbp+var_4]
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_400D03
    mov     eax, [rbp+var_4]
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    mov     eax, [rax]
    test    eax, eax
    jnz     short loc_400D03
    mov     eax, [rbp+var_4]
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+var_4]
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     qword ptr [rdx+rax], 0
    mov     eax, cs:flowercount
    sub     eax, 1
    mov     cs:flowercount, eax
loc_400D03:
    add     [rbp+var_4], 1
loc_400D07:
    cmp     [rbp+var_4], 63h ; 'c'
    jbe     loc_400C85
    lea     rdi, aDone; "Done!"
    call    _puts
    nop
    leave
    retn
clean endp

