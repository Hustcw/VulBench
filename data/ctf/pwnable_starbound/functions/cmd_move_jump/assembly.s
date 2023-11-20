cmd_move_jump proc
    push    edi
    push    esi
    sub     esp, 24h
    mov     [esp+2Ch+n], offset aLeftOrRight; "left or right? "
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     eax, ds:stdin@@GLIBC_2_0
    mov     [esp+2Ch+stream], eax; stream
    mov     [esp+2Ch+n], 0Ah; n
    lea     esi, [esp+2Ch+var_16]
    mov     [esp+2Ch+s], esi; s
    call    _fgets
    mov     edi, offset aLeft; "left"
    mov     ecx, 4
    repe cmpsb
    setnbe  dl
    setb    al
    cmp     dl, al
    jnz     short loc_8049F2B
    mov     esi, ds:dword_8057F88
    call    _rand
    mov     ecx, eax
    mov     edx, 51EB851Fh
    imul    edx
    sar     edx, 5
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    imul    edx, 64h ; 'd'
    sub     ecx, edx
    lea     eax, [esi+ecx+64h]
    mov     ds:dword_8057F88, eax
    jmp     short loc_8049F57
loc_8049F2B:
    mov     esi, ds:dword_8057F88
    call    _rand
    mov     ecx, eax
    mov     edx, 51EB851Fh
    imul    edx
    sar     edx, 5
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    imul    edx, 64h ; 'd'
    sub     edx, ecx
    lea     eax, [esi+edx-64h]
    mov     ds:dword_8057F88, eax
loc_8049F57:
    mov     eax, ds:dword_8057F88
    mov     ecx, ds:dword_8057F84
    cdq
    idiv    ecx
    mov     ds:dword_8057F88, edx
    test    edx, edx
    jns     short loc_8049F77
    add     ecx, edx
    mov     ds:dword_8057F88, ecx
loc_8049F77:
    mov     [esp+2Ch+n], offset aIku; "Iku~~ "
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     [esp+2Ch+s], 1; seconds
    call    _sleep
    mov     [esp+2Ch+s], 2Eh ; '.'; c
    call    _putchar
    mov     [esp+2Ch+s], 1; seconds
    call    _sleep
    mov     [esp+2Ch+s], 2Eh ; '.'; c
    call    _putchar
    mov     [esp+2Ch+s], 1; seconds
    call    _sleep
    mov     [esp+2Ch+s], (offset aLanding+8); s
    call    _puts
    mov     [esp+2Ch+n], offset aLanding; "Landing ."
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     [esp+2Ch+s], 1; seconds
    call    _sleep
    mov     [esp+2Ch+s], 2Eh ; '.'; c
    call    _putchar
    mov     [esp+2Ch+s], 1; seconds
    call    _sleep
    mov     [esp+2Ch+s], 2Eh ; '.'; c
    call    _putchar
    mov     [esp+2Ch+s], offset aOuch; " Ouch!"
    call    _puts
    call    check_pos
    add     esp, 24h
    pop     esi
    pop     edi
    retn
cmd_move_jump endp

