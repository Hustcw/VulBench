addpost proc
    push    ebp
    mov     ebp, esp
    sub     esp, 38h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     eax, ds:numposts
    cmp     eax, 7
    jle     short loc_8048881
    sub     esp, 0Ch
    push    offset aBlagIsFull; "Blag is full!"
    call    _puts
    add     esp, 10h
    jmp     loc_8048957
loc_8048881:
    mov     eax, ds:numposts
    mov     eax, ds:posts[eax*4]
    mov     [ebp+var_30], eax
    sub     esp, 0Ch
    push    offset aAuthor; "Author?"
    call    _puts
    add     esp, 10h
    mov     eax, ds:stdin@@GLIBC_2_0
    sub     esp, 4
    push    eax
    push    20h ; ' '
    lea     eax, [ebp+src]
    push    eax
    call    readline
    add     esp, 10h
    mov     eax, [ebp+var_30]
    lea     edx, [eax+4]
    sub     esp, 8
    lea     eax, [ebp+src]
    push    eax; src
    push    edx; dest
    call    _strcpy
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aTitle; "Title?"
    call    _puts
    add     esp, 10h
    mov     eax, ds:stdin@@GLIBC_2_0
    sub     esp, 4
    push    eax
    push    20h ; ' '
    lea     eax, [ebp+src]
    push    eax
    call    readline
    add     esp, 10h
    mov     eax, [ebp+var_30]
    lea     edx, [eax+24h]
    sub     esp, 8
    lea     eax, [ebp+src]
    push    eax; src
    push    edx; dest
    call    _strcpy
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aBody; "Body?"
    call    _puts
    add     esp, 10h
    mov     eax, ds:stdin@@GLIBC_2_0
    sub     esp, 4
    push    eax
    push    140h
    lea     eax, [ebp+src]
    push    eax
    call    readline
    add     esp, 10h
    mov     eax, [ebp+var_30]
    lea     edx, [eax+44h]
    sub     esp, 8
    lea     eax, [ebp+src]
    push    eax; src
    push    edx; dest
    call    _strcpy
    add     esp, 10h
    mov     eax, ds:numposts
    add     eax, 1
    mov     ds:numposts, eax
loc_8048957:
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_8048968
    call    ___stack_chk_fail
locret_8048968:
    leave
    retn
addpost endp

