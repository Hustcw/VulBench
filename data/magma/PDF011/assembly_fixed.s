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

