sub_400D52 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     rax, [rbp+var_8]
    lea     rdx, [rax+100h]
    mov     rax, [rbp+var_8]
    mov     rsi, rax
    mov     edi, offset aPaperNameSAuth; "Paper name:\n\t\"%s\"\nAuthors:\n\t%s\n"
    mov     eax, 0
    call    _printf
    mov     edi, offset aAbstract; "Abstract:\n\t"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+var_8]
    add     rax, 200h
    movzx   eax, byte ptr [rax]
    test    al, al
    jz      short loc_400DB8
    mov     rax, [rbp+var_8]
    add     rax, 200h
    mov     rdi, rax; format
    mov     eax, 0
    call    _printf
    jmp     short loc_400DC7
loc_400DB8:
    mov     edi, offset aNA; "N/A"
    mov     eax, 0
    call    _printf
loc_400DC7:
    mov     edi, offset aTags; "\nTags:\n\t"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+var_8]
    add     rax, 400h
    movzx   eax, byte ptr [rax]
    test    al, al
    jz      short loc_400E00
    mov     rax, [rbp+var_8]
    add     rax, 400h
    mov     rdi, rax; format
    mov     eax, 0
    call    _printf
    jmp     short loc_400E0F
loc_400E00:
    mov     edi, offset aNA; "N/A"
    mov     eax, 0
    call    _printf
loc_400E0F:
    mov     edi, offset asc_4012C9; "\n\n"
    call    _puts
    nop
    leave
    retn
sub_400D52 endp

