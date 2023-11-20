welcome proc
    push    ebp
    mov     ebp, esp
    sub     esp, 8
    sub     esp, 0Ch
    push    offset asc_8048C90; "#######################################"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aThisIsASimpleP; "   This is a simple program to open,rea"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aYouCanOpenWhat; "   You can open what you want to see"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aCanYouReadEver; "   Can you read everything ?"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048C90; "#######################################"...
    call    _puts
    add     esp, 10h
    nop
    leave
    retn
welcome endp

