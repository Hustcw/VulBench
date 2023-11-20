cmd_multiplayer_recvmap proc
    push    edi
    push    esi
    push    ebx
    sub     esp, 20h
    call    _getpid
    mov     [esp+2Ch+var_18], eax
    mov     [esp+2Ch+s], offset aAskYourFriends; "Ask your friends to share their coordin"...
    call    _puts
    mov     ebx, 1
    lea     esi, [esp+2Ch+var_D]
    lea     edi, [esp+2Ch+var_18]
loc_804A474:
    mov     [esp+2Ch+nbytes], 1; nbytes
    mov     [esp+2Ch+buf], esi; buf
    mov     eax, ds:fd
    mov     [esp+2Ch+s], eax; fd
    call    _read
    test    eax, eax
    jg      short loc_804A4A2
    mov     [esp+2Ch+s], offset aErrorTransmiss; "[Error] Transmission error :("
    call    _puts
    jmp     loc_804A5FE
loc_804A4A2:
    movzx   eax, [esp+2Ch+var_D]
    cmp     al, 0Ah
    jz      short loc_804A4EA
    mov     [esp+2Ch+buf], edi
    movsx   eax, al
    mov     [esp+2Ch+s], eax
    call    rotate_shift_add_decrypt
    mov     [esp+2Ch+var_D], al
    test    ebx, ebx
    jz      short loc_804A4DB
    mov     [esp+2Ch+buf], offset aInfoReceiving; "[Info] Receiving ("
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     ebx, 0
loc_804A4DB:
    movsx   eax, [esp+2Ch+var_D]
    mov     [esp+2Ch+s], eax; c
    call    _putchar
    jmp     short loc_804A474
loc_804A4EA:
    mov     [esp+2Ch+s], offset asc_804EB85; ")"
    call    _puts
    mov     [esp+2Ch+buf], offset aInfoCalculateD; "[Info] Calculate distance ... "
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     [esp+2Ch+var_14], 0
    mov     ebx, 0
    jmp     short loc_804A54B
loc_804A519:
    lea     eax, [esp+2Ch+var_14]
    add     eax, ebx
    mov     [esp+2Ch+nbytes], 1; nbytes
    mov     [esp+2Ch+buf], eax; buf
    mov     eax, ds:fd
    mov     [esp+2Ch+s], eax; fd
    call    _read
    test    eax, eax
    jg      short loc_804A548
    mov     [esp+2Ch+s], 0; status
    call    _exit
loc_804A548:
    add     ebx, 1
loc_804A54B:
    cmp     ebx, 1
    jle     short loc_804A519
    mov     eax, [esp+2Ch+var_14]
    mov     [esp+2Ch+nbytes], eax
    mov     [esp+2Ch+buf], offset aDly; "%dly\n"
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     [esp+2Ch+s], offset aStartTeleporti; "Start teleporting!"
    call    _puts
    mov     eax, [esp+2Ch+var_14]
    mov     ds:dword_8057F84, eax
    mov     edx, eax
    shr     edx, 1Fh
    add     eax, edx
    sar     eax, 1
    mov     [esp+2Ch+var_14], eax
    mov     ebx, 0
    mov     esi, offset byte_8057F98
    jmp     short loc_804A5C9
loc_804A59A:
    mov     [esp+2Ch+nbytes], 1; nbytes
    mov     [esp+2Ch+buf], esi; buf
    mov     eax, ds:fd
    mov     [esp+2Ch+s], eax; fd
    call    _read
    test    eax, eax
    jg      short loc_804A5C3
    mov     [esp+2Ch+s], 0; status
    call    _exit
loc_804A5C3:
    add     esi, 1
    add     ebx, 1
loc_804A5C9:
    cmp     ebx, [esp+2Ch+var_14]
    jl      short loc_804A59A
    mov     eax, ds:dword_8057F88
    cdq
    idiv    ds:dword_8057F84
    mov     ds:dword_8057F88, edx
    mov     [esp+2Ch+s], (offset aInfoLanding+7); s
    call    _puts
    mov     [esp+2Ch+s], 7A120h; useconds
    call    _usleep
    call    cmd_view
loc_804A5FE:
    add     esp, 20h
    pop     ebx
    pop     esi
    pop     edi
    retn
cmd_multiplayer_recvmap endp

