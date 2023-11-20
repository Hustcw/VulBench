cmd_multiplayer_disable proc
    sub     esp, 1Ch
    mov     eax, ds:fd
    test    eax, eax
    js      short loc_8049909
    mov     [esp+1Ch+fd], eax; fd
    call    _close
    call    cleanup_sun
loc_8049909:
    mov     [esp+1Ch+fd], offset aInfoPortalDisa; "[Info] Portal disabled"
    call    _puts
    add     esp, 1Ch
    retn
cmd_multiplayer_disable endp

