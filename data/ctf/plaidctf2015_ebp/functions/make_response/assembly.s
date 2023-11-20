make_response proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     dword ptr [esp+8], offset buf; format
    mov     dword ptr [esp+4], 400h; maxlen
    mov     dword ptr [esp], offset response; s
    call    _snprintf
    leave
    retn
make_response endp

