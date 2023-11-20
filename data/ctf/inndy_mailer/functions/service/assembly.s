service proc
    push    ebp
    mov     ebp, esp
    push    edi
    push    esi
    push    ebx
    sub     esp, 0Ch
    mov     edx, offset helloworld
    mov     ebx, offset unk_8048AA0
    mov     eax, 12h
    mov     edi, edx
    mov     esi, ebx
    mov     ecx, eax
    rep movsd
    mov     ds:root, offset helloworld
    mov     eax, ds:root
    add     eax, 48h ; 'H'
    sub     esp, 4
    push    0Ch; n
    push    offset aHelloWorld; "Hello, World"
    push    eax; dest
    call    _memcpy
    add     esp, 10h
loc_804884C:
    sub     esp, 0Ch
    push    offset a0Exit; "0. Exit"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a1WriteMail; "1. Write mail"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset a2DumpMails; "2. Dump mails"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aAction; "Action: "
    call    _printf
    add     esp, 10h
    call    readint
    cmp     eax, 1
    jz      short loc_80488B4
    cmp     eax, 1
    jb      short loc_80488A2
    cmp     eax, 2
    jz      short loc_80488BB
    jmp     short loc_80488C2
loc_80488A2:
    sub     esp, 0Ch
    push    offset aBye; "Bye"
    call    _puts
    add     esp, 10h
    jmp     short loc_80488D7
loc_80488B4:
    call    write_mail
    jmp     short loc_80488D2
loc_80488BB:
    call    dump_mail
    jmp     short loc_80488D2
loc_80488C2:
    sub     esp, 0Ch
    push    offset aInvalidChoice; "Invalid choice"
    call    _puts
    add     esp, 10h
loc_80488D2:
    jmp     loc_804884C
loc_80488D7:
    lea     esp, [ebp-0Ch]
    pop     ebx
    pop     esi
    pop     edi
    pop     ebp
    retn
service endp

