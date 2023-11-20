cmd_nop proc
    sub     esp, 1Ch
    mov     [esp+1Ch+s], offset aTrollollNothin; "\n\n[TROLLOLL] NOTHING TO DO HERE\n"
    call    _puts
    mov     eax, jetpack
    mov     [esp+1Ch+s], eax; s
    call    _puts
    add     esp, 1Ch
    retn
cmd_nop endp

