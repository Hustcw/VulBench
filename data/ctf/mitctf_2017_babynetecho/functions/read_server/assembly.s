read_server proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    sub     esp, 4
    push    40h ; '@'; n
    push    0; c
    push    offset buff; s
    call    _memset
    add     esp, 10h
    sub     esp, 4
    push    0; protocol
    push    1; type
    push    2; domain
    call    _socket
    add     esp, 10h
    mov     [ebp+fd], eax
    sub     esp, 4
    push    10h; n
    push    0; c
    lea     eax, [ebp+s]
    push    eax; s
    call    _memset
    add     esp, 10h
    mov     [ebp+s], 2
    mov     eax, [ebp+arg_0]
    movzx   eax, ax
    sub     esp, 0Ch
    push    eax; hostshort
    call    _htons
    add     esp, 10h
    mov     [ebp+var_1E], ax
    sub     esp, 4
    lea     eax, [ebp+s]
    add     eax, 4
    push    eax; buf
    push    offset s; cp
    push    2; af
    call    _inet_pton
    add     esp, 10h
    jmp     short loc_8048779
loc_804876C:
    sub     esp, 0Ch
    push    1; seconds
    call    _sleep
    add     esp, 10h
loc_8048779:
    sub     esp, 4
    push    10h; len
    lea     eax, [ebp+s]
    push    eax; addr
    push    [ebp+fd]; fd
    call    _connect
    add     esp, 10h
    test    eax, eax
    js      short loc_804876C
    sub     esp, 4
    push    40h ; '@'; nbytes
    push    offset buff; buf
    push    [ebp+fd]; fd
    call    _read
    add     esp, 10h
    mov     [ebp+var_10], eax
    sub     esp, 8
    push    0; how
    push    [ebp+fd]; fd
    call    _shutdown
    add     esp, 10h
    mov     eax, [ebp+var_10]
    leave
    retn
read_server endp

