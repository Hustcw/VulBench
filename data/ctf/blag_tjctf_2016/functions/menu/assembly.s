menu proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 0Ch
    push    offset aCommandsListLi; "Commands:\n\nlist: List all posts.\nrea"...
    call    _puts
    add     esp, 10h
loc_8048ACC:
    sub     esp, 0Ch
    push    offset asc_8049079; "> "
    call    _printf
    add     esp, 10h
    mov     eax, ds:stdin@@GLIBC_2_0
    sub     esp, 4
    push    eax
    push    8
    lea     eax, [ebp+s1]
    push    eax
    call    readline
    add     esp, 10h
    sub     esp, 8
    push    offset s2; "list"
    lea     eax, [ebp+s1]
    push    eax; s1
    call    _strcmp
    add     esp, 10h
    test    eax, eax
    jnz     short loc_8048B15
    call    listposts
    jmp     loc_8048BA9
loc_8048B15:
    sub     esp, 8
    push    offset aRead; "read"
    lea     eax, [ebp+s1]
    push    eax; s1
    call    _strcmp
    add     esp, 10h
    test    eax, eax
    jnz     short loc_8048B34
    call    readpost
    jmp     short loc_8048BA9
loc_8048B34:
    sub     esp, 8
    push    offset aAdd; "add"
    lea     eax, [ebp+s1]
    push    eax; s1
    call    _strcmp
    add     esp, 10h
    test    eax, eax
    jnz     short loc_8048B53
    call    addpost
    jmp     short loc_8048BA9
loc_8048B53:
    sub     esp, 8
    push    offset aAuth; "auth"
    lea     eax, [ebp+s1]
    push    eax; s1
    call    _strcmp
    add     esp, 10h
    test    eax, eax
    jnz     short loc_8048B72
    call    auth
    jmp     short loc_8048BA9
loc_8048B72:
    sub     esp, 8
    push    offset aQuit; "quit"
    lea     eax, [ebp+s1]
    push    eax; s1
    call    _strcmp
    add     esp, 10h
    test    eax, eax
    jnz     short loc_8048B99
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_8048BB3
    jmp     short loc_8048BAE
loc_8048B99:
    sub     esp, 0Ch
    push    offset aInvalidCommand; "Invalid command."
    call    _puts
    add     esp, 10h
loc_8048BA9:
    jmp     loc_8048ACC
loc_8048BAE:
    call    ___stack_chk_fail
locret_8048BB3:
    leave
    retn
menu endp

