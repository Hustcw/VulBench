sub_9C4 proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 4
    call    sub_FB8
    add     eax, (offset off_2FB8 - $)
    mov     ecx, [ebp+arg_0]
    mov     edx, [ebp+arg_4]
    add     edx, ecx
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
sub_9C4 endp

