sub_8048786 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 2028h
    sub     esp, 4
    push    0; protocol
    push    1; type
    push    2; domain
    call    _socket
    add     esp, 10h
    mov     [ebp+fd], eax
    cmp     [ebp+fd], 0FFFFFFFFh
    jnz     short loc_80487BE
    sub     esp, 0Ch
    push    offset aNoSocket; "No socket :("
    call    _puts
    add     esp, 10h
    jmp     locret_8048865
loc_80487BE:
    sub     esp, 0Ch
    push    [ebp+cp]; cp
    call    _inet_addr
    add     esp, 10h
    mov     dword ptr [ebp+addr.sa_data+2], eax
    mov     [ebp+addr.sa_family], 2
    mov     eax, [ebp+arg_4]
    movzx   eax, ax
    sub     esp, 0Ch
    push    eax; hostshort
    call    _htons
    add     esp, 10h
    mov     word ptr [ebp+addr.sa_data], ax
    sub     esp, 4
    push    10h; len
    lea     eax, [ebp+addr]
    push    eax; addr
    push    [ebp+fd]; fd
    call    _connect
    add     esp, 10h
    test    eax, eax
    jns     short loc_8048815
    sub     esp, 0Ch
    push    offset aNoCommunicatio; "No communication :(\n"
    call    _perror
    add     esp, 10h
    jmp     short locret_8048865
loc_8048815:
    push    0; flags
    push    2000h; n
    lea     eax, [ebp+buf]
    push    eax; buf
    push    [ebp+fd]; fd
    call    _recv
    add     esp, 10h
    test    eax, eax
    jns     short loc_8048844
    sub     esp, 0Ch
    push    offset aNoData; "No data :("
    call    _puts
    add     esp, 10h
    jmp     short locret_8048865
loc_8048844:
    sub     esp, 0Ch
    lea     eax, [ebp+buf]
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    push    [ebp+fd]; fd
    call    _close
    add     esp, 10h
    nop
locret_8048865:
    leave
    retn
sub_8048786 endp

