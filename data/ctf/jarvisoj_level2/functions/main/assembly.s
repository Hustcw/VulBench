main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 4
    call    vulnerable_function
    sub     esp, 0Ch
    push    offset aEchoHelloWorld; "echo 'Hello World!'"
    call    _system
    add     esp, 10h
    mov     eax, 0
    mov     ecx, [ebp+var_4]
    leave
    lea     esp, [ecx-4]
    retn
main endp

