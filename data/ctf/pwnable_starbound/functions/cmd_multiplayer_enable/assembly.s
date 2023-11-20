cmd_multiplayer_enable proc
    push    edi
    push    esi
    push    ebx
    sub     esp, 0A0h
    mov     eax, ds:fd
    cmp     eax, 0FFFFFFFFh
    jz      short loc_80493DC
    mov     [esp+0ACh+fd], eax; fd
    call    _close
loc_80493DC:
    mov     [esp+0ACh+addr.sa_family], 1
    mov     [esp+0ACh+protocol], 0; protocol
    mov     [esp+0ACh+type], 2; type
    mov     [esp+0ACh+fd], 1; domain
    call    _socket
    mov     ds:fd, eax
    test    eax, eax
    js      loc_80494BB
    mov     [esp+0ACh+type], 1C0h; mode
    mov     [esp+0ACh+fd], offset path; "/home/starbound/.multiplayer"
    call    _mkdir
    call    _getpid
    mov     esi, eax
    mov     [esp+0ACh+var_9C], eax
    mov     [esp+0ACh+var_A0], offset aHomeStarboundM_0; "/home/starbound/.multiplayer/%d"
    mov     [esp+0ACh+protocol], 6Ch ; 'l'
    mov     [esp+0ACh+type], 1
    lea     edi, [esp+0ACh+addr]
    lea     ebx, [esp+0ACh+addr.sa_data]
    mov     [esp+0ACh+fd], ebx
    call    ___sprintf_chk
    mov     [esp+0ACh+fd], ebx; name
    call    _unlink
    mov     [esp+0ACh+protocol], 6Eh ; 'n'; len
    mov     [esp+0ACh+type], edi; addr
    mov     eax, ds:fd
    mov     [esp+0ACh+fd], eax; fd
    call    _bind
    test    eax, eax
    js      short loc_80494BB
    mov     [esp+0ACh+len], 6Eh ; 'n'
    lea     eax, [esp+0ACh+len]
    mov     [esp+0ACh+protocol], eax; len
    lea     eax, [esp+0ACh+addr]
    mov     [esp+0ACh+type], eax; addr
    mov     eax, ds:fd
    mov     [esp+0ACh+fd], eax; fd
    call    _getsockname
    test    eax, eax
    js      short loc_80494BB
    mov     [esp+0ACh+protocol], esi
    mov     [esp+0ACh+type], offset aInfoPortalDEna; "[Info] Portal %d enabled\n"
    mov     [esp+0ACh+fd], 1
    call    ___printf_chk
    jmp     short loc_80494D4
loc_80494BB:
    mov     [esp+0ACh+fd], offset aErrorFailToEna; "[Error] Fail to enable"
    call    _puts
    mov     eax, ds:fd
    mov     [esp+0ACh+fd], eax; fd
    call    _close
loc_80494D4:
    add     esp, 0A0h
    pop     ebx
    pop     esi
    pop     edi
    retn
cmd_multiplayer_enable endp

