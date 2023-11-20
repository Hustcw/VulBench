SplashOutputDev::type3D1(GfxState *,double,double,double,double,double,double) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 58h
    mov     rax, [this+130h]
    cmp     byte ptr [rax+2], 0
    jnz     loc_445A4D
    mov     byte ptr [rax+2], 1
    cmp     byte ptr [rax+3], 0
    jnz     loc_445A4D
    cmp     qword ptr [rax+20h], 0
    jnz     loc_445CC5
    movsd   [rsp+88h+var_80], xmm2
    movsd   [rsp+88h+var_88], xmm3
    movsd   [rsp+88h+var_60], xmm4
    movsd   [rsp+88h+var_78], xmm5
    cmp     qword ptr [rax+28h], 0
    jnz     loc_445CCF
    mov     r14, state
    mov     r15, this
    mov     r12, [rax+8]
    lea     rsi, [rsp+88h+x2]; x2
    lea     rdx, [rsp+88h+y2]; y2
    xorps   xmm0, xmm0; x1
    xorps   xmm1, xmm1; y1
    mov     rdi, state; this
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    lea     rbx, [rsp+88h+var_50]
    lea     rbp, [rsp+88h+var_58]
    mov     rdi, state; this
    movsd   xmm0, [rsp+88h+var_80]; x1
    movsd   xmm1, [rsp+88h+var_88]; y1
    mov     rsi, rbx; x2
    mov     rdx, rbp; y2
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+88h+var_50]
    movsd   [rsp+88h+var_68], xmm0
    movsd   xmm0, [rsp+88h+var_58]
    movsd   [rsp+88h+var_70], xmm0
    mov     rdi, state; this
    movsd   xmm0, [rsp+88h+var_80]; x1
    movsd   xmm1, [rsp+88h+var_78]; y1
    mov     rsi, rbx; x2
    mov     rdx, rbp; y2
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    movsd   xmm2, [rsp+88h+var_68]
    movsd   xmm0, [rsp+88h+var_50]
    ucomisd xmm2, xmm0
    jbe     short loc_44587E
    movsd   [rsp+88h+var_80], xmm2
    movaps  xmm2, xmm0
    jmp     short loc_445892
loc_44587E:
    ucomisd xmm0, xmm2
    jbe     short loc_44588C
    movsd   [rsp+88h+var_80], xmm0
    jmp     short loc_445892
loc_44588C:
    movsd   [rsp+88h+var_80], xmm2
loc_445892:
    movsd   xmm0, [rsp+88h+var_60]; x1
    movsd   xmm1, [rsp+88h+var_88]; y1
    movsd   xmm4, [rsp+88h+var_70]
    movsd   xMin, [rsp+88h+var_58]
    ucomisd yMax, xMin
    movsd   [rsp+88h+var_68], xt
    jbe     short loc_4458BC
    movsd   [rsp+88h+var_88], xmm3
    jmp     short loc_4458D4
loc_4458BC:
    ucomisd xmm3, yMax
    jbe     short loc_4458CF
    movsd   [rsp+88h+var_70], xmm3
    movsd   [rsp+88h+var_88], y1
    jmp     short loc_4458DA
loc_4458CF:
    movsd   [rsp+88h+var_88], yMax
loc_4458D4:
    movsd   [rsp+88h+var_70], y1
loc_4458DA:
    lea     rsi, [rsp+88h+var_50]; x2
    lea     rdx, [rsp+88h+var_58]; y2
    mov     rdi, state; this
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+88h+var_50]
    movsd   xmm2, [rsp+88h+var_68]
    ucomisd xmm2, xmm0
    jbe     short loc_445909
    movaps  xmm2, xmm0
    movsd   xMax, [rsp+88h+var_78]
    jmp     short loc_44591D
loc_445909:
    ucomisd xmm0, [rsp+88h+var_80]
    movsd   xMax, [rsp+88h+var_78]; y1
    jbe     short loc_44591D
    movsd   [rsp+88h+var_80], xmm0
loc_44591D:
    movsd   xmm0, [rsp+88h+var_60]; x1
    movsd   xmm3, [rsp+88h+var_88]
    movsd   y1, [rsp+88h+var_58]
    ucomisd xMin, xmm4
    movsd   [rsp+88h+var_68], xmm2
    jbe     short loc_44594D
    movsd   [rsp+88h+var_88], xmm4
    movsd   xmm2, [rsp+88h+var_70]
    movsd   [rsp+88h+var_78], xmm2
    jmp     short loc_445967
loc_44594D:
    movsd   xmm3, [rsp+88h+var_70]
    ucomisd xmm4, xmm3
    jbe     short loc_445961
    movsd   [rsp+88h+var_78], xmm4
    jmp     short loc_445967
loc_445961:
    movsd   [rsp+88h+var_78], xmm3
loc_445967:
    lea     rsi, [rsp+88h+var_50]; x2
    lea     rdx, [rsp+88h+var_58]; y2
    mov     rdi, state; this
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+88h+var_50]
    movsd   xmm3, [rsp+88h+var_68]
    ucomisd xmm3, xmm0
    jbe     short loc_445991
    movapd  xmm3, xmm0
    jmp     short loc_44599F
loc_445991:
    ucomisd xmm0, [rsp+88h+var_80]
    jbe     short loc_44599F
    movsd   [rsp+88h+var_80], xmm0
loc_44599F:
    movsd   xmm4, [rsp+88h+var_88]
    movsd   x1, [rsp+88h+var_78]
    movsd   xmm0, [rsp+88h+var_58]
    ucomisd xMin, xmm0
    jbe     short loc_4459BC
    movapd  xMin, xmm0
    jmp     short loc_4459C2
loc_4459BC:
    ucomisd xmm0, yMax
    ja      short loc_4459C6
loc_4459C2:
    movapd  xmm0, yMax
loc_4459C6:
    movsd   yMax, [rsp+88h+x2]
    subsd   xmm3, yMax
    mov     eax, [t3Font+28h]
    xorps   xt, xt
    cvtsi2sd xt, eax
    ucomisd xt, xmm3
    ja      short loc_445A30
    movsd   xt, [rsp+88h+y2]
    subsd   xmm4, xt
    mov     ecx, [t3Font+2Ch]
    xorps   yt, yt
    cvtsi2sd yt, ecx
    ucomisd yt, xmm4
    ja      short loc_445A30
    movsd   yt, [rsp+88h+var_80]
    subsd   yt, yMax
    add     eax, [t3Font+30h]
    xorps   yMax, yMax
    cvtsi2sd yMax, eax
    ucomisd yt, yMax
    ja      short loc_445A30
    subsd   xmm0, xmm2
    add     ecx, [t3Font+34h]
    xorps   xmm1, xmm1
    cvtsi2sd xmm1, ecx
    ucomisd xmm0, xmm1
    jbe     short loc_445A5C
loc_445A30:
    cmp     byte ptr [t3Font+38h], 0
    jz      short loc_445A4D
    mov     edx, offset aBadBoundingBox; "Bad bounding box in Type 3 glyph"
loc_445A3D:
    xor     edi, edi; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
loc_445A4D:
    add     rsp, 58h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_445A5C:
    mov     rbp, [t3Font+50h]
    test    rbp, rbp
    jz      short loc_445A4D
    mov     rax, [this+130h]
    mov     ecx, [t3Font+44h]
    test    ecx, ecx
    jle     short loc_445AE0
    movzx   r8d, word ptr [rax]
    movzx   esi, r8w
    mov     edi, [t3Font+40h]
    add     edi, 0FFFFFFFFh
    and     edi, esi
    imul    edi, ecx
    lea     esi, [rcx-1]
    movsxd  i, edi
    lea     rbp, [rbp+rdi*4+0]
    jmp     short loc_445AAD
loc_445A98:
    add     edx, 1
    mov     [rbp+2], dx
loc_445A9F:
    add     rdi, 1
    add     rbp, 4
    add     rcx, 0FFFFFFFFFFFFFFFFh
    jz      short loc_445AE0
loc_445AAD:
    movzx   edx, word ptr [rbp+2]
    mov     ebx, edx
    and     ebx, 7FFFh
    cmp     esi, ebx
    jnz     short loc_445A98
    mov     word ptr [rbp+2], 8000h
    mov     [rbp+0], r8w
    mov     [rax+10h], rbp
    movsxd  rdx, dword ptr [t3Font+3Ch]
    imul    rdx, rdi
    add     rdx, [t3Font+48h]
    mov     [rax+18h], rdx
    jmp     short loc_445A9F
loc_445AE0:
    movups  xmm0, xmmword ptr [this+0D0h]
    movups  xmmword ptr [rax+20h], xmm0
    mov     rdi, state; this
    call    _ZNK8GfxState6getCTMEv; GfxState::getCTM(void)
    mov     rdx, [ctm+20h]
    mov     rcx, [this+130h]
    mov     [rcx+30h], rdx
    mov     [rsp+88h+var_68], ctm
    mov     rax, [rax+28h]
    mov     [rcx+38h], rax
    mov     ebp, [this+74h]
    mov     edi, 30h ; '0'; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbx, rax
    mov     esi, [t3Font+30h]; widthA
    mov     edx, [t3Font+34h]; heightA
    mov     rdi, rax; this
    mov     ecx, 1; rowPadA
    test    ebp, ebp
    jz      short loc_445B83
    mov     r8d, 1; modeA
    mov     r9d, 0; alphaA
    push    0; separationListA
    push    1; topDown
    call    _ZN12SplashBitmapC2Eiii15SplashColorModebbPNSt3__16vectorIP23GfxSeparationColorSpaceNS1_9allocatorIS4_EEEE; SplashBitmap::SplashBitmap(int,int,int,SplashColorMode,bool,bool,std::vector<GfxSeparationColorSpace *> *)
    add     rsp, 10h
    mov     [this+0D0h], rbx
    mov     edi, 0D0h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     r13, rax
    movzx   ebp, byte ptr [this+7Eh]
    mov     rax, [this+130h]
    mov     rdi, [rax+28h]; this
    call    _ZN6Splash9getScreenEv; Splash::getScreen(void)
    mov     rdi, r13
    mov     rsi, rbx
    mov     edx, ebp
    jmp     short loc_445BC8
loc_445B83:
    mov     r8d, 0; modeA
    mov     r9d, 0; alphaA
    push    0; separationListA
    push    1; topDown
    call    _ZN12SplashBitmapC2Eiii15SplashColorModebbPNSt3__16vectorIP23GfxSeparationColorSpaceNS1_9allocatorIS4_EEEE; SplashBitmap::SplashBitmap(int,int,int,SplashColorMode,bool,bool,std::vector<GfxSeparationColorSpace *> *)
    add     rsp, 10h
    mov     [this+0D0h], rbx
    mov     edi, 0D0h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     r13, rax
    mov     rax, [this+130h]
    mov     rdi, [rax+28h]; this
    call    _ZN6Splash9getScreenEv; Splash::getScreen(void)
    mov     rdi, r13; this
    mov     rsi, rbx; bitmapA
    xor     edx, edx; vectorAntialiasA
loc_445BC8:
    mov     rcx, rax; screenA
    call    _ZN6SplashC2EP12SplashBitmapbP12SplashScreen; Splash::Splash(SplashBitmap *,bool,SplashScreen *)
    mov     [this+0D8h], r13
    mov     [rsp+88h+colorA], 0
    lea     rsi, [rsp+88h+colorA]; color
    mov     rdi, r13; this
    mov     r13, rsi
    xor     edx, edx; alpha
    call    _ZN6Splash5clearEPhh; Splash::clear(uchar *,uchar)
    mov     [rsp+88h+colorA], 0FFh
    mov     rdi, [this+0D8h]; this
    xorps   xmm0, xmm0
    call    _ZN6Splash15setMinLineWidthEd; Splash::setMinLineWidth(double)
    mov     rdi, [this+0D8h]; this
    xor     esi, esi; thinLineModeA
    call    _ZN6Splash15setThinLineModeE18SplashThinLineMode; Splash::setThinLineMode(SplashThinLineMode)
    mov     rbp, [this+0D8h]
    mov     edi, 10h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbx, rax
    mov     rdi, rax; this
    mov     rsi, r13; colorA
    call    _ZN16SplashSolidColorC2EPh; SplashSolidColor::SplashSolidColor(uchar *)
    mov     rdi, rbp; this
    mov     rsi, rbx; fillPattern
    call    _ZN6Splash14setFillPatternEP13SplashPattern; Splash::setFillPattern(SplashPattern *)
    mov     rbx, [this+0D8h]
    mov     edi, 10h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbp, rax
    mov     rdi, rax; this
    mov     rsi, r13; colorA
    call    _ZN16SplashSolidColorC2EPh; SplashSolidColor::SplashSolidColor(uchar *)
    mov     rdi, rbx; this
    mov     rsi, rbp; strokePattern
    call    _ZN6Splash16setStrokePatternEP13SplashPattern; Splash::setStrokePattern(SplashPattern *)
    mov     rax, [rsp+88h+var_68]
    movsd   xmm0, qword ptr [rax]
    movsd   xmm1, qword ptr [rax+8]; a
    movsd   xmm2, qword ptr [rax+10h]; b
    movsd   xmm3, qword ptr [rax+18h]; c
    xor     eax, eax
    sub     eax, [t3Font+28h]
    cvtsi2sd xmm4, eax; d
    xor     eax, eax
    sub     eax, [t3Font+2Ch]
    cvtsi2sd xmm5, eax; e
    mov     rdi, state; this
    call    _ZN8GfxState6setCTMEdddddd; GfxState::setCTM(double,double,double,double,double,double)
    mov     rax, [this]
    xorpd   xmm0, xmm0
    xorpd   xmm1, xmm1
    xorpd   xmm2, xmm2
    xorpd   xmm3, xmm3
    xorpd   xmm4, xmm4
    xorps   xmm5, xmm5
    mov     rdi, this
    mov     rsi, state
    call    qword ptr [rax+0B8h]
    jmp     loc_445A4D
loc_445CC5:
    mov     edx, offset aT3glyphstackOr; "t3GlyphStack origBitmap was not null in"...
    jmp     loc_445A3D
loc_445CCF:
    mov     edx, offset aT3glyphstackOr_0; "t3GlyphStack origSplash was not null in"...
    jmp     loc_445A3D
SplashOutputDev::type3D1(GfxState *,double,double,double,double,double,double) endp

