PixarLogDecode proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 28h
    mov     r15, occ
    mov     rbx, op
    mov     r14, tif
    mov     r12, [rdi+3F0h]
    mov     eax, [sp_0+108h]
    lea     ecx, [rax-2]
    cmp     ecx, 3
    jb      short loc_43491E
    cmp     eax, 2
    jb      short loc_434921
    cmp     eax, 5
    jnz     loc_434BD3
    shr     occ, 2
    test    sp_0, sp_0
    jnz     short loc_434926
loc_434905:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPixarlogC; "tif_pixarlog.c"
    mov     ecx, offset aIntPixarlogdec; "int PixarLogDecode(TIFF *, uint8_t *, t"...
    mov     edx, 311h; line
    call    ___assert_fail
loc_43491E:
    shr     occ, 1
loc_434921:
    test    sp_0, sp_0
    jz      short loc_434905
loc_434926:
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
    jnz     loc_434A53
    lea     rbp, [sp_0+80h]
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+rax+00h]
loc_434990:
    mov     rdi, rbp
    mov     esi, 1
    call    _inflate
    test    eax, eax
    jnz     loc_434B7C
    cmp     dword ptr [sp_0+0A0h], 0
    jnz     short loc_434990
loc_4349B0:
    mov     rax, [sp_0+80h]
    mov     [tif+428h], rax
    mov     eax, [sp_0+88h]
    mov     [tif+430h], rax
    mov     rbp, [sp_0+0F8h]
    cmp     byte ptr [tif+10h], 0
    jns     short loc_4349E8
    mov     rdi, up; wp
    mov     rsi, nsamples; n
    call    TIFFSwabArrayOfShort
loc_4349E8:
    movsxd  rcx, r13d
    mov     rax, nsamples
    cqo
    mov     [rsp+58h+var_48], rcx
    idiv    rcx
    test    rdx, rdx
    jz      short loc_434A25
    mov     rdi, [tif+458h]; fd
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     qword ptr [rsp+58h+n], rdx
    mov     edx, offset aStrideDIsNotAM; "stride %d is not a multiple of sample c"...
    mov     ecx, r13d
    mov     r8, nsamples
    xor     eax, eax
    call    TIFFWarningExt
    sub     nsamples, qword ptr [rsp+58h+n]
loc_434A25:
    test    nsamples, nsamples
    jle     loc_434BC9
    mov     [rsp+58h+n], r13d
    mov     [rsp+58h+var_40], tif
    mov     rax, [rsp+58h+var_48]
    lea     r13, [rax+rax]
    lea     rax, ds:0[rax*4]
    mov     [rsp+58h+var_38], rax
    xor     r14d, r14d
    jmp     short loc_434AA9
loc_434A53:
    mov     rdi, [tif+458h]; fd
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aZlibCannotDeal; "ZLib cannot deal with buffers this size"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     loc_434C74
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434ABB case 4
    mov     r8, [sp_0+128h]; ToLinear16
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate16
loc_434A92:
    mov     rax, r13
loc_434A95:
    add     op, rax
    add     i, [rsp+58h+var_48]
    add     rbp, r13
    cmp     i, nsamples
    jge     loc_434BC9
loc_434AA9:
    mov     eax, [sp_0+108h]
    cmp     rax, 5; switch 6 cases
    ja      def_434ABB; jumptable 0000000000434ABB default case
def_434ABB:
    jmp     ds:jpt_434ABB[rax*8]; switch jump
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434ABB case 0
    mov     r8, [sp_0+130h]; ToLinear8
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate8
    mov     rax, [rsp+58h+var_48]
    jmp     short loc_434A95
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434ABB case 2
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate11
    jmp     short loc_434A92
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434ABB case 3
    mov     r8, [sp_0+120h]; ToLinearF
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate12
    jmp     loc_434A92
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434ABB case 1
    mov     r8, [sp_0+130h]; ToLinear8
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulate8abgr
    mov     rax, [rsp+58h+var_48]
    jmp     loc_434A95
    movzx   edx, word ptr [sp_0+100h]; jumptable 0000000000434ABB case 5
    mov     r8, [sp_0+120h]; ToLinearF
    mov     rdi, rbp; wp
    mov     esi, [rsp+58h+n]; n
    mov     rcx, op; op
    call    horizontalAccumulateF
    mov     rax, [rsp+58h+var_38]
    jmp     loc_434A95
loc_434B7C:
    cmp     eax, 1
    jz      loc_434C12
    cmp     eax, 0FFFFFFFDh
    jnz     loc_434C46
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
    jmp     loc_434C74
loc_434BC9:
    mov     ebx, 1
    jmp     loc_434C74
loc_434BD3:
    mov     rdi, [tif+458h]
    movzx   ecx, word ptr [tif+74h]
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aUBitInputNotSu; "%u bit input not supported in PixarLog"
    jmp     short loc_434C09
    mov     rax, [rsp+58h+var_40]; jumptable 0000000000434ABB default case
    mov     rdi, [rax+458h]; fd
    movzx   ecx, word ptr [rax+74h]
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aUnsupportedBit_0; "Unsupported bits/sample: %u"
loc_434C09:
    xor     eax, eax
    call    TIFFErrorExt
    jmp     short loc_434C74
loc_434C12:
    mov     r8d, [sp_0+0A0h]
    test    r8d, r8d
    jz      loc_4349B0
    mov     rdi, [tif+458h]; fd
    mov     ecx, [tif+31Ch]
    xor     ebx, ebx
    mov     esi, offset PixarLogDecode_module; "PixarLogDecode"
    mov     edx, offset aNotEnoughDataA_2; "Not enough data at scanline %u (short %"...
    xor     eax, eax
    call    TIFFErrorExt
    jmp     short loc_434C74
loc_434C46:
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
loc_434C74:
    mov     eax, ebx
    add     rsp, 28h
    pop     rbx
    pop     sp_0
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
PixarLogDecode endp

