readn proc
    sub     esp, 1Ch
    mov     eax, [esp+1Ch+arg_4]
    mov     [esp+1Ch+nbytes], eax; nbytes
    mov     eax, [esp+1Ch+arg_0]
    mov     [esp+1Ch+buf], eax; buf
    mov     [esp+1Ch+fd], 0; fd
    call    _read
    test    eax, eax
    jg      short loc_8049948
    mov     [esp+1Ch+fd], 0; status
    call    _exit
loc_8049948:
    add     esp, 1Ch
    retn
readn endp

