sub_804880D proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, [ebp+arg_0]
    mov     [ebp+var_1C], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     dword ptr [esp], offset aTimeOut; "\nTime Out!\n"
    call    sub_80488B1
    mov     eax, ds:fd
    mov     [esp], eax; fd
    call    _close
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_804884F
    call    ___stack_chk_fail
locret_804884F:
    leave
    retn
sub_804880D endp

