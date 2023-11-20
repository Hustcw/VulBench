is_printable proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     [ebp+var_C], 0
    jmp     short loc_8048731
loc_8048708:
    mov     edx, [ebp+var_C]
    mov     eax, [ebp+s]
    add     eax, edx
    movzx   eax, byte ptr [eax]
    cmp     al, 1Fh
    jle     short loc_8048726
    mov     edx, [ebp+var_C]
    mov     eax, [ebp+s]
    add     eax, edx
    movzx   eax, byte ptr [eax]
    cmp     al, 7Fh
    jnz     short loc_804872D
loc_8048726:
    mov     eax, 0
    jmp     short locret_804874D
loc_804872D:
    add     [ebp+var_C], 1
loc_8048731:
    sub     esp, 0Ch
    push    [ebp+s]; s
    call    _strlen
    add     esp, 10h
    mov     edx, eax
    mov     eax, [ebp+var_C]
    cmp     edx, eax
    ja      short loc_8048708
    mov     eax, 1
locret_804874D:
    leave
    retn
is_printable endp

