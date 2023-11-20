sub_8048851 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     dword ptr [esp], offset unk_804B0A0
    call    sub_80488B1
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_804887F
    call    ___stack_chk_fail
locret_804887F:
    leave
    retn
sub_8048851 endp

