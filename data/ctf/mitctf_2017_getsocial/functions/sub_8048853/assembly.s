sub_8048853 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 8
    sub     esp, 0Ch
    push    offset aIfYouCanWriteA; "If you can write a million tweets, mayb"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aCommands0Print; "Commands:\n\t[0] print tweets\n\t[1] co"...
    call    _puts
    add     esp, 10h
    leave
    retn
sub_8048853 endp

