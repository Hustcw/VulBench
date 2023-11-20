writefile proc
    push    ebp
    mov     ebp, esp
    sub     esp, 8
    sub     esp, 8
    push    offset needle; "flag"
    push    offset filename; haystack
    call    _strstr
    add     esp, 10h
    test    eax, eax
    jnz     short loc_80488E9
    sub     esp, 8
    push    offset aFlag_0; "FLAG"
    push    offset magicbuf; haystack
    call    _strstr
    add     esp, 10h
    test    eax, eax
    jnz     short loc_80488E9
    sub     esp, 8
    push    7Dh ; '}'; c
    push    offset magicbuf; s
    call    _strchr
    add     esp, 10h
    test    eax, eax
    jz      short loc_8048903
loc_80488E9:
    sub     esp, 0Ch
    push    offset aYouCanTSeeIt; "you can't see it"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_8048903:
    sub     esp, 0Ch
    push    offset magicbuf; s
    call    _puts
    add     esp, 10h
    nop
    leave
    retn
writefile endp

