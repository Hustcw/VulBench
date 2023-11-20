main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 24h
    mov     eax, ds:stdout
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    mov     [ebp+var_1C], 0
    sub     esp, 0Ch
    push    offset s; "This is a remote printer!"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset format; "Enter IPv4 address:"
    call    _printf
    add     esp, 10h
    sub     esp, 8
    lea     eax, [ebp+cp]
    push    eax
    push    offset a15s; "%15s"
    call    ___isoc99_scanf
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aEnterPort; "Enter port:"
    call    _printf
    add     esp, 10h
    sub     esp, 8
    lea     eax, [ebp+var_1C]
    push    eax
    push    offset aD; "%d"
    call    ___isoc99_scanf
    add     esp, 10h
    mov     eax, [ebp+var_1C]
    sub     esp, 4
    push    eax
    lea     eax, [ebp+cp]
    push    eax
    push    offset aThankYouIMTryi; "Thank you, I'm trying to print %s:%d no"...
    call    _printf
    add     esp, 10h
    mov     eax, [ebp+var_1C]
    sub     esp, 8
    push    eax; int
    lea     eax, [ebp+cp]
    push    eax; cp
    call    sub_8048786
    add     esp, 10h
    mov     eax, 0
    mov     ecx, [ebp+var_4]
    leave
    lea     esp, [ecx-4]
    retn
main endp

