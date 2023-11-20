visit proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, cs:flowercount
    test    eax, eax
    jnz     short loc_400D43
    lea     rdi, aNoFlowerInTheG_0; "No flower in the garden !"
    call    _puts
    jmp     loc_400DF4
loc_400D43:
    mov     [rbp+var_4], 0
    jmp     loc_400DEA
loc_400D4F:
    mov     eax, [rbp+var_4]
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_400DE6
    mov     eax, [rbp+var_4]
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    mov     eax, [rax]
    test    eax, eax
    jz      short loc_400DE6
    mov     eax, [rbp+var_4]
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    mov     rdx, [rax+8]
    mov     eax, [rbp+var_4]
    mov     esi, eax
    lea     rdi, aNameOfTheFlowe; "Name of the flower[%u] :%s\n"
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_4]
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    lea     rdx, [rax+10h]
    mov     eax, [rbp+var_4]
    mov     esi, eax
    lea     rdi, aColorOfTheFlow; "Color of the flower[%u] :%s\n"
    mov     eax, 0
    call    _printf
loc_400DE6:
    add     [rbp+var_4], 1
loc_400DEA:
    cmp     [rbp+var_4], 63h ; 'c'
    jbe     loc_400D4F
loc_400DF4:
    nop
    leave
    retn
visit endp

