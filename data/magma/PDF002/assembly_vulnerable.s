Stream::toUnsignedChars(int *,int,int) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r15d, ecx
    mov     ebp, edx
    mov     r14, length
    mov     r12, this
    movsxd  rbx, edx
    mov     rdi, rbx; size
    xor     esi, esi; checkoverflow
    call    _Z7gmallocmb; gmalloc(ulong,bool)
    mov     r13, rax
    mov     dword ptr [length], 0
    mov     rax, [this]
    mov     rdi, this
    call    qword ptr [rax+18h]
    movsxd  rdx, dword ptr [length]
    add     rdx, buf; buffer
    mov     rdi, this; this
    mov     esi, ebx; nChars
    call    _ZN6Stream10doGetCharsEiPh; Stream::doGetChars(int,uchar *)
    test    eax, eax
    jz      short loc_45D894
    lea     ebx, [sizeIncrement+charsToRead]
    nop
loc_45D850:
    add     [length], eax
    cmp     eax, ebp
    jnz     short loc_45D894
    mov     readChars, [this]
    mov     rdi, this
    call    qword ptr [rax+30h]
    cmp     eax, 0FFFFFFFFh
    jz      short loc_45D894
    movsxd  rbx, ebx
    mov     rdi, buf; p
    mov     rsi, rbx; size
    xor     edx, edx; checkoverflow
    call    _Z8greallocPvmb; grealloc(void *,ulong,bool)
    mov     buf, rax
    movsxd  rdx, dword ptr [length]
    add     rdx, rax; buffer
    mov     rdi, this; this
    mov     esi, r15d; nChars
    call    _ZN6Stream10doGetCharsEiPh; Stream::doGetChars(int,uchar *)
    add     ebx, r15d
    mov     ebp, r15d
    test    eax, eax
    jnz     short loc_45D850
loc_45D894:
    mov     rax, buf
    add     rsp, 8
    pop     rbx
    pop     this
    pop     buf
    pop     length
    pop     sizeIncrement
    pop     rbp
    retn
Stream::toUnsignedChars(int *,int,int) endp



JPXStream::init(void) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 68h
    mov     rbx, this
    lea     rdi, [rsp+98h+var_48]; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    lea     rdi, [rsp+98h+var_68]; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    lea     rdi, [rsp+98h+var_58]; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    mov     rax, [this]
    mov     rdi, this
    call    qword ptr [rax+98h]
    test    rax, rax
    jz      loc_45D04C
    mov     rax, [this]
    mov     rdi, this
    call    qword ptr [rax+98h]
    lea     rbp, [rsp+98h+other]
    mov     edx, offset aLength; "Length"
    mov     rdi, rbp
    mov     rsi, rax; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rdi, [rsp+98h+var_48]; this
    mov     rsi, rbp; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rax, [this]
    mov     rdi, this
    call    qword ptr [rax+98h]
    lea     rbp, [rsp+98h+other]
    mov     edx, (offset state.px1+7); key
    mov     rdi, rbp
    mov     rsi, rax; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rdi, [rsp+98h+var_68]; this
    mov     rsi, rbp; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rax, [this]
    mov     rdi, this
    call    qword ptr [rax+98h]
    lea     rbp, [rsp+98h+other]
    mov     edx, offset aSmaskindata; "SMaskInData"
    mov     rdi, rbp
    mov     rsi, rax; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rdi, [rsp+98h+var_58]; this
    mov     rsi, rbp; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
loc_45D04C:
    lea     rdi, [rsp+98h+var_48]; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    mov     ebp, 1000h
    test    al, al
    jz      short loc_45D06B
    lea     rdi, [rsp+98h+var_48]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    mov     ebp, eax
loc_45D06B:
    lea     rdi, [rsp+98h+var_68]; this
    call    _ZNK6Object7isArrayEv; Object::isArray(void)
    test    al, al
    jz      short loc_45D0B7
    lea     rdi, [rsp+98h+var_68]; this
    call    _ZNK6Object14arrayGetLengthEv; Object::arrayGetLength(void)
    test    eax, eax
    jle     short loc_45D0B7
    lea     r15, [rsp+98h+other]
    lea     rsi, [rsp+98h+var_68]; this
    mov     rdi, r15
    xor     edx, edx; i
    xor     ecx, ecx; recursion
    call    _ZNK6Object8arrayGetEii; Object::arrayGet(int,int)
    mov     esi, (offset state.ctm+0Ch); nameA
    mov     rdi, r15; this
    call    _ZNK6Object6isNameEPKc; Object::isName(char const*)
    mov     r14d, eax
    mov     rdi, r15; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    jmp     short loc_45D0BA
loc_45D0B7:
    xor     r14d, r14d
loc_45D0BA:
    mov     rax, [this+18h]
    mov     dword ptr [rax+1Ch], 0
    lea     rdi, [rsp+98h+var_58]; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    jz      short loc_45D0E4
    lea     rdi, [rsp+98h+var_58]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    mov     rcx, [this+18h]
    mov     [rcx+1Ch], eax
loc_45D0E4:
    mov     [rsp+98h+other.type], 0
    mov     rdi, [this+10h]; this
    lea     rsi, [rsp+98h+other]; length
    mov     edx, ebp; initialSize
    mov     ecx, 1000h; sizeIncrement
    call    _ZN6Stream15toUnsignedCharsEPiii; Stream::toUnsignedChars(int *,int,int)
    mov     bufSize, rax
    mov     rdi, [this+18h]; this
    mov     ecx, [rsp+98h+other.type]; length
    movzx   r14d, r14b
    mov     esi, 2; format
    mov     rdx, rax; buf
    mov     r8d, r14d; indexed
    call    _ZN16JPXStreamPrivate5init2E12CODEC_FORMATPhib; JPXStreamPrivate::init2(CODEC_FORMAT,uchar *,int,bool)
    mov     rdi, buf; p
    call    _Z5gfreePv; gfree(void *)
    mov     rax, [this+18h]
    mov     rcx, [rax]
    test    rcx, rcx
    jz      loc_45D2C7
    mov     edx, [rcx+10h]
    mov     esi, [rcx+14h]
    mov     edi, edx
    xor     edi, 4
    or      esi, 2
    xor     esi, 3
    or      esi, edi
    setz    dil
    mov     rcx, [rcx+18h]
    mov     esi, [rcx+0Ch]
    imul    esi, [rcx+8]
    mov     [rax+10h], esi
    mov     [rax+14h], edx
    cmp     edx, 2
    jz      short loc_45D16F
    test    dil, dil
    jnz     short loc_45D16F
    cmp     edx, 5
    jl      short loc_45D17B
loc_45D16F:
    cmp     dword ptr [rax+1Ch], 0
    jnz     short loc_45D17B
    add     edx, 0FFFFFFFFh
    mov     [rax+14h], edx
loc_45D17B:
    test    edx, edx
    jle     loc_45D2CE
    mov     dword ptr [rsp+98h+indexed], r14d
    mov     [rsp+98h+var_98], this
    mov     buf, [rcx+30h]
    test    rbp, rbp
    jz      loc_45D2B4
    xor     r13d, r13d
    nop     dword ptr [rax+00h]
loc_45D1A0:
    mov     [rsp+98h+var_38], component
    shl     r13, 6
    mov     r8d, [rcx+r13+18h]
    lea     esi, [depth-8]
    cmp     r8d, 8
    mov     edx, 0
    cmovbe  esi, edx; adjust
    cmp     dword ptr [rcx+r13+20h], 0
    mov     ebx, 0
    jz      short loc_45D1D8
    mov     cl, [rcx+18h]
    add     cl, 0FFh
    mov     ebx, 1
    shl     ebx, cl
loc_45D1D8:
    cmp     dword ptr [rax+10h], 0
    mov     r14, [rsp+98h+var_98]
    mov     r15d, dword ptr [rsp+98h+indexed]
    jle     loc_45D286
    mov     [rsp+98h+var_78], r13
    mov     edi, [rbp+0]; r
    mov     [rsp+98h+var_70], rbp
    mov     edx, r8d; depth
    mov     ecx, ebx; sgndcorr
    mov     rbp, depth
    mov     r8d, r15d; indexed
    mov     r13d, esi
    call    _ZL10adjustCompiiiib; adjustComp(int,int,int,int,bool)
    mov     rcx, [rsp+98h+var_70]
    mov     [rcx], al
    mov     rax, [oLen+18h]
    cmp     dword ptr [rax+10h], 2
    jl      short loc_45D286
    mov     r12d, r15d
    mov     r15d, 1
    mov     oLen, [rsp+98h+var_98]
    mov     rdx, rbp; depth
    mov     rdi, [rsp+98h+var_78]
    mov     esi, r13d; adjust
    mov     ecx, ebx; sgndcorr
    nop     word ptr [rax+rax+00000000h]
loc_45D240:
    mov     rax, [rax]
    mov     rax, [rax+18h]
    mov     rax, [rax+rdi+30h]
    mov     edi, [rax+i*4]; r
    mov     r13, rdx
    mov     r8d, r12d; indexed
    mov     ebx, esi
    mov     ebp, ecx
    call    _ZL10adjustCompiiiib; adjustComp(int,int,int,int,bool)
    mov     ecx, ebp
    mov     esi, ebx
    mov     rdi, [rsp+98h+var_78]
    mov     rdx, r13
    mov     rbp, [rsp+98h+var_70]
    mov     [rbp+i+0], al
    add     i, 1
    mov     rax, [cspace+18h]
    movsxd  rbp, dword ptr [rax+10h]
    cmp     r15, rbp
    jl      short loc_45D240
loc_45D286:
    mov     r13, [rsp+98h+var_38]
    add     r13, 1
    movsxd  rcx, dword ptr [rax+14h]
    cmp     component, rcx
    jge     short loc_45D2CE
    mov     rcx, [rax]
    mov     rcx, [rcx+18h]
    mov     rdx, component
    shl     rdx, 6
    mov     rbp, [rcx+rdx+30h]
    test    rbp, rbp
    jnz     loc_45D1A0
loc_45D2B4:
    mov     rbx, [rsp+98h+var_98]
    mov     rax, [smaskInData]
    mov     rdi, smaskInData
    call    qword ptr [rax+20h]
    mov     rax, [smaskInData+18h]
    jmp     short loc_45D2CE
loc_45D2C7:
    mov     dword ptr [rax+10h], 0
loc_45D2CE:
    mov     qword ptr [rax+8], 0
    mov     byte ptr [rax+18h], 1
    lea     rdi, [rsp+98h+var_58]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+98h+var_68]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+98h+var_48]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    add     rsp, 68h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
JPXStream::init(void) endp

