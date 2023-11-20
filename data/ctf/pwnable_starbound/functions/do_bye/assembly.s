do_bye proc
    sub     esp, 1Ch
    mov     [esp+1Ch+var_14], offset byte_80580D0
    mov     [esp+1Ch+var_18], offset aGoodbyeS; "Goodbye, %s\n"
    mov     [esp+1Ch+var_1C], 1
    call    ___printf_chk
    add     esp, 1Ch
    retn
do_bye endp

