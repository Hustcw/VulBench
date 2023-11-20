sub_8048881 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     dword ptr [esp], offset unk_8048F2C
    call    sub_80488B1
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_80488AF
    call    ___stack_chk_fail
locret_80488AF:
    leave
    retn
sub_8048881 endp

