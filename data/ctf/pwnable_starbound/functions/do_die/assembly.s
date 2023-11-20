do_die proc
    push    ebx
    sub     esp, 428h
    mov     eax, [esp+42Ch+arg_0]
    mov     [esp+42Ch+buf], eax
    mov     [esp+42Ch+s], 1
    call    ___printf_chk
    mov     [esp+42Ch+s], (offset aPlayerSFromS+19h); s
    call    _puts
    mov     [esp+42Ch+buf], offset aSaveYourRecord; "Save your record? (y/n)"
    mov     [esp+42Ch+s], 1
    call    ___printf_chk
    mov     [esp+42Ch+nbytes], 400h; nbytes
    lea     eax, [esp+42Ch+var_40C]
    mov     [esp+42Ch+buf], eax; buf
    mov     [esp+42Ch+s], 0; fd
    call    _read
    cmp     [esp+42Ch+var_40C], 79h ; 'y'
    jnz     short loc_8049D87
    mov     eax, ds:dword_8057F94
    mov     [esp+42Ch+var_418], eax
    mov     eax, ds:me
    mov     [esp+42Ch+var_41C], eax
    mov     [esp+42Ch+var_420], offset aMapSeed08xScor; "Map seed: %08X\nScore: %d\n"
    mov     [esp+42Ch+nbytes], 400h
    mov     [esp+42Ch+buf], 1
    lea     ebx, [esp+42Ch+var_40C]
    mov     [esp+42Ch+s], ebx
    call    ___sprintf_chk
    mov     edx, ds:dword_8057F84
    sar     edx, 1
    add     eax, ebx
    mov     [esp+42Ch+nbytes], edx; n
    mov     [esp+42Ch+buf], offset byte_8057F98; src
    mov     [esp+42Ch+s], eax; dest
    call    _memcpy
    mov     [esp+42Ch+buf], 400h; n
    mov     [esp+42Ch+s], ebx; buf
    call    do_send_record
loc_8049D87:
    call    do_bye
    mov     [esp+42Ch+s], 0; status
    call    _exit
do_die endp

