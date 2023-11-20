show_multiplayer_menu proc
    sub     esp, 1Ch
    mov     [esp+1Ch+s], offset aStarboundV10Mu; "\n-+STARBOUND v1.0: MULTIPLAYER+-"
    call    _puts
    mov     [esp+1Ch+s], offset a0Exit; "  0. Exit"
    call    _puts
    mov     [esp+1Ch+s], offset a1Back; "  1. Back"
    call    _puts
    mov     [esp+1Ch+s], offset a2Enable; "  2. Enable"
    call    _puts
    mov     [esp+1Ch+s], offset a3Disable; "  3. Disable"
    call    _puts
    mov     [esp+1Ch+s], offset a4Teleport; "  4. Teleport"
    call    _puts
    mov     [esp+1Ch+s], offset a5ShareYourCoor; "  5. Share Your Coordinate"
    call    _puts
    mov     [esp+1Ch+var_18], offset asc_804A792; "> "
    mov     [esp+1Ch+s], 1
    call    ___printf_chk
    mov     eax, 0
    jmp     short loc_8048ECC
loc_8048EBE:
    mov     ds:dword_8058154[eax*4], offset cmd_nop
    add     eax, 1
loc_8048ECC:
    cmp     eax, 9
    jle     short loc_8048EBE
    mov     ds:dword_8058158, offset cmd_go_back
    mov     ds:dword_805815C, offset cmd_multiplayer_enable
    mov     ds:dword_8058160, offset cmd_multiplayer_disable
    mov     ds:dword_8058164, offset cmd_multiplayer_recvmap
    mov     ds:dword_8058168, offset cmd_multiplayer_sendmap
    add     esp, 1Ch
    retn
show_multiplayer_menu endp

