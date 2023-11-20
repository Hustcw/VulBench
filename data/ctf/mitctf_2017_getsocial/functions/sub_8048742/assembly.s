sub_8048742 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, ds:dword_8049FB8
    mov     [ebp+var_C], eax
    mov     [ebp+var_10], 0
    jmp     short loc_804878C
loc_8048759:
    add     [ebp+var_10], 1
    cmp     [ebp+var_10], 0F4240h
    jnz     short loc_8048780
    sub     esp, 0Ch
    push    offset command; "cat flag"
    call    _system
    add     esp, 10h
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_8048780:
    mov     eax, [ebp+var_C]
    mov     eax, [eax+8Ch]
    mov     [ebp+var_C], eax
loc_804878C:
    cmp     [ebp+var_C], 0
    jnz     short loc_8048759
    sub     esp, 8
    push    [ebp+var_10]
    push    offset aThereAreZuTwee; "There are %zu tweets\n"
    call    _printf
    add     esp, 10h
    leave
    retn
sub_8048742 endp

