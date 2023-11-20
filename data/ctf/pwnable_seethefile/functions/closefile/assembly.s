closefile proc
    push    ebp
    mov     ebp, esp
    sub     esp, 8
    mov     eax, ds:fp
    test    eax, eax
    jz      short loc_8048938
    mov     eax, ds:fp
    sub     esp, 0Ch
    push    eax; stream
    call    _fclose
    add     esp, 10h
    jmp     short loc_8048948
loc_8048938:
    sub     esp, 0Ch
    push    offset aNothingNeedToC; "Nothing need to close"
    call    _puts
    add     esp, 10h
loc_8048948:
    mov     ds:fp, 0
    nop
    leave
    retn
closefile endp

