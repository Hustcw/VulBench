sub_804895A proc
    push    ebp
    mov     ebp, esp
    sub     esp, 98h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     dword ptr [esp], offset aSelectMenu; "Select menu > "
    call    sub_80488B1
    mov     dword ptr [esp+4], 78h ; 'x'
    lea     eax, [ebp+nptr]
    mov     [esp], eax
    call    sub_8048907
    mov     [ebp+var_88], eax
    mov     eax, [ebp+var_88]
    sub     eax, 1
    mov     [ebp+eax+nptr], 0
    lea     eax, [ebp+nptr]
    mov     [esp], eax; nptr
    call    _atoi
    mov     edx, [ebp+var_C]
    xor     edx, large gs:14h
    jz      short locret_80489C6
    call    ___stack_chk_fail
locret_80489C6:
    leave
    retn
sub_804895A endp

