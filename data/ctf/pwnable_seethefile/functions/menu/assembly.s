menu proc
    push    ebp
    mov     ebp, esp
    sub     esp, 8
    sub     esp, 0Ch
    push    offset aMenu; "---------------MENU---------------"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a1Open; "  1. Open"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a2Read; "  2. Read"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a3WriteToScreen; "  3. Write to screen"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a4Close; "  4. Close"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a5Exit; "  5. Exit"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048DA8; "----------------------------------"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aYourChoice; "Your choice :"
    call    _printf
    add     esp, 10h
    nop
    leave
    retn
menu endp

