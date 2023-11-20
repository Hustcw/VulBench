Parser::makeStream(Object &&,unsigned char const*,CryptAlgorithm,int,int,int,int,bool) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 48h
    mov     r14d, r9d
    mov     r12d, r8d
    mov     r13d, ecx
    mov     [rsp+78h+var_50], fileKey
    mov     [rsp+78h+__t], dict
    mov     rbx, this
    mov     r15d, [rsp+78h+arg_0]
    call    _ZNK5Lexer7getXRefEv; Lexer::getXRef(void)
    test    xref, xref
    jz      short loc_4C2AA0
    mov     rdi, xref; this
    mov     esi, r14d; i
    xor     edx, edx; complainIfMissing
    call    _ZN4XRef8getEntryEib; XRef::getEntry(int,bool)
    test    rax, rax
    jz      short loc_4C2AA0
    mov     rbp, rax
    mov     rdi, rax; this
    mov     esi, 1; flag
    call    _ZNK9XRefEntry7getFlagENS_4FlagE; XRefEntry::getFlag(XRefEntry::Flag)
    mov     ecx, r15d
    or      ecx, r14d
    jz      short loc_4C2A8E
    test    al, al
    jz      short loc_4C2A8E
    mov     rdi, this; this
    call    _ZN6Parser6getPosEv; Parser::getPos(void)
    xor     r12d, r12d
    mov     edx, offset aObject0D1DObjI; "Object '{0:d} {1:d} obj' is being alrea"...
    mov     edi, 1; category
    mov     rsi, rax; pos
    mov     ecx, r14d
    mov     r8d, r15d
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    jmp     loc_4C2D74
loc_4C2A8E:
    mov     rdi, entry; this
    mov     esi, 1; flag
    mov     edx, 1; value
    call    _ZN9XRefEntry7setFlagENS_4FlagEb; XRefEntry::setFlag(XRefEntry::Flag,bool)
loc_4C2AA0:
    mov     rdi, this; this
    call    _ZN5Lexer14skipToNextLineEv; Lexer::skipToNextLine(void)
    mov     rdi, this; this
    call    _ZN5Lexer9getStreamEv; Lexer::getStream(void)
    test    str, str
    jz      short loc_4C2B08
    mov     [rsp+78h+algoA], r13d
    mov     r15d, [rsp+78h+arg_8]
    mov     rcx, [str]
    mov     rdi, str
    call    qword ptr [rcx+68h]
    mov     r13, rax
    lea     rbp, [rsp+78h+var_60]
    mov     edx, offset aLength; "Length"
    mov     rdi, rbp
    mov     rsi, [rsp+78h+__t]; this
    mov     ecx, r15d; recursion
    call    _ZNK6Object10dictLookupEPKci; Object::dictLookup(char const*,int)
    mov     rdi, rbp; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    mov     [rsp+78h+var_64], r12d
    lea     rdi, [rsp+78h+var_60]; this
    jz      short loc_4C2B10
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    movsxd  r12, eax
    jmp     short loc_4C2B55
loc_4C2B08:
    xor     r12d, r12d
    jmp     loc_4C2D74
loc_4C2B10:
    call    _ZNK6Object7isInt64Ev; Object::isInt64(void)
    test    al, al
    jz      short loc_4C2B28
    lea     rdi, [rsp+78h+var_60]; this
    call    _ZNK6Object8getInt64Ev; Object::getInt64(void)
    mov     r12, rax
    jmp     short loc_4C2B55
loc_4C2B28:
    mov     rdi, this; this
    call    _ZN6Parser6getPosEv; Parser::getPos(void)
    xor     r12d, r12d
    mov     edx, offset aBadLengthAttri; "Bad 'Length' attribute in stream"
    mov     edi, 1; category
    mov     rsi, rax; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    cmp     [rsp+78h+strict], 0
    jnz     loc_4C2D6A
loc_4C2B55:
    mov     rdi, this; this
    call    _ZNK5Lexer7hasXRefEv; Lexer::hasXRef(void)
    test    al, al
    jz      short loc_4C2B85
    mov     rdi, this; this
    call    _ZNK5Lexer7getXRefEv; Lexer::getXRef(void)
    lea     rdx, [rsp+78h+streamEnd]; streamEnd
    mov     rdi, rax; this
    mov     rsi, pos; streamStart
    call    _ZN4XRef12getStreamEndExPx; XRef::getStreamEnd(long long,long long *)
    test    al, al
    jz      short loc_4C2B85
    mov     length, [rsp+78h+streamEnd]
    sub     endPos, pos
loc_4C2B85:
    mov     rdi, this; this
    call    _ZN5Lexer9getStreamEv; Lexer::getStream(void)
    test    rax, rax
    jz      loc_4C2C37
    mov     rdi, this; this
    call    _ZN5Lexer9getStreamEv; Lexer::getStream(void)
    mov     rcx, [rax]
    mov     rdi, rax
    call    qword ptr [rcx+88h]
    mov     rbp, rax
    cmp     dword ptr [this], 0FFFFFFFDh
    jz      short loc_4C2BBC
    add     pos, 0FFFFFFFFFFFFFFFFh
    mov     dword ptr [this], 0FFFFFFFDh
loc_4C2BBC:
    test    length, length
    js      short loc_4C2C37
    lea     rsi, [length+pos]; pos
    mov     rdi, this; this
    call    _ZN5Lexer6setPosEx; Lexer::setPos(long long)
    mov     rdi, this; this
    mov     esi, 0FFFFFFFFh; objNum
    call    _ZN6Parser5shiftEi; Parser::shift(int)
    mov     esi, offset aEndstream; "endstream"
    mov     rdi, this; this
    mov     edx, r14d; objNum
    call    _ZN6Parser5shiftEPKci; Parser::shift(char const*,int)
    lea     r15, [this+0C0h]
    mov     esi, offset aEndstream; "endstream"
    mov     rdi, r15; this
    call    _ZNK6Object5isCmdEPKc; Object::isCmd(char const*)
    mov     rdi, this; this
    test    al, al
    jz      short loc_4C2C14
    mov     esi, 0FFFFFFFFh; objNum
    call    _ZN6Parser5shiftEi; Parser::shift(int)
    jmp     loc_4C2CB0
loc_4C2C14:
    call    _ZN6Parser6getPosEv; Parser::getPos(void)
    mov     edx, offset aMissingEndstre; "Missing 'endstream' or incorrect stream"...
    mov     edi, 1; category
    mov     rsi, rax; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    cmp     [rsp+78h+strict], 0
    jz      short loc_4C2C3F
loc_4C2C37:
    xor     r12d, r12d
    jmp     loc_4C2D6A
loc_4C2C3F:
    mov     rdi, this; this
    call    _ZNK5Lexer7hasXRefEv; Lexer::hasXRef(void)
    test    al, al
    jz      short loc_4C2CA9
    mov     rdi, this; this
    call    _ZN5Lexer9getStreamEv; Lexer::getStream(void)
    test    rax, rax
    jz      short loc_4C2CA9
    mov     rdi, this; this
    call    _ZNK5Lexer6getPosEv; Lexer::getPos(void)
    mov     length, rax
    sub     r12, pos
    mov     esi, offset aEndstream; "endstream"
    mov     rdi, r15; this
    call    _ZNK6Object5isCmdEPKc; Object::isCmd(char const*)
    test    al, al
    jz      short loc_4C2CB0
    mov     r15, baseStr
    lea     rbp, [rsp+78h+val]
    mov     rdi, rbp; this
    mov     rsi, length; int64gA
    call    _ZN6ObjectC2Ex; Object::Object(long long)
    mov     esi, offset aLength; "Length"
    mov     rdi, [rsp+78h+__t]; this
    mov     rdx, rbp; val
    call    _ZN6Object7dictSetEPKcOS_; Object::dictSet(char const*,Object&&)
    mov     rdi, rbp; this
    mov     rbp, baseStr
    call    _ZN6ObjectD2Ev; Object::~Object()
    jmp     short loc_4C2CB0
loc_4C2CA9:
    add     length, 1388h
loc_4C2CB0:
    mov     rdi, [rsp+78h+__t]; __t
    call    _ZNSt3__14moveIR6ObjectEEONS_16remove_referenceIT_E4typeEOS4_; std::move<Object &>(Object &&&)
    mov     rdi, baseStr
    mov     baseStr, [baseStr+0]
    mov     rsi, pos
    mov     edx, 1
    mov     rcx, length
    mov     r8, rax
    call    qword ptr [rbp+0D8h]
    mov     rbp, rax
    mov     length, [rsp+78h+var_50]
    test    r12, r12
    jz      short loc_4C2D1A
    mov     edi, 178h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     r15, rax
    mov     eax, [rsp+78h+arg_0]
    shl     rax, 20h
    mov     r9d, r14d
    or      r9, rax; refA
    mov     rdi, str; this
    mov     rsi, rbp; strA
    mov     rdx, r12; fileKey
    mov     ecx, [rsp+78h+algoA]; algoA
    mov     r8d, [rsp+78h+var_64]; keyLength
    call    _ZN13DecryptStreamC2EP6StreamPKh14CryptAlgorithmi3Ref; DecryptStream::DecryptStream(Stream *,uchar const*,CryptAlgorithm,int,Ref)
    mov     rbp, str
loc_4C2D1A:
    mov     rax, [str+0]
    mov     rdi, str
    call    qword ptr [rax+98h]
    mov     rdi, str; this
    mov     rsi, rax; dict
    mov     edx, [rsp+78h+arg_8]; recursion
    call    _ZN6Stream10addFiltersEP4Dicti; Stream::addFilters(Dict *,int)
    mov     r12, rax
    mov     rdi, this; this
    call    _ZNK5Lexer7getXRefEv; Lexer::getXRef(void)
    test    xref, xref
    jz      short loc_4C2D6A
    mov     rdi, xref; this
    mov     esi, r14d; i
    xor     edx, edx; complainIfMissing
    call    _ZN4XRef8getEntryEib; XRef::getEntry(int,bool)
    test    entry, entry
    jz      short loc_4C2D6A
    mov     rdi, entry; this
    mov     esi, 1; flag
    xor     edx, edx; value
    call    _ZN9XRefEntry7setFlagENS_4FlagEb; XRefEntry::setFlag(XRefEntry::Flag,bool)
loc_4C2D6A:
    lea     rdi, [rsp+78h+var_60]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
loc_4C2D74:
    mov     rax, r12
    add     rsp, 48h
    pop     this
    pop     r12
    pop     r13
    pop     objNum
    pop     r15
    pop     rbp
    retn
Parser::makeStream(Object &&,unsigned char const*,CryptAlgorithm,int,int,int,int,bool) endp

