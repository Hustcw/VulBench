sub_400AC7 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edi, offset aTheIdYouWantTo; "The id you want to delete:"
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_400941
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    js      short loc_400B09
    cmp     [rbp+var_4], 13h
    jg      short loc_400B09
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:ptr[rax*8]
    test    rax, rax
    jnz     short loc_400B15
loc_400B09:
    mov     edi, offset aInvalidId; "Invalid id !!"
    call    _puts
    jmp     short locret_400B74
loc_400B15:
    mov     eax, [rbp+var_4]
    cdqe
    mov     rax, ds:ptr[rax*8]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+var_4]
    cdqe
    mov     ds:ptr[rax*8], 0
loc_400B3B:
    mov     eax, [rbp+var_4]
    add     eax, 1
    cmp     eax, 13h
    jg      short loc_400B69
    mov     eax, [rbp+var_4]
    add     eax, 1
    cdqe
    mov     rdx, ds:ptr[rax*8]
    mov     eax, [rbp+var_4]
    cdqe
    mov     ds:ptr[rax*8], rdx
    add     [rbp+var_4], 1
    jmp     short loc_400B3B
loc_400B69:
    nop
    mov     edi, offset aDone; "Done!"
    call    _puts
locret_400B74:
    leave
    retn
sub_400AC7 endp

