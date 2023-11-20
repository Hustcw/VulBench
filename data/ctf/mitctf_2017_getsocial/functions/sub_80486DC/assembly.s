sub_80486DC proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, ds:dword_8049FB8
    mov     [ebp+var_C], eax
    mov     [ebp+var_10], 0
    sub     esp, 0Ch
    push    offset s; "######"
    call    _puts
    add     esp, 10h
    jmp     short loc_804872A
loc_8048703:
    mov     eax, [ebp+var_C]
    sub     esp, 4
    push    eax
    push    [ebp+var_10]
    push    offset format; "Tweet %d: %s\n"
    call    _printf
    add     esp, 10h
    mov     eax, [ebp+var_C]
    mov     eax, [eax+8Ch]
    mov     [ebp+var_C], eax
    add     [ebp+var_10], 1
loc_804872A:
    cmp     [ebp+var_C], 0
    jnz     short loc_8048703
    sub     esp, 0Ch
    push    offset s; "######"
    call    _puts
    add     esp, 10h
    leave
    retn
sub_80486DC endp

