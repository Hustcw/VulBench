show_move_menu proc
    sub     esp, 1Ch
    cmp     ds:dword_80580CC, 0
    jz      short loc_80491CF
    call    cmd_view
loc_80491CF:
    mov     [esp+1Ch+s], offset aStarboundV10Mo; "\n-+STARBOUND v1.0: MOVE+-"
    call    _puts
    mov     [esp+1Ch+s], offset a0Exit; "  0. Exit"
    call    _puts
    mov     [esp+1Ch+s], offset a1Back; "  1. Back"
    call    _puts
    mov     [esp+1Ch+s], offset a2Left; "  2. Left"
    call    _puts
    mov     [esp+1Ch+s], offset a3Right; "  3. Right"
    call    _puts
    mov     [esp+1Ch+s], offset a4Jump; "  4. Jump"
    call    _puts
    mov     [esp+1Ch+var_18], offset asc_804A792; "> "
    mov     [esp+1Ch+s], 1
    call    ___printf_chk
    mov     eax, 0
    jmp     short loc_8049240
loc_8049232:
    mov     ds:dword_8058154[eax*4], offset cmd_nop
    add     eax, 1
loc_8049240:
    cmp     eax, 9
    jle     short loc_8049232
    mov     ds:dword_8058158, offset cmd_go_back
    mov     ds:dword_805815C, offset cmd_move_left
    mov     ds:dword_8058160, offset cmd_move_right
    mov     ds:dword_8058164, offset cmd_move_jump
    add     esp, 1Ch
    retn
show_move_menu endp

