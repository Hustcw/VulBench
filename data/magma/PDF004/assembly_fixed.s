SplashXPathScanner::clipAALine(SplashBitmap *,int *,int *,int) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 48h
    mov     [rsp+78h+var_58], x1
    mov     [rsp+78h+var_40], x0
    mov     [rsp+78h+var_78], aaBuf
    lea     ebp, ds:0[y*4]
    mov     eax, [this+10h]
    xor     ebx, ebx
    sub     eax, ebp
    cmovle  eax, ebx
    mov     [rsp+78h+var_64], eax
    mov     eax, [this+18h]
    lea     ecx, ds:3[y*4]
    mov     edx, eax
    mov     rsi, rbp
    mov     [rsp+78h+var_48], rbp
    sub     edx, ebp
    cmp     ecx, eax
    mov     eax, 3
    cmovg   eax, edx
    mov     [rsp+78h+var_68], eax
    mov     [rsp+78h+var_50], this
    lea     rax, [rdi+20h]
    mov     [rsp+78h+var_60], rax
    jmp     short loc_4FA591
loc_4FA580:
    mov     rbx, [rsp+78h+var_70]
    add     ebx, 1
    cmp     ebx, 4
    jz      loc_4FA8CF
loc_4FA591:
    mov     rax, [rsp+78h+var_40]
    mov     r12d, [rax]
    shl     r12d, 2
    cmp     ebx, [rsp+78h+var_64]
    mov     [rsp+78h+var_70], yy
    jl      loc_4FA7D0
    cmp     ebx, [rsp+78h+var_68]
    jg      loc_4FA7D0
    mov     rax, [rsp+78h+var_48]
    add     ebx, eax
    mov     rax, [rsp+78h+var_50]
    sub     ebx, [rax+10h]
    js      loc_4FA8CF
    mov     ebp, ebx
    mov     rdi, [rsp+78h+var_60]; this
    call    _ZNKSt3__16vectorIN5boost9container12small_vectorI15SplashIntersectLm4ENS2_13new_allocatorIS4_EEEENS_9allocatorIS7_EEE4sizeEv; std::vector<boost::container::small_vector<SplashIntersect,4ul,boost::container::new_allocator<SplashIntersect>>>::size(void)
    cmp     rax, rbp
    jbe     loc_4FA8CF
    movsxd  rsi, ebx; __n
    mov     rdi, [rsp+78h+var_60]; this
    call    _ZNSt3__16vectorIN5boost9container12small_vectorI15SplashIntersectLm4ENS2_13new_allocatorIS4_EEEENS_9allocatorIS7_EEEixEm; std::vector<boost::container::small_vector<SplashIntersect,4ul,boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    mov     rbp, rax
    mov     rdi, rax; this
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEE4sizeEv; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(void)
    test    rax, rax
    jz      loc_4FA7D0
    xor     r14d, r14d
    xor     ebx, ebx
    jmp     short loc_4FA62F
loc_4FA610:
    mov     edx, r12d
loc_4FA613:
    lea     r12d, [xx1+1]
    cmp     r15d, edx
    cmovl   r12d, edx
    mov     rdi, line; this
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEE4sizeEv; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(void)
    cmp     interIdx, rax
    jnb     loc_4FA7D0
loc_4FA62F:
    mov     rax, [rsp+78h+var_58]
    mov     eax, [rax]
    lea     eax, ds:4[rax*4]
    cmp     r12d, eax
    jge     loc_4FA7D0
    mov     rdi, line; this
    mov     rsi, interIdx; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    mov     r13d, [rax+4]
    nop     word ptr [rax+rax+00000000h]
    nop
loc_4FA660:
    mov     rdi, line; this
    mov     rsi, interIdx; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    mov     r15d, [rax+8]
loc_4FA66F:
    mov     rdi, line; this
    mov     rsi, interIdx; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    add     ebx, [rax+0Ch]
    add     interIdx, 1
    mov     rdi, line; this
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEE4sizeEv; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(void)
    cmp     interIdx, rax
    jnb     short loc_4FA6D0
    mov     rdi, line; this
    mov     rsi, r14; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    cmp     [rax+4], r15d
    jle     short loc_4FA6BB
    mov     eax, ebx
    and     eax, 1
    xor     ecx, ecx
    test    ebx, ebx
    setnz   cl
    mov     rdx, [rsp+78h+var_50]
    cmp     byte ptr [rdx+8], 0
    cmovnz  ecx, eax
    test    ecx, ecx
    jz      short loc_4FA6D0
loc_4FA6BB:
    mov     rdi, line; this
    mov     rsi, interIdx; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    cmp     [rax+8], r15d
    jg      short loc_4FA660
    jmp     short loc_4FA66F
loc_4FA6D0:
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap8getWidthEv; SplashBitmap::getWidth(void)
    cmp     r13d, eax
    jle     short loc_4FA6EA
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap8getWidthEv; SplashBitmap::getWidth(void)
    mov     r13d, eax
loc_4FA6EA:
    cmp     r12d, r13d
    jge     loc_4FA610
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap10getDataPtrEv; SplashBitmap::getDataPtr(void)
    mov     [rsp+78h+var_38], rax
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap10getRowSizeEv; SplashBitmap::getRowSize(void)
    imul    eax, dword ptr [rsp+78h+var_70]
    movsxd  rcx, eax
    add     rcx, [rsp+78h+var_38]
    mov     eax, r12d
    sar     eax, 3
    cdqe
    add     rax, rcx
    mov     ecx, r12d
    and     ecx, 7
    jz      short loc_4FA75F
    mov     edx, 0FF00h
    shr     edx, cl
    and     r12d, 0FFFFFFF8h
    mov     ecx, r13d
    and     ecx, 0FFFFFFF8h
    cmp     r12d, ecx
    jnz     short loc_4FA755
    mov     ecx, r13d
    and     cl, 7
    mov     esi, 0FFh
    shr     esi, cl
    and     edx, 0FEh
    or      edx, esi
loc_4FA755:
    and     [p], dl
    add     p, 1
    add     r12d, 8
loc_4FA75F:
    lea     ecx, [xx+7]
    cmp     ecx, r13d
    jge     short loc_4FA7A0
    nop     dword ptr [p+00000000h]
loc_4FA770:
    mov     byte ptr [p], 0
    add     p, 1
    lea     edx, [xx+8]
    add     r12d, 0Fh
    cmp     r12d, r13d
    mov     r12d, edx
    jl      short loc_4FA770
    cmp     edx, r13d
    jge     loc_4FA613
    jmp     short loc_4FA7AC
loc_4FA7A0:
    mov     edx, r12d
    cmp     edx, r13d
    jge     loc_4FA613
loc_4FA7AC:
    and     r13b, 7
    mov     esi, 0FFh
    mov     ecx, r13d
    shr     esi, cl
    and     [p], sil
    jmp     loc_4FA613
loc_4FA7D0:
    mov     rax, [rsp+78h+var_58]
    mov     eax, [rax]
    lea     ebp, ds:4[rax*4]
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap8getWidthEv; SplashBitmap::getWidth(void)
    cmp     ebp, eax
    jle     short loc_4FA7F6
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap8getWidthEv; SplashBitmap::getWidth(void)
    mov     ebp, eax
loc_4FA7F6:
    test    r12d, r12d
    js      loc_4FA580
    cmp     r12d, ebp
    jge     loc_4FA580
    mov     rbx, [rsp+78h+var_78]
    mov     rdi, yy; this
    call    _ZN12SplashBitmap10getDataPtrEv; SplashBitmap::getDataPtr(void)
    mov     r14, rax
    mov     rdi, yy; this
    call    _ZN12SplashBitmap10getRowSizeEv; SplashBitmap::getRowSize(void)
    imul    eax, dword ptr [rsp+78h+var_70]
    movsxd  rcx, eax
    add     rcx, r14
    mov     eax, r12d
    shr     eax, 3
    add     rax, rcx
    mov     ecx, r12d
    and     ecx, 7
    jz      short loc_4FA86E
    mov     edx, 0FF00h
    shr     edx, cl
    and     r12d, 0FFFFFFF8h
    mov     ecx, ebp
    and     ecx, 0FFFFFFF8h
    cmp     r12d, ecx
    jnz     short loc_4FA864
    mov     ecx, ebp
    and     cl, 7
    mov     esi, 0FFh
    shr     esi, cl
    and     edx, esi
    and     edx, 0FEh
loc_4FA864:
    and     [p], dl
    add     p, 1
    add     r12d, 8
loc_4FA86E:
    lea     ecx, [xx+7]
    cmp     ecx, ebp
    jge     short loc_4FA8B0
    nop     word ptr [p+p+00000000h]
loc_4FA880:
    mov     byte ptr [p], 0
    add     p, 1
    lea     ecx, [xx+8]
    add     r12d, 0Fh
    cmp     r12d, ebp
    mov     r12d, ecx
    jl      short loc_4FA880
    cmp     ecx, ebp
    jge     loc_4FA580
    jmp     short loc_4FA8BB
loc_4FA8B0:
    mov     ecx, r12d
    cmp     ecx, ebp
    jge     loc_4FA580
loc_4FA8BB:
    and     bpl, 7
    mov     edx, 0FFh
    mov     ecx, ebp
    shr     edx, cl
    and     [p], dl
    jmp     loc_4FA580
loc_4FA8CF:
    add     rsp, 48h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
SplashXPathScanner::clipAALine(SplashBitmap *,int *,int *,int) endp

