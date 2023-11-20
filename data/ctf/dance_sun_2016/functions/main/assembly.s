main proc
    push    ebp
    mov     ebp, esp
    push    esi
    sub     esp, 0D4h
    mov     eax, 0
    mov     ecx, 50h ; 'P'
    lea     edx, [ebp+s]
    mov     [ebp+var_8], 0
    mov     [ebp+var_C], 0
    mov     [ebp+var_10], 0
    mov     [esp], edx; s
    mov     dword ptr [esp+4], 0; c
    mov     dword ptr [esp+8], 50h ; 'P'; n
    mov     [ebp+var_68], eax
    mov     [ebp+var_6C], ecx
    call    _memset
    lea     eax, aWelcomeToThePr; "welcome to the pro club. you just paid "...
    mov     [ebp+var_C], 12ADAAC9h
    mov     [esp], eax; format
    call    _printf
    mov     ecx, ds:stdout@@GLIBC_2_0
    mov     [esp], ecx; stream
    mov     [ebp+var_70], eax
    call    _fflush
    mov     ecx, 59h ; 'Y'
    lea     edx, [ebp+s]
    mov     esi, ds:__bss_start
    mov     [esp], edx; s
    mov     dword ptr [esp+4], 59h ; 'Y'; n
    mov     [esp+8], esi; stream
    mov     [ebp+var_74], eax
    mov     [ebp+var_78], ecx
    call    _fgets
    lea     ecx, [ebp+s]
    mov     [ebp+var_64], ecx
    mov     [ebp+var_7C], eax
loc_8048641:
    mov     eax, [ebp+var_64]
    mov     [esp], eax; s
    call    _strlen
    cmp     eax, 0
    jbe     loc_804877F
    mov     eax, [ebp+var_64]
    movsx   eax, byte ptr [eax]
    cmp     eax, 77h ; 'w'
    jnz     loc_80486F0
    lea     eax, aDoTheWhip; "do the whip!\n"
    mov     ecx, [ebp+var_64]
    add     ecx, 5
    mov     [ebp+var_64], ecx
    mov     [esp], eax; format
    call    _printf
    mov     ecx, ds:stdout@@GLIBC_2_0
    mov     [esp], ecx; stream
    mov     [ebp+var_80], eax
    call    _fflush
    mov     ecx, 0C3500h
    mov     dword ptr [esp], 0C3500h; useconds
    mov     [ebp+var_84], ecx
    mov     [ebp+var_88], eax
    call    _usleep
    mov     [ebp+var_8C], eax
    call    do_whip
    mov     eax, ds:stdout@@GLIBC_2_0
    mov     [esp], eax; stream
    call    _fflush
    mov     ecx, 7A120h
    mov     dword ptr [esp], 7A120h; useconds
    mov     [ebp+var_90], eax
    mov     [ebp+var_94], ecx
    call    _usleep
    mov     [ebp+var_98], eax
    jmp     loc_804877A
loc_80486F0:
    mov     eax, [ebp+var_64]
    movsx   eax, byte ptr [eax]
    cmp     eax, 6Eh ; 'n'
    jnz     loc_804876F
    lea     eax, aDoTheNaenae; "do the naenae\n"
    mov     ecx, [ebp+var_64]
    add     ecx, 7
    mov     [ebp+var_64], ecx
    mov     [esp], eax; format
    call    _printf
    mov     ecx, ds:stdout@@GLIBC_2_0
    mov     [esp], ecx; stream
    mov     [ebp+var_9C], eax
    call    _fflush
    mov     ecx, 7A120h
    mov     dword ptr [esp], 7A120h; useconds
    mov     [ebp+var_A0], eax
    mov     [ebp+var_A4], ecx
    call    _usleep
    mov     [ebp+var_A8], eax
    call    do_naenae
    mov     eax, ds:stdout@@GLIBC_2_0
    mov     [esp], eax; stream
    call    _fflush
    mov     [ebp+var_AC], eax
    jmp     loc_804877A
loc_804876F:
    mov     eax, [ebp+var_64]
    add     eax, 1
    mov     [ebp+var_64], eax
loc_804877A:
    jmp     loc_8048641
loc_804877F:
    cmp     [ebp+var_C], 12ADAAC9h
    jnz     loc_80487C6
    cmp     [ebp+var_10], 0
    jz      loc_80487C1
    lea     eax, aGirlUCanDanceW; "girl u can dance w the best of em. the "...
    mov     [esp], eax; format
    call    _printf
    mov     ecx, ds:stdout@@GLIBC_2_0
    mov     [esp], ecx; stream
    mov     [ebp+var_B0], eax
    call    _fflush
    mov     [ebp+var_B4], eax
loc_80487C1:
    jmp     loc_80487EE
loc_80487C6:
    lea     eax, aThoseDanceMove; "those dance moves are some dark artsz k"...
    mov     [esp], eax; format
    call    _printf
    mov     ecx, ds:stdout@@GLIBC_2_0
    mov     [esp], ecx; stream
    mov     [ebp+var_B8], eax
    call    _fflush
    mov     [ebp+var_BC], eax
loc_80487EE:
    lea     eax, aCoolDanceComeA; "\ncool dance! come again!\n"
    mov     [esp], eax; format
    call    _printf
    mov     ecx, ds:stdout@@GLIBC_2_0
    mov     [esp], ecx; stream
    mov     [ebp+var_C0], eax
    call    _fflush
    mov     ecx, 0
    mov     [ebp+var_C4], eax
    mov     eax, ecx
    add     esp, 0D4h
    pop     esi
    pop     ebp
    retn
main endp

