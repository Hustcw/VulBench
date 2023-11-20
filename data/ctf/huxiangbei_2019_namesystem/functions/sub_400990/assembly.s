sub_400990 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], 0
    jmp     short loc_4009A5
loc_4009A1:
    add     [rbp+var_8], 1
loc_4009A5:
    mov     eax, [rbp+var_8]
    cdqe
    mov     rax, ds:ptr[rax*8]
    test    rax, rax
    jz      short loc_4009BD
    cmp     [rbp+var_8], 13h
    jle     short loc_4009A1
loc_4009BD:
    cmp     [rbp+var_8], 13h
    jle     short loc_4009D2
    mov     edi, offset aNotAnyMore; "Not any more !!"
    call    _puts
    jmp     locret_400A56
loc_4009D2:
    mov     edi, offset format; "Name Size:"
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_400941
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0Fh
    jle     short loc_400A4C
    cmp     [rbp+var_4], 60h ; '`'
    jg      short loc_400A4C
    mov     edi, offset aName; "Name:"
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_4]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     rdx, rax
    mov     eax, [rbp+var_8]
    cdqe
    mov     ds:ptr[rax*8], rdx
    mov     eax, [rbp+var_8]
    cdqe
    mov     rax, ds:ptr[rax*8]
    mov     edx, [rbp+var_4]
    mov     esi, edx
    mov     rdi, rax
    call    sub_400846
    mov     edi, offset aDone; "Done!"
    call    _puts
    jmp     short locret_400A56
loc_400A4C:
    mov     edi, offset aInvalidSize; "Invalid size !!"
    call    _puts
locret_400A56:
    leave
    retn
sub_400990 endp

