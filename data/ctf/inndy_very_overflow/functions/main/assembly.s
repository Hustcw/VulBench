main proc
    push    ebp
    mov     ebp, esp
    and     esp, 0FFFFFFF0h
    sub     esp, 10h
    mov     eax, ds:stdout@@GLIBC_2_0
    mov     dword ptr [esp+0Ch], 0; n
    mov     dword ptr [esp+8], 2; modes
    mov     dword ptr [esp+4], 0; buf
    mov     [esp], eax; stream
    call    _setvbuf
    mov     eax, ds:stdin@@GLIBC_2_0
    mov     dword ptr [esp+0Ch], 0; n
    mov     dword ptr [esp+8], 2; modes
    mov     dword ptr [esp+4], 0; buf
    mov     [esp], eax; stream
    call    _setvbuf
    mov     dword ptr [esp], offset aHelloWelcomeTo; "Hello, Welcome to Very Overflow Notes S"...
    call    _puts
    call    vuln
    mov     eax, 0
    leave
    retn
main endp

