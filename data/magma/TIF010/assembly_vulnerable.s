LZWDecodeCompat proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 28h
    mov     rbx, [tif+3F0h]
    test    sp_0, sp_0
    jz      loc_42EFD6
    mov     r15, occ0
    mov     rbp, tif
    mov     r8, [sp_0+0A8h]
    test    r8, r8
    jz      loc_42E9E6
    mov     rax, [sp_0+0C8h]
    movzx   edx, word ptr [codep+8]
    mov     s, rdx
    sub     rcx, r8
    cmp     residue, occ0
    jle     loc_42E93A
    lea     rdi, [r8+occ0]
    mov     [sp_0+0A8h], rdi
    mov     tif, rdx
    sub     rbp, r8
    mov     edi, ebp
    sub     edi, r15d
    not     r8
    add     r8, rdx
    sub     r8, occ0
    and     rdi, 7
    jz      short loc_42E892
    xor     ecx, ecx
    nop     word ptr [codep+codep+00000000h]
    nop
loc_42E880:
    mov     codep, [codep]
    add     rcx, 1
    cmp     rdi, rcx
    jnz     short loc_42E880
    sub     rbp, rcx
    mov     rcx, rbp
loc_42E892:
    cmp     r8, 7
    jb      short loc_42E8C1
    nop     dword ptr [codep+codep+00000000h]
loc_42E8A0:
    mov     codep, [codep]
    mov     codep, [codep]
    mov     codep, [codep]
    mov     codep, [codep]
    mov     codep, [codep]
    mov     codep, [codep]
    mov     codep, [codep]
    mov     codep, [codep]
    add     rcx, 0FFFFFFFFFFFFFFF8h
    cmp     residue, occ0
    jg      short loc_42E8A0
loc_42E8C1:
    lea     rdi, [occ0-1]
    mov     rdx, occ0
    and     rdx, 3
    jz      short loc_42E8E6
    xchg    ax, ax
loc_42E8D0:
    movzx   ecx, byte ptr [codep+0Ah]
    mov     [op0+occ-1], cl
    mov     codep, [codep]
    add     occ, 0FFFFFFFFFFFFFFFFh
    add     rdx, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_42E8D0
loc_42E8E6:
    add     op0, r15
    mov     ebp, 1
    cmp     rdi, 3
    jb      loc_42EEAF
    neg     r15
    xor     ecx, ecx
    nop     dword ptr [codep]
loc_42E900:
    movzx   edx, byte ptr [codep+0Ah]
    mov     [rsi+rcx-1], dl
    mov     codep, [codep]
    movzx   edx, byte ptr [codep+0Ah]
    mov     [rsi+rcx-2], dl
    mov     codep, [codep]
    movzx   edx, byte ptr [codep+0Ah]
    mov     [rsi+rcx-3], dl
    mov     codep, [codep]
    movzx   edx, byte ptr [codep+0Ah]
    mov     [rsi+rcx-4], dl
    mov     codep, [codep]
    add     rcx, 0FFFFFFFFFFFFFFFCh
    cmp     r15, rcx
    jnz     short loc_42E900
    jmp     loc_42EEAF
loc_42E93A:
    mov     r9, sp_0
    add     op0, residue
    not     r8
    add     r8, rdx
    mov     sp_0, residue
    and     rbx, 3
    jz      short loc_42E988
    mov     r11, tif
    xor     ebp, ebp
    mov     rdi, tp
    nop     word ptr [codep+codep+00000000h]
loc_42E960:
    movzx   edx, byte ptr [codep+0Ah]
    mov     [tp-1], dl
    add     tp, 0FFFFFFFFFFFFFFFFh
    mov     codep, [codep]
    add     rbp, 1
    cmp     rbx, rbp
    jnz     short loc_42E960
    mov     r10, rcx
    sub     r10, rbp
    mov     rbp, r11
    cmp     r8, 3
    jnb     short loc_42E994
    jmp     short loc_42E9D5
loc_42E988:
    mov     rdi, tp
    mov     r10, residue
    cmp     r8, 3
    jb      short loc_42E9D5
loc_42E994:
    neg     r10
    xor     edx, edx
    nop     dword ptr [codep+00000000h]
loc_42E9A0:
    movzx   ebx, byte ptr [codep+0Ah]
    mov     [rdi+rdx-1], bl
    mov     codep, [codep]
    movzx   ebx, byte ptr [codep+0Ah]
    mov     [rdi+rdx-2], bl
    mov     codep, [codep]
    movzx   ebx, byte ptr [codep+0Ah]
    mov     [rdi+rdx-3], bl
    mov     codep, [codep]
    movzx   ebx, byte ptr [codep+0Ah]
    mov     [rdi+rdx-4], bl
    mov     codep, [codep]
    add     rdx, 0FFFFFFFFFFFFFFFCh
    cmp     r10, rdx
    jnz     short loc_42E9A0
loc_42E9D5:
    sub     occ0, rcx
    mov     rbx, r9
    mov     qword ptr [r9+0A8h], 0
loc_42E9E6:
    mov     r10, [rbp+428h]
    mov     rax, [rbp+430h]
    sub     rax, [rbx+0B8h]
    shl     rax, 3
    add     rax, [rbx+0B0h]
    mov     [rbx+0B0h], rax
    movzx   r8d, word ptr [rbx+80h]
    mov     r14, [rbx+88h]
    mov     r12, [rbx+90h]
    mov     r9, [rbx+0A0h]
    mov     rcx, [rbx+0D0h]
    mov     r13, [rbx+0D8h]
    mov     r11, [rbx+0E0h]
    test    occ, occ
    jle     loc_42EE28
    mov     edx, r8d
    cmp     rax, rdx
    mov     [rsp+58h+var_50], rbp
    mov     [rsp+58h+var_40], oldcodep
    jnb     short loc_42EAB0
loc_42EA5A:
    mov     [rsp+58h+var_48], nbitsmask
    mov     [rsp+58h+var_54], r8d
    mov     [rsp+58h+var_38], bp_0
    mov     rdi, [rbp+458h]; fd
    mov     ecx, [rbp+324h]
    mov     esi, offset LZWDecodeCompat_module; "LZWDecodeCompat"
    mov     edx, offset aLzwdecodeStrip; "LZWDecode: Strip %u not terminated with"...
    xor     eax, eax
    mov     rbp, maxcodep
    call    TIFFWarningExt
    mov     r9, [rsp+58h+var_48]
    mov     r8d, [rsp+58h+var_54]
    mov     r11, maxcodep
    mov     rbp, [rsp+58h+var_50]
    mov     r10, [rsp+58h+var_38]
    jmp     loc_42EE23
loc_42EAB0:
    movzx   edi, byte ptr [bp_0]
    mov     ecx, r12d
    shl     rdi, cl
    or      rdi, nextdata
    lea     rcx, [nextbits+8]
    cmp     nextbits, rdx
    jge     short loc_42EAE0
    movzx   ebp, byte ptr [bp_0+1]
    shl     rbp, cl
    add     bp_0, 2
    or      nextdata, rbp
    add     r12, 10h
    jmp     short loc_42EAE7
loc_42EAE0:
    add     bp_0, 1
    mov     r12, nextbits
loc_42EAE7:
    mov     rbp, nextdata
    mov     [rsp+58h+var_48], nbitsmask
    and     rbp, r9
    movzx   r9d, bp
    mov     r14, nextdata
    mov     ecx, r8d
    sar     nextdata, cl
    sub     r12, rdx
    sub     rax, rdx
    mov     [rbx+0B0h], rax
    cmp     r9d, 100h
    jz      loc_42EC70
    movzx   eax, bp
    cmp     eax, 101h
    jz      loc_42EE19
    mov     rdx, [rbx+0E8h]
    cmp     free_entp, rdx
    mov     rcx, [rsp+58h+var_40]
    jb      loc_42EEC0
    lea     rax, [rdx+13FF0h]
    cmp     free_entp, rax
    jnb     loc_42EEC0
    mov     [free_entp+0], rcx
    cmp     rcx, rdx
    jb      loc_42EEC0
    cmp     rcx, rax
    jnb     loc_42EEC0
    mov     [rsp+58h+var_38], bp_0
    mov     [rsp+58h+var_54], r8d
    mov     eax, r9d
    shl     rax, 4
    lea     r10, [rdx+rax]
    mov     r8b, [rcx+0Bh]
    lea     rdi, [free_entp+0Bh]
    mov     [free_entp+0Bh], r8b
    mov     r8, oldcodep
    mov     ecx, [rcx+8]
    add     ecx, 1
    mov     [free_entp+8], cx
    cmp     r10, free_entp
    lea     rcx, [rdx+rax+0Bh]
    cmovnb  rcx, rdi
    mov     cl, [rcx]
    mov     [free_entp+0Ah], cl
    add     free_entp, 10h
    cmp     free_entp, maxcodep
    jbe     short loc_42EBDB
    mov     ecx, [rsp+58h+var_54]
    cmp     ecx, 0Ch
    mov     edi, 0Bh
    cmovge  ecx, edi
    add     ecx, 1
    mov     maxcodep, 0FFFFFFFFFFFFFFFFh
    mov     [rsp+58h+var_54], ecx
    shl     r11, cl
    not     r11
    mov     [rsp+58h+var_48], nbitsmask
    shl     r11, 4
    add     r11, rdx
loc_42EBDB:
    mov     r10, [rsp+58h+var_38]
    cmp     r9d, 100h
    jb      loc_42ED6C
    movzx   edx, word ptr [rdx+rax+8]
    test    rdx, rdx
    mov     code, [rsp+58h+var_48]
    jz      loc_42EEF1
    mov     rax, occ
    sub     rax, rdx
    mov     rbp, [rsp+58h+var_50]
    jl      loc_42EF11
    mov     rdi, rbx
    lea     rcx, [op+rdx]
    add     rdx, rsi
    add     rdx, 0FFFFFFFFFFFFFFFFh
    mov     rsi, oldcodep
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+00h]
loc_42EC30:
    movzx   ebx, byte ptr [codep+0Ah]
    mov     [rdx], bl
    mov     codep, [codep]
    add     rdx, 0FFFFFFFFFFFFFFFFh
    test    codep, codep
    jnz     short loc_42EC30
    mov     codep, op
    mov     r15, occ
    mov     op, oldcodep
    mov     rbx, rdi
    mov     r8d, [rsp+58h+var_54]
    test    occ, occ
    jg      loc_42ED8D
    jmp     loc_42EEE7
loc_42EC70:
    mov     rbp, bp_0
    mov     [rsp+58h+var_48], op
    mov     maxcodep, [rbx+0E8h]
    jmp     short loc_42ECC8
loc_42EC90:
    movzx   esi, byte ptr [bp_0+1]
    shl     rsi, cl
    add     bp_0, 2
    or      nextdata, rsi
    add     r12, 10h
loc_42ECA2:
    mov     ecx, eax
    and     ecx, 1FFh
    mov     r14, nextdata
    sar     r14, 9
    add     r12, 0FFFFFFFFFFFFFFF7h
    add     rdx, 0FFFFFFFFFFFFFFF7h
    mov     [rbx+0B0h], rdx
    cmp     ecx, 100h
    jnz     short loc_42ED1E
loc_42ECC8:
    mov     free_entp, r11
    add     r13, 1020h
    mov     edx, 12FD0h; c
    mov     rdi, free_entp; p
    xor     esi, esi; v
    call    _TIFFmemset
    mov     rdx, [rbx+0B0h]
    mov     r11, [rbx+0E8h]
    cmp     rdx, 8
    jbe     loc_42EDAF
    movzx   eax, byte ptr [bp_0+0]
    mov     ecx, r12d
    shl     rax, cl
    or      rax, nextdata
    lea     rcx, [nextbits+8]
    cmp     nextbits, 8
    jle     loc_42EC90
    add     bp_0, 1
    mov     r12, nextbits
    jmp     short loc_42ECA2
loc_42ED1E:
    cmp     ecx, 101h
    jz      loc_42EDF9
    jnb     loc_42EF62
    mov     r10, bp_0
    add     r11, 1FF0h
    mov     rsi, [rsp+58h+var_48]
    mov     [rsi], al
    add     rsi, 1
    add     occ, 0FFFFFFFFFFFFFFFFh
    mov     ecx, ecx
    shl     rcx, 4
    add     rcx, [rbx+0E8h]
    mov     r9d, 1FFh
    mov     r8d, 9
    test    occ, occ
    jg      short loc_42ED8D
    jmp     loc_42EEE7
loc_42ED6C:
    mov     [op], bpl
    add     op, 1
    add     occ, 0FFFFFFFFFFFFFFFFh
    mov     rcx, oldcodep
    mov     r8d, [rsp+58h+var_54]
    mov     code, [rsp+58h+var_48]
    test    occ, occ
    jle     loc_42EEE7
loc_42ED8D:
    mov     [rsp+58h+var_40], oldcodep
    mov     rax, [rbx+0B0h]
    movsxd  rdx, r8d
    cmp     rax, rdx
    mov     rbp, [rsp+58h+var_50]
    jnb     loc_42EAB0
    jmp     loc_42EA5A
loc_42EDAF:
    add     r11, 1FF0h
    mov     [rsp+58h+var_48], r11
    mov     rax, [rsp+58h+var_50]
    mov     rdi, [rax+458h]; fd
    mov     ecx, [rax+324h]
    mov     esi, offset LZWDecodeCompat_module; "LZWDecodeCompat"
    mov     edx, offset aLzwdecodeStrip; "LZWDecode: Strip %u not terminated with"...
    xor     eax, eax
    call    TIFFWarningExt
    mov     r11, [rsp+58h+var_48]
    mov     r9d, 1FFh
    mov     r8d, 9
    mov     r10, bp_0
    mov     bp_0, [rsp+58h+var_50]
    jmp     short loc_42EE23
loc_42EDF9:
    add     r11, 1FF0h
    mov     r9d, 1FFh
    mov     r8d, 9
    mov     rax, [rsp+58h+var_50]
    mov     r10, bp_0
    mov     bp_0, rax
    jmp     short loc_42EE23
loc_42EE19:
    mov     rbp, [rsp+58h+var_50]
    mov     code, [rsp+58h+var_48]
loc_42EE23:
    mov     rcx, [rsp+58h+var_40]
loc_42EE28:
    mov     rax, [rbp+428h]
    sub     rax, bp_0
    add     rax, [rbp+430h]
    mov     [rbp+430h], rax
    mov     [rbp+428h], bp_0
    mov     [rbx+0B8h], rax
    mov     [rbx+80h], r8w
    mov     [rbx+88h], nextdata
    mov     [rbx+90h], nextbits
    mov     [rbx+0A0h], nbitsmask
    mov     [rbx+0D0h], oldcodep
    mov     [rbx+0D8h], free_entp
    mov     [rbx+0E0h], maxcodep
    test    occ, occ
    jle     short loc_42EEAA
    mov     rdi, [rbp+458h]; fd
    mov     ecx, [rbp+31Ch]
    xor     ebp, ebp
    mov     esi, offset LZWDecodeCompat_module; "LZWDecodeCompat"
    mov     edx, offset aNotEnoughDataA_1; "Not enough data at scanline %u (short %"...
    mov     nbits, occ
    xor     eax, eax
    call    TIFFErrorExt
    jmp     short loc_42EEAF
loc_42EEAA:
    mov     ebp, 1
loc_42EEAF:
    mov     eax, ebp
    add     rsp, 28h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_42EEC0:
    mov     rax, [rsp+58h+var_50]
    mov     rdi, [rax+458h]; fd
    mov     ecx, [rax+31Ch]
    xor     ebp, ebp
    mov     esi, offset LZWDecodeCompat_module; "LZWDecodeCompat"
    mov     edx, offset aCorruptedLzwTa; "Corrupted LZW table at scanline %u"
loc_42EEDE:
    xor     eax, eax
    call    TIFFErrorExt
    jmp     short loc_42EEAF
loc_42EEE7:
    mov     rbp, [rsp+58h+var_50]
    jmp     loc_42EE28
loc_42EEF1:
    mov     rax, [rsp+58h+var_50]
    mov     rdi, [rax+458h]
    mov     ecx, [rax+31Ch]
    xor     ebp, ebp
    mov     esi, offset LZWDecodeCompat_module; "LZWDecodeCompat"
    mov     edx, offset aWrongLengthOfD; "Wrong length of decoded string: data pr"...
    jmp     short loc_42EEDE
loc_42EF11:
    mov     [rbx+0C8h], oldcodep
    mov     rcx, oldcodep
loc_42EF1B:
    mov     codep, [codep]
    movzx   eax, word ptr [codep+8]
    cmp     occ, rax
    jl      short loc_42EF1B
    mov     [rbx+0A8h], occ
    lea     rax, [occ-1]
    mov     rdx, occ
    and     rdx, 3
    jz      short loc_42EF83
    mov     rdi, rbx
loc_42EF3E:
    movzx   ebx, byte ptr [codep+0Ah]
    mov     [op+occ-1], bl
    mov     codep, [codep]
    add     occ, 0FFFFFFFFFFFFFFFFh
    add     rdx, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_42EF3E
    add     op, occ
    mov     rbx, rdi
    cmp     rax, 3
    jnb     short loc_42EF8C
    jmp     short loc_42EFC6
loc_42EF62:
    mov     rax, [rsp+58h+var_50]
    mov     rdi, [rax+458h]
    mov     rsi, [rax]
    mov     ecx, [rax+31Ch]
    xor     ebp, ebp
    mov     edx, offset aLzwdecode; "LZWDecode: "
    jmp     loc_42EEDE
loc_42EF83:
    add     op, occ
    cmp     rax, 3
    jb      short loc_42EFC6
loc_42EF8C:
    neg     occ
    xor     eax, eax
loc_42EF91:
    movzx   edx, byte ptr [codep+0Ah]
    mov     [rsi+rax-1], dl
    mov     codep, [codep]
    movzx   edx, byte ptr [codep+0Ah]
    mov     [rsi+rax-2], dl
    mov     codep, [codep]
    movzx   edx, byte ptr [codep+0Ah]
    mov     [rsi+rax-3], dl
    mov     codep, [codep]
    movzx   edx, byte ptr [codep+0Ah]
    mov     [rsi+rax-4], dl
    mov     codep, [codep]
    add     rax, 0FFFFFFFFFFFFFFFCh
    cmp     r15, rax
    jnz     short loc_42EF91
loc_42EFC6:
    xor     r15d, r15d
    mov     codep, oldcodep
    mov     r8d, [rsp+58h+var_54]
    jmp     loc_42EE28
loc_42EFD6:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifLzwC; "tif_lzw.c"
    mov     ecx, offset aIntLzwdecodeco; "int LZWDecodeCompat(TIFF *, uint8_t *, "...
    mov     edx, 25Ah; line
    call    ___assert_fail
LZWDecodeCompat endp

