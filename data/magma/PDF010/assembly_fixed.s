SplashOutputDev::type3D1(GfxState *,double,double,double,double,double,double) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 58h
    mov     rax, [this+130h]
    test    rax, rax
    jz      loc_4D3621
    cmp     byte ptr [rax+2], 0
    jnz     loc_4D3621
    mov     byte ptr [rax+2], 1
    cmp     byte ptr [rax+3], 0
    jnz     loc_4D3621
    cmp     qword ptr [rax+20h], 0
    jnz     loc_4D3898
    movsd   [rsp+88h+var_80], xmm2
    movsd   [rsp+88h+var_88], xmm3
    movsd   [rsp+88h+var_60], xmm4
    movsd   [rsp+88h+var_78], xmm5
    cmp     qword ptr [rax+28h], 0
    jnz     loc_4D38A2
    mov     r14, state
    mov     rbx, this
    mov     r13, [rax+8]
    lea     rsi, [rsp+88h+x2]; x2
    lea     rdx, [rsp+88h+y2]; y2
    xorps   xmm0, xmm0; x1
    xorps   xmm1, xmm1; y1
    mov     rdi, state; this
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    lea     r15, [rsp+88h+var_50]
    lea     r12, [rsp+88h+var_58]
    mov     rdi, state; this
    movsd   xmm0, [rsp+88h+var_80]; x1
    movsd   xmm1, [rsp+88h+var_88]; y1
    mov     rsi, r15; x2
    mov     rdx, r12; y2
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+88h+var_50]
    movsd   [rsp+88h+var_68], xmm0
    movsd   xmm0, [rsp+88h+var_58]
    movsd   [rsp+88h+var_70], xmm0
    mov     rdi, state; this
    movsd   xmm0, [rsp+88h+var_80]; x1
    movsd   xmm1, [rsp+88h+var_78]; y1
    mov     rsi, r15; x2
    mov     rdx, r12; y2
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    movsd   xmm2, [rsp+88h+var_68]
    movsd   xmm0, [rsp+88h+var_50]
    ucomisd xmm2, xmm0
    jbe     short loc_4D3457
    movsd   [rsp+88h+var_80], xmm2
    movaps  xmm2, xmm0
    jmp     short loc_4D346B
loc_4D3457:
    ucomisd xmm0, xmm2
    jbe     short loc_4D3465
    movsd   [rsp+88h+var_80], xmm0
    jmp     short loc_4D346B
loc_4D3465:
    movsd   [rsp+88h+var_80], xmm2
loc_4D346B:
    movsd   xmm0, [rsp+88h+var_60]; x1
    movsd   xmm1, [rsp+88h+var_88]; y1
    movsd   xmm4, [rsp+88h+var_70]
    movsd   xMin, [rsp+88h+var_58]
    ucomisd yMax, xMin
    movsd   [rsp+88h+var_68], xt
    jbe     short loc_4D3495
    movsd   [rsp+88h+var_88], xmm3
    jmp     short loc_4D34AD
loc_4D3495:
    ucomisd xmm3, yMax
    jbe     short loc_4D34A8
    movsd   [rsp+88h+var_70], xmm3
    movsd   [rsp+88h+var_88], y1
    jmp     short loc_4D34B3
loc_4D34A8:
    movsd   [rsp+88h+var_88], yMax
loc_4D34AD:
    movsd   [rsp+88h+var_70], y1
loc_4D34B3:
    lea     rsi, [rsp+88h+var_50]; x2
    lea     rdx, [rsp+88h+var_58]; y2
    mov     rdi, state; this
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+88h+var_50]
    movsd   xmm2, [rsp+88h+var_68]
    ucomisd xmm2, xmm0
    jbe     short loc_4D34E2
    movaps  xmm2, xmm0
    movsd   xMax, [rsp+88h+var_78]
    jmp     short loc_4D34F6
loc_4D34E2:
    ucomisd xmm0, [rsp+88h+var_80]
    movsd   xMax, [rsp+88h+var_78]; y1
    jbe     short loc_4D34F6
    movsd   [rsp+88h+var_80], xmm0
loc_4D34F6:
    movsd   xmm0, [rsp+88h+var_60]; x1
    movsd   xmm3, [rsp+88h+var_88]
    movsd   y1, [rsp+88h+var_58]
    ucomisd xMin, xmm4
    movsd   [rsp+88h+var_68], xmm2
    jbe     short loc_4D3526
    movsd   [rsp+88h+var_88], xmm4
    movsd   xmm2, [rsp+88h+var_70]
    movsd   [rsp+88h+var_78], xmm2
    jmp     short loc_4D3540
loc_4D3526:
    movsd   xmm3, [rsp+88h+var_70]
    ucomisd xmm4, xmm3
    jbe     short loc_4D353A
    movsd   [rsp+88h+var_78], xmm4
    jmp     short loc_4D3540
loc_4D353A:
    movsd   [rsp+88h+var_78], xmm3
loc_4D3540:
    lea     rsi, [rsp+88h+var_50]; x2
    lea     rdx, [rsp+88h+var_58]; y2
    mov     rdi, state; this
    call    _ZNK8GfxState9transformEddPdS0_; GfxState::transform(double,double,double *,double *)
    movsd   xmm0, [rsp+88h+var_50]
    movsd   xmm3, [rsp+88h+var_68]
    ucomisd xmm3, xmm0
    jbe     short loc_4D356A
    movapd  xmm3, xmm0
    jmp     short loc_4D3578
loc_4D356A:
    ucomisd xmm0, [rsp+88h+var_80]
    jbe     short loc_4D3578
    movsd   [rsp+88h+var_80], xmm0
loc_4D3578:
    movsd   xmm4, [rsp+88h+var_88]
    movsd   x1, [rsp+88h+var_78]
    movsd   xmm0, [rsp+88h+var_58]
    ucomisd xMin, xmm0
    jbe     short loc_4D3595
    movapd  xMin, xmm0
    jmp     short loc_4D359B
loc_4D3595:
    ucomisd xmm0, yMax
    ja      short loc_4D359F
loc_4D359B:
    movapd  xmm0, yMax
loc_4D359F:
    movsd   yMax, [rsp+88h+x2]
    subsd   xmm3, yMax
    mov     eax, [t3Font+28h]
    xorps   xt, xt
    cvtsi2sd xt, eax
    ucomisd xt, xmm3
    ja      short loc_4D3605
    movsd   xt, [rsp+88h+y2]
    subsd   xmm4, xt
    mov     ecx, [t3Font+2Ch]
    xorps   yt, yt
    cvtsi2sd yt, ecx
    ucomisd yt, xmm4
    ja      short loc_4D3605
    movsd   yt, [rsp+88h+var_80]
    subsd   yt, yMax
    add     eax, [t3Font+30h]
    xorps   yMax, yMax
    cvtsi2sd yMax, eax
    ucomisd yt, yMax
    ja      short loc_4D3605
    subsd   xmm0, xmm2
    add     ecx, [t3Font+34h]
    xorps   xmm1, xmm1
    cvtsi2sd xmm1, ecx
    ucomisd xmm0, xmm1
    jbe     short loc_4D3630
loc_4D3605:
    cmp     byte ptr [t3Font+38h], 0
    jz      short loc_4D3621
    mov     edx, offset aBadBoundingBox; "Bad bounding box in Type 3 glyph"
loc_4D3611:
    xor     edi, edi; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
loc_4D3621:
    add     rsp, 58h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_4D3630:
    mov     rbp, [t3Font+50h]
    test    rbp, rbp
    jz      short loc_4D3621
    mov     r9, [this+130h]
    mov     ecx, [t3Font+44h]
    test    ecx, ecx
    jle     short loc_4D36AF
    movzx   r8d, word ptr [r9]
    movzx   edx, r8w
    mov     edi, [t3Font+40h]
    add     edi, 0FFFFFFFFh
    and     edi, edx
    imul    edi, ecx
    lea     esi, [rcx-1]
    movsxd  i, edi
    lea     rbp, [rbp+rdi*4+0]
    jmp     short loc_4D367E
loc_4D3669:
    add     eax, 1
    mov     [rbp+2], ax
loc_4D3670:
    add     rdi, 1
    add     rbp, 4
    add     rcx, 0FFFFFFFFFFFFFFFFh
    jz      short loc_4D36AF
loc_4D367E:
    movzx   eax, word ptr [rbp+2]
    mov     edx, eax
    and     edx, 7FFFh
    cmp     esi, edx
    jnz     short loc_4D3669
    mov     word ptr [rbp+2], 8000h
    mov     [rbp+0], r8w
    mov     [r9+10h], rbp
    movsxd  rax, dword ptr [t3Font+3Ch]
    imul    rax, rdi
    add     rax, [t3Font+48h]
    mov     [r9+18h], rax
    jmp     short loc_4D3670
loc_4D36AF:
    movups  xmm0, xmmword ptr [this+0D0h]
    movups  xmmword ptr [r9+20h], xmm0
    mov     rdi, state; this
    call    _ZNK8GfxState6getCTMEv; GfxState::getCTM(void)
    mov     rbp, rax
    mov     rax, [rax+20h]
    mov     rcx, [this+130h]
    mov     [rcx+30h], rax
    mov     rax, [ctm+28h]
    mov     [rcx+38h], rax
    mov     r15d, [this+74h]
    mov     edi, 30h ; '0'; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     r12, rax
    mov     esi, [t3Font+30h]; widthA
    mov     edx, [t3Font+34h]; heightA
    test    r15d, r15d
    mov     [rsp+88h+var_68], ctm
    mov     rdi, rax; this
    mov     ecx, 1; rowPadA
    jz      short loc_4D3755
    mov     r8d, 1; modeA
    mov     r9d, 0; alphaA
    push    0; separationListA
    push    1; topDown
    call    _ZN12SplashBitmapC2Eiii15SplashColorModebbPNSt3__16vectorIP23GfxSeparationColorSpaceNS1_9allocatorIS4_EEEE; SplashBitmap::SplashBitmap(int,int,int,SplashColorMode,bool,bool,std::vector<GfxSeparationColorSpace *> *)
    add     rsp, 10h
    mov     [this+0D0h], r12
    mov     edi, 0D0h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbp, rax
    movzx   r15d, byte ptr [this+7Eh]
    mov     rax, [this+130h]
    mov     rdi, [rax+28h]; this
    call    _ZN6Splash9getScreenEv; Splash::getScreen(void)
    mov     rdi, rbp
    mov     rsi, r12
    mov     edx, r15d
    jmp     short loc_4D379A
loc_4D3755:
    mov     r8d, 0; modeA
    mov     r9d, 0; alphaA
    push    0; separationListA
    push    1; topDown
    call    _ZN12SplashBitmapC2Eiii15SplashColorModebbPNSt3__16vectorIP23GfxSeparationColorSpaceNS1_9allocatorIS4_EEEE; SplashBitmap::SplashBitmap(int,int,int,SplashColorMode,bool,bool,std::vector<GfxSeparationColorSpace *> *)
    add     rsp, 10h
    mov     [this+0D0h], r12
    mov     edi, 0D0h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbp, rax
    mov     rax, [this+130h]
    mov     rdi, [rax+28h]; this
    call    _ZN6Splash9getScreenEv; Splash::getScreen(void)
    mov     rdi, rbp; this
    mov     rsi, r12; bitmapA
    xor     edx, edx; vectorAntialiasA
loc_4D379A:
    mov     rcx, rax; screenA
    call    _ZN6SplashC2EP12SplashBitmapbP12SplashScreen; Splash::Splash(SplashBitmap *,bool,SplashScreen *)
    mov     [this+0D8h], rbp
    mov     [rsp+88h+colorA], 0
    lea     rsi, [rsp+88h+colorA]; color
    xor     r15d, r15d
    mov     rdi, rbp; this
    xor     edx, edx; alpha
    call    _ZN6Splash5clearEPhh; Splash::clear(uchar *,uchar)
    mov     [rsp+88h+colorA], 0FFh
    mov     rdi, [this+0D8h]; this
    xorps   xmm0, xmm0
    call    _ZN6Splash15setMinLineWidthEd; Splash::setMinLineWidth(double)
    mov     rdi, [this+0D8h]; this
    xor     esi, esi; thinLineModeA
    call    _ZN6Splash15setThinLineModeE18SplashThinLineMode; Splash::setThinLineMode(SplashThinLineMode)
    mov     r12, [this+0D8h]
    mov     edi, 10h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbp, rax
    mov     rdi, rax; this
    lea     rsi, [rsp+88h+colorA]; colorA
    call    _ZN16SplashSolidColorC2EPh; SplashSolidColor::SplashSolidColor(uchar *)
    mov     rdi, r12; this
    mov     rsi, rbp; fillPattern
    call    _ZN6Splash14setFillPatternEP13SplashPattern; Splash::setFillPattern(SplashPattern *)
    mov     r12, [this+0D8h]
    mov     edi, 10h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbp, rax
    mov     rdi, rax; this
    lea     rsi, [rsp+88h+colorA]; colorA
    call    _ZN16SplashSolidColorC2EPh; SplashSolidColor::SplashSolidColor(uchar *)
    mov     rdi, r12; this
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
    sub     r15d, [t3Font+2Ch]
    cvtsi2sd xmm5, r15d; e
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
    jmp     loc_4D3621
loc_4D3898:
    mov     edx, offset aT3glyphstackOr; "t3GlyphStack origBitmap was not null in"...
    jmp     loc_4D3611
loc_4D38A2:
    mov     edx, offset aT3glyphstackOr_0; "t3GlyphStack origSplash was not null in"...
    jmp     loc_4D3611
SplashOutputDev::type3D1(GfxState *,double,double,double,double,double,double) endp

