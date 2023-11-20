XRef::getEntry(int,bool) proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    mov     r15d, edx
    mov     r14d, esi
    mov     rbx, this
    cmp     [rdi+1Ch], esi
    jle     short loc_454213
    mov     rax, [this+10h]
    movsxd  rbp, r14d
    lea     rcx, ds:0[rbp*4]
    add     rcx, rbp
    cmp     dword ptr [rax+rcx*8+0Ch], 3
    jnz     loc_4542BE
loc_454213:
    cmp     byte ptr [this+0C8h], 0
    jz      short loc_45427C
loc_45421C:
    mov     rdi, this; this
    mov     esi, r14d; untilEntryNum
    xor     edx, edx; xrefStreamObjsNum
    call    _ZN4XRef13readXRefUntilEiPNSt3__16vectorIiNS0_9allocatorIiEEEE; XRef::readXRefUntil(int,std::vector<int> *)
    cmp     [this+1Ch], r14d
    jle     loc_4542F1
    movsxd  rbp, r14d
    mov     rax, [this+10h]
    lea     r12, ds:0[rbp*4]
    add     r12, rbp
    cmp     dword ptr [rax+r12*8+0Ch], 3
    jnz     short loc_4542BE
    test    r15b, r15b
    jz      short loc_454271
    mov     edx, offset aInvalidXrefEnt; "Invalid XRef entry {0:d}"
    mov     edi, 1; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    mov     ecx, r14d
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    mov     rax, [this+10h]
loc_454271:
    mov     dword ptr [rax+r12*8+0Ch], 0
    jmp     short loc_4542BE
loc_45427C:
    mov     rsi, [this+0C0h]
    test    rsi, rsi
    jz      short loc_45421C
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
    jz      short loc_4542D6
    mov     rax, [this+10h]
loc_4542BE:
    lea     rcx, ds:0[rbp*4]
    add     rcx, rbp
    lea     rax, [rax+rcx*8]
loc_4542CD:
    pop     this
    pop     r12
    pop     i
    pop     r15
    pop     rbp
    retn
loc_4542D6:
    mov     edx, offset aFailedToParseX; "Failed to parse XRef entry [{0:d}]."
    mov     edi, 1; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    mov     ecx, r14d
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
loc_4542F1:
    mov     eax, offset _ZN12_GLOBAL__N_114dummyXRefEntryE; `anonymous namespace'::dummyXRefEntry
    jmp     short loc_4542CD
XRef::getEntry(int,bool) endp

