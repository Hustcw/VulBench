get_server_key proc
    push    edi
    push    esi
    push    ebx
    sub     esp, 270h
    lea     edx, [esp+27Ch+var_20C]
    mov     ecx, 80h
    mov     eax, 0
    mov     edi, edx
    rep stosd
    mov     [esp+27Ch+oflag], 0; oflag
    mov     [esp+27Ch+file], offset aHomeStarboundH; "/home/starbound/hint"
    call    _open
    mov     esi, eax
    mov     ebx, 0
    jmp     short loc_8049A5E
loc_8049A29:
    lea     eax, [esp+27Ch+var_20C]
    add     eax, ebx
    mov     [esp+27Ch+nbytes], 20h ; ' '; nbytes
    mov     [esp+27Ch+oflag], eax; buf
    mov     [esp+27Ch+file], esi; fd
    call    _read
    mov     [esp+27Ch+nbytes], 0; whence
    mov     [esp+27Ch+oflag], 0; offset
    mov     [esp+27Ch+file], esi; fd
    call    _lseek
    add     ebx, 20h ; ' '
loc_8049A5E:
    cmp     ebx, 1FFh
    jle     short loc_8049A29
    mov     [esp+27Ch+oflag], 200h
    lea     esi, [esp+27Ch+var_20C]
    mov     [esp+27Ch+file], esi
    call    _memfrob
    lea     ebx, [esp+27Ch+var_268]
    mov     [esp+27Ch+file], ebx
    call    _MD5_Init
    mov     [esp+27Ch+nbytes], 200h
    mov     [esp+27Ch+oflag], esi
    mov     [esp+27Ch+file], ebx
    call    _MD5_Update
    mov     [esp+27Ch+oflag], ebx
    mov     eax, [esp+27Ch+arg_0]
    mov     [esp+27Ch+file], eax
    call    _MD5_Final
    add     esp, 270h
    pop     ebx
    pop     esi
    pop     edi
    retn
get_server_key endp

