FileSpec::FileSpec(Object const*) proc
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 20h
    mov     r13, fileSpecA
    mov     r12, this
    lea     r14, [rdi+8]
    mov     rdi, r14; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    lea     r15, [this+28h]
    mov     rdi, r15; this
    call    _ZN6ObjectC2Ev; Object::Object(void)
    mov     byte ptr [this], 1
    xorps   xmm0, xmm0
    movups  xmmword ptr [this+18h], xmm0
    movups  xmmword ptr [this+38h], xmm0
    mov     rbx, rsp
    mov     rdi, rbx
    mov     rsi, fileSpecA; this
    call    _ZNK6Object4copyEv; Object::copy(void)
    mov     rdi, r14; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rbx, rsp
    mov     rdi, rbx
    mov     rsi, fileSpecA; fileSpec
    call    _Z15getFileSpecNamePK6Object; getFileSpecName(Object const*)
    mov     rdi, rbx; this
    call    _ZNK6Object8isStringEv; Object::isString(void)
    test    al, al
    jz      loc_429DD0
    lea     rbx, [this+18h]
    mov     rdi, rsp; this
    call    _ZNK6Object9getStringEv; Object::getString(void)
    mov     rdi, rax; this
    call    _ZNK9GooString4copyEv; GooString::copy(void)
    mov     [rbx], rax
    mov     rdi, r14; this
    call    _ZNK6Object6isDictEv; Object::isDict(void)
    test    al, al
    jz      loc_429DED
    lea     rbx, [rsp+48h+other]
    mov     edx, offset aEf; "EF"
    mov     rdi, rbx
    mov     rsi, r14; this
    xor     ecx, ecx; recursion
    call    _ZNK6Object10dictLookupEPKci; Object::dictLookup(char const*,int)
    mov     fileSpecA, rsp
    mov     rdi, r13; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, r13; this
    call    _ZNK6Object6isDictEv; Object::isDict(void)
    test    al, al
    jz      short loc_429D80
    mov     rdi, rsp; this
    mov     esi, (offset aCcf+2); key
    call    _ZNK6Object12dictLookupNFEPKc; Object::dictLookupNF(char const*)
    lea     rbx, [rsp+48h+other]
    mov     rdi, rbx
    mov     rsi, rax; this
    call    _ZNK6Object4copyEv; Object::copy(void)
    mov     rdi, r15; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, r15; this
    call    _ZNK6Object5isRefEv; Object::isRef(void)
    test    al, al
    jz      loc_429E03
loc_429D80:
    lea     rbx, [rsp+48h+other]
    mov     edx, offset aDesc; "Desc"
    mov     rdi, rbx
    mov     rsi, r14; this
    xor     ecx, ecx; recursion
    call    _ZNK6Object10dictLookupEPKci; Object::dictLookup(char const*,int)
    mov     r14, rsp
    mov     rdi, r14; this
    mov     rsi, rbx; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, rbx; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, r14; this
    call    _ZNK6Object8isStringEv; Object::isString(void)
    test    al, al
    jz      short loc_429DED
    mov     rdi, rsp; this
    call    _ZNK6Object9getStringEv; Object::getString(void)
    mov     rdi, rax; this
    call    _ZNK9GooString4copyEv; GooString::copy(void)
    mov     [this+40h], rax
    jmp     short loc_429DED
loc_429DD0:
    mov     byte ptr [this], 0
    mov     edx, offset aInvalidFilespe; "Invalid FileSpec"
loc_429DDA:
    mov     edi, 1; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
loc_429DED:
    mov     rdi, rsp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    add     rsp, 20h
    pop     rbx
    pop     this
    pop     r13
    pop     r14
    pop     r15
    retn
loc_429E03:
    mov     byte ptr [this], 0
    mov     rdi, r15; this
    call    _ZN6Object9setToNullEv; Object::setToNull(void)
    mov     edx, offset aInvalidFilespe_0; "Invalid FileSpec: Embedded file stream "...
    jmp     short loc_429DDA
FileSpec::FileSpec(Object const*) endp

