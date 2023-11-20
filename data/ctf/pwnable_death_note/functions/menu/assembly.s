menu proc
    push    ebp
    mov     ebp, esp
    sub     esp, 8
    sub     esp, 0Ch
    push    offset asc_8048B0C; "-----------------------------------"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aDeathnote; "             DeathNote             "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048B0C; "-----------------------------------"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a1AddAName; " 1. Add a name                     "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a2ShowANameOnTh; " 2. show a name on the note        "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a3DeleteANameIn; " 3. delete a name int the note     "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a4Exit; " 4. Exit                           "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048B0C; "-----------------------------------"
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

