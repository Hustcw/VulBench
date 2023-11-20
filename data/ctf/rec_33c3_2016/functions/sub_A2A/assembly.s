sub_A2A proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 4
    call    sub_FB8
    add     eax, (offset off_2FB8 - $)
    mov     edx, [ebp+arg_0]
    imul    edx, [ebp+arg_4]
    sub     esp, 8
    push    edx
    lea     edx, (aResultD - 2FB8h)[eax]; "Result: %d\n"
    push    edx; format
    mov     ebx, eax
    call    _printf
    add     esp, 10h
    nop
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_A2A endp

