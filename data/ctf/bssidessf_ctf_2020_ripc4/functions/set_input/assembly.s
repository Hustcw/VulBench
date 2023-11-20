set_input proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+ws], rdi
    mov     rax, [rbp+ws]
    mov     rax, [rax+8]
    test    rax, rax
    jz      short loc_1833
    mov     rax, [rbp+ws]
    mov     rax, [rax+8]
    mov     rdi, rax; ptr
    call    secure_free
    mov     rax, [rbp+ws]
    mov     qword ptr [rax+8], 0
    mov     rax, [rbp+ws]
    mov     qword ptr [rax+10h], 0
loc_1833:
    lea     rdi, aInput; "input"
    call    prompt
    mov     [rbp+inp], rax
    cmp     [rbp+inp], 0
    jnz     short loc_185D
    lea     rdi, aNoInput; "No input!"
    mov     eax, 0
    call    _printf
    jmp     short locret_18AD
loc_185D:
    mov     rax, [rbp+inp]
    mov     rdi, rax; s
    call    secure_strdup
    mov     rdx, [rbp+ws]
    mov     [rdx+8], rax
    mov     rax, [rbp+ws]
    mov     rax, [rax+8]
    mov     rdi, rax; s
    call    _strlen
    mov     rsi, rax
    lea     rdi, aInputIsLuBytes; "Input is %lu bytes long.\n"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+ws]
    mov     rax, [rax+8]
    mov     rdi, rax; s
    call    _strlen
    mov     rdx, [rbp+ws]
    mov     [rdx+10h], rax
locret_18AD:
    leave
    retn
set_input endp

