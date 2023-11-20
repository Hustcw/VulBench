sub_D80 proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 4
    call    sub_890
    add     ebx, (offset off_2F74 - $)
    lea     eax, (dword_3010 - 2F74h)[ebx]
    mov     eax, [eax]
    sub     esp, 0Ch
    push    eax; stream
    call    _fclose
    add     esp, 10h
    lea     eax, (unk_300C - 2F74h)[ebx]
    mov     eax, [eax]
    sub     esp, 0Ch
    push    eax; ptr
    call    _free
    add     esp, 10h
    nop
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_D80 endp

