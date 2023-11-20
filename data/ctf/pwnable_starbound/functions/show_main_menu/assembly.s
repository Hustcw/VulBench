show_main_menu proc
    sub     esp, 1Ch
    mov     [esp+1Ch+s], offset s; "\n-+STARBOUND v1.0+-"
    call    _puts
    mov     [esp+1Ch+s], offset a0Exit; "  0. Exit"
    call    _puts
    mov     [esp+1Ch+s], offset a1Info; "  1. Info"
    call    _puts
    mov     [esp+1Ch+s], offset a2Move; "  2. Move"
    call    _puts
    mov     [esp+1Ch+s], offset a3View; "  3. View"
    call    _puts
    mov     [esp+1Ch+s], offset a4Tools; "  4. Tools"
    call    _puts
    mov     [esp+1Ch+s], offset a5Kill; "  5. Kill"
    call    _puts
    mov     [esp+1Ch+s], offset a6Settings; "  6. Settings"
    call    _puts
    mov     [esp+1Ch+s], offset a7Multiplayer; "  7. Multiplayer"
    call    _puts
    mov     [esp+1Ch+var_18], offset asc_804A792; "> "
    mov     [esp+1Ch+s], 1
    call    ___printf_chk
    mov     eax, 0
    jmp     short loc_8048DFD
loc_8048DEF:
    mov     ds:dword_8058154[eax*4], offset cmd_nop
    add     eax, 1
loc_8048DFD:
    cmp     eax, 9
    jle     short loc_8048DEF
    mov     ds:dword_8058158, offset cmd_info
    mov     ds:dword_805815C, offset cmd_move
    mov     ds:dword_8058160, offset cmd_view
    mov     ds:dword_8058164, offset cmd_build
    mov     ds:dword_8058168, offset cmd_kill
    mov     ds:dword_805816C, offset cmd_settings
    mov     ds:dword_8058170, offset cmd_multiplayer
    add     esp, 1Ch
    retn
show_main_menu endp

