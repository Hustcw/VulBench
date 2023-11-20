sub_C85 proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 4
    call    sub_FB8
    add     eax, (offset off_2FB8 - $)
    sub     esp, 0Ch
    lea     edx, (aPositive - 2FB8h)[eax]; "Positive"
    push    edx; s
    mov     ebx, eax
    call    _puts
    add     esp, 10h
    nop
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_C85 endp

