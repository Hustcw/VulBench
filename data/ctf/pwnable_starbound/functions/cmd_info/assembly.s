cmd_info proc
    push    ebx
    sub     esp, 28h
    lea     eax, [esp+2Ch+var_1C]
    mov     [esp+2Ch+s], eax
    call    get_server_key
    mov     [esp+2Ch+s], offset aStarboundV10In; "\n-+STARBOUND v1.0: INFORMATION+-"
    call    _puts
    mov     [esp+2Ch+var_28], offset aServerId; " |  Server ID: "
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     ebx, 0
    jmp     short loc_8049B0E
loc_8049AEE:
    movzx   eax, [esp+ebx+2Ch+var_1C]
    mov     [esp+2Ch+var_24], eax
    mov     [esp+2Ch+var_28], offset a02x; "%02X"
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    add     ebx, 1
loc_8049B0E:
    cmp     ebx, 0Fh
    jle     short loc_8049AEE
    mov     [esp+2Ch+s], (offset aPlayerSFromS+19h); s
    call    _puts
    mov     eax, ds:me
    mov     [esp+2Ch+var_24], eax
    mov     [esp+2Ch+var_28], offset aSeed08x; " |  Seed: %08X\n"
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     eax, ds:dword_8057F84
    mov     [esp+2Ch+var_24], eax
    mov     [esp+2Ch+var_28], offset aSizeD; " |  Size: %d\n"
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     eax, ds:cp
    mov     [esp+2Ch+var_20], eax
    mov     [esp+2Ch+var_24], offset byte_80580D0
    mov     [esp+2Ch+var_28], offset aPlayerSFromS; " +  Player: %s (from %s)\n"
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     eax, ds:dword_8057F88
    mov     [esp+2Ch+var_24], eax
    mov     [esp+2Ch+var_28], offset aPositionD; " |  Position: %d\n"
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     eax, ds:dword_8057F90
    mov     [esp+2Ch+var_24], eax
    mov     [esp+2Ch+var_28], offset aHpD; " |  HP: %d\n"
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     eax, ds:dword_8057F8C
    mov     [esp+2Ch+var_24], eax
    mov     [esp+2Ch+var_28], offset aCobblestoneD; " |  Cobblestone: %d\n"
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     eax, ds:dword_8057F94
    mov     [esp+2Ch+var_24], eax
    mov     [esp+2Ch+var_28], offset aScoreD; " |  Score: %d\n"
    mov     [esp+2Ch+s], 1
    call    ___printf_chk
    mov     [esp+2Ch+s], (offset aPlayerSFromS+19h); s
    call    _puts
    add     esp, 28h
    pop     ebx
    retn
cmd_info endp

