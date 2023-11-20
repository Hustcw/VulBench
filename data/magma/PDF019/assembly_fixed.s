JBIG2Bitmap::combine(JBIG2Bitmap*,int,int,unsigned int) proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 58h
    mov     [rsp+88h+var_68], bitmap
    cmp     ecx, 80000000h
    jz      loc_543B5A
    mov     r15d, ecx
    mov     ebp, edx
    mov     r13, this
    mov     eax, ecx
    neg     eax
    mov     r14d, ecx
    sar     r14d, 1Fh
    and     r14d, eax
    mov     rax, [rsp+88h+var_68]
    mov     eax, [rax+10h]
    lea     ecx, [rax+y]
    mov     edx, [rdi+10h]
    mov     edi, edx
    sub     edi, r15d
    cmp     ecx, edx
    cmovle  edi, eax
    cmp     r14d, edi
    jge     loc_543B5A
    mov     ebx, r8d
    mov     eax, ebp
    and     eax, 0FFFFFFF8h
    xor     r12d, r12d
    test    ebp, ebp
    cmovns  r12d, eax
    mov     rax, [rsp+88h+var_68]
    mov     esi, [rax+0Ch]; y
    lea     rdx, [rsp+88h+z]; z
    mov     [rsp+88h+var_80], edi
    mov     edi, ebp; x
    mov     [rsp+88h+var_5C], ebp
    call    _Z10checkedAddIiEbT_S0_PS0_; checkedAdd<int>(int,int,int*)
    mov     r9d, [rsp+88h+var_80]
    mov     r11d, [rsp+88h+var_5C]
    test    al, al
    jnz     loc_543B5A
    mov     xx, r12
    mov     edi, [rsp+88h+z]
    mov     eax, [this+0Ch]
    cmp     edi, eax
    jle     short loc_5437CB
    mov     [rsp+88h+z], eax
    mov     edi, eax
loc_5437CB:
    cmp     ebp, edi
    jge     loc_543B5A
    mov     edx, edi
    and     edx, 7
    mov     eax, 0FFh
    mov     ecx, edx
    shr     eax, cl
    mov     [rsp+88h+var_78], eax
    mov     r12d, r11d
    and     r12d, 7
    mov     cl, 8
    sub     cl, dl
    mov     eax, 0FFh
    shl     eax, cl
    mov     r8d, 0FFh
    test    edx, edx
    cmovz   eax, r8d
    mov     esi, 0FFh
    mov     ecx, r12d
    shr     esi, cl
    mov     cl, 8
    mov     [rsp+88h+var_84], eax
    and     esi, eax
    add     edi, 0FFFFFFFFh
    and     edi, 0FFFFFFF8h
    mov     edx, r11d
    neg     edx
    sar     edx, 3
    movsxd  rax, edx
    mov     [rsp+88h+var_48], rax
    sub     cl, r12b
    shl     r8d, cl
    mov     [rsp+88h+var_50], r8d
    mov     eax, r11d
    shr     rax, 3
    mov     [rsp+88h+var_38], rax
    lea     eax, [rbp+8]
    mov     [rsp+88h+var_4C], eax
    mov     [rsp+88h+var_54], esi
    not     esi
    mov     [rsp+88h+var_58], esi
    mov     [rsp+88h+var_40], y
    mov     [rsp+88h+var_70], rbp
    mov     [rsp+88h+var_7C], edi
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+rax+00h]
loc_543870:
    mov     ecx, r14d
    add     ecx, r15d
    js      loc_543B25
    cmp     ecx, [this+10h]
    jge     loc_543B25
    movsxd  rdx, dword ptr [this+14h]
    movsxd  r10, ecx
    imul    r10, rdx
    add     r10, [this+18h]
    cmp     ebp, edi
    jnz     short loc_5438F0
    test    r11d, r11d
    js      loc_543948
    mov     rax, [rsp+88h+var_38]
    movzx   r8d, byte ptr [destPtr+rax]
    add     destPtr, rax
    cmp     ebx, 4; switch 5 cases
    ja      def_5438D2; jumptable 00000000005438D2 default case
    mov     rax, [rsp+88h+var_68]
    mov     rcx, [rax+18h]
    movsxd  rdx, dword ptr [rax+14h]
    movsxd  rsi, r14d
    imul    rsi, rdx
    movzx   edx, byte ptr [rcx+rsi]
    mov     ecx, ebx
def_5438D2:
    jmp     ds:jpt_5438D2[rcx*8]; switch jump
    mov     ecx, r12d; jumptable 00000000005438D2 case 0
    shr     edx, cl
    and     edx, [rsp+88h+var_84]
    or      r8d, edx
    jmp     def_5438D2; jumptable 00000000005438D2 default case
loc_5438F0:
    movsxd  rcx, r14d
    mov     r9d, ebx
    test    r11d, r11d
    js      loc_543987
    mov     rax, [rsp+88h+var_68]
    mov     x, [rax+18h]
    movsxd  rdx, dword ptr [rax+14h]
    imul    rdx, rcx
    movzx   edi, byte ptr [r11+rdx]
    mov     rax, [rsp+88h+var_38]
    movzx   esi, byte ptr [destPtr+rax]
    add     destPtr, rax
    cmp     ebx, 4; switch 5 cases
    ja      def_54392B; jumptable 000000000054392B default case
def_54392B:
    jmp     ds:jpt_54392B[r9*8]; switch jump
    lea     r8d, [src1+0FF00h]; jumptable 000000000054392B case 1
    mov     ecx, r12d
    shr     r8d, cl
    and     esi, r8d
    jmp     def_54392B; jumptable 000000000054392B default case
loc_543948:
    movzx   r8d, byte ptr [destPtr]
    cmp     ebx, 4; switch 5 cases
    ja      def_5438D2; jumptable 00000000005438D2 default case
    mov     rax, [rsp+88h+var_68]
    movsxd  rcx, dword ptr [rax+14h]
    movsxd  rdx, r14d
    imul    rdx, rcx
    mov     rcx, [rax+18h]
    add     rcx, [rsp+88h+var_48]
    movzx   ecx, byte ptr [rdx+rcx]
    mov     edx, ebx
    jmp     ds:jpt_543974[rdx*8]; switch jump
    and     ecx, [rsp+88h+var_84]; jumptable 0000000000543974 case 0
    or      r8d, ecx
    jmp     def_5438D2; jumptable 00000000005438D2 default case
loc_543987:
    mov     rax, [rsp+88h+var_68]
    movsxd  rdx, dword ptr [rax+14h]
    imul    rdx, rcx
    mov     rcx, [rax+18h]
    add     rcx, [rsp+88h+var_48]
    lea     x, [rcx+rdx]
    movzx   edi, byte ptr [rdx+rcx]
    xor     esi, esi
    jmp     short loc_543A25
    or      edx, 0FF00h; jumptable 00000000005438D2 case 1
    mov     ecx, r12d
    shr     edx, cl
    or      edx, [rsp+88h+var_78]
    and     r8d, edx
    jmp     def_5438D2; jumptable 00000000005438D2 default case
    xor     edx, 0FFh; jumptable 00000000005438D2 case 3
    mov     ecx, r12d; jumptable 00000000005438D2 case 2
    shr     edx, cl
    and     edx, [rsp+88h+var_84]
    xor     r8d, edx
    jmp     def_5438D2; jumptable 00000000005438D2 default case
    mov     ecx, r12d; jumptable 00000000005438D2 case 4
    shr     edx, cl
    and     r8d, [rsp+88h+var_58]
    and     edx, [rsp+88h+var_54]
    or      r8d, edx
    jmp     def_5438D2; jumptable 00000000005438D2 default case
    mov     r8d, edi; jumptable 000000000054392B case 2
    jmp     short loc_5439FC
    mov     r8d, edi; jumptable 000000000054392B case 3
    xor     r8d, 0FFh
loc_5439FC:
    mov     ecx, r12d
    shr     r8d, cl
    xor     esi, r8d
    jmp     short def_54392B; jumptable 000000000054392B default case
    and     esi, [rsp+88h+var_50]; jumptable 000000000054392B case 4
    mov     r8d, edi; jumptable 000000000054392B case 0
    mov     ecx, r12d
    shr     r8d, cl
    or      esi, r8d
    add     r11, rdx; jumptable 000000000054392B default case
    mov     [destPtr], sil
    add     destPtr, 1
    mov     esi, [rsp+88h+var_4C]
loc_543A25:
    mov     r15d, [rsp+88h+z]
    movzx   edx, byte ptr [r11+1]
    shl     edi, 8
    or      edi, edx
    mov     ecx, r12d
    shr     edi, cl
    add     r15d, 0FFFFFFF8h
    movzx   r8d, byte ptr [destPtr]
    movzx   ecx, dil
    cmp     esi, r15d
    jge     loc_543AD0
    add     r11, 2
    mov     r15, [rsp+88h+var_40]
    cmp     ebx, 4
    jbe     short loc_543AA9
    jmp     short def_543AA9; jumptable 0000000000543AA9 default case
    xor     ecx, r8d; jumptable 0000000000543AA9 case 3
    xor     ecx, 0FFh
    nop     word ptr [rax+rax+00000000h]
loc_543A70:
    mov     [destPtr], cl; jumptable 0000000000543AA9 case 4
    add     esi, 8
    mov     ebp, [rsp+88h+z]
    add     ebp, 0FFFFFFF8h
    movzx   r8d, byte ptr [destPtr+1]
    movzx   eax, byte ptr [r11]
    shl     edx, 8
    or      edx, eax
    mov     edi, edx
    mov     ecx, r12d
    shr     edi, cl
    add     destPtr, 1
    movzx   ecx, dil
    add     r11, 1
    mov     edx, eax
    cmp     esi, ebp
    jge     short loc_543AD5
    cmp     ebx, 4; switch 5 cases
    ja      short def_543AA9; jumptable 0000000000543AA9 default case
def_543AA9:
    jmp     ds:jpt_543AA9[r9*8]; switch jump
    or      ecx, r8d; jumptable 0000000000543AA9 case 0
    jmp     short loc_543A70; jumptable 0000000000543AA9 case 4
    mov     ecx, r8d; jumptable 0000000000543AA9 default case
    jmp     short loc_543A70; jumptable 0000000000543AA9 case 4
    and     edi, r8d; jumptable 0000000000543AA9 case 1
    mov     ecx, edi
    jmp     short loc_543A70; jumptable 0000000000543AA9 case 4
    xor     ecx, r8d; jumptable 0000000000543AA9 case 2
    jmp     short loc_543A70; jumptable 0000000000543AA9 case 4
loc_543AD0:
    mov     r15, [rsp+88h+var_40]
loc_543AD5:
    cmp     ebx, 4; switch 5 cases
    mov     r11d, [rsp+88h+var_5C]
    ja      short def_543ADF; jumptable 0000000000543ADF default case
def_543ADF:
    jmp     ds:jpt_543ADF[r9*8]; switch jump
    and     ecx, [rsp+88h+var_84]; jumptable 0000000000543ADF case 0
    jmp     short loc_543B11
    or      edi, [rsp+88h+var_78]; jumptable 0000000000543ADF case 1
    and     edi, r8d
    mov     r8d, edi
    jmp     short def_543ADF; jumptable 0000000000543ADF default case
    xor     ecx, 0FFh; jumptable 0000000000543ADF case 3
    and     ecx, [rsp+88h+var_84]; jumptable 0000000000543ADF case 2
    xor     r8d, ecx
    jmp     short def_543ADF; jumptable 0000000000543ADF default case
    and     ecx, [rsp+88h+var_84]; jumptable 0000000000543ADF case 4
    and     r8d, [rsp+88h+var_78]
loc_543B11:
    or      r8d, ecx
    mov     r9d, [rsp+88h+var_80]; jumptable 0000000000543ADF default case
    mov     rbp, [rsp+88h+var_70]
    mov     edi, [rsp+88h+var_7C]
    mov     [destPtr], r8b; jumptable 00000000005438D2 default case
loc_543B25:
    add     r14d, 1
    cmp     r14d, r9d
    jl      loc_543870
    jmp     short loc_543B5A
    or      ecx, [rsp+88h+var_78]; jumptable 0000000000543974 case 1
    and     r8d, ecx
    jmp     short def_5438D2; jumptable 00000000005438D2 default case
    xor     ecx, 0FFh; jumptable 0000000000543974 case 3
    and     ecx, [rsp+88h+var_84]; jumptable 0000000000543974 case 2
    xor     r8d, ecx
    jmp     short def_5438D2; jumptable 00000000005438D2 default case
    and     ecx, [rsp+88h+var_84]; jumptable 0000000000543974 case 4
    and     r8d, [rsp+88h+var_78]
    or      r8d, ecx
    jmp     short def_5438D2; jumptable 00000000005438D2 default case
loc_543B5A:
    add     rsp, 58h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
JBIG2Bitmap::combine(JBIG2Bitmap*,int,int,unsigned int) endp

