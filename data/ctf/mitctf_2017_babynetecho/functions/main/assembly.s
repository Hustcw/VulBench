main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 14h
    mov     [ebp+var_C], 0
    sub     esp, 0Ch
    push    offset aIp; "IP: "
    call    _printf
    add     esp, 10h
    mov     eax, ds:stdin@@GLIBC_2_0
    sub     esp, 4
    push    eax; stream
    push    20h ; ' '; n
    push    offset s; s
    call    _fgets
    add     esp, 10h
    sub     esp, 0Ch
    push    offset s; s
    call    _strlen
    add     esp, 10h
    sub     eax, 1
    mov     ds:s[eax], 0
loc_80488A3:
    sub     esp, 0Ch
    push    0; timer
    call    _time
    add     esp, 10h
    cmp     eax, 58684680h
    jnz     short loc_80488BE
    call    admin
    jmp     short loc_80488A3
loc_80488BE:
    call    _rand
    mov     edx, eax
    mov     eax, edx
    sar     eax, 1Fh
    shr     eax, 10h
    add     edx, eax
    movzx   edx, dx
    sub     edx, eax
    mov     eax, edx
    sub     esp, 8
    push    [ebp+var_C]
    push    eax
    call    loop
    add     esp, 10h
    mov     [ebp+var_C], eax
    jmp     short loc_80488A3
main endp

