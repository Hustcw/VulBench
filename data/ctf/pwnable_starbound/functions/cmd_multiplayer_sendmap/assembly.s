cmd_multiplayer_sendmap proc
    push    ebp
    push    edi
    push    esi
    push    ebx
    sub     esp, 0BCh
    mov     [esp+0CCh+n], offset aYourFriendSPor; "Your friend's portal ID: "
    mov     [esp+0CCh+s], 1
    call    ___printf_chk
    mov     eax, ds:stdin@@GLIBC_2_0
    mov     [esp+0CCh+stream], eax; stream
    mov     [esp+0CCh+n], 0Ah; n
    lea     ebx, [esp+0CCh+nptr]
    mov     [esp+0CCh+s], ebx; s
    call    _fgets
    mov     [esp+0CCh+stream], 0Ah; base
    mov     [esp+0CCh+n], 0; endptr
    mov     [esp+0CCh+s], ebx; nptr
    call    _strtol
    mov     [esp+0CCh+var_90], eax
    mov     [esp+0CCh+stream], 0; protocol
    mov     [esp+0CCh+n], 2; type
    mov     [esp+0CCh+s], 1; domain
    call    _socket
    mov     edi, eax
    mov     [esp+0CCh+var_8A.sa_family], 1
    mov     eax, [esp+0CCh+var_90]
    mov     [esp+0CCh+addr], eax
    mov     [esp+0CCh+flags], offset aHomeStarboundM_0; "/home/starbound/.multiplayer/%d"
    mov     [esp+0CCh+stream], 6Ch ; 'l'
    mov     [esp+0CCh+n], 1
    lea     eax, [esp+0CCh+var_8A.sa_data]
    mov     [esp+0CCh+s], eax
    call    ___sprintf_chk
    mov     [esp+0CCh+n], offset aMakeSomeCommen; "Make some comments: "
    mov     [esp+0CCh+s], 1
    call    ___printf_chk
    mov     [esp+0CCh+ptr], 0
    mov     [esp+0CCh+var_A4], 0
    mov     eax, ds:stdin@@GLIBC_2_0
    mov     [esp+0CCh+stream], eax
    lea     eax, [esp+0CCh+var_A4]
    mov     [esp+0CCh+n], eax
    lea     eax, [esp+0CCh+ptr]
    mov     [esp+0CCh+s], eax
    call    _getline
    mov     [esp+0CCh+var_B0], eax
    mov     ebx, 0
    lea     ebp, [esp+0CCh+var_90]
    jmp     loc_804A33B
loc_804A2AD:
    mov     ecx, ebx
    mov     esi, ebx
    add     esi, [esp+0CCh+ptr]
    movzx   eax, byte ptr [esi]
    lea     edx, [eax-20h]
    cmp     dl, 5Eh ; '^'
    jbe     short loc_804A2F5
    mov     byte ptr [esi], 0Ah
    mov     [esp+0CCh+addr_len], 6Eh ; 'n'; addr_len
    lea     eax, [esp+0CCh+var_8A]
    mov     [esp+0CCh+addr], eax; addr
    mov     [esp+0CCh+flags], 0; flags
    mov     [esp+0CCh+stream], 1; n
    add     ecx, [esp+0CCh+ptr]
    mov     [esp+0CCh+n], ecx; buf
    mov     [esp+0CCh+s], edi; fd
    call    _sendto
    jmp     short loc_804A345
loc_804A2F5:
    mov     [esp+0CCh+n], ebp
    movsx   eax, al
    mov     [esp+0CCh+s], eax
    call    rotate_shift_add_encrypt
    mov     [esi], al
    mov     [esp+0CCh+addr_len], 6Eh ; 'n'; addr_len
    lea     eax, [esp+0CCh+var_8A]
    mov     [esp+0CCh+addr], eax; addr
    mov     [esp+0CCh+flags], 0; flags
    mov     [esp+0CCh+stream], 1; n
    mov     eax, ebx
    add     eax, [esp+0CCh+ptr]
    mov     [esp+0CCh+n], eax; buf
    mov     [esp+0CCh+s], edi; fd
    call    _sendto
    add     ebx, 1
loc_804A33B:
    cmp     ebx, [esp+0CCh+var_B0]
    jl      loc_804A2AD
loc_804A345:
    mov     eax, [esp+0CCh+ptr]
    mov     [esp+0CCh+s], eax; ptr
    call    _free
    mov     ebx, 0
    lea     esi, [esp+0CCh+var_8A]
    jmp     short loc_804A38D
loc_804A35C:
    mov     [esp+0CCh+addr_len], 6Eh ; 'n'; addr_len
    mov     [esp+0CCh+addr], esi; addr
    mov     [esp+0CCh+flags], 0; flags
    mov     [esp+0CCh+stream], 1; n
    lea     eax, dword_8057F84[ebx]
    mov     [esp+0CCh+n], eax; buf
    mov     [esp+0CCh+s], edi; fd
    call    _sendto
    add     ebx, 1
loc_804A38D:
    cmp     ebx, 1
    jle     short loc_804A35C
    mov     ebx, 0
    lea     esi, [esp+0CCh+var_8A]
    jmp     short loc_804A3CE
loc_804A39D:
    lea     eax, byte_8057F98[ebx]
    mov     [esp+0CCh+addr_len], 6Eh ; 'n'; addr_len
    mov     [esp+0CCh+addr], esi; addr
    mov     [esp+0CCh+flags], 0; flags
    mov     [esp+0CCh+stream], 1; n
    mov     [esp+0CCh+n], eax; buf
    mov     [esp+0CCh+s], edi; fd
    call    _sendto
    add     ebx, 1
loc_804A3CE:
    mov     eax, ds:dword_8057F84
    mov     edx, eax
    shr     edx, 1Fh
    add     eax, edx
    sar     eax, 1
    cmp     eax, ebx
    jg      short loc_804A39D
    mov     [esp+0CCh+s], edi; fd
    call    _close
    mov     [esp+0CCh+s], offset aInfoCompleted; "[Info] Completed"
    call    _puts
    add     esp, 0BCh
    pop     ebx
    pop     esi
    pop     edi
    pop     ebp
    retn
cmd_multiplayer_sendmap endp

