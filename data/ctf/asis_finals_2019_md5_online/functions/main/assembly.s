main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    esi
    push    ebx
    push    ecx
    sub     esp, 1Ch
    call    sub_890
    add     ebx, (offset off_2F74 - $)
    call    sub_C1C
    mov     [ebp+var_1C], 0
    jmp     loc_F53
loc_DEF:
    sub     esp, 0Ch
    lea     eax, (aText - 2F74h)[ebx]; "Text: "
    push    eax; format
    call    _printf
    add     esp, 10h
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    add     eax, 40h ; '@'
    sub     esp, 8
    push    200h; int
    push    eax; s
    call    sub_B8C
    add     esp, 10h
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    movzx   eax, byte ptr [eax+40h]
    test    al, al
    jz      loc_F5F
    sub     esp, 0Ch
    lea     eax, (aWithSaltYN - 2F74h)[ebx]; "With salt? [y/N] "
    push    eax; format
    call    _printf
    add     esp, 10h
    call    _getchar
    mov     [ebp+var_1D], al
    call    _getchar
    cmp     [ebp+var_1D], 59h ; 'Y'
    jz      short loc_E60
    cmp     [ebp+var_1D], 79h ; 'y'
    jnz     loc_F10
loc_E60:
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    mov     edx, eax
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    add     eax, 40h ; '@'
    sub     esp, 4
    push    1
    push    edx
    push    eax
    call    sub_9C0
    add     esp, 10h
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    sub     esp, 8
    push    eax
    lea     eax, (aMd5SaltedS - 2F74h)[ebx]; "MD5 (salted): %s\n"
    push    eax; format
    call    _printf
    add     esp, 10h
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    mov     eax, [eax+240h]
    add     eax, 3
    movzx   eax, byte ptr [eax]
    movzx   esi, al
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    mov     eax, [eax+240h]
    add     eax, 2
    movzx   eax, byte ptr [eax]
    movzx   ecx, al
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    mov     eax, [eax+240h]
    add     eax, 1
    movzx   eax, byte ptr [eax]
    movzx   edx, al
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    mov     eax, [eax+240h]
    movzx   eax, byte ptr [eax]
    movzx   eax, al
    sub     esp, 0Ch
    push    esi
    push    ecx
    push    edx
    push    eax
    lea     eax, (aSaltX02xX02xX0 - 2F74h)[ebx]; "Salt: \\x%02x\\x%02x\\x%02x\\x%02x\n"
    push    eax; format
    call    _printf
    add     esp, 20h
    jmp     short loc_F4F
loc_F10:
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    mov     edx, eax
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    add     eax, 40h ; '@'
    sub     esp, 4
    push    0
    push    edx
    push    eax
    call    sub_9C0
    add     esp, 10h
    lea     eax, (dword_300C - 2F74h)[ebx]
    mov     eax, [eax]
    sub     esp, 8
    push    eax
    lea     eax, (aMd5S - 2F74h)[ebx]; "MD5: %s\n"
    push    eax; format
    call    _printf
    add     esp, 10h
loc_F4F:
    add     [ebp+var_1C], 1
loc_F53:
    cmp     [ebp+var_1C], 2
    jle     loc_DEF
    jmp     short loc_F60
loc_F5F:
    nop
loc_F60:
    call    sub_D80
    mov     eax, 0
    lea     esp, [ebp-0Ch]
    pop     ecx
    pop     ebx
    pop     esi
    pop     ebp
    lea     esp, [ecx-4]
    retn
main endp

