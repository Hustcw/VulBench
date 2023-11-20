print_state proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+ws], rdi
    mov     rax, [rbp+ws]
    mov     eax, [rax]
    and     eax, 2
    test    eax, eax
    jz      short loc_1980
    mov     rax, [rbp+ws]
    mov     rax, [rax+18h]
    test    rax, rax
    jnz     short loc_195E
    lea     rdi, aMustUseSetEnco; "Must use set_encoding first."
    call    _puts
    jmp     short locret_19AB
loc_195E:
    mov     rax, [rbp+ws]
    mov     rcx, [rax+18h]
    mov     rax, [rbp+ws]
    mov     rdx, [rax+10h]
    mov     rax, [rbp+ws]
    mov     rax, [rax+8]
    mov     rsi, rdx
    mov     rdi, rax
    call    rcx
    jmp     short locret_19AB
loc_1980:
    mov     rax, [rbp+ws]
    mov     eax, [rax]
    and     eax, 1
    test    eax, eax
    jz      short loc_199F
    mov     rax, [rbp+ws]
    mov     rax, [rax+8]
    mov     rdi, rax; s
    call    _puts
    jmp     short locret_19AB
loc_199F:
    lea     rdi, aPrintingNotSup; "Printing not supported for encrypted da"...
    call    _puts
locret_19AB:
    leave
    retn
print_state endp

