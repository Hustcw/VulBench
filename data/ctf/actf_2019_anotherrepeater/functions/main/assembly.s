main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 4
    call    init
    sub     esp, 0Ch
    push    offset aThereComesBrut; "There comes brute repeater, it will rep"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aBeCarefulHowMa; "Be careful. How many chars you want to "...
    call    _puts
    add     esp, 10h
    call    input
loc_80487B8:
    sub     esp, 0Ch
    push    offset str; "WTF?"
    call    _puts
    add     esp, 10h
    jmp     short loc_80487B8
main endp

