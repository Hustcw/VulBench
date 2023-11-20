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
    jz      loc_4A29A0
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
    jge     loc_4A29A0
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
    jnz     loc_4A29A0
    mov     xx, r12
    mov     edi, [rsp+88h+z]
    mov     eax, [this+0Ch]
    cmp     edi, eax
    jle     short loc_4A262B
    mov     [rsp+88h+z], eax
    mov     edi, eax
loc_4A262B:
    cmp     ebp, edi
    jge     loc_4A29A0
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
    jmp     short loc_4A26EE
    xor     ecx, 0FFh; jumptable 00000000004A2943 case 3
    and     ecx, [rsp+88h+var_84]; jumptable 00000000004A2943 case 2
    xor     r8d, ecx
    mov     r9d, [rsp+88h+var_80]; jumptable 00000000004A2943 default case
    mov     rbp, [rsp+88h+var_70]
    mov     edi, [rsp+88h+var_7C]
    mov     [destPtr], r8b; jumptable 00000000004A273A default case
    add     r14d, 1
    cmp     r14d, r9d
    jge     loc_4A29A0
loc_4A26EE:
    lea     ecx, [yy+y]
    movsxd  rdx, dword ptr [this+14h]
    movsxd  r10, ecx
    imul    r10, rdx
    add     r10, [this+18h]
    cmp     ebp, edi
    jnz     short loc_4A2750
    test    r11d, r11d
    js      loc_4A27A8
    mov     rax, [rsp+88h+var_38]
    movzx   r8d, byte ptr [destPtr+rax]
    add     destPtr, rax
    cmp     ebx, 4; switch 5 cases
    ja      short def_4A273A; jumptable 00000000004A273A default case
    mov     rax, [rsp+88h+var_68]
    mov     rcx, [rax+18h]
    movsxd  rdx, dword ptr [rax+14h]
    movsxd  rsi, r14d
    imul    rsi, rdx
    movzx   edx, byte ptr [rcx+rsi]
    mov     ecx, ebx
def_4A273A:
    jmp     ds:jpt_4A273A[rcx*8]; switch jump
    mov     ecx, r12d; jumptable 00000000004A273A case 0
    shr     edx, cl
    and     edx, [rsp+88h+var_84]
    or      r8d, edx
    jmp     short def_4A273A; jumptable 00000000004A273A default case
loc_4A2750:
    movsxd  rcx, r14d
    mov     r9d, ebx
    test    r11d, r11d
    js      loc_4A27E7
    mov     rax, [rsp+88h+var_68]
    mov     x, [rax+18h]
    movsxd  rdx, dword ptr [rax+14h]
    imul    rdx, rcx
    movzx   edi, byte ptr [r11+rdx]
    mov     rax, [rsp+88h+var_38]
    movzx   esi, byte ptr [destPtr+rax]
    add     destPtr, rax
    cmp     ebx, 4; switch 5 cases
    ja      def_4A278B; jumptable 00000000004A278B default case
def_4A278B:
    jmp     ds:jpt_4A278B[r9*8]; switch jump
    lea     r8d, [src1+0FF00h]; jumptable 00000000004A278B case 1
    mov     ecx, r12d
    shr     r8d, cl
    and     esi, r8d
    jmp     def_4A278B; jumptable 00000000004A278B default case
loc_4A27A8:
    movzx   r8d, byte ptr [destPtr]
    cmp     ebx, 4; switch 5 cases
    ja      def_4A273A; jumptable 00000000004A273A default case
    mov     rax, [rsp+88h+var_68]
    movsxd  rcx, dword ptr [rax+14h]
    movsxd  rdx, r14d
    imul    rdx, rcx
    mov     rcx, [rax+18h]
    add     rcx, [rsp+88h+var_48]
    movzx   ecx, byte ptr [rdx+rcx]
    mov     edx, ebx
    jmp     ds:jpt_4A27D4[rdx*8]; switch jump
    and     ecx, [rsp+88h+var_84]; jumptable 00000000004A27D4 case 0
    or      r8d, ecx
    jmp     def_4A273A; jumptable 00000000004A273A default case
loc_4A27E7:
    mov     rax, [rsp+88h+var_68]
    movsxd  rdx, dword ptr [rax+14h]
    imul    rdx, rcx
    mov     rcx, [rax+18h]
    add     rcx, [rsp+88h+var_48]
    lea     x, [rcx+rdx]
    movzx   edi, byte ptr [rdx+rcx]
    xor     esi, esi
    jmp     short loc_4A2885
    or      edx, 0FF00h; jumptable 00000000004A273A case 1
    mov     ecx, r12d
    shr     edx, cl
    or      edx, [rsp+88h+var_78]
    and     r8d, edx
    jmp     def_4A273A; jumptable 00000000004A273A default case
    xor     edx, 0FFh; jumptable 00000000004A273A case 3
    mov     ecx, r12d; jumptable 00000000004A273A case 2
    shr     edx, cl
    and     edx, [rsp+88h+var_84]
    xor     r8d, edx
    jmp     def_4A273A; jumptable 00000000004A273A default case
    mov     ecx, r12d; jumptable 00000000004A273A case 4
    shr     edx, cl
    and     r8d, [rsp+88h+var_58]
    and     edx, [rsp+88h+var_54]
    or      r8d, edx
    jmp     def_4A273A; jumptable 00000000004A273A default case
    mov     r8d, edi; jumptable 00000000004A278B case 2
    jmp     short loc_4A285C
    mov     r8d, edi; jumptable 00000000004A278B case 3
    xor     r8d, 0FFh
loc_4A285C:
    mov     ecx, r12d
    shr     r8d, cl
    xor     esi, r8d
    jmp     short def_4A278B; jumptable 00000000004A278B default case
    and     esi, [rsp+88h+var_50]; jumptable 00000000004A278B case 4
    mov     r8d, edi; jumptable 00000000004A278B case 0
    mov     ecx, r12d
    shr     r8d, cl
    or      esi, r8d
    add     r11, rdx; jumptable 00000000004A278B default case
    mov     [destPtr], sil
    add     destPtr, 1
    mov     esi, [rsp+88h+var_4C]
loc_4A2885:
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
    jge     loc_4A2930
    add     r11, 2
    mov     r15, [rsp+88h+var_40]
    cmp     ebx, 4
    jbe     short loc_4A2909
    jmp     short def_4A2909; jumptable 00000000004A2909 default case
    xor     ecx, r8d; jumptable 00000000004A2909 case 3
    xor     ecx, 0FFh
    nop     word ptr [rax+rax+00000000h]
loc_4A28D0:
    mov     [destPtr], cl; jumptable 00000000004A2909 case 4
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
    jge     short loc_4A2935
    cmp     ebx, 4; switch 5 cases
    ja      short def_4A2909; jumptable 00000000004A2909 default case
def_4A2909:
    jmp     ds:jpt_4A2909[r9*8]; switch jump
    or      ecx, r8d; jumptable 00000000004A2909 case 0
    jmp     short loc_4A28D0; jumptable 00000000004A2909 case 4
    mov     ecx, r8d; jumptable 00000000004A2909 default case
    jmp     short loc_4A28D0; jumptable 00000000004A2909 case 4
    and     edi, r8d; jumptable 00000000004A2909 case 1
    mov     ecx, edi
    jmp     short loc_4A28D0; jumptable 00000000004A2909 case 4
    xor     ecx, r8d; jumptable 00000000004A2909 case 2
    jmp     short loc_4A28D0; jumptable 00000000004A2909 case 4
loc_4A2930:
    mov     r15, [rsp+88h+var_40]
loc_4A2935:
    cmp     ebx, 4; switch 5 cases
    mov     r11d, [rsp+88h+var_5C]
    ja      def_4A2943; jumptable 00000000004A2943 default case
def_4A2943:
    jmp     ds:jpt_4A2943[r9*8]; switch jump
    and     ecx, [rsp+88h+var_84]; jumptable 00000000004A2943 case 0
    jmp     short loc_4A2969
    or      edi, [rsp+88h+var_78]; jumptable 00000000004A2943 case 1
    and     edi, r8d
    mov     r8d, edi
    jmp     def_4A2943; jumptable 00000000004A2943 default case
    and     ecx, [rsp+88h+var_84]; jumptable 00000000004A2943 case 4
    and     r8d, [rsp+88h+var_78]
loc_4A2969:
    or      r8d, ecx
    jmp     def_4A2943; jumptable 00000000004A2943 default case
    or      ecx, [rsp+88h+var_78]; jumptable 00000000004A27D4 case 1
    and     r8d, ecx
    jmp     def_4A273A; jumptable 00000000004A273A default case
    xor     ecx, 0FFh; jumptable 00000000004A27D4 case 3
    and     ecx, [rsp+88h+var_84]; jumptable 00000000004A27D4 case 2
    xor     r8d, ecx
    jmp     def_4A273A; jumptable 00000000004A273A default case
    and     ecx, [rsp+88h+var_84]; jumptable 00000000004A27D4 case 4
    and     r8d, [rsp+88h+var_78]
    or      r8d, ecx
    jmp     def_4A273A; jumptable 00000000004A273A default case
loc_4A29A0:
    add     rsp, 58h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
JBIG2Bitmap::combine(JBIG2Bitmap*,int,int,unsigned int) endp

