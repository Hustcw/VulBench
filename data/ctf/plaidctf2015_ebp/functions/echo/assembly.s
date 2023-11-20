echo proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    call    make_response
    mov     dword ptr [esp], offset response; s
    call    _puts
    mov     eax, ds:stdout@@GLIBC_2_0
    mov     [esp], eax; stream
    call    _fflush
    leave
    retn
echo endp

