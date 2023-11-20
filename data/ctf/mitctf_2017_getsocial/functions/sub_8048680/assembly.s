sub_8048680 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, ds:dword_8049FB8
    mov     [ebp+dest], eax
    mov     [ebp+var_10], 0
    jmp     short loc_80486D4
loc_8048697:
    mov     eax, [ebp+var_10]
    cmp     eax, [ebp+arg_0]
    jnz     short loc_80486C4
    sub     esp, 0Ch
    push    [ebp+s]; s
    call    _strlen
    add     esp, 10h
    mov     edx, eax
    mov     eax, [ebp+dest]
    sub     esp, 4
    push    edx; n
    push    [ebp+s]; src
    push    eax; dest
    call    _memcpy
    add     esp, 10h
    jmp     short locret_80486DA
loc_80486C4:
    mov     eax, [ebp+dest]
    mov     eax, [eax+8Ch]
    mov     [ebp+dest], eax
    add     [ebp+var_10], 1
loc_80486D4:
    cmp     [ebp+dest], 0
    jnz     short loc_8048697
locret_80486DA:
    leave
    retn
sub_8048680 endp

