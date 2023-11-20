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
    jz      short loc_452AB4
    lea     ebx, [sizeIncrement+charsToRead]
    nop
loc_452A70:
    add     [length], eax
    cmp     eax, ebp
    jnz     short loc_452AB4
    mov     readChars, [this]
    mov     rdi, this
    call    qword ptr [rax+30h]
    cmp     eax, 0FFFFFFFFh
    jz      short loc_452AB4
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
    jnz     short loc_452A70
loc_452AB4:
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
    mov     rbp, this
    lea     rdi, [rsp+98h+var_58]; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    lea     rdi, [rsp+98h+var_68]; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    lea     rdi, [rsp+98h+var_48]; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    mov     rax, [this+0]
    mov     rdi, this
    call    qword ptr [rax+98h]
    test    rax, rax
    jz      loc_4FE560
    mov     rax, [this+0]
    mov     rdi, this
    call    qword ptr [rax+98h]
    lea     rbx, [rsp+98h+other]
    mov     edx, offset aLength; "Length"
    mov     rdi, rbx
    mov     rsi, rax; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rdi, [rsp+98h+var_58]; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rax, [this+0]
    mov     rdi, this
    call    qword ptr [rax+98h]
    lea     rbx, [rsp+98h+other]
    mov     edx, offset aColorspace; "ColorSpace"
    mov     rdi, rbx
    mov     rsi, rax; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rdi, [rsp+98h+var_68]; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rax, [this+0]
    mov     rdi, this
    call    qword ptr [rax+98h]
    lea     rbx, [rsp+98h+other]
    mov     edx, offset aSmaskindata; "SMaskInData"
    mov     rdi, rbx
    mov     rsi, rax; this
    xor     ecx, ecx; recursion
    call    _ZNK4Dict6lookupEPKci; Dict::lookup(char const*,int)
    lea     rdi, [rsp+98h+var_48]; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
loc_4FE560:
    lea     rdi, [rsp+98h+var_58]; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    mov     ebx, 1000h
    test    al, al
    jz      short loc_4FE58D
    lea     rdi, [rsp+98h+var_58]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    test    eax, eax
    jle     short loc_4FE58D
    lea     rdi, [rsp+98h+var_58]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    mov     ebx, eax
loc_4FE58D:
    lea     rdi, [rsp+98h+var_68]; this
    call    _ZNK6Object7isArrayEv; Object::isArray(void)
    test    al, al
    jz      short loc_4FE5D9
    lea     rdi, [rsp+98h+var_68]; this
    call    _ZNK6Object14arrayGetLengthEv; Object::arrayGetLength(void)
    test    eax, eax
    jle     short loc_4FE5D9
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
    jmp     short loc_4FE5DC
loc_4FE5D9:
    xor     r14d, r14d
loc_4FE5DC:
    mov     rax, [this+18h]
    mov     dword ptr [rax+1Ch], 0
    lea     rdi, [rsp+98h+var_48]; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    jz      short loc_4FE606
    lea     rdi, [rsp+98h+var_48]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    mov     rcx, [this+18h]
    mov     [rcx+1Ch], eax
loc_4FE606:
    mov     [rsp+98h+other.type], 0
    mov     rdi, [this+10h]; this
    lea     rsi, [rsp+98h+other]; length
    mov     edx, ebx; initialSize
    mov     ecx, 1000h; sizeIncrement
    call    _ZN6Stream15toUnsignedCharsEPiii; Stream::toUnsignedChars(int *,int,int)
    mov     bufSize, rax
    mov     rdi, [this+18h]; this
    mov     ecx, [rsp+98h+other.type]; length
    movzx   r8d, r14b; indexed
    mov     esi, 2; format
    mov     rdx, rax; buf
    mov     dword ptr [rsp+98h+indexed], r8d
    call    _ZN16JPXStreamPrivate5init2E12CODEC_FORMATPhib; JPXStreamPrivate::init2(CODEC_FORMAT,uchar *,int,bool)
    mov     rdi, buf; p
    call    _Z5gfreePv; gfree(void *)
    mov     rax, [this+18h]
    mov     rcx, [rax]
    test    rcx, rcx
    mov     [rsp+98h+var_88], this
    jz      loc_4FE7D5
    mov     edx, [rcx+10h]
    mov     esi, [rcx+14h]
    mov     edi, edx
    xor     edi, 4
    or      esi, 2
    xor     esi, 3
    or      esi, edi
    setz    bl
    mov     rdi, [rcx+18h]
    mov     esi, [rdi+0Ch]
    imul    esi, [rdi+8]
    mov     [rax+10h], esi
    mov     [rax+14h], edx
    cmp     edx, 2
    jz      short loc_4FE696
    test    bl, bl
    jnz     short loc_4FE696
    cmp     edx, 5
    jl      short loc_4FE6A2
loc_4FE696:
    cmp     dword ptr [rax+1Ch], 0
    jnz     short loc_4FE6A2
    add     edx, 0FFFFFFFFh
    mov     [rax+14h], edx
loc_4FE6A2:
    mov     r8d, dword ptr [rsp+98h+indexed]; indexed
    test    edx, edx
    jle     loc_4FE7FE
    mov     r13, [rdi+30h]
    test    r13, r13
    jz      loc_4FE7F3
    xor     ecx, ecx
    xchg    ax, ax
loc_4FE6C0:
    mov     r12, component
    shl     r12, 6
    mov     esi, [rdi+r12+0Ch]
    imul    esi, [rdi+r12+8]
    cmp     esi, [rax+10h]
    jnz     loc_4FE7DE
    mov     [rsp+98h+var_38], component
    mov     edx, [rdi+r12+18h]; depth
    lea     ebx, [depth-8]
    xor     ebp, ebp
    cmp     edx, 8
    cmovbe  ebx, ebp
    cmp     dword ptr [rdi+r12+20h], 0
    jz      short loc_4FE705
    mov     cl, [rdi+18h]
    add     cl, 0FFh
    mov     ebp, 1
    shl     ebp, cl
loc_4FE705:
    test    esi, esi
    mov     r14, [rsp+98h+var_88]
    jle     loc_4FE7A5
    mov     edi, [r13+0]; r
    mov     [rsp+98h+var_70], r13
    mov     esi, ebx; adjust
    mov     ecx, ebp; sgndcorr
    mov     r13, depth
    call    _ZL10adjustCompiiiib; adjustComp(int,int,int,int,bool)
    mov     rcx, [rsp+98h+var_70]
    mov     [rcx], al
    mov     rax, [r14+18h]
    cmp     dword ptr [rax+10h], 2
    jl      short loc_4FE7A0
    mov     r15d, 1
    mov     r14, [rsp+98h+var_88]
    mov     rdx, r13; depth
    mov     r13d, ebp
    nop     dword ptr [rax+00000000h]
loc_4FE750:
    mov     rax, [rax]
    mov     rax, [rax+18h]
    mov     rax, [rax+r12+30h]
    mov     edi, [rax+i*4]; r
    mov     esi, ebx; adjust
    mov     ecx, r13d; sgndcorr
    mov     r8d, dword ptr [rsp+98h+indexed]; indexed
    mov     ebp, ebx
    mov     rbx, rdx
    call    _ZL10adjustCompiiiib; adjustComp(int,int,int,int,bool)
    mov     rdx, rbx
    mov     ebx, ebp
    mov     r8d, dword ptr [rsp+98h+indexed]
    mov     rsi, [rsp+98h+var_70]
    mov     [rsi+i], al
    add     i, 1
    mov     rax, [r14+18h]
    movsxd  rsi, dword ptr [rax+10h]
    cmp     r15, rsi
    jl      short loc_4FE750
    jmp     short loc_4FE7A5
loc_4FE7A0:
    mov     r8d, dword ptr [rsp+98h+indexed]
loc_4FE7A5:
    mov     rcx, [rsp+98h+var_38]
    add     rcx, 1
    movsxd  rdx, dword ptr [rax+14h]
    cmp     component, rdx
    jge     short loc_4FE7FE
    mov     rdx, [rax]
    mov     rdi, [rdx+18h]
    mov     rdx, component
    shl     rdx, 6
    mov     r13, [rdi+rdx+30h]
    test    r13, r13
    jnz     loc_4FE6C0
    jmp     short loc_4FE7F3
loc_4FE7D5:
    mov     dword ptr [rax+10h], 0
    jmp     short loc_4FE7FE
loc_4FE7DE:
    mov     edx, offset aComponent0DHas; "Component {0:d} has different WxH than "...
    xor     edi, edi; category
    mov     componentPixels, 0FFFFFFFFFFFFFFFFh; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
loc_4FE7F3:
    mov     rdi, [rsp+98h+var_88]
    mov     rax, [rdi]
    call    qword ptr [rax+20h]
loc_4FE7FE:
    mov     rax, [rsp+98h+var_88]
    mov     rax, [rax+18h]
    mov     qword ptr [rax+8], 0
    mov     byte ptr [rax+18h], 1
    lea     rdi, [rsp+98h+var_48]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+98h+var_68]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+98h+var_58]; this
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

