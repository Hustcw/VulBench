ImageStream::getLine(void) proc
    push    r14
    push    rbx
    push    rax
    mov     rdx, [this+20h]; buffer
    test    rdx, rdx
    jz      loc_447B47
    mov     r14, this
    mov     rdi, [rdi]; this
    mov     esi, [this+18h]; nChars
    call    _ZN6Stream10doGetCharsEiPh; Stream::doGetChars(int,uchar *)
    cmp     eax, [this+18h]
    jge     short loc_447955
    cdqe
    nop     dword ptr [readChars+readChars+00000000h]
loc_447940:
    mov     rcx, [this+20h]
    mov     byte ptr [rcx+readChars], 0FFh
    add     readChars, 1
    movsxd  rcx, dword ptr [this+18h]
    cmp     rax, rcx
    jl      short loc_447940
loc_447955:
    mov     ecx, [this+10h]
    cmp     ecx, 10h
    jz      loc_447A23
    cmp     ecx, 8
    jz      loc_447B3B
    cmp     ecx, 1
    jnz     loc_447A5D
    cmp     dword ptr [this+14h], 0
    jle     loc_447B3B
    mov     rax, [this+20h]
    xor     ecx, ecx
    nop     word ptr [p+p+00000000h]
    nop
loc_447990:
    movzx   ebx, byte ptr [p]
    add     p, 1
    mov     edx, ebx
    shr     dl, 7
    mov     rsi, [this+28h]
    mov     [rsi+i], dl
    mov     edx, ebx
    shr     dl, 6
    and     dl, 1
    mov     rsi, [this+28h]
    mov     [rsi+i+1], dl
    mov     edx, ebx
    shr     dl, 5
    and     dl, 1
    mov     rsi, [this+28h]
    mov     [rsi+i+2], dl
    mov     edx, ebx
    shr     dl, 4
    and     dl, 1
    mov     rsi, [this+28h]
    mov     [rsi+i+3], dl
    mov     edx, ebx
    shr     dl, 3
    and     dl, 1
    mov     rsi, [this+28h]
    mov     [rsi+i+4], dl
    mov     edx, ebx
    shr     dl, 2
    and     dl, 1
    mov     rsi, [this+28h]
    mov     [rsi+i+5], dl
    mov     edx, ebx
    shr     dl, 1
    and     dl, 1
    mov     rsi, [this+28h]
    mov     [rsi+i+6], dl
    and     bl, 1
    mov     rdx, [this+28h]
    mov     [rdx+i+7], bl
    add     i, 8
    movsxd  rdx, dword ptr [this+14h]
    cmp     rcx, rdx
    jl      loc_447990
    jmp     loc_447B3B
loc_447A23:
    cmp     dword ptr [this+14h], 0
    jle     loc_447B3B
    mov     rax, [this+20h]
    xor     ecx, ecx
    nop     word ptr [rax+rax+00000000h]
    xchg    ax, ax
loc_447A40:
    movzx   edx, byte ptr [rax+i*2]
    mov     rsi, [this+28h]
    mov     [rsi+i], dl
    add     i, 1
    movsxd  rdx, dword ptr [this+14h]
    cmp     rcx, rdx
    jl      short loc_447A40
    jmp     loc_447B3B
loc_447A5D:
    mov     r8d, 0FFFFFFFFh
    shl     r8d, cl
    cmp     dword ptr [this+14h], 0
    jle     loc_447B3B
    xor     r8d, 0FFh
    mov     rsi, [this+20h]
    xor     r9d, r9d
    xor     eax, eax
    xor     edi, edi
    cmp     eax, ecx
    jl      short loc_447AC2
    nop     word ptr [bits+bits+00000000h]
loc_447A90:
    mov     edx, eax
    sub     edx, ecx
    mov     rbx, buf
    mov     ecx, edx
    shr     rbx, cl
    and     ebx, r8d
    mov     rcx, [this+28h]
    mov     [rcx+i], bl
    mov     ecx, [this+10h]
    sub     eax, ecx
    add     i, 1
    movsxd  rdx, dword ptr [this+14h]
    cmp     r9, rdx
    jge     loc_447B3B
    cmp     eax, ecx
    jge     short loc_447A90
loc_447AC2:
    mov     r10d, eax
    not     r10d
    add     r10d, ecx
    mov     edx, r10d
    shr     edx, 3
    add     edx, 1
    and     edx, 3
    jz      short loc_447AF5
    neg     edx
    nop     dword ptr [bits+bits+00h]
loc_447AE0:
    shl     buf, 8
    movzx   ebx, byte ptr [p]
    add     p, 1
    or      rdi, rbx
    add     eax, 8
    inc     edx
    jnz     short loc_447AE0
loc_447AF5:
    cmp     r10d, 18h
    jb      short loc_447A90
    nop     dword ptr [rax+rax+00h]
loc_447B00:
    shl     buf, 8
    movzx   edx, byte ptr [p]
    or      rdx, rdi
    shl     buf, 8
    movzx   edi, byte ptr [p+1]
    or      rdi, rdx
    shl     buf, 8
    movzx   edx, byte ptr [p+2]
    or      rdx, rdi
    shl     buf, 8
    movzx   edi, byte ptr [p+3]
    add     p, 4
    or      rdi, rdx
    add     eax, 20h ; ' '
    cmp     eax, ecx
    jl      short loc_447B00
    jmp     loc_447A90
loc_447B3B:
    mov     rax, [this+28h]
loc_447B3F:
    add     rsp, 8
    pop     rbx
    pop     r14
    retn
loc_447B47:
    xor     eax, eax
    jmp     short loc_447B3F
ImageStream::getLine(void) endp



EmbedStream::getChars(int,unsigned char *) proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    test    esi, esi
    jle     short loc_448BC0
    mov     r14, buffer
    mov     rbx, this
    cmp     byte ptr [rdi+33h], 0
    jz      short loc_448BC8
    mov     rbp, [this+48h]
    mov     rax, [this+50h]
    mov     r12d, 0FFFFFFFFh
    cmp     rbp, rax
    jle     loc_448C41
    sub     ebp, eax
    cmp     ebp, esi
    cmovle  esi, ebp
    mov     rax, [this+38h]
    movsxd  rdx, esi; n
    mov     rdi, buffer; dest
    mov     nChars, rax; src
    call    _memcpy
    mov     r12d, ebp
    jmp     loc_448C41
loc_448BC0:
    xor     r12d, r12d
    jmp     loc_448C41
loc_448BC8:
    cmp     byte ptr [this+30h], 0
    jz      short loc_448BDD
    mov     rax, [this+10h]
    movsxd  rcx, esi
    cmp     rax, rcx
    cmovge  eax, esi
    mov     esi, eax; nChars
loc_448BDD:
    mov     rdi, [this+28h]; this
    mov     rdx, buffer; buffer
    call    _ZN6Stream10doGetCharsEiPh; Stream::doGetChars(int,uchar *)
    mov     r12d, eax
    cmp     byte ptr [this+32h], 0
    jz      short loc_448C41
    mov     rsi, [this+40h]
    mov     rdi, [this+48h]
    movsxd  r15, r12d
    lea     rax, [rdi+r15]
    cmp     rax, rsi
    jge     short loc_448C10
    mov     rax, [this+38h]
    jmp     short loc_448C2F
loc_448C10:
    add     rsi, rsi; size
    cmp     rax, rsi
    jge     short loc_448C10
    mov     [this+40h], rsi
    mov     rdi, [this+38h]; p
    xor     edx, edx; checkoverflow
    call    _Z8greallocPvmb; grealloc(void *,ulong,bool)
    mov     [this+38h], rax
    mov     rdi, [this+48h]
loc_448C2F:
    add     rdi, rax; dest
    mov     rsi, buffer; src
    mov     rdx, r15; n
    call    _memcpy
    add     [this+48h], r15
loc_448C41:
    mov     eax, r12d
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    pop     rbp
    retn
EmbedStream::getChars(int,unsigned char *) endp

