sub_8048637 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 118h
    sub     esp, 0Ch
    push    offset aWelcomeToMyGam; "Welcome to my game server"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aFirstYouNeedTo; "First, you need to tell me you name?"
    call    _puts
    add     esp, 10h
    mov     eax, ds:stdin
    sub     esp, 4
    push    eax; stream
    push    100h; n
    push    offset byte_804A180; s
    call    _fgets
    add     esp, 10h
    sub     esp, 8
    push    0Ah; c
    push    offset byte_804A180; s
    call    _strrchr
    add     esp, 10h
    mov     [ebp+var_C], eax
    cmp     [ebp+var_C], 0
    jz      short loc_804869C
    mov     eax, [ebp+var_C]
    mov     byte ptr [eax], 0
loc_804869C:
    sub     esp, 8
    push    offset byte_804A180
    push    offset format; "Hello %s\n"
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aWhatSYouOccupa; "What's you occupation?"
    call    _puts
    add     esp, 10h
    mov     eax, ds:stdin
    sub     esp, 4
    push    eax; stream
    push    100h; n
    push    offset byte_804A080; s
    call    _fgets
    add     esp, 10h
    sub     esp, 8
    push    0Ah; c
    push    offset byte_804A080; s
    call    _strrchr
    add     esp, 10h
    mov     [ebp+var_C], eax
    cmp     [ebp+var_C], 0
    jz      short loc_80486FD
    mov     eax, [ebp+var_C]
    mov     byte ptr [eax], 0
loc_80486FD:
    sub     esp, 8
    push    offset byte_804A080
    push    offset aWellMyNobleS; "Well, my noble %s\n"
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    push    offset byte_804A080
    push    offset byte_804A180
    push    offset aOurSIsANobleSH; "Our %s is a noble %s. He is come from n"...
    push    100h; maxlen
    lea     eax, [ebp+s]
    push    eax; s
    call    _snprintf
    add     esp, 20h
    mov     [ebp+nbytes], eax
    sub     esp, 0Ch
    push    offset aHereIsYouIntro; "Here is you introduce"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+s]
    push    eax; s
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aDoYouWantToEdi; "Do you want to edit you introduce by yo"...
    call    _puts
    add     esp, 10h
    call    _getchar
    mov     [ebp+var_11], al
    call    _getchar
    cmp     [ebp+var_11], 59h ; 'Y'
    jnz     short loc_8048797
    sub     esp, 4
    push    [ebp+nbytes]; nbytes
    lea     eax, [ebp+s]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
loc_8048797:
    lea     eax, [ebp+s]
    push    eax
    push    offset byte_804A080
    push    offset byte_804A180
    push    offset aNameSOccupatio; "name : %s\noccupation : %s\nintroduce :"...
    call    _printf
    add     esp, 10h
    nop
    leave
    retn
sub_8048637 endp

