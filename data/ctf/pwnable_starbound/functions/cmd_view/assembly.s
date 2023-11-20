cmd_view proc
    push    ebp
    push    edi
    push    esi
    push    ebx
    sub     esp, 0DCh
    mov     eax, ds:dword_8057F88
    mov     [esp+0ECh+var_D0], eax
    mov     esi, ds:dword_8057F84
    mov     ebx, 0
    mov     edi, 0Ch
    mov     ebp, eax
    jmp     short loc_8048F8C
loc_8048F4E:
    lea     eax, [ebx+ebp-19h]
    add     eax, esi
    cdq
    idiv    esi
    mov     eax, edx
    sar     eax, 1
    mov     ecx, edx
    and     ecx, 1
    shl     ecx, 2
    movsx   eax, ds:byte_8057F98[eax]
    sar     eax, cl
    and     eax, 0Fh
    mov     [esp+ebx+0ECh+var_4F], al
    sub     edx, ds:dword_8058150
    lea     edx, [edx+2]
    cmp     edx, 4
    cmovbe  eax, edi
    mov     [esp+ebx+0ECh+var_82], al
    add     ebx, 1
loc_8048F8C:
    cmp     ebx, 32h ; '2'
    jle     short loc_8048F4E
    mov     [esp+0ECh+s], offset asc_8051E14; "  _____________________________________"...
    call    _puts
    mov     eax, ds:dword_8057F90
    mov     [esp+0ECh+var_D8], eax
    mov     eax, ds:dword_8057F88
    mov     [esp+0ECh+var_DC], eax
    mov     [esp+0ECh+var_E0], offset aPos3dHp3d; " / Pos: %3d HP: %3d                    "...
    mov     [esp+0ECh+var_E4], 40h ; '@'
    mov     [esp+0ECh+var_E8], 1
    lea     eax, [esp+0ECh+var_C2]
    mov     [esp+0ECh+s], eax
    call    ___sprintf_chk
    mov     edi, 11h
    jmp     loc_80491A3
loc_8048FDD:
    movzx   edi, [esp+ebx+0ECh+var_82]
    mov     eax, edi
    movsx   eax, al
    cmp     esi, eax
    jnz     short loc_8048FFA
    cmp     ebx, 19h
    jnz     short loc_8048FFA
    mov     [esp+ebx+0ECh+var_C2], 6Fh ; 'o'
    jmp     loc_804915F
loc_8048FFA:
    cmp     eax, [esp+0ECh+var_D4]
    jnz     short loc_804900F
    cmp     ebx, 19h
    jnz     short loc_804900F
    mov     [esp+ebx+0ECh+var_C2], 54h ; 'T'
    jmp     loc_804915F
loc_804900F:
    movzx   ebp, [esp+ebx+0ECh+var_4F]
    mov     edx, ebp
    movsx   edx, dl
    cmp     edx, ecx
    jnz     loc_80490CE
    mov     eax, edi
    mov     edx, ebp
    cmp     al, dl
    jnz     loc_80490C4
    movsx   eax, [esp+ebx+0ECh+var_50]
    cmp     eax, ecx
    jge     short loc_8049064
    movsx   eax, [esp+ebx+0ECh+var_4E]
    cmp     eax, ecx
    jge     short loc_8049052
    mov     [esp+ebx+0ECh+var_C2], 5Eh ; '^'
    jmp     loc_804915F
loc_8049052:
    cmp     ecx, eax
    setl    al
    lea     eax, [eax+eax*2+2Ch]
    mov     [esp+ebx+0ECh+var_C2], al
    jmp     loc_804915F
loc_8049064:
    cmp     ecx, eax
    jge     short loc_8049096
    movsx   eax, [esp+ebx+0ECh+var_4E]
    cmp     eax, ecx
    jge     short loc_804907E
    mov     [esp+ebx+0ECh+var_C2], 5Ch ; '\'
    jmp     loc_804915F
loc_804907E:
    cmp     ecx, eax
    mov     eax, 76h ; 'v'
    mov     edx, 60h ; '`'
    cmovge  eax, edx
    mov     [esp+ebx+0ECh+var_C2], al
    jmp     loc_804915F
loc_8049096:
    movsx   eax, [esp+ebx+0ECh+var_4E]
    cmp     eax, ecx
    jge     short loc_80490AC
    mov     [esp+ebx+0ECh+var_C2], 7Eh ; '~'
    jmp     loc_804915F
loc_80490AC:
    cmp     ecx, eax
    mov     eax, 2Dh ; '-'
    mov     edx, 5Fh ; '_'
    cmovge  eax, edx
    mov     [esp+ebx+0ECh+var_C2], al
    jmp     loc_804915F
loc_80490C4:
    mov     [esp+ebx+0ECh+var_C2], 77h ; 'w'
    jmp     loc_804915F
loc_80490CE:
    cmp     ecx, edx
    jle     short loc_8049102
    cmp     ecx, 11h
    jz      loc_804915F
    cmp     ecx, eax
    lea     esi, [esi+0]
    jle     short loc_80490E9
    mov     [esp+ebx+0ECh+var_C2], 20h ; ' '
    jmp     short loc_804915F
loc_80490E9:
    mov     eax, edi
    mov     edx, ebp
    cmp     al, dl
    mov     eax, 20h ; ' '
    mov     edx, 4Dh ; 'M'
    cmovnz  eax, edx
    mov     [esp+ebx+0ECh+var_C2], al
    jmp     short loc_804915F
loc_8049102:
    mov     edi, ds:me
    sar     edi, cl
    mov     eax, [esp+0ECh+var_D0]
    add     eax, ebx
    xor     edi, eax
    mov     eax, 66666667h
    imul    edi
    sar     edx, 3
    mov     eax, edi
    sar     eax, 1Fh
    sub     edx, eax
    lea     eax, [edx+edx*4]
    shl     eax, 2
    cmp     edi, eax
    jz      short loc_8049134
    mov     [esp+ebx+0ECh+var_C2], 2Eh ; '.'
    jmp     short loc_804915F
loc_8049134:
    lea     edi, [ecx+ebx]
    add     edi, [esp+0ECh+var_D0]
    mov     eax, 66666667h
    imul    edi
    sar     edx, 1
    mov     eax, edi
    sar     eax, 1Fh
    sub     edx, eax
    lea     eax, [edx+edx*4]
    sub     edi, eax
    cmp     edi, 1
    sbb     eax, eax
    and     eax, 1Dh
    add     eax, 23h ; '#'
    mov     [esp+ebx+0ECh+var_C2], al
loc_804915F:
    add     ebx, 1
    jmp     short loc_8049175
loc_8049164:
    mov     ebx, 1
    lea     esi, [edi-2]
    lea     eax, [edi-1]
    mov     [esp+0ECh+var_D4], eax
    mov     ecx, edi
loc_8049175:
    cmp     ebx, 31h ; '1'
    jle     loc_8048FDD
    mov     edi, ecx
    cmp     ecx, 11h
    jz      short loc_804918F
    mov     [esp+0ECh+var_C2], 7Ch ; '|'
    mov     [esp+0ECh+var_90], 7Ch ; '|'
loc_804918F:
    mov     [esp+0ECh+var_8F], 0
    lea     eax, [esp+0ECh+var_C2]
    mov     [esp+0ECh+s], eax; s
    call    _puts
    sub     edi, 1
loc_80491A3:
    test    edi, edi
    jns     short loc_8049164
    mov     [esp+0ECh+s], offset asc_8051E80; " \\____________________________________"...
    call    _puts
    add     esp, 0DCh
    pop     ebx
    pop     esi
    pop     edi
    pop     ebp
    retn
cmd_view endp

