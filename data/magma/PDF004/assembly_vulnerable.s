SplashXPathScanner::clipAALine(SplashBitmap *,int *,int *,int) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 48h
    mov     [rsp+78h+var_60], x1
    mov     [rsp+78h+var_40], x0
    mov     [rsp+78h+var_78], aaBuf
    lea     ebp, ds:0[y*4]
    mov     eax, [this+10h]
    xor     ebx, ebx
    sub     eax, ebp
    cmovle  eax, ebx
    mov     [rsp+78h+var_6C], eax
    mov     eax, [this+18h]
    lea     ecx, ds:3[y*4]
    mov     edx, eax
    mov     rsi, rbp
    mov     [rsp+78h+var_48], rbp
    sub     edx, ebp
    cmp     ecx, eax
    mov     eax, 3
    cmovg   eax, edx
    mov     [rsp+78h+var_70], eax
    mov     [rsp+78h+var_58], this
    lea     rax, [rdi+20h]
    mov     [rsp+78h+var_50], rax
    jmp     short loc_46DF9C
loc_46DF90:
    add     ebx, 1
    cmp     ebx, 4
    jz      loc_46E2BF
loc_46DF9C:
    mov     rax, [rsp+78h+var_40]
    mov     r12d, [rax]
    shl     r12d, 2
    cmp     ebx, [rsp+78h+var_6C]
    mov     [rsp+78h+var_68], yy
    jl      loc_46E1C0
    cmp     ebx, [rsp+78h+var_70]
    jg      loc_46E1C0
    mov     rax, [rsp+78h+var_48]
    add     eax, ebx
    mov     rcx, [rsp+78h+var_58]
    sub     eax, [rcx+10h]
    movsxd  rsi, eax; __n
    mov     rdi, [rsp+78h+var_50]; this
    call    _ZNSt3__16vectorIN5boost9container12small_vectorI15SplashIntersectLm4ENS2_13new_allocatorIS4_EEEENS_9allocatorIS7_EEEixEm; std::vector<boost::container::small_vector<SplashIntersect,4ul,boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    mov     rbp, rax
    mov     rdi, rax; this
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEE4sizeEv; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(void)
    test    rax, rax
    jz      loc_46E1C0
    xor     r13d, r13d
    xor     ebx, ebx
    jmp     short loc_46E01F
loc_46E000:
    mov     edx, r12d
loc_46E003:
    lea     r12d, [xx1+1]
    cmp     r15d, edx
    cmovl   r12d, edx
    mov     rdi, line; this
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEE4sizeEv; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(void)
    cmp     interIdx, rax
    jnb     loc_46E1C0
loc_46E01F:
    mov     rax, [rsp+78h+var_60]
    mov     eax, [rax]
    lea     eax, ds:4[rax*4]
    cmp     r12d, eax
    jge     loc_46E1C0
    mov     rdi, line; this
    mov     rsi, interIdx; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    mov     r14d, [rax+4]
    nop     word ptr [rax+rax+00000000h]
    nop
loc_46E050:
    mov     rdi, line; this
    mov     rsi, interIdx; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    mov     r15d, [rax+8]
loc_46E05F:
    mov     rdi, line; this
    mov     rsi, interIdx; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    add     ebx, [rax+0Ch]
    add     interIdx, 1
    mov     rdi, line; this
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEE4sizeEv; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::size(void)
    cmp     interIdx, rax
    jnb     short loc_46E0C0
    mov     rdi, line; this
    mov     rsi, r13; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    cmp     [rax+4], r15d
    jle     short loc_46E0AB
    mov     eax, ebx
    and     eax, 1
    xor     ecx, ecx
    test    ebx, ebx
    setnz   cl
    mov     rdx, [rsp+78h+var_58]
    cmp     byte ptr [rdx+8], 0
    cmovnz  ecx, eax
    test    ecx, ecx
    jz      short loc_46E0C0
loc_46E0AB:
    mov     rdi, line; this
    mov     rsi, interIdx; n
    call    _ZNK5boost9container6vectorI15SplashIntersectNS0_22small_vector_allocatorINS0_13new_allocatorIS2_EEEEEixEm; boost::container::vector<SplashIntersect,boost::container::small_vector_allocator<boost::container::new_allocator<SplashIntersect>>>::operator[](ulong)
    cmp     [rax+8], r15d
    jg      short loc_46E050
    jmp     short loc_46E05F
loc_46E0C0:
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap8getWidthEv; SplashBitmap::getWidth(void)
    cmp     r14d, eax
    jle     short loc_46E0DA
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap8getWidthEv; SplashBitmap::getWidth(void)
    mov     r14d, eax
loc_46E0DA:
    cmp     r12d, r14d
    jge     loc_46E000
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap10getDataPtrEv; SplashBitmap::getDataPtr(void)
    mov     [rsp+78h+var_38], rax
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap10getRowSizeEv; SplashBitmap::getRowSize(void)
    imul    eax, dword ptr [rsp+78h+var_68]
    movsxd  rcx, eax
    add     rcx, [rsp+78h+var_38]
    mov     eax, r12d
    sar     eax, 3
    cdqe
    add     rax, rcx
    mov     ecx, r12d
    and     ecx, 7
    jz      short loc_46E14F
    mov     edx, 0FF00h
    shr     edx, cl
    and     r12d, 0FFFFFFF8h
    mov     ecx, r14d
    and     ecx, 0FFFFFFF8h
    cmp     r12d, ecx
    jnz     short loc_46E145
    mov     ecx, r14d
    and     cl, 7
    mov     esi, 0FFh
    shr     esi, cl
    and     edx, 0FEh
    or      edx, esi
loc_46E145:
    and     [p], dl
    add     p, 1
    add     r12d, 8
loc_46E14F:
    lea     ecx, [xx+7]
    cmp     ecx, r14d
    jge     short loc_46E190
    nop     dword ptr [p+00000000h]
loc_46E160:
    mov     byte ptr [p], 0
    add     p, 1
    lea     edx, [xx+8]
    add     r12d, 0Fh
    cmp     r12d, r14d
    mov     r12d, edx
    jl      short loc_46E160
    cmp     edx, r14d
    jge     loc_46E003
    jmp     short loc_46E19C
loc_46E190:
    mov     edx, r12d
    cmp     edx, r14d
    jge     loc_46E003
loc_46E19C:
    and     r14b, 7
    mov     esi, 0FFh
    mov     ecx, r14d
    shr     esi, cl
    and     [p], sil
    jmp     loc_46E003
loc_46E1C0:
    mov     rax, [rsp+78h+var_60]
    mov     eax, [rax]
    lea     ebp, ds:4[rax*4]
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap8getWidthEv; SplashBitmap::getWidth(void)
    cmp     ebp, eax
    jle     short loc_46E1E6
    mov     rdi, [rsp+78h+var_78]; this
    call    _ZN12SplashBitmap8getWidthEv; SplashBitmap::getWidth(void)
    mov     ebp, eax
loc_46E1E6:
    test    r12d, r12d
    mov     rbx, [rsp+78h+var_68]
    js      loc_46DF90
    cmp     r12d, ebp
    jge     loc_46DF90
    mov     r15, [rsp+78h+var_78]
    mov     rdi, r15; this
    call    _ZN12SplashBitmap10getDataPtrEv; SplashBitmap::getDataPtr(void)
    mov     r14, rax
    mov     rdi, r15; this
    call    _ZN12SplashBitmap10getRowSizeEv; SplashBitmap::getRowSize(void)
    imul    eax, ebx
    movsxd  rcx, eax
    add     rcx, r14
    mov     eax, r12d
    shr     eax, 3
    add     rax, rcx
    mov     ecx, r12d
    and     ecx, 7
    jz      short loc_46E261
    mov     edx, 0FF00h
    shr     edx, cl
    and     r12d, 0FFFFFFF8h
    mov     ecx, ebp
    and     ecx, 0FFFFFFF8h
    cmp     r12d, ecx
    jnz     short loc_46E257
    mov     ecx, ebp
    and     cl, 7
    mov     esi, 0FFh
    shr     esi, cl
    and     edx, esi
    and     edx, 0FEh
loc_46E257:
    and     [p], dl
    add     p, 1
    add     r12d, 8
loc_46E261:
    lea     ecx, [xx+7]
    cmp     ecx, ebp
    jge     short loc_46E2A0
    nop     word ptr [p+p+00h]
loc_46E270:
    mov     byte ptr [p], 0
    add     p, 1
    lea     ecx, [xx+8]
    add     r12d, 0Fh
    cmp     r12d, ebp
    mov     r12d, ecx
    jl      short loc_46E270
    cmp     ecx, ebp
    jge     loc_46DF90
    jmp     short loc_46E2AB
loc_46E2A0:
    mov     ecx, r12d
    cmp     ecx, ebp
    jge     loc_46DF90
loc_46E2AB:
    and     bpl, 7
    mov     edx, 0FFh
    mov     ecx, ebp
    shr     edx, cl
    and     [p], dl
    jmp     loc_46DF90
loc_46E2BF:
    add     rsp, 48h
    pop     yy
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
SplashXPathScanner::clipAALine(SplashBitmap *,int *,int *,int) endp

