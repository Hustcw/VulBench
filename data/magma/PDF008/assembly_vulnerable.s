GfxGouraudTriangleShading::parse(GfxResources *,int,Dict *,Stream *,OutputDev *,GfxState *) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 398h
    mov     r14, gfxState
    mov     r15, out
    mov     [rsp+3C8h+strA], str
    mov     r13, dict
    mov     [rsp+3C8h+var_3BC], esi
    mov     r12, res
    lea     rdi, [rsp+3C8h+var_2D0]; this
    call    _ZNSt3__16vectorINS_10unique_ptrI8FunctionNS_14default_deleteIS2_EEEENS_9allocatorIS5_EEEC2Ev; std::vector<std::unique_ptr<Function>>::vector(void)
    lea     rbx, [rsp+3C8h+funcObj]
    mov     rdi, rbx; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    lea     rbp, [rsp+3C8h+other]
    mov     edx, offset aBitspercoordin; "BitsPerCoordinate"
    mov     rdi, rbp
    mov     rsi, dict; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    mov     rdi, rbx; this
    mov     rsi, rbp; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, rbx; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    jz      loc_414066
    lea     rdi, [rsp+3C8h+funcObj]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    mov     [rsp+3C8h+__lcpp_y], eax
    test    eax, eax
    jle     loc_4149E9
    lea     rbx, [rsp+3C8h+other]
    mov     edx, offset aBitspercompone; "BitsPerComponent"
    mov     rdi, rbx
    mov     rsi, dict; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rbp, [rsp+3C8h+funcObj]
    mov     rdi, rbp; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, rbp; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    jz      loc_414072
    lea     rdi, [rsp+3C8h+funcObj]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    mov     rcx, compBits
    mov     qword ptr [rsp+3C8h+var_310], rax
    add     eax, 0FFFFFFFFh
    cmp     eax, 1Eh
    ja      loc_4149F5
    cmp     [rsp+3C8h+var_3BC], 4
    jnz     short loc_41407E
    lea     rbx, [rsp+3C8h+other]
    xor     eax, eax
    mov     [rsp+3C8h+var_358], rax
    mov     edx, offset aBitsperflag; "BitsPerFlag"
    mov     rdi, rbx
    mov     rsi, dict; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rbp, [rsp+3C8h+funcObj]
    mov     rdi, rbp; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, rbp; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    jz      loc_4143D9
    lea     rdi, [rsp+3C8h+funcObj]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    mov     [rsp+3C8h+n], eax
    jmp     short loc_4140D7
loc_414066:
    xor     ebp, ebp
    mov     edx, offset aMissingOrInval_0; "Missing or invalid BitsPerCoordinate in"...
    jmp     loc_4143E9
loc_414072:
    xor     ebp, ebp
    mov     edx, offset aMissingOrInval_1; "Missing or invalid BitsPerComponent in "...
    jmp     loc_4143E9
loc_41407E:
    lea     rbx, [rsp+3C8h+other]
    mov     [rsp+3C8h+n], 0
    mov     edx, offset aVerticesperrow; "VerticesPerRow"
    mov     rdi, rbx
    mov     rsi, dict; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rbp, [rsp+3C8h+funcObj]
    mov     rdi, rbp; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, rbp; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    jz      loc_4143E2
    lea     rdi, [rsp+3C8h+funcObj]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    mov     [rsp+3C8h+var_358], rax
loc_4140D7:
    lea     rbx, [rsp+3C8h+other]
    mov     edx, offset aDecode; "Decode"
    mov     rdi, rbx
    mov     rsi, dict; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rbp, [rsp+3C8h+funcObj]
    mov     rdi, rbp; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, rbp; this
    call    _ZNK6Object7isArrayEv; Object::isArray(void)
    test    al, al
    jz      loc_4143D0
    lea     rdi, [rsp+3C8h+funcObj]; this
    call    _ZNK6Object14arrayGetLengthEv; Object::arrayGetLength(void)
    cmp     eax, 6
    jl      loc_4143D0
    mov     [rsp+3C8h+var_328], res
    mov     [rsp+3C8h+var_2D8], out
    mov     [rsp+3C8h+var_320], gfxState
    mov     byte ptr [rsp+3C8h+ok], 1
    lea     rbp, [rsp+3C8h+other]
    lea     r12, [rsp+3C8h+funcObj]
    xor     r15d, r15d
    mov     rdi, rbp
    mov     rsi, r12; this
    xor     edx, edx; i
    xor     ecx, ecx; recursion
    call    _ZNK6Object8arrayGetEii; Object::arrayGet(int,int)
    lea     r14, [rsp+3C8h+ok]
    mov     rdi, rbp; this
    mov     rsi, r14; ok
    call    _ZNK6Object6getNumEPb; Object::getNum(bool *)
    movaps  [rsp+3C8h+var_2F8], xmm0
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rbp, [rsp+3C8h+other]
    mov     rdi, rbp
    mov     rsi, r12; this
    mov     edx, 1; i
    xor     ecx, ecx; recursion
    call    _ZNK6Object8arrayGetEii; Object::arrayGet(int,int)
    mov     rdi, rbp; this
    mov     rsi, r14; ok
    call    _ZNK6Object6getNumEPb; Object::getNum(bool *)
    movaps  [rsp+3C8h+var_2E8], xmm0
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    movsd   xmm0, cs:qword_50A5D0
    mov     ebx, [rsp+3C8h+__lcpp_y]
    mov     edi, ebx; __lcpp_y
    call    _Z3powIdiENSt3__19_MetaBaseIXaasr3std13is_arithmeticIT_EE5valuesr3std13is_arithmeticIT0_EE5valueEE13_EnableIfImplINS0_9__promoteIS2_S3_vEEE4typeES2_S3_
    movaps  xmmword ptr [rsp+3C8h+var_388], xmm0
    lea     rbp, [rsp+3C8h+other]
    mov     rdi, rbp
    mov     rsi, r12; this
    mov     edx, 2; i
    xor     ecx, ecx; recursion
    call    _ZNK6Object8arrayGetEii; Object::arrayGet(int,int)
    mov     rdi, rbp; this
    mov     rsi, r14; ok
    call    _ZNK6Object6getNumEPb; Object::getNum(bool *)
    movaps  xmmword ptr [rsp+3C8h+p], xmm0
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rbp, [rsp+3C8h+other]
    mov     rdi, rbp
    mov     rsi, r12; this
    mov     edx, 3; i
    xor     ecx, ecx; recursion
    call    _ZNK6Object8arrayGetEii; Object::arrayGet(int,int)
    mov     rdi, rbp; this
    mov     rsi, r14; ok
    call    _ZNK6Object6getNumEPb; Object::getNum(bool *)
    movaps  [rsp+3C8h+var_348], xmm0
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    movsd   xmm0, cs:qword_50A5D0
    mov     edi, ebx; __lcpp_y
    call    _Z3powIdiENSt3__19_MetaBaseIXaasr3std13is_arithmeticIT_EE5valuesr3std13is_arithmeticIT0_EE5valueEE13_EnableIfImplINS0_9__promoteIS2_S3_vEEE4typeES2_S3_
    movapd  [rsp+3C8h+var_308], xmm0
    mov     rdi, r12; this
    call    _ZNK6Object14arrayGetLengthEv; Object::arrayGetLength(void)
    cmp     eax, 6
    mov     [rsp+3C8h+var_318], dict
    jl      loc_414356
    mov     eax, 0FFFFFFFFh
    mov     rcx, qword ptr [rsp+3C8h+var_310]
    shl     eax, cl
    not     eax
    xorps   xmm0, xmm0
    cvtsi2sd xmm0, rax
    movsd   qword ptr [rsp+3C8h+var_3B8], xmm0
    mov     r14d, 7
    xor     r15d, r15d
    lea     rbp, [rsp+3C8h+var_2B8]
    lea     rbx, [rsp+3C8h+funcObj]
    lea     r12, [rsp+3C8h+ok]
    nop     word ptr [rax+rax+00h]
loc_4142B0:
    lea     r13d, [r14-2]
    lea     edx, [r14-3]; i
    mov     rdi, rbp
    mov     rsi, rbx; this
    xor     ecx, ecx; recursion
    call    _ZNK6Object8arrayGetEii; Object::arrayGet(int,int)
    mov     rdi, rbp; this
    mov     rsi, r12; ok
    call    _ZNK6Object6getNumEPb; Object::getNum(bool *)
    movsd   [rsp+3C8h+var_360], xmm0
    movsd   qword ptr [rsp+i*8+3C8h+other.type], xmm0
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, rbp
    mov     rsi, rbx; this
    mov     edx, r13d; i
    xor     ecx, ecx; recursion
    call    _ZNK6Object8arrayGetEii; Object::arrayGet(int,int)
    mov     rdi, rbp; this
    mov     rsi, r12; ok
    call    _ZNK6Object6getNumEPb; Object::getNum(bool *)
    movsd   [rsp+3C8h+var_370], xmm0
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    movsd   xmm0, [rsp+3C8h+var_370]
    subsd   xmm0, [rsp+3C8h+var_360]
    divsd   xmm0, qword ptr [rsp+3C8h+var_3B8]
    movsd   [rsp+i*8+3C8h+var_138], xmm0
    add     i, 1
    mov     rdi, rbx; this
    call    _ZNK6Object14arrayGetLengthEv; Object::arrayGetLength(void)
    cmp     r15, 1Fh
    ja      short loc_41434E
    cdqe
    cmp     r14, rax
    lea     r14, [r14+2]
    jl      loc_4142B0
loc_41434E:
    mov     r13, [rsp+3C8h+var_318]
loc_414356:
    cmp     byte ptr [rsp+3C8h+ok], 0
    jz      short loc_4143D0
    lea     rbp, [rsp+3C8h+var_2B8]
    xor     eax, eax
    mov     qword ptr [rsp+3C8h+var_3B8], rax
    mov     edx, offset aFunction; "Function"
    mov     rdi, rbp
    mov     rsi, r13; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rbx, [rsp+3C8h+funcObj]
    mov     rdi, rbx; this
    mov     rsi, rbp; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, rbx; this
    call    _ZNK6Object6isNullEv; Object::isNull(void)
    test    al, al
    jnz     loc_4144AF
    lea     rdi, [rsp+3C8h+funcObj]; this
    call    _ZNK6Object7isArrayEv; Object::isArray(void)
    lea     rdi, [rsp+3C8h+funcObj]; funcObj
    test    al, al
    jz      short loc_414425
    call    _ZNK6Object14arrayGetLengthEv; Object::arrayGetLength(void)
    cmp     eax, 20h ; ' '
    jle     loc_414452
    xor     ebp, ebp
    mov     edx, offset aInvalidFunctio; "Invalid Function array in shading dicti"...
    jmp     short loc_4143E9
loc_4143D0:
    xor     ebp, ebp
    mov     edx, offset aMissingOrInval_2; "Missing or invalid Decode array in shad"...
    jmp     short loc_4143E9
loc_4143D9:
    xor     ebp, ebp
    mov     edx, offset aMissingOrInval_3; "Missing or invalid BitsPerFlag in shadi"...
    jmp     short loc_4143E9
loc_4143E2:
    xor     ebp, ebp
    mov     edx, offset aMissingOrInval_4; "Missing or invalid VerticesPerRow in sh"...
loc_4143E9:
    xor     edi, edi; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
loc_4143F9:
    lea     rdi, [rsp+3C8h+funcObj]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+3C8h+var_2D0]; this
    call    _ZNSt3__16vectorINS_10unique_ptrI8FunctionNS_14default_deleteIS2_EEEENS_9allocatorIS5_EEED2Ev; std::vector<std::unique_ptr<Function>>::~vector()
    mov     rax, rbp
    add     rsp, 398h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_414425:
    call    _ZN8Function5parseEP6Object; Function::parse(Object *)
    mov     qword ptr [rsp+3C8h+var_2B8.type], f
    test    f, f
    jz      loc_4149D3
    lea     rdi, [rsp+3C8h+var_2D0]; this
    lea     rsi, [rsp+3C8h+var_2B8]; __args
    call    _ZNSt3__16vectorINS_10unique_ptrI8FunctionNS_14default_deleteIS2_EEEENS_9allocatorIS5_EEE12emplace_backIJRPS2_EEEvDpOT_; std::vector<std::unique_ptr<Function>>::emplace_back<Function*&>(Function*&)
    jmp     short loc_4144AF
loc_414452:
    mov     r12d, eax
    test    eax, eax
    jle     short loc_4144AF
    xor     ebp, ebp
    lea     rbx, [rsp+3C8h+var_2B8]
    lea     r14, [rsp+3C8h+funcObj]
loc_414468:
    mov     rdi, rbx
    mov     rsi, r14; this
    mov     edx, ebp; i
    xor     ecx, ecx; recursion
    call    _ZNK6Object8arrayGetEii; Object::arrayGet(int,int)
    mov     rdi, rbx; funcObj
    call    _ZN8Function5parseEP6Object; Function::parse(Object *)
    mov     [rsp+3C8h+ok], f
    test    f, f
    jz      loc_4149DA
    lea     rdi, [rsp+3C8h+var_2D0]; this
    lea     rsi, [rsp+3C8h+ok]; __args
    call    _ZNSt3__16vectorINS_10unique_ptrI8FunctionNS_14default_deleteIS2_EEEENS_9allocatorIS5_EEE12emplace_backIJRPS2_EEEvDpOT_; std::vector<std::unique_ptr<Function>>::emplace_back<Function*&>(Function*&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    add     ebp, 1
    cmp     r12d, ebp
    jnz     short loc_414468
loc_4144AF:
    movapd  xmm1, [rsp+3C8h+var_2E8]
    unpcklpd xmm1, [rsp+3C8h+var_348]
    movapd  xmm0, [rsp+3C8h+var_2F8]
    unpcklpd xmm0, xmmword ptr [rsp+3C8h+p]
    subpd   xmm1, xmm0
    movapd  xmm0, xmmword ptr [rsp+3C8h+var_388]
    unpcklpd xmm0, [rsp+3C8h+var_308]
    addpd   xmm0, cs:xmmword_50A670
    divpd   xmm1, xmm0
    movapd  [rsp+3C8h+var_2E8], xmm1
    mov     [rsp+3C8h+val], 0
    mov     edi, 10h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     r12, rax
    mov     rdi, rax; this
    mov     rsi, [rsp+3C8h+strA]; strA
    call    _ZN16GfxShadingBitBufC2EP6Stream; GfxShadingBitBuf::GfxShadingBitBuf(Stream *)
    mov     r14d, r15d
    movapd  xmm0, [rsp+3C8h+var_2F8]
    unpcklpd xmm0, xmmword ptr [rsp+3C8h+p]
    movapd  [rsp+3C8h+var_2F8], xmm0
    xor     r13d, r13d
    xor     eax, eax
    mov     [rsp+3C8h+var_388], rax
    xor     eax, eax
    mov     [rsp+3C8h+p], rax
    xor     eax, eax
    mov     [rsp+3C8h+strA], rax
    xor     eax, eax
    mov     [rsp+3C8h+var_360], rax
    xor     eax, eax
    mov     qword ptr [rsp+3C8h+var_308], rax
    xor     eax, eax
loc_414569:
    mov     ecx, [rsp+3C8h+var_3BC]
loc_41456D:
    mov     dword ptr [rsp+3C8h+var_348], eax
loc_414574:
    cmp     ecx, 4
    jnz     short loc_414592
    mov     rdi, bitBuf; this
    mov     esi, [rsp+3C8h+n]; n
    lea     rdx, [rsp+3C8h+val]; val
    call    _ZN16GfxShadingBitBuf7getBitsEiPj; GfxShadingBitBuf::getBits(int,uint *)
    test    al, al
    jz      loc_414870
loc_414592:
    mov     rdi, bitBuf; this
    mov     esi, [rsp+3C8h+__lcpp_y]; n
    lea     rdx, [rsp+3C8h+ok]; val
    call    _ZN16GfxShadingBitBuf7getBitsEiPj; GfxShadingBitBuf::getBits(int,uint *)
    test    al, al
    jz      loc_414870
    mov     rdi, bitBuf; this
    mov     esi, [rsp+3C8h+__lcpp_y]; n
    lea     rdx, [rsp+3C8h+var_34C]; val
    call    _ZN16GfxShadingBitBuf7getBitsEiPj; GfxShadingBitBuf::getBits(int,uint *)
    test    al, al
    jz      loc_414870
    test    r15d, r15d
    jz      short loc_414605
    mov     rbp, r14
    lea     rbx, [rsp+3C8h+var_2B8]
    nop     word ptr [rax+rax+00000000h]
    xchg    ax, ax
loc_4145E0:
    mov     rdi, bitBuf; this
    mov     rsi, qword ptr [rsp+3C8h+var_310]; n
    mov     rdx, rbx; val
    call    _ZN16GfxShadingBitBuf7getBitsEiPj; GfxShadingBitBuf::getBits(int,uint *)
    test    al, al
    jz      loc_414870
    add     rbx, 4
    add     rbp, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_4145E0
loc_414605:
    mov     rdx, nVerticesA
    mov     nVerticesA, [rsp+3C8h+var_360]
    mov     eax, r13d
    mov     rcx, rdx
    mov     [rsp+3C8h+var_370], rdx
    cmp     rdx, rax
    jnz     short loc_414688
    lea     ebx, [r13+r13+0]
    test    r13d, r13d
    mov     eax, 10h
    cmovz   ebx, eax
    mov     rdi, [rsp+3C8h+p]; p
    mov     esi, ebx; count
    mov     edx, 90h; size
    call    _Z23greallocn_checkoverflowPvii; greallocn_checkoverflow(void *,int,int)
    test    rax, rax
    jz      loc_414A01
    mov     rbp, rax
    movsxd  rax, r13d
    lea     rdi, [rax+rax*8]
    shl     rdi, 4
    add     rdi, verticesA; s
    mov     eax, ebx
    sub     eax, r13d
    cdqe
    shl     rax, 4
    lea     rdx, [rax+rax*8]; n
    xor     esi, esi; c
    call    _memset
    mov     rax, verticesA
    mov     [rsp+3C8h+p], verticesA
    mov     rcx, rbp
    mov     eax, ebx
    mov     [rsp+3C8h+var_360], rax
    jmp     short loc_41468D
loc_414688:
    mov     rcx, [rsp+3C8h+strA]
loc_41468D:
    mov     r13, [rsp+3C8h+var_370]
    lea     rax, ds:0[r13*8]
    add     rax, r13
    shl     rax, 4
    movd    xmm0, [rsp+3C8h+var_34C]
    movd    xmm1, dword ptr [rsp+3C8h+ok]
    punpckldq xmm1, xmm0
    movdqa  xmm0, xmm1
    pand    xmm0, cs:xmmword_50A680
    cvtdq2pd xmm0, xmm0
    psrld   xmm1, 10h
    cvtdq2pd xmm1, xmm1
    mulpd   xmm1, cs:xmmword_50A690
    addpd   xmm1, xmm0
    mulpd   xmm1, [rsp+3C8h+var_2E8]
    addpd   xmm1, [rsp+3C8h+var_2F8]; x
    mov     rdx, verticesA
    mov     [rsp+3C8h+strA], rcx
    movupd  xmmword ptr [rcx+rax], xmm1
    test    r15d, r15d
    jz      short loc_414742
    mov     rcx, [rsp+3C8h+strA]
    lea     rbx, [rcx+rax]
    add     rbx, 10h
    xor     ebp, ebp
    nop     dword ptr [rax+00000000h]
loc_414710:
    mov     eax, [rsp+i*4+3C8h+var_2B8.type]
    xorps   xmm0, xmm0
    cvtsi2sd xmm0, rax
    mulsd   xmm0, [rsp+i*8+3C8h+var_138]
    addsd   xmm0, qword ptr [rsp+i*8+3C8h+other.type]
    call    _ZL8dblToCold; dblToCol(double)
    mov     [rbx+i*4], eax
    add     i, 1
    cmp     r14, rbp
    jnz     short loc_414710
loc_414742:
    add     r13, 1
    mov     rdi, bitBuf; this
    call    _ZN16GfxShadingBitBuf9flushBitsEv; GfxShadingBitBuf::flushBits(void)
    mov     ecx, [rsp+3C8h+var_3BC]
    cmp     ecx, 4
    jnz     loc_414574
    mov     eax, dword ptr [rsp+3C8h+var_348]
    cmp     eax, 1
    ja      short loc_41476F
    add     eax, 1
    jmp     loc_41456D
loc_41476F:
    mov     ebp, [rsp+3C8h+val]
    cmp     eax, 2
    jz      short loc_414785
    mov     eax, 1
    test    ebp, ebp
    jz      loc_41456D
loc_414785:
    mov     rax, qword ptr [rsp+3C8h+var_308]
    cmp     [rsp+3C8h+var_3B8], eax
    jnz     short loc_4147CC
    mov     rax, qword ptr [rsp+3C8h+var_3B8]
    lea     ecx, [rax+rax]
    test    eax, eax
    mov     eax, 10h
    cmovz   ecx, eax
    mov     qword ptr [rsp+3C8h+var_308], triSize
    lea     esi, [rcx+rcx*2]; count
    mov     rdi, [rsp+3C8h+var_388]; p
    mov     edx, 4; size
    xor     ecx, ecx; checkoverflow
    mov     r8d, 1; free_p
    call    _Z9greallocnPviibb; greallocn(void *,int,int,bool,bool)
    mov     [rsp+3C8h+var_388], rax
loc_4147CC:
    cmp     dword ptr [rsp+3C8h+var_348], 2
    jz      short loc_4147FA
    mov     rdx, qword ptr [rsp+3C8h+var_3B8]
    lea     eax, [rdx-1]
    movsxd  rcx, eax
    mov     eax, edx
    lea     rcx, [rcx+rcx*2]
    cmp     ebp, 1
    jnz     short loc_41482B
    mov     rdx, [rsp+3C8h+var_388]
    mov     rdi, rdx
    mov     edx, [rdx+rcx*4+4]
    jmp     short loc_414836
loc_4147FA:
    mov     eax, [rsp+3C8h+var_3B8]
    lea     rcx, [rax+rax*2]
    mov     rdx, [rsp+3C8h+var_370]
    mov     rdi, rdx
    add     edx, 0FFFFFFFEh
    mov     rsi, [rsp+3C8h+var_388]
    mov     [rsi+rcx*4], edx
    mov     edx, edi
    add     edx, 0FFFFFFFFh
    mov     [rsi+rcx*4+4], edx
    mov     dword ptr [rsp+3C8h+var_348], 3
    jmp     short loc_414845
loc_41482B:
    mov     rdx, [rsp+3C8h+var_388]
    mov     rdi, rdx
    mov     edx, [rdx+rcx*4]
loc_414836:
    lea     rsi, [rax+rax*2]
    mov     [rdi+rsi*4], edx
    mov     ecx, [rdi+rcx*4+8]
    mov     [rdi+rsi*4+4], ecx
loc_414845:
    lea     rax, [rax+rax*2]
    mov     rcx, [rsp+3C8h+var_388]
    mov     rdx, [rsp+3C8h+var_370]
    mov     [rcx+rax*4+8], edx
    mov     rax, qword ptr [rsp+3C8h+var_3B8]
    add     eax, 1
    mov     qword ptr [rsp+3C8h+var_3B8], rax
    mov     eax, dword ptr [rsp+3C8h+var_348]
    jmp     loc_414569
loc_414870:
    mov     rdi, bitBuf; this
    call    _ZN16GfxShadingBitBufD2Ev; GfxShadingBitBuf::~GfxShadingBitBuf()
    mov     rdi, bitBuf; void *
    call    __ZdlPv; operator delete(void *)
    cmp     [rsp+3C8h+var_3BC], 5
    jnz     loc_414955
    test    r13d, r13d
    mov     nComps, [rsp+3C8h+var_320]
    mov     bitBuf, [rsp+3C8h+var_328]
    jz      loc_414965
    mov     eax, r13d
    cdq
    mov     rcx, [rsp+3C8h+var_358]
    idiv    ecx
    mov     r14d, eax
    add     r14d, 0FFFFFFFFh
    lea     ebp, [rcx-1]
    mov     eax, r14d
    imul    eax, ebp
    add     eax, eax
    mov     qword ptr [rsp+3C8h+var_3B8], nTrianglesA
    lea     edi, [rax+rax*2]; count
    mov     esi, 4; size
    call    _Z22gmallocn_checkoverflowii; gmallocn_checkoverflow(int,int)
    test    trianglesA, trianglesA
    jz      loc_414A37
    test    r14d, r14d
    mov     [rsp+3C8h+var_388], trianglesA
    jle     short loc_414965
    mov     r8, trianglesA
    add     r8, 14h
    xor     ecx, ecx
    xor     edx, edx
    mov     r9, [rsp+3C8h+var_358]
    test    ebp, ebp
    jg      short loc_414906
loc_4148FA:
    add     edx, 1
loc_4148FD:
    cmp     edx, r14d
    jz      short loc_414965
    test    ebp, ebp
    jle     short loc_4148FA
loc_414906:
    movsxd  trianglesA, ecx
    lea     rax, [rax+rax*2]
    lea     rsi, [r8+rax*4]
    mov     edi, r9d
    imul    edi, edx
    add     edx, 1
    mov     eax, r9d
    imul    eax, edx
    mov     ebx, ebp
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+00h]
loc_414930:
    mov     [rsi-14h], edi
    add     edi, 1
    mov     [rsi-10h], edi
    mov     [rsi-0Ch], eax
    mov     [rsi-8], edi
    mov     [rsi-4], eax
    add     eax, 1
    mov     [rsi], eax
    add     rsi, 18h
    add     ecx, 2
    add     ebx, 0FFFFFFFFh
    jnz     short loc_414930
    jmp     short loc_4148FD
loc_414955:
    mov     nComps, [rsp+3C8h+var_320]
    mov     bitBuf, [rsp+3C8h+var_328]
loc_414965:
    mov     edi, 0F0h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     rbp, rax
    lea     rdi, [rsp+3C8h+var_2D0]; __t
    call    _ZNSt3__14moveIRNS_6vectorINS_10unique_ptrI8FunctionNS_14default_deleteIS3_EEEENS_9allocatorIS6_EEEEEEONS_16remove_referenceIT_E4typeEOSC_; std::move<std::vector<std::unique_ptr<Function>> &>(std::vector<std::unique_ptr<Function>> &&&)
    mov     [rsp+3C8h+funcsA], rax; funcsA
    mov     rdi, shading; this
    mov     esi, [rsp+3C8h+var_3BC]; typeA
    mov     rdx, [rsp+3C8h+strA]; verticesA
    mov     ecx, r13d; nVerticesA
    mov     r8, [rsp+3C8h+var_388]; trianglesA
    mov     r9, qword ptr [rsp+3C8h+var_3B8]; nTrianglesA
    call    _ZN25GfxGouraudTriangleShadingC2EiP16GfxGouraudVertexiPA3_iiONSt3__16vectorINS4_10unique_ptrI8FunctionNS4_14default_deleteIS7_EEEENS4_9allocatorISA_EEEE; GfxGouraudTriangleShading::GfxGouraudTriangleShading(int,GfxGouraudVertex *,int,int (*)[3],int,std::vector<std::unique_ptr<Function>> &&)
    mov     rax, [shading+0]
    mov     rdi, shading
    mov     rsi, r12
    mov     rdx, [rsp+3C8h+var_318]
    mov     rcx, [rsp+3C8h+var_2D8]
    mov     r8, r15
    call    qword ptr [rax+18h]
    test    al, al
    jnz     loc_4143F9
    mov     rax, [shading+0]
    mov     rdi, shading
    call    qword ptr [rax+8]
loc_4149D3:
    xor     ebp, ebp
    jmp     loc_4143F9
loc_4149DA:
    lea     rdi, [rsp+3C8h+var_2B8]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    jmp     short loc_4149D3
loc_4149E9:
    xor     ebp, ebp
    mov     edx, offset aInvalidBitsper; "Invalid BitsPerCoordinate in shading di"...
    jmp     loc_4143E9
loc_4149F5:
    xor     ebp, ebp
    mov     edx, offset aInvalidBitsper_0; "Invalid BitsPerComponent in shading dic"...
    jmp     loc_4143E9
loc_414A01:
    xor     ebp, ebp
    mov     edx, offset aGfxgouraudtria; "GfxGouraudTriangleShading::parse: verti"...
    xor     edi, edi; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    mov     rdi, [rsp+3C8h+var_388]; p
    call    _Z5gfreePv; gfree(void *)
    mov     rdi, bitBuf; this
    call    _ZN16GfxShadingBitBufD2Ev; GfxShadingBitBuf::~GfxShadingBitBuf()
    mov     rdi, bitBuf; void *
    call    __ZdlPv; operator delete(void *)
    jmp     loc_4143F9
loc_414A37:
    mov     rdi, [rsp+3C8h+p]; p
    call    _Z5gfreePv; gfree(void *)
    jmp     short loc_4149D3
GfxGouraudTriangleShading::parse(GfxResources *,int,Dict *,Stream *,OutputDev *,GfxState *) endp

