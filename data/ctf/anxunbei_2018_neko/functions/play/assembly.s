play proc
    push    ebp
    mov     ebp, esp
    sub     esp, 0D8h
    sub     esp, 4
    push    0C8h; n
    push    0; c
    lea     eax, [ebp+s]
    push    eax; s
    call    _memset
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aHuhMabyYouHave; "Huh...maby you have a change to get my "...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aIfYouCanSolveM; "If you can solve my puzzle :p"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048B80; "                             ,"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048BA0; "      ,-.       _,---._ __  / \\  "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048BC4; "     /  )    .-'       `./ /   \\  "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048BE8; "    (  (   ,'            `/    /|  "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048C0C; "     \\  `-\"             \\'\\   / |  "...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048C34; "      `.              ,  \\ \\ /  |    "...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aY; "       /`.          ,'-`----Y   |      "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048C84; "      (            ;        |   '      "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048CAC; "      |  ,-.    ,-'         |  /       "...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048CD8; "      |  | (   |            | /        "...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048D04; "      )  |  \\  `.___________|/        "...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048D30; "      `--'   `--'\")                   "...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aHelpThisCatFou; "Help this cat found his anchovies:"
    call    _puts
    add     esp, 10h
    sub     esp, 4
    push    190h; nbytes
    lea     eax, [ebp+s]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aWhereAreTheAnc; "Where are the anchovies?"
    call    _puts
    add     esp, 10h
    mov     eax, 0
    leave
    retn
play endp

