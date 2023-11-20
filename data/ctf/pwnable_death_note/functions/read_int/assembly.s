read_int proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 4
    push    0Fh; nbytes
    lea     eax, [ebp+buf]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    mov     [ebp+var_24], eax
    cmp     [ebp+var_24], 0
    jg      short loc_80486D1
    sub     esp, 0Ch
    push    offset s; "read error"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_80486D1:
    sub     esp, 0Ch
    lea     eax, [ebp+buf]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     [ebp+var_20], eax
    mov     eax, [ebp+var_20]
    mov     edx, [ebp+var_C]
    xor     edx, large gs:14h
    jz      short locret_80486F7
    call    ___stack_chk_fail
locret_80486F7:
    leave
    retn
read_int endp

