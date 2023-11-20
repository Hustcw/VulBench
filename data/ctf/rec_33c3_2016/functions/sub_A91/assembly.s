sub_A91 proc
    push    ebp
    mov     ebp, esp
    call    sub_FB8
    add     eax, (offset off_2FB8 - $)
    mov     eax, [ebp+arg_0]
    pop     ebp
    retn
sub_A91 endp

