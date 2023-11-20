sub_8048907 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 38h
    mov     eax, [ebp+arg_0]
    mov     [ebp+buf], eax
    mov     eax, [ebp+arg_4]
    mov     [ebp+n], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     edx, [ebp+n]
    mov     eax, ds:fd
    mov     dword ptr [esp+0Ch], 0; flags
    mov     [esp+8], edx; n
    mov     edx, [ebp+buf]
    mov     [esp+4], edx; buf
    mov     [esp], eax; fd
    call    _recv
    mov     ecx, [ebp+var_C]
    xor     ecx, large gs:14h
    jz      short locret_8048958
    call    ___stack_chk_fail
locret_8048958:
    leave
    retn
sub_8048907 endp

