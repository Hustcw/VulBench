openfile proc
    push    ebp
    mov     ebp, esp
    sub     esp, 8
    mov     eax, ds:fp
    test    eax, eax
    jz      short loc_8048770
    sub     esp, 0Ch
    push    offset aYouNeedToClose; "You need to close the file first"
    call    _puts
    add     esp, 10h
    mov     eax, 0
    jmp     locret_8048824
loc_8048770:
    sub     esp, 4
    push    190h; n
    push    0; c
    push    offset magicbuf; s
    call    _memset
    add     esp, 10h
    sub     esp, 0Ch
    push    offset format; "What do you want to see :"
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    offset filename
    push    offset a63s; "%63s"
    call    ___isoc99_scanf
    add     esp, 10h
    sub     esp, 8
    push    offset needle; "flag"
    push    offset filename; haystack
    call    _strstr
    add     esp, 10h
    test    eax, eax
    jz      short loc_80487DF
    sub     esp, 0Ch
    push    offset aDanger; "Danger !"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_80487DF:
    sub     esp, 8
    push    offset modes; "r"
    push    offset filename; filename
    call    _fopen
    add     esp, 10h
    mov     ds:fp, eax
    mov     eax, ds:fp
    test    eax, eax
    jnz     short loc_8048814
    sub     esp, 0Ch
    push    offset aOpenFailed; "Open failed"
    call    _puts
    add     esp, 10h
    jmp     short locret_8048824
loc_8048814:
    sub     esp, 0Ch
    push    offset aOpenSuccessful; "Open Successful"
    call    _puts
    add     esp, 10h
locret_8048824:
    leave
    retn
openfile endp

