XRef::parseEntry(long long,XRefEntry *) proc
    push    r15
    push    r14
    push    r12
    push    rbx
    sub     rsp, 148h
    test    entry, entry
    jz      loc_4B4BA3
    mov     r14, entry
    mov     r15, offset
    mov     rbx, [this]
    mov     r12, rsp
    mov     this, r12; this
    mov     esi, 5; typeA
    call    _ZN6ObjectC2E7ObjType; Object::Object(ObjType)
    mov     rax, [rbx]
    mov     ecx, 14h
    mov     rdi, rbx
    mov     rsi, offset
    xor     edx, edx
    mov     r8, r12
    call    qword ptr [rax+0D8h]
    lea     offset, [rsp+168h+var_158.lexer.tokBuf+27h]
    mov     rdi, r15; this
    xor     esi, esi; xrefA
    mov     rdx, rax; streamA
    mov     ecx, 1; allowStreamsA
    call    _ZN6ParserC2EP4XRefP6Streamb; Parser::Parser(XRef *,Stream *,bool)
    mov     rdi, r12; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     r12, rsp
    mov     rdi, r12; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    lea     rdi, [rsp+168h+var_158.lexer.tokBuf+7]; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    lea     rdi, [rsp+168h+var_158.lexer.strPtr]; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    sub     rsp, 8
    lea     rbx, [rsp+170h+var_158]
    mov     rdi, rbx; this
    mov     rsi, r15; simpleOnly
    mov     edx, 0; fileKey
    mov     ecx, 0; encAlgorithm
    mov     r8d, 0; keyLength
    mov     r9d, 0; objNum
    push    1
    push    0; decryptString
    push    0; strict
    push    0; recursion
    push    0; objGen
    call    _ZN6Parser6getObjEbPKh14CryptAlgorithmiiiibb; Parser::getObj(bool,uchar const*,CryptAlgorithm,int,int,int,int,bool,bool)
    add     rsp, 30h
    mov     rdi, r12; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, r12; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    jnz     short loc_4B49F6
    mov     rdi, rsp; this
    call    _ZNK6Object7isInt64Ev; Object::isInt64(void)
    test    al, al
    jz      loc_4B4AD1
loc_4B49F6:
    sub     rsp, 8
    lea     r15, [rsp+170h+var_158.lexer.curStr.anonymous_0]
    lea     rsi, [rsp+170h+var_158.lexer.tokBuf+27h]; simpleOnly
    mov     rdi, r15; this
    mov     edx, 0; fileKey
    mov     ecx, 0; encAlgorithm
    mov     r8d, 0; keyLength
    mov     r9d, 0; objNum
    push    1
    push    0; decryptString
    push    0; strict
    push    0; recursion
    push    0; objGen
    call    _ZN6Parser6getObjEbPKh14CryptAlgorithmiiiibb; Parser::getObj(bool,uchar const*,CryptAlgorithm,int,int,int,int,bool,bool)
    add     rsp, 30h
    lea     rbx, [rsp+168h+var_158.lexer.tokBuf+7]
    mov     rdi, rbx; this
    mov     rsi, r15; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZNK6Object5isIntEv; Object::isInt(void)
    test    al, al
    jz      short loc_4B4AC7
    sub     rsp, 8
    lea     r15, [rsp+170h+var_158.lexer.tokBuf+17h]
    lea     rsi, [rsp+170h+var_158.lexer.tokBuf+27h]; simpleOnly
    mov     rdi, r15; this
    mov     edx, 0; fileKey
    mov     ecx, 0; encAlgorithm
    mov     r8d, 0; keyLength
    mov     r9d, 0; objNum
    push    1
    push    0; decryptString
    push    0; strict
    push    0; recursion
    push    0; objGen
    call    _ZN6Parser6getObjEbPKh14CryptAlgorithmiiiibb; Parser::getObj(bool,uchar const*,CryptAlgorithm,int,int,int,int,bool,bool)
    add     rsp, 30h
    lea     rbx, [rsp+168h+var_158.lexer.strPtr]
    mov     rdi, rbx; this
    mov     rsi, r15; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     esi, (offset aThisMHolderMSi+18h); cmdA
    mov     rdi, rbx; this
    call    _ZNK6Object5isCmdEPKc; Object::isCmd(char const*)
    test    al, al
    jz      short loc_4B4AE2
    lea     rdi, [rsp+168h+var_158.lexer.tokBuf+17h]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+168h+var_158.lexer.curStr.anonymous_0]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+168h+var_158]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    jmp     short loc_4B4B15
loc_4B4AC7:
    lea     rdi, [rsp+168h+var_158.lexer.curStr.anonymous_0]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
loc_4B4AD1:
    lea     rdi, [rsp+168h+var_158]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
loc_4B4ADB:
    xor     ebx, ebx
    jmp     loc_4B4B6C
loc_4B4AE2:
    lea     rdi, [rsp+168h+var_158.lexer.strPtr]; this
    mov     esi, (offset aSegol1f+6); cmdA
    call    _ZNK6Object5isCmdEPKc; Object::isCmd(char const*)
    mov     ebx, eax
    lea     rdi, [rsp+168h+var_158.lexer.tokBuf+17h]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+168h+var_158.lexer.curStr.anonymous_0]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+168h+var_158]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    test    bl, bl
    jz      short loc_4B4ADB
loc_4B4B15:
    mov     rdi, rsp; this
    call    _ZNK6Object7isInt64Ev; Object::isInt64(void)
    mov     rdi, rsp; this
    test    al, al
    jz      short loc_4B4B2B
    call    _ZNK6Object8getInt64Ev; Object::getInt64(void)
    jmp     short loc_4B4B32
loc_4B4B2B:
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    cdqe
loc_4B4B32:
    mov     [entry], rax
    lea     rdi, [rsp+168h+var_158.lexer.tokBuf+7]; this
    call    _ZNK6Object6getIntEv; Object::getInt(void)
    mov     [entry+8], eax
    lea     rdi, [rsp+168h+var_158.lexer.strPtr]; this
    mov     esi, (offset aThisMHolderMSi+18h); cmdA
    call    _ZNK6Object5isCmdEPKc; Object::isCmd(char const*)
    movzx   eax, al
    mov     [entry+0Ch], eax
    lea     rdi, [entry+18h]; this
    call    _ZN6Object9setToNullEv; Object::setToNull(void)
    mov     dword ptr [entry+10h], 0
    mov     bl, 1
loc_4B4B6C:
    lea     rdi, [rsp+168h+var_158.lexer.strPtr]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+168h+var_158.lexer.tokBuf+7]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, rsp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+168h+var_158.lexer.tokBuf+27h]; this
    call    _ZN6ParserD2Ev; Parser::~Parser()
loc_4B4B92:
    mov     eax, ebx
    add     rsp, 148h
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    retn
loc_4B4BA3:
    xor     ebx, ebx
    jmp     short loc_4B4B92
XRef::parseEntry(long long,XRefEntry *) endp



XRef::getEntry(int,bool) proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    mov     r14d, esi
    test    esi, esi
    js      loc_4B3A8B
    mov     r15d, edx
    mov     rbx, this
    cmp     [rdi+1Ch], r14d
    jle     short loc_4B399C
    mov     rax, [this+10h]
    movsxd  rbp, r14d
    lea     rcx, ds:0[rbp*4]
    add     rcx, rbp
    cmp     dword ptr [rax+rcx*8+0Ch], 3
    jnz     loc_4B3A51
loc_4B399C:
    cmp     byte ptr [this+0C8h], 0
    jz      short loc_4B3A05
loc_4B39A5:
    mov     rdi, this; this
    mov     esi, r14d; untilEntryNum
    xor     edx, edx; xrefStreamObjsNum
    call    _ZN4XRef13readXRefUntilEiPNSt3__16vectorIiNS0_9allocatorIiEEEE; XRef::readXRefUntil(int,std::vector<int> *)
    cmp     [this+1Ch], r14d
    jle     loc_4B3A97
    movsxd  rbp, r14d
    mov     rax, [this+10h]
    lea     r12, ds:0[rbp*4]
    add     r12, rbp
    cmp     dword ptr [rax+r12*8+0Ch], 3
    jnz     short loc_4B3A51
    test    r15b, r15b
    jz      short loc_4B39FA
    mov     edx, offset aInvalidXrefEnt; "Invalid XRef entry {0:d}"
    mov     edi, 1; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    mov     ecx, r14d
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    mov     rax, [this+10h]
loc_4B39FA:
    mov     dword ptr [rax+r12*8+0Ch], 0
    jmp     short loc_4B3A51
loc_4B3A05:
    mov     rsi, [this+0C0h]
    test    rsi, rsi
    jz      short loc_4B39A5
    cmp     [this+18h], r14d
    jle     loc_4B3A9E
    lea     eax, ds:0[i*4]
    lea     eax, [rax+rax*4]
    cdqe
    add     rsi, rax; offset
    movsxd  rbp, r14d
    lea     rdx, ds:0[rbp*4]
    add     rdx, rbp
    shl     rdx, 3
    add     rdx, [this+10h]; entry
    mov     rdi, this; this
    call    _ZN4XRef10parseEntryExP9XRefEntry; XRef::parseEntry(long long,XRefEntry *)
    test    al, al
    jz      short loc_4B3A69
    mov     rax, [this+10h]
loc_4B3A51:
    lea     rcx, ds:0[rbp*4]
    add     rcx, rbp
    lea     rax, [rax+rcx*8]
loc_4B3A60:
    pop     rbx
    pop     r12
    pop     i
    pop     r15
    pop     rbp
    retn
loc_4B3A69:
    mov     edx, offset aFailedToParseX; "Failed to parse XRef entry [{0:d}]."
    mov     edi, 1; category
loc_4B3A73:
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    mov     ecx, r14d
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    mov     eax, offset _ZN12_GLOBAL__N_114dummyXRefEntryE; `anonymous namespace'::dummyXRefEntry
    jmp     short loc_4B3A60
loc_4B3A8B:
    mov     edx, offset aRequestForInva; "Request for invalid XRef entry [{0:d}]"
loc_4B3A90:
    mov     edi, 7
    jmp     short loc_4B3A73
loc_4B3A97:
    mov     eax, offset _ZN12_GLOBAL__N_114dummyXRefEntryE; `anonymous namespace'::dummyXRefEntry
    jmp     short loc_4B3A60
loc_4B3A9E:
    mov     edx, offset aRequestForOutO; "Request for out-of-bounds XRef entry [{"...
    jmp     short loc_4B3A90
XRef::getEntry(int,bool) endp

