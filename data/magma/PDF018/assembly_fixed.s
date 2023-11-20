AnnotInk::draw(Gfx *,bool) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0B8h
    mov     r15, gfx
    mov     r12, this
    mov     esi, edx; printing
    call    _ZN5Annot9isVisibleEb; Annot::isVisible(bool)
    test    al, al
    jz      loc_527BDA
    lea     rsi, [this+0B0h]; __m
    lea     rdi, [rsp+0E8h+var_60]; this
    call    _ZNSt3__111unique_lockINS_15recursive_mutexEEC2ERS1_; std::unique_lock<std::recursive_mutex>::unique_lock(std::recursive_mutex&)
    lea     rbx, [this+50h]
    mov     rdi, rbx; this
    call    _ZNK6Object6isNullEv; Object::isNull(void)
    test    al, al
    jz      loc_527AAA
    mov     [rsp+0E8h+var_B8], rbx
    mov     [rsp+0E8h+var_B0], gfx
    lea     r14, [this+20h]
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEE3getEv; std::unique_ptr<PDFRectangle>::get(void)
    mov     [rsp+0E8h+__args], rax
    lea     rbp, [rsp+0E8h+__u]
    lea     rsi, [rsp+0E8h+__args]; __args
    mov     rdi, rbp
    call    _ZNSt3__111make_uniqueI19AnnotAppearanceBBoxJP12PDFRectangleEEENS_11__unique_ifIT_E15__unique_singleEDpOT0_; std::make_unique<AnnotAppearanceBBox,PDFRectangle *>(PDFRectangle * &&)
    lea     r13, [this+60h]
    mov     rdi, r13; this
    mov     rsi, rbp; __u
    call    _ZNSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEaSEOS4_; std::unique_ptr<AnnotAppearanceBBox>::operator=(std::unique_ptr<AnnotAppearanceBBox>&&)
    mov     rdi, rbp; this
    call    _ZNSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEED2Ev; std::unique_ptr<AnnotAppearanceBBox>::~unique_ptr()
    movsd   xmm0, qword ptr [this+0E8h]
    movsd   [rsp+0E8h+opacity], xmm0
    lea     rbp, [rsp+0E8h+var_D0]
    mov     rdi, rbp; this
    call    _ZN22AnnotAppearanceBuilderC2Ev; AnnotAppearanceBuilder::AnnotAppearanceBuilder(void)
    mov     esi, offset text; "q\n"
    mov     rdi, rbp; this
    call    _ZN22AnnotAppearanceBuilder6appendEPKc; AnnotAppearanceBuilder::append(char const*)
    lea     rbp, [this+0A0h]
    mov     rdi, rbp; this
    call    _ZNKSt3__110unique_ptrI10AnnotColorNS_14default_deleteIS1_EEEcvbEv; std::unique_ptr<AnnotColor>::operator bool(void)
    test    al, al
    jz      short loc_5276CB
    mov     rdi, rbp; this
    call    _ZNKSt3__110unique_ptrI10AnnotColorNS_14default_deleteIS1_EEE3getEv; std::unique_ptr<AnnotColor>::get(void)
    lea     rdi, [rsp+0E8h+var_D0]; this
    mov     rsi, rax; drawColor
    xor     edx, edx; fill
    call    _ZN22AnnotAppearanceBuilder12setDrawColorEPK10AnnotColorb; AnnotAppearanceBuilder::setDrawColor(AnnotColor const*,bool)
loc_5276CB:
    lea     rbp, [this+98h]
    mov     rdi, rbp; this
    call    _ZNKSt3__110unique_ptrI11AnnotBorderNS_14default_deleteIS1_EEE3getEv; std::unique_ptr<AnnotBorder>::get(void)
    lea     rdi, [rsp+0E8h+var_D0]; this
    mov     rsi, rax; border
    call    _ZN22AnnotAppearanceBuilder21setLineStyleForBorderEPK11AnnotBorder; AnnotAppearanceBuilder::setLineStyleForBorder(AnnotBorder const*)
    mov     rdi, r13; this
    call    _ZNKSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<AnnotAppearanceBBox>::operator->(void)
    mov     r15, rax
    mov     rax, 3FF0000000000000h
    mov     [rsp+0E8h+__u.__ptr_.baseclass_0.__value_], rax
    mov     rdi, rbp; this
    call    _ZNKSt3__110unique_ptrI11AnnotBorderNS_14default_deleteIS1_EEEptEv; std::unique_ptr<AnnotBorder>::operator->(void)
    mov     rcx, [rax]
    mov     rdi, rax
    call    qword ptr [rcx+20h]
    movsd   [rsp+0E8h+__args], xmm0
    lea     rdi, [rsp+0E8h+__u]; __a
    lea     rsi, [rsp+0E8h+__args]; __b
    call    _ZNSt3__13maxIdEERKT_S3_S3_; std::max<double>(double const&,double const&)
    movsd   xmm0, qword ptr [rax]
    mov     rdi, r15; this
    call    _ZN19AnnotAppearanceBBox14setBorderWidthEd; AnnotAppearanceBBox::setBorderWidth(double)
    cmp     dword ptr [this+118h], 0
    jle     loc_527978
    xor     ebx, ebx
    lea     rbp, [rsp+0E8h+var_D0]
    mov     [rsp+0E8h+var_80], this
    jmp     short loc_52778C
loc_527760:
    mov     esi, (offset a430123M1969923_7+6CDh); text
    mov     rdi, rbp; this
    call    _ZN22AnnotAppearanceBuilder6appendEPKc; AnnotAppearanceBuilder::append(char const*)
    mov     r12, [rsp+0E8h+var_80]
    mov     rbx, [rsp+0E8h+xMax]
loc_527777:
    add     rbx, 1
    movsxd  rax, dword ptr [r12+118h]
    cmp     rbx, rax
    jge     loc_527978
loc_52778C:
    mov     rax, [this+110h]
    mov     r15, [rax+i*8]
    test    path, path
    jz      short loc_527777
    mov     rdi, path; this
    call    _ZNK9AnnotPath15getCoordsLengthEv; AnnotPath::getCoordsLength(void)
    test    eax, eax
    jz      short loc_527777
    mov     [rsp+0E8h+xMax], i
    mov     rdi, path; this
    xor     esi, esi; coord
    call    _ZNK9AnnotPath4getXEi; AnnotPath::getX(int)
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm0, [rsp+0E8h+xMin]
    subsd   xmm0, qword ptr [rax]
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, path; this
    xor     esi, esi; coord
    call    _ZNK9AnnotPath4getYEi; AnnotPath::getY(int)
    movsd   [rsp+0E8h+yMin], xmm0
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm1, [rsp+0E8h+yMin]
    subsd   xmm1, qword ptr [rax+8]
    mov     esi, offset a02f12fM; "{0:.2f} {1:.2f} m\n"
    mov     rdi, rbp; this
    movsd   xmm0, [rsp+0E8h+xMin]
    mov     al, 2
    call    _ZN22AnnotAppearanceBuilder7appendfEPKcz; AnnotAppearanceBuilder::appendf(char const*,...)
    mov     rdi, r13; this
    call    _ZNKSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<AnnotAppearanceBBox>::operator->(void)
    mov     this, rax
    mov     rdi, path; this
    xor     esi, esi; coord
    call    _ZNK9AnnotPath4getXEi; AnnotPath::getX(int)
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm0, [rsp+0E8h+xMin]
    subsd   xmm0, qword ptr [rax]
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, path; this
    xor     esi, esi; coord
    call    _ZNK9AnnotPath4getYEi; AnnotPath::getY(int)
    movsd   [rsp+0E8h+yMin], xmm0
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm1, [rsp+0E8h+yMin]
    subsd   xmm1, qword ptr [rax+8]; x
    mov     rdi, r12; this
    movsd   xmm0, [rsp+0E8h+xMin]
    call    _ZN19AnnotAppearanceBBox8extendToEdd; AnnotAppearanceBBox::extendTo(double,double)
    mov     rdi, path; this
    call    _ZNK9AnnotPath15getCoordsLengthEv; AnnotPath::getCoordsLength(void)
    cmp     eax, 2
    jl      loc_527760
    mov     r12d, 1
    nop     dword ptr [rax+00000000h]
loc_527890:
    mov     rdi, path; this
    mov     esi, r12d; coord
    call    _ZNK9AnnotPath4getXEi; AnnotPath::getX(int)
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm0, [rsp+0E8h+xMin]
    subsd   xmm0, qword ptr [rax]
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, path; this
    mov     esi, r12d; coord
    call    _ZNK9AnnotPath4getYEi; AnnotPath::getY(int)
    movsd   [rsp+0E8h+yMin], xmm0
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm1, [rsp+0E8h+yMin]
    subsd   xmm1, qword ptr [rax+8]
    mov     esi, offset a02f12fL; "{0:.2f} {1:.2f} l\n"
    mov     rdi, rbp; this
    movsd   xmm0, [rsp+0E8h+xMin]
    mov     al, 2
    call    _ZN22AnnotAppearanceBuilder7appendfEPKcz; AnnotAppearanceBuilder::appendf(char const*,...)
    mov     rdi, r13; this
    call    _ZNKSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<AnnotAppearanceBBox>::operator->(void)
    mov     rbx, r13
    mov     r13, rax
    mov     rdi, path; this
    mov     esi, r12d; coord
    call    _ZNK9AnnotPath4getXEi; AnnotPath::getX(int)
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm0, [rsp+0E8h+xMin]
    subsd   xmm0, qword ptr [rax]
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, path; this
    mov     esi, r12d; coord
    call    _ZNK9AnnotPath4getYEi; AnnotPath::getY(int)
    movsd   [rsp+0E8h+yMin], xmm0
    mov     rdi, r14; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm1, [rsp+0E8h+yMin]
    subsd   xmm1, qword ptr [rax+8]; x
    mov     rdi, r13; this
    mov     r13, rbx
    movsd   xmm0, [rsp+0E8h+xMin]
    call    _ZN19AnnotAppearanceBBox8extendToEdd; AnnotAppearanceBBox::extendTo(double,double)
    add     r12d, 1
    mov     rdi, path; this
    call    _ZNK9AnnotPath15getCoordsLengthEv; AnnotPath::getCoordsLength(void)
    cmp     r12d, eax
    jl      loc_527890
    jmp     loc_527760
loc_527978:
    lea     rdi, [rsp+0E8h+var_D0]; this
    mov     esi, (offset a430123M1969923_4+233h); text
    call    _ZN22AnnotAppearanceBuilder6appendEPKc; AnnotAppearanceBuilder::append(char const*)
    mov     rdi, r13; this
    call    _ZNKSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<AnnotAppearanceBBox>::operator->(void)
    lea     rsi, [rsp+0E8h+__u]; bbox
    mov     rdi, rax; this
    call    _ZNK19AnnotAppearanceBBox11getBBoxRectEPd; AnnotAppearanceBBox::getBBoxRect(double *)
    movsd   xmm0, [rsp+0E8h+opacity]
    ucomisd xmm0, cs:x
    jnz     short loc_5279EB
    jp      short loc_5279EB
    lea     rdi, [rsp+0E8h+var_D0]; this
    call    _ZNK22AnnotAppearanceBuilder6bufferEv; AnnotAppearanceBuilder::buffer(void)
    lea     rcx, [rsp+0E8h+__u]; bbox
    lea     rbp, [rsp+0E8h+__args]
    mov     rdi, rbp
    mov     rsi, r12; this
    mov     rdx, rax; appearBuf
    xor     r8d, r8d; transparencyGroup
    xor     r9d, r9d; resDict
    call    _ZN5Annot10createFormEPK9GooStringPdbP4Dict; Annot::createForm(GooString const*,double *,bool,Dict *)
    mov     rbx, [rsp+0E8h+var_B8]
    mov     rdi, rbx; this
    mov     rsi, rbp; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    jmp     loc_527A93
loc_5279EB:
    lea     rbp, [rsp+0E8h+__t]
    lea     rdi, [rsp+0E8h+var_D0]; this
    call    _ZNK22AnnotAppearanceBuilder6bufferEv; AnnotAppearanceBuilder::buffer(void)
    lea     r14, [rsp+0E8h+__u]
    mov     rdi, rbp
    mov     rsi, r12; this
    mov     rdx, rax; appearBuf
    mov     rcx, r14; bbox
    mov     r8d, 1; transparencyGroup
    xor     r9d, r9d; resDict
    call    _ZN5Annot10createFormEPK9GooStringPdbP4Dict; Annot::createForm(GooString const*,double *,bool,Dict *)
    lea     r15, [rsp+0E8h+__args]
    mov     esi, offset aGs0GsFm0Do; "/GS0 gs\n/Fm0 Do"
    mov     rdi, r15; this
    call    _ZN9GooStringC2EPKc; GooString::GooString(char const*)
    mov     rdi, rbp; __t
    call    _ZNSt3__14moveIR6ObjectEEONS_16remove_referenceIT_E4typeEOS4_; std::move<Object &>(Object &&&)
    mov     esi, offset formName; "Fm0"
    mov     ecx, offset stateName; "GS0"
    mov     rdi, r12; this
    mov     rdx, rax; formStream
    movsd   xmm0, [rsp+0E8h+opacity]; opacity
    xor     r8d, r8d; blendMode
    call    _ZN5Annot19createResourcesDictEPKcO6ObjectS1_dS1_; Annot::createResourcesDict(char const*,Object &&,char const*,double,char const*)
    lea     r13, [rsp+0E8h+other]
    mov     rdi, r13
    mov     rsi, r12; this
    mov     rdx, r15; appearBuf
    mov     rcx, r14; bbox
    xor     r8d, r8d; transparencyGroup
    mov     r9, resDict; resDict
    call    _ZN5Annot10createFormEPK9GooStringPdbP4Dict; Annot::createForm(GooString const*,double *,bool,Dict *)
    mov     rbx, [rsp+0E8h+var_B8]
    mov     rdi, rbx; this
    mov     rsi, r13; other
    call    _ZN6ObjectaSEOS_; Object::operator=(Object&&)
    mov     rdi, r13; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    mov     rdi, r15; void *
    call    __ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED2Ev; std::string::~string()
loc_527A93:
    mov     r15, [rsp+0E8h+var_B0]
    mov     rdi, rbp; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+0E8h+var_D0]; this
    call    _ZN22AnnotAppearanceBuilderD2Ev; AnnotAppearanceBuilder::~AnnotAppearanceBuilder()
loc_527AAA:
    mov     rdi, r15; this
    call    _ZN3Gfx7getXRefEv; Gfx::getXRef(void)
    lea     rdi, [rsp+0E8h+__u]
    mov     rsi, rbx; this
    mov     rdx, rax; xref
    xor     ecx, ecx; recursion
    call    _ZNK6Object5fetchEP4XRefi; Object::fetch(XRef *,int)
    lea     rbp, [r12+60h]
    mov     rdi, rbp; this
    call    _ZNKSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEcvbEv; std::unique_ptr<AnnotAppearanceBBox>::operator bool(void)
    mov     ebx, eax
    lea     rdi, [r12+0A0h]; this
    call    _ZNKSt3__110unique_ptrI10AnnotColorNS_14default_deleteIS1_EEE3getEv; std::unique_ptr<AnnotColor>::get(void)
    mov     r14, rax
    test    bl, bl
    jz      short loc_527B3B
    mov     rdi, rbp; this
    call    _ZNKSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<AnnotAppearanceBBox>::operator->(void)
    mov     rdi, rax; this
    call    _ZNK19AnnotAppearanceBBox11getPageXMinEv; AnnotAppearanceBBox::getPageXMin(void)
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, rbp; this
    call    _ZNKSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<AnnotAppearanceBBox>::operator->(void)
    mov     rdi, rax; this
    call    _ZNK19AnnotAppearanceBBox11getPageYMinEv; AnnotAppearanceBBox::getPageYMin(void)
    movsd   [rsp+0E8h+yMin], xmm0
    mov     rdi, rbp; this
    call    _ZNKSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<AnnotAppearanceBBox>::operator->(void)
    mov     rdi, rax; this
    call    _ZNK19AnnotAppearanceBBox11getPageXMaxEv; AnnotAppearanceBBox::getPageXMax(void)
    movsd   [rsp+0E8h+xMax], xmm0
    mov     rdi, rbp; this
    call    _ZNKSt3__110unique_ptrI19AnnotAppearanceBBoxNS_14default_deleteIS1_EEEptEv; std::unique_ptr<AnnotAppearanceBBox>::operator->(void)
    mov     rdi, rax; this
    call    _ZNK19AnnotAppearanceBBox11getPageYMaxEv; AnnotAppearanceBBox::getPageYMax(void)
    jmp     short loc_527B85
loc_527B3B:
    lea     rbx, [r12+20h]
    mov     rdi, rbx; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm0, qword ptr [rax]
    movsd   [rsp+0E8h+xMin], xmm0
    mov     rdi, rbx; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm0, qword ptr [rax+8]
    movsd   [rsp+0E8h+yMin], xmm0
    mov     rdi, rbx; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm0, qword ptr [rax+10h]
    movsd   [rsp+0E8h+xMax], xmm0
    mov     rdi, rbx; this
    call    _ZNKSt3__110unique_ptrI12PDFRectangleNS_14default_deleteIS1_EEEptEv; std::unique_ptr<PDFRectangle>::operator->(void)
    movsd   xmm0, qword ptr [rax+18h]
loc_527B85:
    movsd   [rsp+0E8h+opacity], xmm0
    mov     rdi, r12; this
    call    _ZNK5Annot11getRotationEv; Annot::getRotation(void)
    lea     rsi, [rsp+0E8h+__u]; str
    mov     rdi, r15; this
    mov     edx, 0; border
    mov     rcx, r14; aColor
    movsd   xmm0, [rsp+0E8h+xMin]; xMin
    movsd   xmm1, [rsp+0E8h+yMin]; yMin
    movsd   xmm2, [rsp+0E8h+xMax]; xMax
    movsd   xmm3, [rsp+0E8h+opacity]; yMax
    mov     r8d, eax; rotate
    call    _ZN3Gfx9drawAnnotEP6ObjectP11AnnotBorderP10AnnotColorddddi; Gfx::drawAnnot(Object *,AnnotBorder *,AnnotColor *,double,double,double,double,int)
    lea     rdi, [rsp+0E8h+__u]; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    lea     rdi, [rsp+0E8h+var_60]; this
    call    _ZNSt3__111unique_lockINS_15recursive_mutexEED2Ev; std::unique_lock<std::recursive_mutex>::~unique_lock()
loc_527BDA:
    add     rsp, 0B8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
AnnotInk::draw(Gfx *,bool) endp



AnnotInk::parseInkList(Array *) proc
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 10h
    mov     r14, array
    mov     r15, this
    mov     rdi, rsi; this
    call    _ZNK5Array9getLengthEv; Array::getLength(void)
    mov     [this+118h], eax
    mov     edi, eax; count
    mov     esi, 8; size
    xor     edx, edx; checkoverflow
    call    _Z8gmallocniib; gmallocn(int,int,bool)
    mov     [this+110h], rax
    movsxd  rdx, dword ptr [this+118h]
    shl     rdx, 3; n
    mov     rdi, rax; s
    xor     esi, esi; c
    call    _memset
    cmp     dword ptr [this+118h], 0
    jle     short loc_527400
    xor     ebx, ebx
    mov     r12, rsp
    jmp     short loc_5273B8
loc_5273A0:
    mov     rdi, r12; this
    call    _ZN6ObjectD2Ev; Object::~Object()
    add     i, 1
    movsxd  rax, dword ptr [this+118h]
    cmp     rbx, rax
    jge     short loc_527400
loc_5273B8:
    mov     rdi, r12
    mov     rsi, array; this
    mov     edx, ebx; i
    xor     ecx, ecx; recursion
    call    _ZNK5Array3getEii; Array::get(int,int)
    mov     rdi, r12; this
    call    _ZNK6Object7isArrayEv; Object::isArray(void)
    test    al, al
    jz      short loc_5273A0
    mov     edi, 18h; unsigned __int64
    call    __Znwm; operator new(ulong)
    mov     r13, rax
    mov     rdi, r12; this
    call    _ZNK6Object8getArrayEv; Object::getArray(void)
    mov     rdi, r13; this
    mov     rsi, rax; array
    call    _ZN9AnnotPathC2EP5Array; AnnotPath::AnnotPath(Array *)
    mov     rax, [this+110h]
    mov     [rax+i*8], r13
    jmp     short loc_5273A0
loc_527400:
    add     rsp, 10h
    pop     rbx
    pop     r12
    pop     r13
    pop     array
    pop     this
    retn
AnnotInk::parseInkList(Array *) endp

