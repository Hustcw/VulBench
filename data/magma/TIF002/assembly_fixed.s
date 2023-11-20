PixarLogDecode proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 28h
    mov     r14, occ
    mov     rbx, op
    mov     r15, tif
    mov     r12, [rdi+3F0h]
    mov     eax, [sp_0+108h]
    lea     ecx, [rax-2]
    cmp     ecx, 3
    jb      short loc_434B3E
    cmp     eax, 2
    jb      short loc_434B41
    cmp     eax, 5
    jnz     loc_434DAF
    shr     occ, 2
    test    sp_0, sp_0
    jnz     short loc_434B46
loc_434B25:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPixarlogC; "tif_pixarlog.c"
    mov     ecx, offset aIntPixarlogdec; "int PixarLogDecode(TIFF *, uint8_t *, t"...
    mov     edx, 311h; line
    call    ___assert_fail
loc_434B3E:
    shr     occ, 1
loc_434B41:
    test    sp_0, sp_0
    jz      short loc_434B25
loc_434B46:
    movzx   r13d, word ptr [sp_0+100h]
    imul    r13d, [tif+58h]
    mov     rax, [tif+428h]
    mov     [sp_0+80h], rax
    mov     eax, [tif+430h]
    mov     [sp_0+88h], eax
    mov     rax, [sp_0+0F8h]
    mov     [sp_0+98h], rax
    lea     rax, [nsamples+nsamples]
    mov     [sp_0+0A0h], eax
    mov     ecx, eax
    cmp     rcx, rax
    jnz     short loc_434BB4
    cmp     rax, [sp_0+0F0h]
    jle     short loc_434BD3
    mov     rdi, [tif+458h]
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aSpStreamAvailO; "sp->stream.avail_out > sp->tbuf_size"
    jmp     short loc_434BC7
loc_434BB4:
    mov     rdi, [tif+458h]; fd
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aZlibCannotDeal; "ZLib cannot deal with buffers this size"
loc_434BC7:
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_434E35
loc_434BD3:
    lea     rbp, [sp_0+80h]
    nop     dword ptr [rax+rax+00h]
loc_434BE0:
    mov     rdi, rbp
    mov     esi, 1
    call    _inflate
    test    eax, eax
    jnz     loc_434DC9
    cmp     dword ptr [sp_0+0A0h], 0
    jnz     short loc_434BE0
loc_434C00:
    mov     rax, [sp_0+80h]
    mov     [tif+428h], rax
    mov     eax, [sp_0+88h]
    mov     [tif+430h], rax
    mov     rbp, [sp_0+0F8h]
    cmp     byte ptr [tif+10h], 0
    jns     short loc_434C38
    mov     rdi, up; wp
    mov     rsi, nsamples; n
    call    TIFFSwabArrayOfShort
loc_434C38:
    movsxd  rcx, r13d
    mov     rax, nsamples
    cqo
    mov     [rsp+58h+var_48], rcx
    idiv    rcx
    test    rdx, rdx
    jz      short loc_434C75
    mov     rdi, [tif+458h]; fd
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     qword ptr [rsp+58h+n], rdx
    mov     edx, offset aStrideDIsNotAM; "stride %d is not a multiple of sample c"...
    mov     ecx, r13d
    mov     r8, nsamples
    xor     eax, eax
    call    TIFFWarningExt
    sub     nsamples, qword ptr [rsp+58h+n]
loc_434C75:
    test    nsamples, nsamples
    jle     loc_434E0F
    mov     [rsp+58h+var_38], nsamples
    mov     [rsp+58h+n], r13d
    mov     rax, [rsp+58h+var_48]
    lea     r14, [rax+rax]
    lea     rax, ds:0[rax*4]
    mov     [rsp+58h+var_40], rax
    xor     r13d, r13d
    jmp     short loc_434CDC
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434CEE case 4
    mov     r8, [sp_0+128h]; ToLinear16
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate16
loc_434CC3:
    mov     rax, r14
loc_434CC6:
    add     op, rax
    add     i, [rsp+58h+var_48]
    add     rbp, r14
    cmp     i, [rsp+58h+var_38]
    jge     loc_434E0F
loc_434CDC:
    mov     eax, [sp_0+108h]
    cmp     rax, 5; switch 6 cases
    ja      def_434CEE; jumptable 0000000000434CEE default case
def_434CEE:
    jmp     ds:jpt_434CEE[rax*8]; switch jump
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434CEE case 0
    mov     r8, [sp_0+130h]; ToLinear8
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate8
    mov     rax, [rsp+58h+var_48]
    jmp     short loc_434CC6
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434CEE case 2
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate11
    jmp     short loc_434CC3
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434CEE case 3
    mov     r8, [sp_0+120h]; ToLinearF
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate12
    jmp     loc_434CC3
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434CEE case 1
    mov     r8, [sp_0+130h]; ToLinear8
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate8abgr
    mov     rax, [rsp+58h+var_48]
    jmp     loc_434CC6
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434CEE case 5
    mov     r8, [sp_0+120h]; ToLinearF
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulateF
    mov     rax, [rsp+58h+var_40]
    jmp     loc_434CC6
loc_434DAF:
    mov     rdi, [tif+458h]
    movzx   ecx, word ptr [tif+74h]
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aUBitInputNotSu; "%u bit input not supported in PixarLog"
    jmp     short loc_434E2E
loc_434DC9:
    cmp     eax, 1
    jz      short loc_434E46
    cmp     eax, 0FFFFFFFDh
    jnz     loc_434E7A
    mov     rdi, [tif+458h]; fd
    mov     ecx, [tif+31Ch]
    mov     state, [sp_0+0B0h]
    test    rax, rax
    mov     r8d, offset aNull_0; "(null)"
    cmovnz  r8, rax
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aDecodingErrorA; "Decoding error at scanline %u, %s"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     short loc_434E35
loc_434E0F:
    mov     ebx, 1
    jmp     short loc_434E35
    mov     rdi, [tif+458h]; jumptable 0000000000434CEE default case
    movzx   ecx, word ptr [tif+74h]
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aUnsupportedBit_0; "Unsupported bits/sample: %u"
loc_434E2E:
    xor     eax, eax
    call    TIFFErrorExt
loc_434E35:
    mov     eax, ebx
    add     rsp, 28h
    pop     rbx
    pop     sp_0
    pop     r13
    pop     r14
    pop     tif
    pop     rbp
    retn
loc_434E46:
    mov     r8d, [sp_0+0A0h]
    test    r8d, r8d
    jz      loc_434C00
    mov     rdi, [tif+458h]; fd
    mov     ecx, [tif+31Ch]
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aNotEnoughDataA_2; "Not enough data at scanline %u (short %"...
    xor     eax, eax
    call    TIFFErrorExt
    jmp     short loc_434E35
loc_434E7A:
    mov     rdi, [tif+458h]; fd
    mov     state, [sp_0+0B0h]
    test    rax, rax
    mov     ecx, offset aNull_0; "(null)"
    cmovnz  rcx, rax
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aZlibErrorS; "ZLib error: %s"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     short loc_434E35
PixarLogDecode endp

