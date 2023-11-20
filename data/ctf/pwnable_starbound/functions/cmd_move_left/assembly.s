cmd_move_left proc
    sub     esp, 1Ch
    mov     eax, ds:dword_8057F88
    sub     eax, 1
    mov     ds:dword_8057F88, eax
    test    eax, eax
    jns     short loc_8049E66
    add     eax, ds:dword_8057F84
    mov     ds:dword_8057F88, eax
loc_8049E66:
    mov     [esp+1Ch+s], offset aInfoMovedLeft; "[Info] Moved left..."
    call    _puts
    call    check_pos
    add     esp, 1Ch
    retn
cmd_move_left endp

