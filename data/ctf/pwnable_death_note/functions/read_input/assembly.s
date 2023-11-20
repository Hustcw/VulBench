read_input proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    sub     esp, 4
    push    [ebp+nbytes]; nbytes
    push    [ebp+buf]; buf
    push    0; fd
    call    _read
    add     esp, 10h
    mov     [ebp+var_C], eax
    cmp     [ebp+var_C], 0
    jg      short loc_8048667
    sub     esp, 0Ch
    push    offset s; "read error"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_8048667:
    mov     eax, [ebp+var_C]
    lea     edx, [eax-1]
    mov     eax, [ebp+buf]
    add     eax, edx
    movzx   eax, byte ptr [eax]
    cmp     al, 0Ah
    jnz     short loc_8048687
    mov     eax, [ebp+var_C]
    lea     edx, [eax-1]
    mov     eax, [ebp+buf]
    add     eax, edx
    mov     byte ptr [eax], 0
loc_8048687:
    nop
    leave
    retn
read_input endp

