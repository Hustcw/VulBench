cmd_build_place proc
    push    edi
    push    esi
    push    ebx
    sub     esp, 10h
    mov     eax, ds:dword_8057F88
    mov     esi, eax
    sar     esi, 1
    movzx   edi, ds:byte_8057F98[esi]
    mov     ebx, eax
    and     ebx, 1
    lea     ecx, ds:0[ebx*4]
    mov     edx, edi
    movsx   edx, dl
    sar     edx, cl
    mov     ecx, edx
    and     ecx, 0Fh
    sub     eax, ds:dword_8058150
    cdq
    xor     eax, edx
    sub     eax, edx
    cmp     eax, 9
    jg      short loc_804A103
    call    check_pos
    jmp     short loc_804A171
loc_804A103:
    cmp     ecx, 0Eh
    jg      short loc_804A148
    mov     eax, ds:dword_8057F8C
    test    eax, eax
    jle     short loc_804A13A
    test    ebx, ebx
    jz      short loc_804A120
    lea     edx, [edi+10h]
    mov     ds:byte_8057F98[esi], dl
    jmp     short loc_804A129
loc_804A120:
    lea     edx, [edi+1]
    mov     ds:byte_8057F98[esi], dl
loc_804A129:
    sub     eax, 1
    mov     ds:dword_8057F8C, eax
    add     ds:dword_8057F94, 1
    jmp     short loc_804A171
loc_804A13A:
    mov     [esp+1Ch+s], offset aNoMoreCobblest; "No more cobblestone :("
    call    _puts
    jmp     short loc_804A171
loc_804A148:
    mov     [esp+1Ch+s], offset aICanTBreatheAn; "I can't breathe anymore!!"
    call    _puts
    mov     eax, ds:dword_8057F90
    sub     eax, 0Ah
    mov     ds:dword_8057F90, eax
    test    eax, eax
    jg      short loc_804A171
    mov     [esp+1Ch+s], offset aSuffocated; "*Suffocated*"
    call    do_die
loc_804A171:
    add     esp, 10h
    pop     ebx
    pop     esi
    pop     edi
    retn
cmd_build_place endp

