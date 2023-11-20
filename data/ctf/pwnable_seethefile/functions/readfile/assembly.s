readfile proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     [ebp+var_C], 0
    sub     esp, 4
    push    190h; n
    push    0; c
    push    offset magicbuf; s
    call    _memset
    add     esp, 10h
    mov     eax, ds:fp
    test    eax, eax
    jz      short loc_8048888
    mov     eax, ds:fp
    push    eax; stream
    push    1; n
    push    18Fh; size
    push    offset magicbuf; ptr
    call    _fread
    add     esp, 10h
    mov     [ebp+var_C], eax
    cmp     [ebp+var_C], 0
    jz      short loc_8048898
    sub     esp, 0Ch
    push    offset aReadSuccessful; "Read Successful"
    call    _puts
    add     esp, 10h
    jmp     short loc_8048898
loc_8048888:
    sub     esp, 0Ch
    push    offset aYouNeedToOpenA; "You need to open a file first"
    call    _puts
    add     esp, 10h
loc_8048898:
    nop
    leave
    retn
readfile endp

