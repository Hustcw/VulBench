Parser::makeStream(Object &&,unsigned char const*,CryptAlgorithm,int,int,int,int,bool) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 58h
    mov     ebx, r9d
    mov     r15d, r8d
    mov     r13d, ecx
    mov     [rsp+88h+var_60], fileKey
    mov     [rsp+88h+__t], dict
    mov     r12, this
    mov     r14d, [rsp+88h+arg_0]
    call    _ZNK5Lexer7getXRefEv; Lexer::getXRef(void)
    test    xref, xref
    jz      short loc_48509D
    mov     rdi, xref; this
    mov     esi, ebx; i
    xor     edx, edx; complainIfMissing
    call    _ZN4XRef8getEntryEib; XRef::getEntry(int,bool)
    test    rax, rax
    jz      short loc_48509D
    mov     rbp, rax
    mov     rdi, rax; this
    mov     esi, 1; flag
    call    _ZNK9XRefEntry7getFlagENS_4FlagE; XRefEntry::getFlag(XRefEntry::Flag)
    mov     ecx, r14d
    or      ecx, ebx
    jz      short loc_48508B
    test    al, al
    jz      short loc_48508B
    mov     rdi, this; this
    call    _ZN6Parser6getPosEv; Parser::getPos(void)
    xor     r15d, r15d
    mov     edx, offset aObject0D1DObjI; "Object '{0:d} {1:d} obj' is being alrea"...
    mov     edi, 1; category
    mov     rsi, rax; pos
    mov     ecx, ebx
    mov     r8d, r14d
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    jmp     loc_4853D7
loc_48508B:
    mov     rdi, entry; this
    mov     esi, 1; flag
    mov     edx, 1; value
    call    _ZN9XRefEntry7setFlagENS_4FlagEb; XRefEntry::setFlag(XRefEntry::Flag,bool)
loc_48509D:
    mov     rdi, this; this
    call    _ZN5Lexer14skipToNextLineEv; Lexer::skipToNextLine(void)
    mov     rdi, this; this
    call    _ZN5Lexer9getStreamEv; Lexer::getStream(void)
    test    str, str
    jz      short loc_48510B
    mov     [rsp+88h+i], ebx
    mov     ebx, [rsp+88h+arg_8]
    mov     rcx, [str]
    mov     rdi, str
    call    qword ptr [rcx+68h]
    mov     r14, rax
    lea     rbp, [rsp+88h+var_58]
    mov     edx, offset aLength; "Length"
    mov     rdi, rbp
    mov     rsi, [rsp+88h+__t]; this
    mov     ecx, ebx; recursion
    call    _ZNK6Object10dictLookupEPKci; Object::dictLookup(char const*,int)
    mov     rdi, rbp; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    mov     [rsp+88h+var_64], r15d
    mov     [rsp+88h+algoA], r13d
    lea     rdi, [rsp+88h+var_58]; this
    jz      short loc_485113
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    movsxd  r13, eax
    mov     ebp, [rsp+88h+i]
    jmp     short loc_485166
loc_48510B:
    xor     r15d, r15d
    jmp     loc_4853D7
loc_485113:
    call    _ZNK6Object7isInt64Ev; Object::isInt64(void)
    test    al, al
    jz      short loc_48512F
    lea     rdi, [rsp+88h+var_58]; this
    call    _ZNK6Object8getInt64Ev; Object::getInt64(void)
    mov     r13, rax
    mov     ebp, [rsp+88h+i]
    jmp     short loc_485166
loc_48512F:
    mov     rdi, this; this
    call    _ZN6Parser6getPosEv; Parser::getPos(void)
    xor     r13d, r13d
    mov     edx, offset aBadLengthAttri; "Bad 'Length' attribute in stream"
    mov     edi, 1; category
    mov     rsi, rax; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    mov     r15d, 0
    cmp     [rsp+88h+strict], 0
    mov     ebp, [rsp+88h+i]
    jnz     loc_4853CD
loc_485166:
    mov     rdi, this; this
    call    _ZNK5Lexer7hasXRefEv; Lexer::hasXRef(void)
    test    al, al
    jz      short loc_485196
    mov     rdi, this; this
    call    _ZNK5Lexer7getXRefEv; Lexer::getXRef(void)
    lea     rdx, [rsp+88h+streamEnd]; streamEnd
    mov     rdi, rax; this
    mov     rsi, pos; streamStart
    call    _ZN4XRef12getStreamEndExPx; XRef::getStreamEnd(long long,long long *)
    test    al, al
    jz      short loc_485196
    mov     length, [rsp+88h+streamEnd]
    sub     endPos, pos
loc_485196:
    mov     rdi, this; this
    call    _ZN5Lexer9getStreamEv; Lexer::getStream(void)
    test    rax, rax
    jz      loc_485254
    mov     rdi, this; this
    call    _ZN5Lexer9getStreamEv; Lexer::getStream(void)
    mov     rcx, [rax]
    mov     rdi, rax
    call    qword ptr [rcx+88h]
    cmp     dword ptr [this], 0FFFFFFFDh
    jz      short loc_4851CE
    add     pos, 0FFFFFFFFFFFFFFFFh
    mov     dword ptr [this], 0FFFFFFFDh
loc_4851CE:
    xor     r15d, r15d
    test    length, length
    js      loc_4853CD
    mov     rcx, 7FFFFFFFFFFFEC77h
    sub     rcx, length
    add     rcx, 1388h
    cmp     pos, rcx
    jg      loc_4853CD
    mov     [rsp+88h+var_78], baseStr
    lea     rsi, [pos+length]; pos
    mov     rdi, this; this
    call    _ZN5Lexer6setPosEx; Lexer::setPos(long long)
    mov     rdi, this; this
    mov     esi, 0FFFFFFFFh; objNum
    call    _ZN6Parser5shiftEi; Parser::shift(int)
    mov     esi, offset aEndstream; "endstream"
    mov     rdi, this; this
    mov     edx, ebp; objNum
    call    _ZN6Parser5shiftEPKci; Parser::shift(char const*,int)
    lea     rbx, [this+0C0h]
    mov     esi, offset aEndstream; "endstream"
    mov     rdi, rbx; this
    call    _ZNK6Object5isCmdEPKc; Object::isCmd(char const*)
    mov     rdi, this; this
    test    al, al
    jz      short loc_48525C
    mov     esi, 0FFFFFFFFh; objNum
    call    _ZN6Parser5shiftEi; Parser::shift(int)
    mov     r15, [rsp+88h+var_60]
    jmp     loc_48530D
loc_485254:
    xor     r15d, r15d
    jmp     loc_4853CD
loc_48525C:
    call    _ZN6Parser6getPosEv; Parser::getPos(void)
    xor     r15d, r15d
    mov     edx, offset aMissingEndstre; "Missing 'endstream' or incorrect stream"...
    mov     edi, 1; category
    mov     rsi, rax; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    cmp     [rsp+88h+strict], 0
    jnz     loc_4853CD
    mov     rdi, this; this
    call    _ZNK5Lexer7hasXRefEv; Lexer::hasXRef(void)
    test    al, al
    mov     r15, [rsp+88h+var_60]
    jz      short loc_4852EF
    mov     rdi, this; this
    call    _ZN5Lexer9getStreamEv; Lexer::getStream(void)
    test    rax, rax
    jz      short loc_4852EF
    mov     rdi, this; this
    call    _ZNK5Lexer6getPosEv; Lexer::getPos(void)
    mov     length, rax
    sub     r13, pos
    mov     esi, offset aEndstream; "endstream"
    mov     rdi, rbx; this
    call    _ZNK6Object5isCmdEPKc; Object::isCmd(char const*)
    test    al, al
    jz      short loc_48530D
    lea     rbp, [rsp+88h+val]
    mov     rdi, rbp; this
    mov     rsi, length; int64gA
    call    _ZN6ObjectC2Ex; Object::Object(long long)
    mov     esi, offset aLength; "Length"
    mov     rdi, [rsp+88h+__t]; this
    mov     rdx, rbp; val
    call    _ZN6Object7dictSetEPKcOS_; Object::dictSet(char const*,Object&&)
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    jmp     short loc_48530D
loc_4852EF:
    mov     rax, 7FFFFFFFFFFFEC77h
    mov     rcx, rax
    sub     rcx, pos
    lea     rax, [length+1388h]
    cmp     length, rcx
    cmovl   length, rax
loc_48530D:
    mov     rbx, [rsp+88h+var_78]
    mov     rdi, [rsp+88h+__t]; __t
    call    _ZNSt3__14moveIR6ObjectEEONS_16remove_referenceIT_E4typeEOS4_; std::move<Object &>(Object &&&)
    mov     rbp, [rbx]
    mov     rdi, rbx
    mov     rsi, pos
    mov     edx, 1
    mov     rcx, length
    mov     r8, rax
    call    qword ptr [rbp+0D8h]
    mov     rbp, rax
    test    r15, r15
    jz      short loc_485378
    mov     edi, 178h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     pos, rax
    mov     eax, [rsp+88h+arg_0]
    shl     rax, 20h
    mov     r9d, [rsp+88h+i]
    or      r9, rax; refA
    mov     rdi, str; this
    mov     rsi, rbp; strA
    mov     rdx, r15; fileKey
    mov     ecx, [rsp+88h+algoA]; algoA
    mov     r8d, [rsp+88h+var_64]; keyLength
    call    _ZN13DecryptStreamC2EP6StreamPKh14CryptAlgorithmi3Ref; DecryptStream::DecryptStream(Stream *,uchar const*,CryptAlgorithm,int,Ref)
    mov     rbp, str
loc_485378:
    mov     r14d, [rsp+88h+arg_8]
    mov     rax, [str+0]
    mov     rdi, str
    call    qword ptr [rax+98h]
    mov     rdi, str; this
    mov     rsi, rax; dict
    mov     edx, r14d; recursion
    call    _ZN6Stream10addFiltersEP4Dicti; Stream::addFilters(Dict *,int)
    mov     r15, rax
    mov     rdi, this; this
    call    _ZNK5Lexer7getXRefEv; Lexer::getXRef(void)
    test    xref, xref
    jz      short loc_4853CD
    mov     rdi, xref; this
    mov     esi, [rsp+88h+i]; i
    xor     edx, edx; complainIfMissing
    call    _ZN4XRef8getEntryEib; XRef::getEntry(int,bool)
    test    entry, entry
    jz      short loc_4853CD
    mov     rdi, entry; this
    mov     esi, 1; flag
    xor     edx, edx; value
    call    _ZN9XRefEntry7setFlagENS_4FlagEb; XRefEntry::setFlag(XRefEntry::Flag,bool)
loc_4853CD:
    lea     rdi, [rsp+88h+var_58]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
loc_4853D7:
    mov     rax, r15
    add     rsp, 58h
    pop     rbx
    pop     this
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
Parser::makeStream(Object &&,unsigned char const*,CryptAlgorithm,int,int,int,int,bool) endp

