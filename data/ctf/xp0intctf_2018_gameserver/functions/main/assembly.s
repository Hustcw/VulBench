main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 4
    mov     eax, ds:stdin
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    mov     eax, ds:stdout
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    mov     eax, ds:stderr
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    call    sub_8048637
    sub     esp, 0Ch
    push    offset s; "Now you can start you game in middle ea"...
    call    _puts
    add     esp, 10h
    mov     eax, 0
    mov     ecx, [ebp+var_4]
    leave
    lea     esp, [ecx-4]
    retn
main endp

