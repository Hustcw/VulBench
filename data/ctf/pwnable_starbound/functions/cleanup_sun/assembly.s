cleanup_sun proc
    push    ebx
    sub     esp, 98h
    call    _getpid
    mov     [esp+9Ch+var_8C], eax
    mov     [esp+9Ch+var_90], offset aHomeStarboundM_0; "/home/starbound/.multiplayer/%d"
    mov     [esp+9Ch+var_94], 68h ; 'h'
    mov     [esp+9Ch+var_98], 1
    lea     ebx, [esp+9Ch+var_74]
    mov     [esp+9Ch+name], ebx
    call    ___sprintf_chk
    mov     [esp+9Ch+name], ebx; name
    call    _unlink
    add     esp, 98h
    pop     ebx
    retn
cleanup_sun endp

