SplashOutputDev::tilingPatternFill(GfxState *,Gfx *,Catalog *,GfxTilingPattern *,double const*,int,int,int,int,double,double) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 1E8h
    movsd   qword ptr [rsp+218h+var_1F8], xStep
    movsd   qword ptr [rsp+218h+var_1E8], xmm0
    mov     r15, mat
    mov     rbp, tPat
    mov     r13, state
    mov     rbx, this
    mov     [rsp+218h+var_60], gfxA
    lea     rdi, [rsp+218h+var_58]; this
    call    _ZN12PDFRectangleC2Ev; PDFRectangle::PDFRectangle(void)
    mov     rax, [this+0D0h]
    mov     [rsp+218h+var_E8], rax
    mov     rax, [this+0D8h]
    mov     [rsp+218h+var_F0], rax
    mov     rdi, tPat; this
    call    _ZNK16GfxTilingPattern7getBBoxEv; GfxTilingPattern::getBBox(void)
    mov     r14, rax
    mov     rdi, tPat; this
    call    _ZNK16GfxTilingPattern9getMatrixEv; GfxTilingPattern::getMatrix(void)
    mov     [rsp+218h+var_118], rax
    mov     rdi, tPat; this
    call    _ZNK16GfxTilingPattern12getPaintTypeEv; GfxTilingPattern::getPaintType(void)
    mov     [rsp+218h+var_1FC], eax
    mov     rdi, tPat; this
    call    _ZN16GfxTilingPattern10getResDictEv; GfxTilingPattern::getResDict(void)
    mov     [rsp+218h+var_68], resDict
    movsd   xmm0, qword ptr [bbox+10h]
    subsd   xmm0, qword ptr [bbox]
    xor     r12d, r12d
    ucomisd xmm0, qword ptr [rsp+218h+var_1E8]
    jnz     loc_44B2BD
    jp      loc_44B2BD
    movsd   width, qword ptr [bbox+18h]
    subsd   width, qword ptr [bbox+8]
    movsd   height, qword ptr [rsp+218h+var_1F8]
    ucomisd width, height
    jnz     loc_44B2BD
    jp      loc_44B2BD
    movsd   [rsp+218h+var_1C8], width
    movsd   [rsp+218h+var_148], xmm0
    mov     [rsp+218h+var_1B0], this
    mov     rdi, state; this
    call    _ZNK8GfxState6getCTMEv; GfxState::getCTM(void)
    movsd   xmm0, qword ptr [ctm]
    movsd   [rsp+218h+var_1A8], xmm0
    movsd   xmm0, qword ptr [ctm+8]
    movsd   [rsp+218h+a], xmm0
    movsd   xmm0, qword ptr [ctm+10h]
    movsd   [rsp+218h+b], xmm0
    movsd   xmm0, qword ptr [ctm+18h]
    movsd   [rsp+218h+c], xmm0
    movsd   xmm0, qword ptr [ctm+20h]
    movsd   [rsp+218h+d], xmm0
    movsd   xmm0, qword ptr [ctm+28h]
    movsd   [rsp+218h+e], xmm0
    movsd   xmm0, qword ptr [mat]
    movsd   xmm1, qword ptr [mat+8]; a
    movsd   xmm2, qword ptr [mat+10h]; b
    movsd   xmm3, qword ptr [mat+18h]; c
    movsd   xmm4, qword ptr [mat+20h]; d
    movsd   xmm5, qword ptr [mat+28h]; e
    mov     rdi, state; this
    call    _ZN8GfxState9concatCTMEdddddd; GfxState::concatCTM(double,double,double,double,double,double)
    movsd   xmm4, qword ptr [bbox]; d
    movsd   xmm5, qword ptr [bbox+8]; e
    movsd   xmm0, cs:x
    xorpd   xmm1, xmm1; a
    xorpd   xmm2, xmm2; b
    mov     rdi, state; this
    movapd  xmm3, xmm0; c
    call    _ZN8GfxState9concatCTMEdddddd; GfxState::concatCTM(double,double,double,double,double,double)
    mov     rdi, state; this
    call    _ZNK8GfxState6getCTMEv; GfxState::getCTM(void)
    mov     rbx, rax
    movsd   xmm0, qword ptr [rax]
    call    _Z8isfiniteIdENSt3__19enable_ifIXaasr3std13is_arithmeticIT_EE5valuesr3std14numeric_limitsIS2_EE12has_infinityEbE4typeES2_
    test    al, al
    jz      loc_44B282
    movsd   xmm0, qword ptr [ctm+8]
    call    _Z8isfiniteIdENSt3__19enable_ifIXaasr3std13is_arithmeticIT_EE5valuesr3std14numeric_limitsIS2_EE12has_infinityEbE4typeES2_
    test    al, al
    jz      loc_44B282
    movsd   xmm0, qword ptr [ctm+10h]
    call    _Z8isfiniteIdENSt3__19enable_ifIXaasr3std13is_arithmeticIT_EE5valuesr3std14numeric_limitsIS2_EE12has_infinityEbE4typeES2_
    test    al, al
    jz      loc_44B282
    movsd   xmm0, qword ptr [ctm+18h]
    call    _Z8isfiniteIdENSt3__19enable_ifIXaasr3std13is_arithmeticIT_EE5valuesr3std14numeric_limitsIS2_EE12has_infinityEbE4typeES2_
    test    al, al
    jz      loc_44B282
    movsd   xmm0, qword ptr [ctm+20h]
    call    _Z8isfiniteIdENSt3__19enable_ifIXaasr3std13is_arithmeticIT_EE5valuesr3std14numeric_limitsIS2_EE12has_infinityEbE4typeES2_
    test    al, al
    jz      loc_44B282
    movsd   xmm0, qword ptr [ctm+28h]
    call    _Z8isfiniteIdENSt3__19enable_ifIXaasr3std13is_arithmeticIT_EE5valuesr3std14numeric_limitsIS2_EE12has_infinityEbE4typeES2_
    test    al, al
    jz      loc_44B282
    mov     r12d, [rsp+218h+x0_0]
    xorps   xmm0, xmm0
    cvtsi2sd xmm0, r12d
    mulsd   xmm0, qword ptr [rsp+218h+var_1E8]
    movsd   xmm1, qword ptr [ctm]
    mulsd   xmm1, xmm0; x
    xorps   xmm2, xmm2
    cvtsi2sd xmm2, [rsp+218h+y0_0]
    mulsd   xmm2, qword ptr [rsp+218h+var_1F8]
    movsd   xmm3, qword ptr [ctm+10h]
    mulsd   xmm3, xmm2
    addsd   xmm3, xmm1
    addsd   xmm3, qword ptr [ctm+20h]
    movsd   [rsp+218h+var_98], xmm3
    mulsd   xmm0, qword ptr [ctm+8]
    mulsd   xmm2, qword ptr [ctm+18h]
    addsd   xmm2, xmm0
    addsd   xmm2, qword ptr [ctm+28h]
    movsd   [rsp+218h+var_90], xmm2
    movsd   xmm0, qword ptr [ctm+8]
    movaps  [rsp+218h+var_1E8], xmm0
    call    _ZL9splashAbsd; splashAbs(double)
    movsd   qword ptr [rsp+218h+var_1F8], xmm0
    movsd   xmm0, qword ptr [ctm]
    movaps  [rsp+218h+var_138], xmm0
    call    _ZL9splashAbsd; splashAbs(double)
    movsd   xmm1, qword ptr [rsp+218h+var_1F8]
    mov     rax, ctm
    ucomisd xmm1, xmm0
    jbe     short loc_44AADD
    add     rax, 10h
    movapd  xmm0, cs:xmmword_5CBE00
    movapd  xmm2, [rsp+218h+var_1E8]
    xorpd   xmm0, xmm2
    movlpd  [rsp+218h+tx], xmm0
    movsd   kx, qword ptr [ctm]
    mulsd   kx, qword ptr [ctm+18h]
    divsd   kx, xmm2
    jmp     short loc_44AAFF
loc_44AADD:
    add     rax, 18h
    movapd  xmm0, [rsp+218h+var_138]
    movsd   [rsp+218h+tx], xmm0
    movapd  xmm1, [rsp+218h+var_1E8]
    mulsd   xmm1, qword ptr [ctm+10h]
    divsd   xmm1, qword ptr [ctm]
loc_44AAFF:
    mov     ecx, [rsp+218h+x1]
    movsd   xmm2, qword ptr [rax]
    subsd   xmm2, kx
    movapd  [rsp+218h+var_1F8], xmm2
    movsd   [rsp+218h+ty], xmm2
    sub     ecx, r12d
    mov     dword ptr [rsp+218h+var_1E8], ecx
    xorps   kx, kx
    cvtsi2sd kx, ecx
    mulsd   xmm0, [rsp+218h+var_148]
    movsd   [rsp+218h+var_120], xmm1
    mulsd   xmm0, xmm1
    andpd   xmm0, cs:xmmword_5CBCE0; x
    call    _ceil
    movsd   qword ptr [rsp+218h+var_138], xmm0
    movapd  xmm1, [rsp+218h+var_1F8]
    mulsd   xmm1, [rsp+218h+var_1C8]
    mov     eax, [rsp+218h+y1]
    sub     eax, [rsp+218h+y0_0]
    mov     dword ptr [rsp+218h+var_1F8], eax
    xorps   xmm0, xmm0
    cvtsi2sd xmm0, eax
    movsd   [rsp+218h+var_F8], xmm0
    mulsd   xmm1, xmm0
    andpd   xmm1, cs:xmmword_5CBCE0
    movapd  xmm0, xmm1; x
    call    _ceil
    movsd   qword ptr [rsp+218h+widthA], xmm0
    mov     rdi, state; this
    call    _ZNK8GfxState7getHDPIEv; GfxState::getHDPI(void)
    divsd   xmm0, cs:hDPI
    movsd   [rsp+218h+tx], xmm0
    mov     rdi, state; this
    call    _ZNK8GfxState7getVDPIEv; GfxState::getVDPI(void)
    divsd   xmm0, cs:hDPI
    movsd   [rsp+218h+ty], xmm0
    mov     rax, [rsp+218h+var_118]
    movsd   ky, qword ptr [rax]
    xorpd   xmm2, xmm2
    ucomisd ky, xmm2
    jnz     short loc_44ABE6
    jp      short loc_44ABE6
    movsd   ky, qword ptr [rax+10h]
loc_44ABE6:
    andpd   ky, cs:xmmword_5CBCE0
    mulsd   ky, [rsp+218h+tx]
    cvttsd2si ecx, qword ptr [rsp+218h+var_138]
    mov     dword ptr [rsp+218h+var_1B8], ecx
    cvttsd2si ecx, qword ptr [rsp+218h+widthA]
    mov     dword ptr [rsp+218h+var_138], ecx
    movsd   [rsp+218h+var_178.m], ky
    xorpd   ky, ky
    movupd  xmmword ptr [rsp+218h+var_178.m+8], ky
    movsd   xmm2, qword ptr [rax+18h]
    xorpd   xmm3, xmm3
    ucomisd xmm2, xmm3
    jnz     short loc_44AC3A
    jp      short loc_44AC3A
    movsd   xmm2, qword ptr [rax+8]
loc_44AC3A:
    movapd  xmm3, cs:xmmword_5CBCE0
    andpd   xmm2, xmm3
    mulsd   xmm0, xmm2
    movsd   [rsp+218h+var_178.m+18h], xmm0
    movupd  xmmword ptr [rsp+218h+var_178.m+20h], xmm1
    lea     rdi, [rsp+218h+var_178]; this
    lea     rsi, [rsp+218h+tx]; tx
    lea     rdx, [rsp+218h+ty]; ty
    movsd   xmm0, [rsp+218h+var_148]; x
    movsd   xmm1, [rsp+218h+var_1C8]; y
    call    _ZNK6Matrix9transformEddPdS0_; Matrix::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+218h+tx]
    andps   xmm0, cs:xmmword_5CBCE0; x
    call    _ceil
    cvttsd2si r12d, xmm0
    movsd   xmm0, [rsp+218h+ty]
    andps   xmm0, cs:xmmword_5CBCE0; x
    call    _ceil
    cvttsd2si ebx, xmm0
    xorps   xmm0, xmm0
    cvtsi2sd xmm0, dword ptr [rsp+218h+var_1B8]
    mov     eax, dword ptr [rsp+218h+var_1E8]
    imul    eax, r12d
    xorps   xmm1, xmm1
    cvtsi2sd xmm1, eax
    xorps   xmm2, xmm2
    cvtsi2sd xmm2, dword ptr [rsp+218h+var_138]
    mov     eax, dword ptr [rsp+218h+var_1F8]
    imul    eax, ebx
    xorps   xmm3, xmm3
    cvtsi2sd xmm3, eax
    divsd   xmm0, xmm1
    divsd   xmm2, xmm3
    mulsd   xmm0, [rsp+218h+var_178.m]
    movsd   [rsp+218h+var_178.m], xmm0
    mulsd   xmm2, [rsp+218h+var_178.m+18h]
    movsd   [rsp+218h+var_178.m+18h], xmm2
    lea     rdi, [rsp+218h+var_178]; this
    movsd   xmm0, [rsp+218h+var_148]; x
    movsd   xmm1, [rsp+218h+var_1C8]; y
    lea     rsi, [rsp+218h+tx]; tx
    lea     rdx, [rsp+218h+ty]; ty
    call    _ZNK6Matrix9transformEddPdS0_; Matrix::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+218h+tx]
    movapd  kx, xmm0
    andpd   kx, cs:xmmword_5CBCE0
    movsd   xmm2, cs:x
    ucomisd xmm2, kx
    jbe     loc_44AE3D
    movsd   kx, [rsp+218h+ty]
    andpd   kx, cs:xmmword_5CBCE0
    movsd   xmm2, cs:x
    ucomisd xmm2, kx
    jbe     loc_44AE3D
    lea     surface_height, [rsp+218h+tx]
    lea     surface_width, [rsp+218h+ty]
    mov     rdi, rbx; __a
    mov     rsi, r12; __b
    call    _ZNSt3__13minIdEERKT_S3_S3_; std::min<double>(double const&,double const&)
    movsd   xmm0, qword ptr [rax]
    movsd   [rsp+218h+tx], xmm0
    movsd   kx, cs:qword_5CBEC0
    divsd   kx, xmm0
    movsd   [rsp+218h+ty], kx
    movsd   xmm0, [rsp+218h+var_178.m]
    mulsd   xmm0, xmm1
    movsd   [rsp+218h+var_178.m], xmm0
    mulsd   xmm1, [rsp+218h+var_178.m+18h]
    movsd   [rsp+218h+var_178.m+18h], xmm1
    lea     rdi, [rsp+218h+var_178]; this
    movsd   xmm0, [rsp+218h+var_148]; x
    movsd   xmm1, [rsp+218h+var_1C8]; y
    mov     rsi, rbx; tx
    mov     rdx, r12; ty
    call    _ZNK6Matrix9transformEddPdS0_; Matrix::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+218h+tx]
    movapd  xmm1, cs:xmmword_5CBCE0
    andpd   xmm0, xmm1; x
    call    _ceil
    cvttsd2si eax, xmm0
    mov     [rsp+218h+widthA], eax
    movsd   xmm0, [rsp+218h+ty]
    andpd   xmm0, cs:xmmword_5CBCE0; x
    call    _ceil
    cvttsd2si eax, xmm0
    mov     dword ptr [rsp+218h+var_118], eax
    mov     ebx, dword ptr [rsp+218h+var_1E8]
    mov     r12d, dword ptr [rsp+218h+var_1F8]
    jmp     loc_44AF98
loc_44AE3D:
    movsxd  rax, r12d
    movsxd  rcx, ebx
    imul    rcx, rax
    cmp     rcx, 800000h
    ja      loc_44B282
    movapd  xmm2, cs:xmmword_5CBCE0
    movsd   xmm3, cs:qword_5CBEB8
    lea     surface_height, [rsp+218h+tx]
    lea     surface_width, [rsp+218h+ty]
    jmp     short loc_44AED6
loc_44AE70:
    movsd   xmm0, [rsp+218h+var_178.m]
    movsd   xmm2, cs:qword_5CBE20
    mulsd   xmm0, xmm2
    movsd   [rsp+218h+var_178.m], xmm0
    movsd   xmm0, [rsp+218h+var_178.m+18h]
    mulsd   xmm0, xmm2
    movsd   [rsp+218h+var_178.m+18h], xmm0
    lea     rdi, [rsp+218h+var_178]; this
    movsd   xmm0, [rsp+218h+var_148]; x
    mov     rsi, rbx; tx
    mov     rdx, r12; ty
    call    _ZNK6Matrix9transformEddPdS0_; Matrix::transform(double,double,double *,double *)
    movsd   xmm3, cs:qword_5CBEB8
    movapd  xmm2, cs:xmmword_5CBCE0
    movsd   xmm0, [rsp+218h+tx]
loc_44AED6:
    andpd   xmm0, xmm2; x
    ucomisd xmm0, xmm3
    movsd   xmm1, [rsp+218h+var_1C8]; y
    ja      short loc_44AE70
    movsd   xmm4, [rsp+218h+ty]
    andpd   xmm4, xmm2
    ucomisd xmm4, xmm3
    ja      loc_44AE70
    movapd  xmmword ptr [rsp+218h+var_118], xmm4
    call    _ceil
    cvttsd2si ebx, xmm0
    movaps  xmm0, xmmword ptr [rsp+218h+var_118]; x
    call    _ceil
    cvttsd2si edi, xmm0
    mov     ecx, dword ptr [rsp+218h+var_1B8]
    mov     eax, ecx
    cdq
    idiv    ebx
    mov     r9d, eax
    mov     r8d, dword ptr [rsp+218h+var_138]
    mov     eax, r8d
    cdq
    idiv    edi
    mov     edx, r9d
    mov     [rsp+218h+widthA], ebx
    imul    edx, ebx
    xor     esi, esi
    cmp     edx, ecx
    setl    sil
    add     esi, r9d
    mov     ecx, eax
    mov     dword ptr [rsp+218h+var_118], edi
    imul    ecx, edi
    xor     edx, edx
    cmp     ecx, r8d
    setl    dl
    add     edx, eax
    mov     ebx, dword ptr [rsp+218h+var_1E8]
    cmp     ebx, esi
    cmovl   ebx, esi
    mov     r12d, dword ptr [rsp+218h+var_1F8]
    cmp     r12d, edx
    cmovl   r12d, edx
    xorps   xmm0, xmm0
    cvtsi2sd xmm0, ebx
    movsd   [rsp+218h+var_120], xmm0
    xorps   xmm0, xmm0
    cvtsi2sd xmm0, r12d
    movsd   [rsp+218h+var_F8], xmm0
loc_44AF98:
    mov     rdi, state; this
    movsd   xmm0, [rsp+218h+var_1A8]
    movsd   xmm1, [rsp+218h+a]; a
    movsd   xmm2, [rsp+218h+b]; b
    movsd   xmm3, [rsp+218h+c]; c
    movsd   xmm4, [rsp+218h+d]; d
    movsd   xmm5, [rsp+218h+e]; e
    call    _ZN8GfxState6setCTMEdddddd; GfxState::setCTM(double,double,double,double,double,double)
    movsd   xmm0, qword ptr [mat]
    movsd   xmm1, qword ptr [mat+8]; a
    movsd   xmm2, qword ptr [mat+10h]; b
    movsd   xmm3, qword ptr [mat+18h]; c
    movsd   xmm4, qword ptr [mat+20h]; d
    movsd   xmm5, qword ptr [mat+28h]; e
    mov     rdi, state; this
    call    _ZN8GfxState9concatCTMEdddddd; GfxState::concatCTM(double,double,double,double,double,double)
    movsd   xmm0, [rsp+218h+var_148]
    mulsd   xmm0, [rsp+218h+var_120]
    movsd   xmm3, [rsp+218h+var_1C8]
    mulsd   xmm3, [rsp+218h+var_F8]; c
    movsd   xmm4, qword ptr [bbox]; d
    movsd   xmm5, qword ptr [bbox+8]; e
    xorpd   xmm1, xmm1; a
    xorpd   xmm2, xmm2; b
    mov     rdi, state; this
    call    _ZN8GfxState9concatCTMEdddddd; GfxState::concatCTM(double,double,double,double,double,double)
    mov     rdi, state; this
    call    _ZNK8GfxState6getCTMEv; GfxState::getCTM(void)
    mov     mat, [ctm]
    mov     [rsp+218h+var_B8], r15
    mov     rdx, [ctm+8]
    mov     [rsp+218h+var_B0], rdx
    mov     rcx, [ctm+10h]
    mov     [rsp+218h+var_A8], rcx
    mov     ctm, [ctm+18h]
    mov     [rsp+218h+var_A0], rax
    mov     esi, r12d
    imul    esi, ebx
    cmp     esi, 5
    jl      loc_44B282
    cmp     dword ptr [rsp+218h+var_118], 0
    jz      loc_44B282
    cmp     [rsp+218h+widthA], 0
    jz      loc_44B282
    mov     dword ptr [rsp+218h+var_1F8], r12d
    mov     dword ptr [rsp+218h+var_1E8], ebx
    movq    xmm0, rdx
    movdqa  xmmword ptr [rsp+218h+var_148], xmm0
    movq    xmm0, r15
    movdqa  xmmword ptr [rsp+218h+var_1C8], xmm0
    movq    xmm0, rax
    movq    [rsp+218h+var_1B8], xmm0
    movq    xmm0, rcx
    movdqa  [rsp+218h+var_138], xmm0
    movsd   xmm0, qword ptr [bbox]; x
    movsd   xmm1, qword ptr [bbox+8]; y
    lea     rdi, [rsp+218h+var_178]; this
    lea     rsi, [rsp+218h+tx]; tx
    lea     rdx, [rsp+218h+ty]; ty
    call    _ZNK6Matrix9transformEddPdS0_; Matrix::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+218h+tx]
    movhps  xmm0, [rsp+218h+ty]
    xorps   xmm0, cs:xmmword_5CBE00
    movups  xmmword ptr [rsp+218h+var_178.m+20h], xmm0
    movups  xmm0, xmmword ptr [bbox]
    movaps  xmmword ptr [rsp+218h+var_58.x1], xmm0
    movups  xmm0, xmmword ptr [bbox+10h]
    movaps  xmmword ptr [rsp+218h+var_58.x2], xmm0
    mov     rax, [rsp+218h+var_1B0]
    lea     rsi, [rax+0C0h]; __args
    mov     [rsp+218h+srcData], rax
    lea     rax, [rsp+218h+var_58]
    mov     [rsp+218h+var_70], rax
    mov     [rsp+218h+var_78], 0
    mov     [rsp+218h+__args], 0
    mov     [rsp+218h+var_88], 0
    sub     rsp, 8
    lea     rax, [rsp+220h+var_60]
    lea     r10, [rsp+220h+var_88]
    lea     r11, [rsp+220h+__args]
    lea     bbox, [rsp+220h+var_100]
    lea     rdx, [rsp+220h+srcData]; __args
    lea     rcx, [rsp+220h+var_68]; __args
    lea     r8, [rsp+220h+var_70]; __args
    lea     r9, [rsp+220h+var_78]; __args
    mov     rdi, r14
    push    rax; __args
    push    r10; __args
    push    r11; __args
    call    _ZNSt3__111make_uniqueI3GfxJRP6PDFDocP15SplashOutputDevRP4DictP12PDFRectangleDnDnDnRPS1_EEENS_11__unique_ifIT_E15__unique_singleEDpOT0_; std::make_unique<Gfx,PDFDoc *&,SplashOutputDev *,Dict *&,PDFRectangle *,decltype(nullptr),decltype(nullptr),decltype(nullptr),Gfx*&>(PDFDoc *&,SplashOutputDev *,Dict *&,PDFRectangle *,decltype(nullptr),decltype(nullptr),decltype(nullptr),Gfx*&)
    add     rsp, 20h
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI3GfxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<Gfx>::operator->(void)
    mov     rdi, rax; this
    call    _ZN3Gfx8getStateEv; Gfx::getState(void)
    movsd   xmm0, [rsp+218h+var_178.m]
    movsd   xmm1, [rsp+218h+var_178.m+8]; a
    movsd   xmm2, [rsp+218h+var_178.m+10h]; b
    movsd   xmm3, [rsp+218h+var_178.m+18h]; c
    movsd   xmm4, [rsp+218h+var_178.m+20h]; d
    movsd   xmm5, [rsp+218h+var_178.m+28h]; e
    mov     rdi, rax; this
    call    _ZN8GfxState6setCTMEdddddd; GfxState::setCTM(double,double,double,double,double,double)
    movaps  xmm0, xmmword ptr [rsp+218h+var_148]
    call    _ZL9splashAbsd; splashAbs(double)
    movsd   [rsp+218h+var_120], xmm0
    movaps  xmm0, xmmword ptr [rsp+218h+var_1C8]
    call    _ZL9splashAbsd; splashAbs(double)
    movsd   xmm1, [rsp+218h+var_120]
    ucomisd xmm1, xmm0
    jbe     loc_44B2D2
    movapd  xmm1, cs:xmmword_5CBE00
    movapd  xmm2, xmmword ptr [rsp+218h+var_148]
    xorpd   xmm1, xmm2
    movlpd  [rsp+218h+tx], xmm1
    movapd  xmm0, xmmword ptr [rsp+218h+var_1C8]
    mulsd   xmm0, [rsp+218h+var_1B8]
    movapd  xmm3, xmm1
    mov     eax, dword ptr [rsp+218h+var_1E8]
    mov     ecx, dword ptr [rsp+218h+var_1F8]
    movapd  kx, [rsp+218h+var_138]
    jmp     short loc_44B301
loc_44B282:
    mov     rdi, state; this
    movsd   xmm0, [rsp+218h+var_1A8]
    movsd   xmm1, [rsp+218h+a]; a
    movsd   xmm2, [rsp+218h+b]; b
    movsd   xmm3, [rsp+218h+c]; c
    movsd   xmm4, [rsp+218h+d]; d
    movsd   xmm5, [rsp+218h+e]; e
    call    _ZN8GfxState6setCTMEdddddd; GfxState::setCTM(double,double,double,double,double,double)
    xor     r12d, r12d
loc_44B2BD:
    mov     eax, r12d
    add     rsp, 1E8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_44B2D2:
    mov     [rsp+218h+tx], r15
    movapd  xmm0, xmmword ptr [rsp+218h+var_148]
    mulsd   xmm0, qword ptr [rsp+218h+var_138]
    movapd  xmm3, xmmword ptr [rsp+218h+var_1C8]
    movapd  xmm2, xmm3
    movsd   xmm4, [rsp+218h+var_1B8]
    mov     eax, dword ptr [rsp+218h+var_1E8]
    mov     ecx, dword ptr [rsp+218h+var_1F8]
loc_44B301:
    divsd   xmm0, xmm2
    subsd   kx, xmm0
    mov     edx, [rsp+218h+widthA]
    imul    edx, eax
    mov     eax, dword ptr [rsp+218h+var_118]
    mov     r12d, eax
    imul    r12d, ecx
    mov     [rsp+218h+var_1C8], result_width
    xorps   xmm0, xmm0
    cvtsi2sd xmm0, edx
    movapd  xmm1, cs:xmmword_5CBCE0
    movapd  xmm2, xmm1
    andpd   xmm3, xmm1
    movsd   xmm1, cs:x
    addsd   xmm3, xmm1
    divsd   xmm0, xmm3
    movsd   [rsp+218h+tx], xmm0
    xorps   xmm3, xmm3
    cvtsi2sd xmm3, r12d
    andpd   xmm4, xmm2
    addsd   xmm4, kx
    divsd   xmm3, xmm4; c
    movsd   [rsp+218h+ty], xmm3
    xorpd   kx, kx; a
    xorpd   xmm2, xmm2; b
    xorpd   ky, ky; d
    xorps   xmm5, xmm5; e
    mov     rdi, state; this
    call    _ZN8GfxState9concatCTMEdddddd; GfxState::concatCTM(double,double,double,double,double,double)
    mov     rdi, state; this
    call    _ZNK8GfxState6getCTMEv; GfxState::getCTM(void)
    mov     rcx, [ctm]
    mov     [rsp+218h+var_B8], rcx
    mov     rdx, [ctm+8]
    mov     [rsp+218h+var_B0], rdx
    mov     rsi, [ctm+10h]
    mov     [rsp+218h+var_A8], rsi
    movsd   xmm0, qword ptr [ctm+18h]
    movq    xmm1, rcx
    xorpd   xmm2, xmm2
    ucomisd xmm1, xmm2
    setnbe  al
    movsd   [rsp+218h+var_A0], xmm0
    movq    xmm1, rdx
    ucomisd xmm1, xmm2
    setnp   cl
    setz    dl
    and     dl, cl
    and     dl, al
    movq    xmm1, rsi
    ucomisd xmm1, xmm2
    pxor    xmm1, xmm1
    setnp   al
    setz    cl
    and     cl, al
    ucomisd xmm0, xmm1
    setnbe  r15b
    and     r15b, cl
    and     r15b, dl
    mov     edi, 30h ; '0'; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbx, rax
    cmp     [rsp+218h+var_1FC], 1
    jz      short loc_44B41F
    mov     r8d, 1
    test    r15b, r15b
    jz      short loc_44B428
loc_44B41F:
    mov     rax, [rsp+218h+var_1B0]
    mov     r8d, [rax+74h]; modeA
loc_44B428:
    mov     rdi, rbx; this
    mov     esi, [rsp+218h+widthA]; widthA
    mov     edx, dword ptr [rsp+218h+var_118]; heightA
    mov     ecx, 1; rowPadA
    mov     r9d, 1; alphaA
    push    0; separationListA
    push    1; topDown
    call    _ZN12SplashBitmapC2Eiii15SplashColorModebbPNSt3__16vectorIP23GfxSeparationColorSpaceNS1_9allocatorIS4_EEEE; SplashBitmap::SplashBitmap(int,int,int,SplashColorMode,bool,bool,std::vector<GfxSeparationColorSpace *> *)
    add     rsp, 10h
    mov     r14, [rsp+218h+var_1B0]
    mov     [r14+0D0h], rbx
    mov     rdi, rbx; this
    call    _ZN12SplashBitmap10getDataPtrEv; SplashBitmap::getDataPtr(void)
    test    rax, rax
    jz      loc_44B521
    mov     edi, 0D0h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbx, rax
    mov     rsi, [r14+0D0h]; bitmapA
    mov     rdi, rax; this
    mov     edx, 1; vectorAntialiasA
    xor     ecx, ecx; screenParams
    call    _ZN6SplashC2EP12SplashBitmapbP18SplashScreenParams; Splash::Splash(SplashBitmap *,bool,SplashScreenParams *)
    mov     [r14+0D8h], rbx
    lea     rdi, [rsp+218h+var_100]; this
    call    _ZNKSt3__110unique_ptrI3GfxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<Gfx>::operator->(void)
    mov     rdi, rax; this
    call    _ZN3Gfx8getStateEv; Gfx::getState(void)
    movsd   xmm0, [rsp+218h+var_178.m]
    movsd   xmm1, [rsp+218h+var_178.m+8]
    movsd   xmm2, [rsp+218h+var_178.m+10h]
    movsd   xmm3, [rsp+218h+var_178.m+18h]
    movsd   xmm4, [rsp+218h+var_178.m+20h]
    movsd   xmm5, [rsp+218h+var_178.m+28h]
    mov     rcx, [r14]
    mov     rdi, r14
    mov     rsi, rax
    call    qword ptr [rcx+0B8h]
    cmp     [rsp+218h+var_1FC], 2
    jnz     loc_44B58C
    mov     eax, [r14+74h]
    add     eax, 0FFFFFFFBh
    cmp     eax, 1
    setnbe  al
    neg     al
    mov     byte ptr [rsp+218h+srcData], al
    mov     rdi, [r14+0D8h]
    lea     rsi, [rsp+218h+srcData]
    jmp     short loc_44B59A
loc_44B521:
    mov     rbx, [r14+0D0h]
    mov     rax, [rsp+218h+var_E8]
    mov     [r14+0D0h], rax
    test    tBitmap, tBitmap
    jz      short loc_44B54C
    mov     rdi, tBitmap; this
    call    _ZN12SplashBitmapD2Ev; SplashBitmap::~SplashBitmap()
    mov     rdi, tBitmap; void *
    call    __ZdlPv; operator delete(void *)
loc_44B54C:
    mov     rdi, state; this
    movsd   xmm0, [rsp+218h+var_1A8]
    movsd   xmm1, [rsp+218h+a]; a
    movsd   xmm2, [rsp+218h+b]; b
    movsd   xmm3, [rsp+218h+c]; c
    movsd   xmm4, [rsp+218h+d]; d
    movsd   xmm5, [rsp+218h+e]; e
    call    _ZN8GfxState6setCTMEdddddd; GfxState::setCTM(double,double,double,double,double,double)
    xor     r12d, r12d
    jmp     loc_44B7DF
loc_44B58C:
    mov     rdi, [r14+0D8h]; this
    lea     rsi, [r14+84h]; color
loc_44B59A:
    xor     edx, edx; alpha
    call    _ZN6Splash5clearEPhh; Splash::clear(uchar *,uchar)
    mov     state, [rsp+218h+var_F0]
    mov     rbx, [r14+0D8h]
    mov     rdi, r13; this
    call    _ZN6Splash15getThinLineModeEv; Splash::getThinLineMode(void)
    mov     rdi, rbx; this
    mov     esi, eax; thinLineModeA
    call    _ZN6Splash15setThinLineModeE18SplashThinLineMode; Splash::setThinLineMode(SplashThinLineMode)
    mov     rdi, [r14+0D8h]; this
    xorpd   xmm0, xmm0
    call    _ZN6Splash15setMinLineWidthEd; Splash::setMinLineWidth(double)
    test    r15b, r15b
    jz      short loc_44B61B
    mov     rbx, [r14+0D8h]
    mov     rdi, r13; this
    call    _ZN6Splash14getFillPatternEv; Splash::getFillPattern(void)
    mov     rcx, [rax]
    mov     rdi, rax
    call    qword ptr [rcx]
    mov     rdi, rbx; this
    mov     rsi, rax; fillPattern
    call    _ZN6Splash14setFillPatternEP13SplashPattern; Splash::setFillPattern(SplashPattern *)
    mov     rbx, [r14+0D8h]
    mov     rdi, r13; this
    call    _ZN6Splash16getStrokePatternEv; Splash::getStrokePattern(void)
    mov     rcx, [rax]
    mov     rdi, rax
    call    qword ptr [rcx]
    mov     rdi, rbx; this
    mov     rsi, rax; strokePattern
    call    _ZN6Splash16setStrokePatternEP13SplashPattern; Splash::setStrokePattern(SplashPattern *)
loc_44B61B:
    lea     rdi, [rsp+218h+var_100]; this
    call    _ZNKSt3__110unique_ptrI3GfxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<Gfx>::operator->(void)
    mov     rbx, rax
    mov     rdi, tPat; this
    call    _ZN16GfxTilingPattern16getContentStreamEv; GfxTilingPattern::getContentStream(void)
    mov     rdi, rbx; this
    mov     rsi, rax; obj
    mov     edx, 1; topLevel
    call    _ZN3Gfx7displayEP6Objectb; Gfx::display(Object *,bool)
    mov     rbx, [r14+0D8h]
    test    rbx, rbx
    jz      short loc_44B65F
    mov     rdi, rbx; this
    call    _ZN6SplashD2Ev; Splash::~Splash()
    mov     rdi, rbx; void *
    call    __ZdlPv; operator delete(void *)
loc_44B65F:
    mov     rbx, [rsp+218h+var_1B0]
    mov     [rbx+0D8h], r13
    mov     rax, [rbx+0D0h]
    mov     [rsp+218h+srcData], rax
    mov     eax, [rsp+218h+var_1FC]
    mov     [rsp+218h+var_CC], eax
    mov     rdi, r13; this
    call    _ZN6Splash14getFillPatternEv; Splash::getFillPattern(void)
    mov     [rsp+218h+var_D8], rax
    mov     r8d, [rbx+74h]; srcMode
    mov     [rsp+218h+var_D0], r8d
    mov     [rsp+218h+var_C0], 0
    mov     ecx, dword ptr [rsp+218h+var_1E8]
    mov     [rsp+218h+var_C8], ecx
    mov     edx, dword ptr [rsp+218h+var_1F8]
    mov     [rsp+218h+var_C4], edx
    mov     r14, [rbx+0D0h]
    mov     rax, [rsp+218h+var_E8]
    mov     [rbx+0D0h], rax
    test    r15b, r15b
    jz      loc_44B785
    mov     r12b, 1
    test    edx, edx
    jle     loc_44B7CA
    xor     r15d, r15d
    test    ecx, ecx
    jg      short loc_44B704
loc_44B6F3:
    add     r15d, 1
    cmp     r15d, edx
    jge     loc_44B7CA
    test    ecx, ecx
    jle     short loc_44B6F3
loc_44B704:
    xor     ebx, ebx
    nop     word ptr [rax+rax+00000000h]
loc_44B710:
    movsd   xmm0, [rsp+218h+var_98]
    call    _ZL11splashFloord; splashFloor(double)
    mov     ebp, eax
    mov     rdi, tBitmap; this
    call    _ZN12SplashBitmap8getWidthEv; SplashBitmap::getWidth(void)
    imul    eax, ebx
    lea     r13d, [rax+rbp]
    movsd   xmm0, [rsp+218h+var_90]
    call    _ZL11splashFloord; splashFloor(double)
    mov     ebp, eax
    mov     rdi, tBitmap; this
    call    _ZN12SplashBitmap9getHeightEv; SplashBitmap::getHeight(void)
    imul    eax, r15d
    lea     r8d, [rax+rbp]; yDest
    mov     rax, [rsp+218h+var_1B0]
    mov     rdi, [rax+0D8h]; this
    mov     rsi, tBitmap; src
    mov     edx, 1; srcAlpha
    mov     ecx, r13d; xDest
    call    _ZN6Splash9blitImageEP12SplashBitmapbii; Splash::blitImage(SplashBitmap *,bool,int,int)
    add     ebx, 1
    mov     ecx, [rsp+218h+var_C8]
    cmp     ebx, ecx
    jl      short loc_44B710
    mov     edx, [rsp+218h+var_C4]
    jmp     loc_44B6F3
loc_44B785:
    mov     rdi, [rbx+0D8h]; this
    sub     rsp, 8
    lea     rax, [rsp+220h+var_B8]
    lea     rcx, [rsp+220h+srcData]; srcData
    mov     esi, offset _ZN15SplashOutputDev15tilingBitmapSrcEPvPhS1_; src
    mov     edx, 0; tf_0
    mov     r9d, 1; srcAlpha
    push    1; tilingPattern
    push    0; interpolate
    push    rax; mat
    push    result_height; h
    push    [rsp+240h+var_1C8]; w
    call    _ZN6Splash9drawImageEPFbPvPhS1_EPFvS0_P12SplashBitmapES0_15SplashColorModebiiPdbb; Splash::drawImage(bool (*)(void *,uchar *,uchar *),void (*)(void *,SplashBitmap *),void *,SplashColorMode,bool,int,int,double *,bool,bool)
    add     rsp, 30h
    test    eax, eax
    setz    r12b
loc_44B7CA:
    test    tBitmap, tBitmap
    jz      short loc_44B7DF
    mov     rdi, tBitmap; this
    call    _ZN12SplashBitmapD2Ev; SplashBitmap::~SplashBitmap()
    mov     rdi, tBitmap; void *
    call    __ZdlPv; operator delete(void *)
loc_44B7DF:
    lea     rdi, [rsp+218h+var_100]; this
    call    _ZNSt3__110unique_ptrI3GfxNS_14default_deleteIS1_EEED2Ev; std::unique_ptr<Gfx>::~unique_ptr()
    jmp     loc_44B2BD
SplashOutputDev::tilingPatternFill(GfxState *,Gfx *,Catalog *,GfxTilingPattern *,double const*,int,int,int,int,double,double) endp

