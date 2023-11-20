sub_D57 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 338h
    call    sub_FB8
    add     eax, (offset off_2FB8 - $)
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    call    sub_CDB
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_D8C
    call    sub_1030
locret_D8C:
    leave
    retn
sub_D57 endp

