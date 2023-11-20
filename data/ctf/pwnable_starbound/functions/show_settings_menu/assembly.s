show_settings_menu proc
    sub     esp, 1Ch
    cmp     ds:dword_80580CC, 0
    jz      short loc_804931F
    call    cmd_view
loc_804931F:
    mov     [esp+1Ch+s], offset aStarboundV10Se; "\n-+STARBOUND v1.0: SETTINGS+-"
    call    _puts
    mov     [esp+1Ch+s], offset a0Exit; "  0. Exit"
    call    _puts
    mov     [esp+1Ch+s], offset a1Back; "  1. Back"
    call    _puts
    mov     [esp+1Ch+s], offset a2Name; "  2. Name"
    call    _puts
    mov     [esp+1Ch+s], offset a3Ip; "  3. IP"
    call    _puts
    mov     [esp+1Ch+s], offset a4ToggleView; "  4. Toggle View"
    call    _puts
    mov     [esp+1Ch+var_18], offset asc_804A792; "> "
    mov     [esp+1Ch+s], 1
    call    ___printf_chk
    mov     eax, 0
    jmp     short loc_8049390
loc_8049382:
    mov     ds:dword_8058154[eax*4], offset cmd_nop
    add     eax, 1
loc_8049390:
    cmp     eax, 9
    jle     short loc_8049382
    mov     ds:dword_8058158, offset cmd_go_back
    mov     ds:dword_805815C, offset cmd_set_name
    mov     ds:dword_8058160, offset cmd_set_ip
    mov     ds:dword_8058164, offset cmd_set_autoview
    add     esp, 1Ch
    retn
show_settings_menu endp

