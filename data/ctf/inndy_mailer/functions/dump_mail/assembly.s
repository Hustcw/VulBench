dump_mail proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, ds:root
    mov     [ebp+var_10], eax
    mov     [ebp+var_C], 1
    jmp     short loc_80487EE
loc_8048776:
    sub     esp, 8
    push    [ebp+var_C]
    push    offset aMailD; "-- Mail %d:\n"
    call    _printf
    add     esp, 10h
    mov     eax, [ebp+var_10]
    add     eax, 4
    sub     esp, 8
    push    eax
    push    offset aTitleS; "Title: %s\n"
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aContent; "Content: "
    call    _printf
    add     esp, 10h
    mov     edx, ds:stdout@@GLIBC_2_0
    mov     eax, [ebp+var_10]
    mov     eax, [eax+44h]
    mov     ecx, [ebp+var_10]
    add     ecx, 48h ; 'H'
    push    edx; s
    push    eax; n
    push    1; size
    push    ecx; ptr
    call    _fwrite
    add     esp, 10h
    sub     esp, 8
    push    [ebp+var_C]
    push    offset aEndMailD; "\n-- End mail %d\n"
    call    _printf
    add     esp, 10h
    add     [ebp+var_C], 1
    mov     eax, [ebp+var_10]
    mov     eax, [eax]
    mov     [ebp+var_10], eax
loc_80487EE:
    cmp     [ebp+var_10], 0
    jnz     short loc_8048776
    sub     esp, 0Ch
    push    offset s; "-- No more mail!"
    call    _puts
    add     esp, 10h
    nop
    leave
    retn
dump_mail endp

