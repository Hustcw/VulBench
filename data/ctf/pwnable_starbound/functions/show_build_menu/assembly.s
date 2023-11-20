show_build_menu proc
    sub     esp, 1Ch
    cmp     ds:dword_80580CC, 0
    jz      short loc_8049282
    call    cmd_view
loc_8049282:
    mov     [esp+1Ch+s], offset aStarboundV10To; "\n-+STARBOUND v1.0: TOOLS+-"
    call    _puts
    mov     [esp+1Ch+s], offset a0Exit; "  0. Exit"
    call    _puts
    mov     [esp+1Ch+s], offset a1Back; "  1. Back"
    call    _puts
    mov     [esp+1Ch+s], offset a2Pickaxe; "  2. Pickaxe"
    call    _puts
    mov     [esp+1Ch+s], offset a3Cobblestone; "  3. Cobblestone"
    call    _puts
    mov     [esp+1Ch+var_18], offset asc_804A792; "> "
    mov     [esp+1Ch+s], 1
    call    ___printf_chk
    mov     eax, 0
    jmp     short loc_80492E7
loc_80492D9:
    mov     ds:dword_8058154[eax*4], offset cmd_nop
    add     eax, 1
loc_80492E7:
    cmp     eax, 9
    jle     short loc_80492D9
    mov     ds:dword_8058158, offset cmd_go_back
    mov     ds:dword_805815C, offset cmd_build_dig
    mov     ds:dword_8058160, offset cmd_build_place
    add     esp, 1Ch
    retn
show_build_menu endp

