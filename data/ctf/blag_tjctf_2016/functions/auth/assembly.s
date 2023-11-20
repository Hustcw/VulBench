auth proc
    push    ebp
    mov     ebp, esp
    sub     esp, 38h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 0Ch
    push    offset s; "Enter admin password:"
    call    _puts
    add     esp, 10h
    mov     eax, ds:stdin@@GLIBC_2_0
    sub     esp, 4
    push    eax
    push    20h ; ' '
    lea     eax, [ebp+s2]
    push    eax
    call    readline
    add     esp, 10h
    sub     esp, 8
    lea     eax, [ebp+s2]
    push    eax; s2
    push    offset adminpassword; s1
    call    _strcmp
    add     esp, 10h
    test    eax, eax
    jnz     short loc_804882E
    sub     esp, 0Ch
    push    offset aAuthenticated; "Authenticated!"
    call    _puts
    add     esp, 10h
    mov     ds:isadmin, 1
    jmp     short loc_804883E
loc_804882E:
    sub     esp, 0Ch
    push    offset aWrongPassword; "Wrong password!"
    call    _puts
    add     esp, 10h
loc_804883E:
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_804884F
    call    ___stack_chk_fail
locret_804884F:
    leave
    retn
auth endp

