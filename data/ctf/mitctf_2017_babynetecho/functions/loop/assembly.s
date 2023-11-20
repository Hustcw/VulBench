loop proc
    push    ebp
    mov     ebp, esp
    push    edi
    sub     esp, 104h
    lea     edx, [ebp+var_108]
    mov     eax, 0
    mov     ecx, 40h ; '@'
    mov     edi, edx
    rep stosd
    mov     eax, DEBUG
    test    eax, eax
    jz      short loc_80487F8
    sub     esp, 8
    push    [ebp+arg_0]
    push    offset format; "PORT: %d\n"
    call    _printf
    add     esp, 10h
loc_80487F8:
    sub     esp, 0Ch
    push    [ebp+arg_0]
    call    read_server
    add     esp, 10h
    mov     eax, [ebp+arg_4]
    lea     edx, [ebp+var_108]
    add     eax, edx
    sub     esp, 8
    push    offset buff; src
    push    eax; dest
    call    _strcpy
    add     esp, 10h
    mov     eax, [ebp+arg_4]
    lea     edx, [ebp+var_108]
    add     eax, edx
    sub     esp, 8
    push    eax
    push    offset aGotS; "GOT: %s\n"
    call    _printf
    add     esp, 10h
    mov     eax, [ebp+arg_4]
    add     eax, 10h
    mov     edi, [ebp+var_4]
    leave
    retn
loop endp

