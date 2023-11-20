new_mail proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, [ebp+arg_0]
    add     eax, 48h ; 'H'
    sub     esp, 0Ch
    push    eax; size
    call    _malloc
    add     esp, 10h
    mov     [ebp+var_C], eax
    mov     eax, [ebp+var_C]
    mov     dword ptr [eax], 0
    mov     eax, [ebp+var_C]
    mov     edx, [ebp+arg_0]
    mov     [eax+44h], edx
    mov     eax, [ebp+var_C]
    leave
    retn
new_mail endp

