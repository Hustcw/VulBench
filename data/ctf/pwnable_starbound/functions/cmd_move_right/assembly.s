cmd_move_right proc
    sub     esp, 1Ch
    mov     eax, ds:dword_8057F88
    add     eax, 1
    mov     ds:dword_8057F88, eax
    mov     edx, ds:dword_8057F84
    cmp     eax, edx
    jl      short loc_8049E9C
    sub     eax, edx
    mov     ds:dword_8057F88, eax
loc_8049E9C:
    mov     [esp+1Ch+s], offset aInfoMovedRight; "[Info] Moved right..."
    call    _puts
    call    check_pos
    add     esp, 1Ch
    retn
cmd_move_right endp

