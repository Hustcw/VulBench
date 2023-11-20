cmd_build_dig proc
    push    esi
    push    ebx
    sub     esp, 14h
    mov     edx, ds:dword_8057F88
    mov     eax, edx
    sub     eax, ds:dword_8058150
    mov     ecx, eax
    sar     ecx, 1Fh
    xor     eax, ecx
    sub     eax, ecx
    cmp     eax, 9
    jg      short loc_804A056
    call    check_pos
    jmp     short loc_804A0B8
loc_804A056:
    mov     eax, edx
    sar     eax, 1
    movzx   ebx, ds:byte_8057F98[eax]
    and     edx, 1
    lea     ecx, ds:0[edx*4]
    movsx   esi, bl
    sar     esi, cl
    test    esi, 0Fh
    jz      short loc_804A0AC
    test    edx, edx
    jz      short loc_804A087
    sub     ebx, 10h
    mov     ds:byte_8057F98[eax], bl
    jmp     short loc_804A090
loc_804A087:
    sub     ebx, 1
    mov     ds:byte_8057F98[eax], bl
loc_804A090:
    add     ds:dword_8057F8C, 1
    add     ds:dword_8057F94, 1
    mov     [esp+1Ch+s], offset aInfoDigDigDig; "[Info] Dig..dig..dig.."
    call    _puts
    jmp     short loc_804A0B8
loc_804A0AC:
    mov     [esp+1Ch+s], offset aCrashSoHard; ">Crash< ... so hard!"
    call    _puts
loc_804A0B8:
    add     esp, 14h
    pop     ebx
    pop     esi
    retn
cmd_build_dig endp

