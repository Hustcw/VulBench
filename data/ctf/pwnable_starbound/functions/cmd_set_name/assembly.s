cmd_set_name proc
    sub     esp, 1Ch
    mov     [esp+1Ch+var_18], offset aEnterYourName; "Enter your name: "
    mov     [esp+1Ch+var_1C], 1
    call    ___printf_chk
    mov     [esp+1Ch+var_18], 64h ; 'd'; size_t
    mov     [esp+1Ch+var_1C], offset byte_80580D0; void *
    call    readn
    mov     byte ptr [eax+80580CFh], 0
    add     esp, 1Ch
    retn
cmd_set_name endp

