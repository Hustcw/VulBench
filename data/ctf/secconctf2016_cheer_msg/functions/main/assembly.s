main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 24h
    mov     dword ptr [esp], offset format; "Hello, I'm Nao.\nGive me your cheering "...
    call    _printf
    call    getint
    mov     [ebp+n], eax
    mov     eax, [ebp+n]
    lea     edx, [eax+0Fh]
    mov     eax, 10h
    sub     eax, 1
    add     eax, edx
    mov     ecx, 10h
    mov     edx, 0
    div     ecx
    imul    eax, 10h
    sub     esp, eax
    lea     eax, [esp+8]
    add     eax, 0Fh
    shr     eax, 4
    shl     eax, 4
    mov     [ebp+var_C], eax
    mov     eax, [ebp+n]
    mov     [esp+4], eax; n
    mov     eax, [ebp+var_C]
    mov     [esp], eax; int
    call    message
    leave
    retn
main endp

