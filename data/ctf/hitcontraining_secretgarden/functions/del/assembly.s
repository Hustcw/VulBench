del proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, cs:flowercount
    test    eax, eax
    jnz     short loc_400BAD
    lea     rdi, aNoFlowerInTheG; "No flower in the garden"
    call    _puts
    jmp     locret_400C5C
loc_400BAD:
    lea     rdi, aWhichFlowerDoY; "Which flower do you want to remove from"...
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_4]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_4]
    cmp     eax, 63h ; 'c'
    ja      short loc_400BFB
    mov     eax, [rbp+var_4]
    mov     eax, eax
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_400C0E
loc_400BFB:
    lea     rdi, aInvalidChoice; "Invalid choice"
    call    _puts
    mov     eax, 0
    jmp     short locret_400C5C
loc_400C0E:
    mov     eax, [rbp+var_4]
    mov     eax, eax
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    mov     dword ptr [rax], 0
    mov     eax, [rbp+var_4]
    mov     eax, eax
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    mov     rax, [rax+8]
    mov     rdi, rax; ptr
    call    _free
    lea     rdi, aSuccessful_0; "Successful"
    call    _puts
locret_400C5C:
    leave
    retn
del endp

