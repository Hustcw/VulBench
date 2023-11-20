main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 14h
    mov     eax, ds:__bss_start
    push    0; n
    push    2; modes
    push    0; buf
    push    eax; stream
    call    _setvbuf
    add     esp, 10h
    call    _getegid
    mov     [ebp+var_C], eax
    sub     esp, 4
    push    [ebp+var_C]
    push    [ebp+var_C]
    push    [ebp+var_C]
    call    _setresgid
    add     esp, 10h
    call    vuln
    mov     eax, 0
    mov     ecx, [ebp+var_4]
    leave
    lea     esp, [ecx-4]
    retn
main endp

