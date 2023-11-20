sub_80488B1 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 38h
    mov     eax, [ebp+arg_0]
    mov     [ebp+s], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     eax, [ebp+s]
    mov     [esp], eax; s
    call    _strlen
    mov     edx, ds:fd
    mov     dword ptr [esp+0Ch], 0; flags
    mov     [esp+8], eax; n
    mov     eax, [ebp+s]
    mov     [esp+4], eax; buf
    mov     [esp], edx; fd
    call    _send
    mov     ecx, [ebp+var_C]
    xor     ecx, large gs:14h
    jz      short locret_8048905
    call    ___stack_chk_fail
locret_8048905:
    leave
    retn
sub_80488B1 endp

