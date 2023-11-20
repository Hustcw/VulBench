main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ebx
    push    ecx
    add     esp, 0FFFFFF80h
    call    sub_8049130
    add     ebx, (offset off_804C000 - $)
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     eax, ds:(stdout_ptr - 804C000h)[ebx]
    mov     eax, [eax]
    push    0; n
    push    2; modes
    push    0; buf
    push    eax; stream
    call    _setvbuf
    add     esp, 10h
    sub     esp, 0Ch
    push    0; timer
    call    _time
    add     esp, 10h
    sub     esp, 0Ch
    push    eax; seed
    call    _srand
    add     esp, 10h
    sub     esp, 8
    push    0; oflag
    lea     eax, (aDevUrandom - 804C000h)[ebx]; "/dev/urandom"
    push    eax; file
    call    _open
    add     esp, 10h
    mov     [ebp+fd], eax
    sub     esp, 4
    push    4; nbytes
    mov     eax, offset dword_804C044
    push    eax; buf
    push    [ebp+fd]; fd
    call    _read
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (aYourName - 804C000h)[ebx]; "your name:"
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 4
    push    63h ; 'c'; nbytes
    lea     eax, [ebp+buf]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (aHello - 804C000h)[ebx]; "Hello,"
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+buf]
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (aYourPasswd - 804C000h)[ebx]; "your passwd:"
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 4
    push    0Fh; nbytes
    lea     eax, [ebp+nptr]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+nptr]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     edx, eax
    mov     eax, offset dword_804C044
    mov     eax, [eax]
    cmp     edx, eax
    jz      short loc_804931A
    sub     esp, 0Ch
    lea     eax, (aFail - 804C000h)[ebx]; "fail"
    push    eax; s
    call    _puts
    add     esp, 10h
    jmp     short loc_804933E
loc_804931A:
    sub     esp, 0Ch
    lea     eax, (aOk - 804C000h)[ebx]; "ok!!"
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, (aBinSh - 804C000h)[ebx]; "/bin/sh"
    push    eax; command
    call    _system
    add     esp, 10h
loc_804933E:
    mov     eax, 0
    mov     ecx, [ebp+var_C]
    xor     ecx, large gs:14h
    jz      short loc_8049354
    call    sub_80493D0
loc_8049354:
    lea     esp, [ebp-8]
    pop     ecx
    pop     ebx
    pop     ebp
    lea     esp, [ecx-4]
    retn
main endp

