main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ebx
    push    ecx
    call    sub_590
    add     ebx, (offset off_2FB8 - $)
    mov     eax, ds:(stdin_ptr - 2FB8h)[ebx]
    mov     eax, [eax]
    push    0; n
    push    2; modes
    push    0; buf
    push    eax; stream
    call    _setvbuf
    add     esp, 10h
    mov     eax, ds:(stdout_ptr - 2FB8h)[ebx]
    mov     eax, [eax]
    push    0; n
    push    2; modes
    push    0; buf
    push    eax; stream
    call    _setvbuf
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (aCalculatorsAre - 2FB8h)[ebx]; "Calculators are fun!"
    push    eax; s
    call    _puts
    add     esp, 10h
    call    sub_E0E
    nop
    lea     esp, [ebp-8]
    pop     ecx
    pop     ebx
    pop     ebp
    lea     esp, [ecx-4]
    retn
main endp

