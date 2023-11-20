sub_A5D proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 4
    call    sub_FBC
    add     ecx, (offset off_2FB8 - $)
    mov     eax, [ebp+arg_0]
    cdq
    idiv    [ebp+arg_4]
    sub     esp, 8
    push    eax
    lea     eax, (aResultD - 2FB8h)[ecx]; "Result: %d\n"
    push    eax; format
    mov     ebx, ecx
    call    _printf
    add     esp, 10h
    nop
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_A5D endp

