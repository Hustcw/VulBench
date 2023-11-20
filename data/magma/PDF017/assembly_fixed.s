FoFiTrueType::cvtSfnts(void (*)(void *,char const*,int),void *,GooString const*,bool,int *)const proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 298h
    mov     rbp, maxUsedGlyph
    mov     [rsp+2C8h+var_2B4], r8d
    mov     r15, name
    mov     r14, outputStream
    mov     r12, outputFunc
    mov     rbx, this
    pxor    xmm0, xmm0
    movdqa  [rsp+2C8h+var_258], xmm0
    movdqa  [rsp+2C8h+var_248], xmm0
    mov     [rsp+2C8h+var_238], 1000000h
    mov     byte ptr [rsp+2C8h+var_258+1], 1
    mov     byte ptr [rsp+2C8h+var_248+5], 1
    mov     dword ptr [r9], 0FFFFFFFFh
    mov     esi, offset tag; "head"
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    test    eax, eax
    js      loc_50333A
    mov     rdi, this; this
    cmp     eax, [rbx+20h]
    jge     loc_50333A
    mov     rcx, [this+18h]
    cdqe
    lea     rax, [rax+rax*4]
    mov     ebx, [rcx+rax*4+8]
    mov     esi, ebx; pos
    mov     edx, 36h ; '6'; size
    mov     [rsp+2C8h+var_2C0], this
    call    _ZNK8FoFiBase11checkRegionEii; FoFiBase::checkRegion(int,int)
    mov     rdx, [rsp+2C8h+var_2C0]
    test    al, al
    jz      loc_50333A
    mov     [rsp+2C8h+var_270], maxUsedGlyph
    mov     [rsp+2C8h+var_230], name
    mov     [rsp+2C8h+var_2B0], outputStream
    mov     [rsp+2C8h+var_2A8], outputFunc
    movsxd  rax, ebx
    mov     rcx, [rdx+8]
    movdqu  xmm0, xmmword ptr [rcx+rax]
    movdqu  xmm1, xmmword ptr [rcx+rax+10h]
    movupd  xmm2, xmmword ptr [rcx+rax+20h]
    movdqa  xmmword ptr [rsp+2C8h+data], xmm0
    mov     rax, [rcx+rax+2Eh]
    mov     [rsp+2C8h+var_1EA], rax
    movapd  xmmword ptr [rsp+0D0h], xmm2
    movdqa  [rsp+2C8h+var_208], xmm1
    mov     dword ptr [rsp+2C8h+data+8], 0
    cmp     dword ptr [rdx+38h], 2
    jb      short loc_5027B3
    mov     word ptr [rsp+2C8h+var_1EA+4], 100h
loc_5027B3:
    mov     edi, [rdx+34h]
    add     edi, 1; count
    mov     esi, 10h; size
    xor     edx, edx; checkoverflow
    call    _Z8gmallocniib; gmallocn(int,int,bool)
    mov     rbp, rax
    mov     esi, offset aLoca; "loca"
    mov     rdi, [rsp+2C8h+var_2C0]; this
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    mov     rcx, [rsp+2C8h+var_2C0]
    mov     pos, [rcx+18h]
    cdqe
    lea     rax, [rax+rax*4]
    mov     r13d, [rbx+rax*4+8]
    mov     esi, offset aGlyf; "glyf"
    mov     rdi, [rsp+2C8h+var_2C0]; this
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    mov     r15, [rsp+2C8h+var_2C0]
    cdqe
    lea     rax, [rax+rax*4]
    mov     r12d, [rbx+rax*4+10h]
    mov     [rsp+2C8h+ok], 1
    mov     eax, [r15+34h]
    test    eax, eax
    mov     [rsp+2C8h+p], locaTable
    js      short loc_502888
    add     rbp, 4
    mov     r14, 0FFFFFFFFFFFFFFFFh
    mov     ebx, r13d
    jmp     short loc_502863
loc_502830:
    mov     rdi, r15; this
    mov     esi, ebx; pos
    lea     rdx, [rsp+2C8h+ok]; ok
    call    _ZNK8FoFiBase8getU16BEEiPb; FoFiBase::getU16BE(int,bool *)
    add     eax, eax
loc_502841:
    cmp     eax, r12d
    cmovg   eax, r12d
    mov     [rbp+0], eax
    movsxd  rax, dword ptr [r15+34h]
    add     ebx, 2
    add     rbp, 10h
    add     r14, 1
    add     r13d, 4
    cmp     r14, rax
    jge     short loc_502883
loc_502863:
    lea     eax, [r14+1]
    mov     [rbp-4], eax
    cmp     dword ptr [r15+38h], 0
    jz      short loc_502830
    mov     rdi, r15; this
    mov     esi, r13d; pos
    lea     rdx, [rsp+2C8h+ok]; ok
    call    _ZNK8FoFiBase8getU32BEEiPb; FoFiBase::getU32BE(int,bool *)
    jmp     short loc_502841
loc_502883:
    mov     rbp, [rsp+2C8h+p]
loc_502888:
    cdqe
    shl     rax, 4
    lea     rsi, [rax+rbp]
    add     rsi, 10h; __last
    mov     rdi, rbp; __first
    call    _ZNSt3__14sortIP12TrueTypeLoca28cmpTrueTypeLocaOffsetFunctorEEvT_S4_T0_; std::sort<TrueTypeLoca *,cmpTrueTypeLocaOffsetFunctor>(TrueTypeLoca *,TrueTypeLoca *,cmpTrueTypeLocaOffsetFunctor)
    movsxd  r9, dword ptr [r15+34h]
    test    r9, r9
    mov     r13, rbp
    mov     glyfTableLen, [rsp+2C8h+var_270]
    jle     short loc_502915
    mov     edx, [r13+4]
    mov     r8d, r9d
    and     r8d, 1
    cmp     r9d, 1
    jnz     short loc_5028C9
    xor     esi, esi
    test    r8, r8
    jnz     short loc_502905
    jmp     short loc_502915
loc_5028C9:
    lea     rdi, [r13+24h]
    mov     rax, r9
    sub     rax, r8
    xor     esi, esi
    mov     ecx, edx
    nop     word ptr [rax+rax+00000000h]
loc_5028E0:
    mov     ebp, [rdi-10h]
    mov     edx, [rdi]
    mov     ebx, edx
    sub     ebx, ebp
    sub     ebp, ecx
    mov     [rdi-18h], ebp
    add     rsi, 2
    mov     [rdi-8], ebx
    add     rdi, 20h ; ' '
    mov     ecx, edx
    cmp     rax, rsi
    jnz     short loc_5028E0
    test    r8, r8
    jz      short loc_502915
loc_502905:
    shl     i, 4
    mov     eax, [r13+rsi+14h]
    sub     eax, edx
    mov     [r13+rsi+0Ch], eax
loc_502915:
    shl     r9, 4
    mov     dword ptr [r13+r9+0Ch], 0
    lea     rsi, [r9+r13]
    add     rsi, 10h; __last
    mov     rdi, r13; __first
    call    _ZNSt3__14sortIP12TrueTypeLoca25cmpTrueTypeLocaIdxFunctorEEvT_S4_T0_; std::sort<TrueTypeLoca *,cmpTrueTypeLocaIdxFunctor>(TrueTypeLoca *,TrueTypeLoca *,cmpTrueTypeLocaIdxFunctor)
    mov     rcx, [rsp+2C8h+var_2C0]
    mov     edi, [rcx+34h]
    test    edi, edi
    js      short loc_5029B9
    lea     rbp, [r13+0Ch]
    xor     r14d, r14d
    mov     rbx, 0FFFFFFFFFFFFFFFFh
    lea     r15, [rsp+2C8h+z]
    jmp     short loc_502971
loc_502960:
    movsxd  rdi, dword ptr [rcx+34h]
    add     rbx, 1
    add     rbp, 10h
    cmp     rbx, rdi
    jge     short loc_5029B9
loc_502971:
    mov     [rbp-4], r14d
    mov     esi, [rbp+0]; y
    mov     edi, r14d; x
    mov     rdx, r15; z
    call    _Z10checkedAddIiEbT_S0_PS0_; checkedAdd<int>(int,int,int*)
    test    al, al
    jnz     short loc_5029B2
    mov     r14d, [rsp+2C8h+z]
    mov     eax, r14d
    and     eax, 3
    jz      short loc_50299E
    sub     r14d, eax
    add     r14d, 4
loc_50299E:
    mov     rcx, [rsp+2C8h+var_2C0]
    cmp     dword ptr [rbp+0], 0
    jle     short loc_502960
    lea     eax, [rbx+1]
    mov     [r12], eax
    jmp     short loc_502960
loc_5029B2:
    mov     [rsp+2C8h+ok], 0
    jmp     short loc_50299E
loc_5029B9:
    add     edi, 1; count
    xor     eax, eax
    cmp     dword ptr [rcx+38h], 0
    setnz   al
    lea     esi, [rax+rax]
    add     esi, 2; size
    mov     [rsp+2C8h+var_298], 0
    xor     edx, edx; checkoverflow
    call    _Z8gmallocniib; gmallocn(int,int,bool)
    mov     rdi, [rsp+2C8h+var_2C0]; this
    cmp     dword ptr [rdi+34h], 0
    js      short loc_502A4C
    xor     ebp, ebp
    jmp     short loc_502A15
loc_5029F0:
    mov     edx, ecx
    shr     edx, 9
    mov     [locaData+i*2], dl
    shr     ecx, 1
    lea     rdx, ds:1[i]
    add     rdx, i
loc_502A05:
    mov     [locaData+rdx], cl
    movsxd  rcx, dword ptr [rdi+34h]
    cmp     rbp, rcx
    lea     rbp, [rbp+1]
    jge     short loc_502A4C
loc_502A15:
    mov     rcx, i
    shl     rcx, 4
    mov     ecx, [r13+rcx+8]
    cmp     dword ptr [rdi+38h], 0
    jz      short loc_5029F0
    mov     edx, ecx
    shr     edx, 18h
    lea     esi, ds:0[i*4]
    mov     [locaData+rsi], dl
    mov     edx, ecx
    shr     edx, 10h
    mov     [locaData+rsi+1], dl
    mov     [locaData+rsi+2], ch
    lea     edx, ds:3[i*4]
    jmp     short loc_502A05
loc_502A4C:
    mov     [rsp+2C8h+var_278], locaData
    mov     esi, offset aVhea; "vhea"
    mov     rbp, rdi
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    mov     ebx, eax
    not     ebx
    shr     ebx, 1Fh
    mov     esi, offset aVmtx; "vmtx"
    mov     rdi, rbp; this
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    not     eax
    shr     eax, 1Fh
    lea     eax, [rbx+rax]
    add     eax, 9
    mov     [rsp+2C8h+var_29C], eax
    cmp     byte ptr [rsp+2C8h+var_2B4], 0
    jz      short loc_502AEE
    mov     esi, offset aVhea; "vhea"
    mov     rdi, rbp; this
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    mov     r14d, eax
    mov     esi, offset aVmtx; "vmtx"
    mov     rdi, rbp; this
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    mov     ebx, eax
    or      eax, r14d
    jns     short loc_502AEE
    mov     esi, offset tag; "head"
    mov     rdi, rbp; this
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    mov     rcx, [rbp+18h]
    cdqe
    lea     rax, [rax+rax*4]
    mov     esi, [rcx+rax*4+8]
    add     esi, 12h; pos
    lea     rdx, [rsp+2C8h+ok]; ok
    mov     rdi, rbp; this
    call    _ZNK8FoFiBase8getU16BEEiPb; FoFiBase::getU16BE(int,bool *)
    mov     [rsp+2C8h+var_298], eax
    shr     r14d, 1Fh
    add     r14d, [rsp+2C8h+var_29C]
    shr     ebx, 1Fh
    add     ebx, r14d
    mov     [rsp+2C8h+var_29C], ebx
loc_502AEE:
    mov     rdi, rbp; this
    mov     eax, [rsp+2C8h+var_29C]
    shl     eax, 4
    mov     qword ptr [rsp+2C8h+var_290], rax
    lea     r12d, [rax+0Ch]
    mov     eax, [rsp+2C8h+var_298]
    mov     ecx, eax
    sar     ecx, 1Fh
    shr     ecx, 18h
    add     ecx, eax
    shr     ecx, 8
    mov     [rsp+2C8h+var_27C], ecx
    lea     rax, [r13+0Ch]
    mov     [rsp+2C8h+var_228], rax
    xor     ebp, ebp
    lea     r14, [rsp+2C8h+s]
    xor     eax, eax
    mov     [rsp+2C8h+var_288], rax
    mov     [rsp+2C8h+var_294], 0
    xor     r13d, r13d
    cmp     ebp, 2
    jnz     short loc_502B6C
    jmp     short loc_502BA0
loc_502B45:
    mov     [rsp+2C8h+ok], 0
    nop     word ptr [rax+rax+00h]
loc_502B50:
    mov     rdi, [rsp+2C8h+var_2C0]; this
    add     r13d, 1
loc_502B59:
    add     rbp, 1
    cmp     rbp, 0Bh
    jz      loc_502E9A
    cmp     ebp, 2
    jz      short loc_502BA0
loc_502B6C:
    cmp     ebp, 6
    jz      loc_502C70
    cmp     ebp, 3
    jnz     loc_502CB0
    mov     ebx, 36h ; '6'
    lea     rsi, [rsp+2C8h+data]; data
    mov     edx, 36h ; '6'; length
loc_502B90:
    call    _ZNK12FoFiTrueType20computeTableChecksumEPKhi; FoFiTrueType::computeTableChecksum(uchar const*,int)
    mov     edx, eax
    jmp     loc_502E10
loc_502BA0:
    mov     rbx, [rdi+18h]
    mov     esi, offset aGlyf; "glyf"
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    mov     rdi, [rsp+2C8h+var_2C0]
    cmp     dword ptr [rdi+34h], 0
    jle     loc_502D38
    mov     [rsp+2C8h+var_220], i
    mov     [rsp+2C8h+var_260], r13d
    mov     [rsp+2C8h+var_25C], r12d
    cdqe
    lea     rax, [rax+rax*4]
    movsxd  rbp, dword ptr [rbx+rax*4+8]
    xor     r15d, r15d
    mov     r13, [rsp+2C8h+var_228]
    mov     dword ptr [rsp+2C8h+var_270], 0
    xor     ebx, ebx
    jmp     short loc_502C1B
loc_502C00:
    add     ebx, r12d
    add     j, 1
    movsxd  rax, dword ptr [r14+34h]
    add     r13, 10h
    cmp     r15, rax
    mov     rdi, r14; this
    jge     loc_502D0D
loc_502C1B:
    mov     edx, [r13+0]; size
    mov     r12d, ebx
    add     r12d, edx
    mov     eax, r12d
    and     eax, 3
    mov     ebx, 4
    sub     ebx, eax
    test    eax, eax
    cmovz   ebx, eax
    mov     esi, [r13-8]
    add     esi, ebp; pos
    mov     r14, rdi
    call    _ZNK8FoFiBase11checkRegionEii; FoFiBase::checkRegion(int,int)
    test    al, al
    jz      short loc_502C00
    mov     rax, [r14+8]
    add     rax, rbp
    movsxd  rsi, dword ptr [r13-8]
    add     rsi, rax; data
    mov     edx, [r13+0]; length
    call    _ZNK12FoFiTrueType20computeTableChecksumEPKhi; FoFiTrueType::computeTableChecksum(uchar const*,int)
    add     dword ptr [rsp+2C8h+var_270], eax
    jmp     short loc_502C00
loc_502C70:
    mov     eax, [rdi+34h]
    add     eax, 1
    xor     ecx, ecx
    cmp     dword ptr [rdi+38h], 0
    setnz   cl
    lea     ebx, [rcx+rcx]
    add     ebx, 2
    imul    ebx, eax
    mov     rsi, [rsp+2C8h+var_278]; data
    mov     edx, ebx; length
    call    _ZNK12FoFiTrueType20computeTableChecksumEPKhi; FoFiTrueType::computeTableChecksum(uchar const*,int)
    mov     edx, eax
    test    ebx, ebx
    jns     loc_502E10
    jmp     loc_502E90
loc_502CB0:
    mov     rax, i
    shl     rax, 4
    mov     rsi, qword ptr ds:_ZL9t42Tables.tag[rax]; tag
    mov     r15, rdi
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    test    eax, eax
    js      short loc_502D41
    mov     rcx, [r15+18h]
    cdqe
    lea     r14, [rax+rax*4]
    mov     esi, [rcx+r14*4+8]; pos
    mov     ebx, [rcx+r14*4+10h]
    mov     rdi, r15; this
    mov     edx, ebx; size
    call    _ZNK8FoFiBase11checkRegionEii; FoFiBase::checkRegion(int,int)
    xor     edx, edx
    test    al, al
    jz      loc_502DF2
    mov     rax, [r15+18h]
    movsxd  rsi, dword ptr [rax+r14*4+8]
    add     rsi, [r15+8]; data
    mov     edx, ebx; length
    call    _ZNK12FoFiTrueType20computeTableChecksumEPKhi; FoFiTrueType::computeTableChecksum(uchar const*,int)
    mov     edx, eax
    jmp     loc_502DF2
loc_502D0D:
    mov     r12d, [rsp+2C8h+var_25C]
    mov     r13d, [rsp+2C8h+var_260]
    mov     rbp, [rsp+2C8h+var_220]
    lea     r14, [rsp+2C8h+s]
    mov     edx, dword ptr [rsp+2C8h+var_270]
    test    ebx, ebx
    jns     loc_502E10
    jmp     loc_502E90
loc_502D38:
    xor     edx, edx
    xor     ebx, ebx
    jmp     loc_502E10
loc_502D41:
    cmp     i, 9
    jnz     short loc_502D72
    cmp     byte ptr [rsp+2C8h+var_2B4], 0
    jz      short loc_502D72
    mov     eax, [rsp+2C8h+var_27C]
    mov     byte ptr [rsp+2C8h+var_258+0Ah], al
    mov     eax, [rsp+2C8h+var_298]
    mov     byte ptr [rsp+2C8h+var_258+0Bh], al
    mov     ebx, 24h ; '$'
    lea     rsi, [rsp+2C8h+var_258]
    mov     edx, 24h ; '$'
    jmp     loc_502B90
loc_502D72:
    cmp     i, 0Ah
    jnz     loc_502E7C
    cmp     byte ptr [rsp+2C8h+var_2B4], 0
    jz      loc_502E7C
    mov     j, [rsp+2C8h+var_2C0]
    mov     r14d, [rax+34h]
    lea     ebx, [r14+r14]
    add     ebx, 2
    movsxd  r15, ebx
    mov     rdi, r15; size
    xor     esi, esi; checkoverflow
    call    _Z7gmallocmb; gmalloc(ulong,bool)
    mov     ecx, [rsp+2C8h+var_27C]
    mov     [vmtxTab], cl
    mov     ecx, [rsp+2C8h+var_298]
    mov     [vmtxTab+1], cl
    cmp     r15d, 3
    mov     rcx, vmtxTab
    mov     [rsp+2C8h+var_288], rax
    jl      short loc_502DE2
    add     r14d, r14d
    mov     rdi, [rsp+2C8h+var_288]
    add     rdi, 2; this
    add     r14d, 0FFFFFFFEh
    add     r14, 2
    xor     esi, esi; c
    mov     rdx, r14; n
    call    _memset
    mov     rax, [rsp+2C8h+var_288]
loc_502DE2:
    mov     rsi, rax; data
    mov     edx, ebx; length
    call    _ZNK12FoFiTrueType20computeTableChecksumEPKhi; FoFiTrueType::computeTableChecksum(uchar const*,int)
    mov     edx, eax
    mov     [rsp+2C8h+var_294], ebx
loc_502DF2:
    lea     r14, [rsp+2C8h+s]
    test    ebx, ebx
    js      loc_502E90
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+00h]
loc_502E10:
    mov     rax, rbp
    shl     rax, 4
    mov     rax, qword ptr ds:_ZL9t42Tables.tag[rax]; t42Tables
    mov     eax, [rax]
    bswap   eax
    movsxd  rcx, r13d
    lea     rcx, [rcx+rcx*4]
    mov     [rsp+rcx*4+2C8h+z], eax
    mov     [rsp+rcx*4+2C8h+var_114], edx
    mov     [rsp+rcx*4+2C8h+var_110], r12d
    mov     [rsp+rcx*4+2C8h+var_108], ebx
    mov     edi, r12d; x
    mov     esi, ebx; y
    mov     rdx, r14; z
    call    _Z10checkedAddIiEbT_S0_PS0_; checkedAdd<int>(int,int,int*)
    test    al, al
    jnz     loc_502B45
    mov     r12d, dword ptr [rsp+2C8h+s]
    test    r12b, 3
    jz      loc_502B50
    and     ebx, 3
    sub     r12d, ebx
    add     r12d, 4
    jmp     loc_502B50
loc_502E7C:
    lea     j, [i-9]
    xor     edx, edx
    mov     ebx, 0
    cmp     rax, 1
    ja      short loc_502E10
    nop     dword ptr [rax]
loc_502E90:
    mov     rdi, [rsp+2C8h+var_2C0]
    jmp     loc_502B59
loc_502E9A:
    mov     r12d, [rsp+2C8h+var_29C]
    cmp     r13d, r12d
    jl      loc_50334C
loc_502EA8:
    mov     dword ptr [rsp+2C8h+s], 100h
    mov     [rsp+2C8h+var_1D4], 0
    mov     [rsp+2C8h+var_1D3], r12b
    mov     [rsp+2C8h+var_1D2], 3008000h
    mov     [rsp+2C8h+var_1CE], 0
    mov     rdx, qword ptr [rsp+2C8h+var_290]
    mov     eax, edx
    xor     al, 80h
    mov     [rsp+2C8h+var_1CD], al
    movsxd  r13, r12d
    test    r12d, r12d
    jle     short loc_502F5B
    lea     rax, [rsp+2C8h+var_1BD]
    lea     rcx, [rsp+2C8h+var_108]
    xor     edi, edi
loc_502F00:
    mov     esi, [rcx-10h]
    bswap   esi
    mov     [rax-0Fh], esi
    mov     esi, [rcx-0Ch]
    bswap   esi
    mov     [rax-0Bh], esi
    mov     esi, [rcx-8]
    bswap   esi
    mov     [rax-7], esi
    mov     esi, [rcx]
    bswap   esi
    mov     [rax-3], esi
    add     i, 1; this
    add     rax, 10h
    add     rcx, 14h
    cmp     rdi, r13
    jl      short loc_502F00
    or      edx, 0Ch; length
    lea     rsi, [rsp+2C8h+s]; data
    mov     qword ptr [rsp+2C8h+var_290], rdx
    call    _ZNK12FoFiTrueType20computeTableChecksumEPKhi; FoFiTrueType::computeTableChecksum(uchar const*,int)
    test    r12d, r12d
    jle     loc_50304F
    cmp     r12d, 9
    jnb     short loc_502F75
    xor     ecx, ecx
    jmp     loc_503025
loc_502F5B:
    or      edx, 0Ch; length
    lea     rsi, [rsp+2C8h+s]; data
    mov     qword ptr [rsp+2C8h+var_290], rdx
    call    _ZNK12FoFiTrueType20computeTableChecksumEPKhi; FoFiTrueType::computeTableChecksum(uchar const*,int)
    jmp     loc_50304F
loc_502F75:
    mov     ecx, r12d
    and     ecx, 7
    test    rcx, rcx
    mov     edx, 8
    cmovnz  rdx, rcx
    mov     rcx, r13
    sub     rcx, rdx
    movd    xmm1, eax
    lea     checksum, [rsp+2C8h+var_C4]
    pxor    xmm0, xmm0
    mov     rdx, rcx
loc_502FA0:
    movdqu  xmm2, xmmword ptr [rax-50h]
    movdqu  xmm3, xmmword ptr [rax-40h]
    movdqu  xmm4, xmmword ptr [rax-30h]
    movdqu  xmm5, xmmword ptr [rax-20h]
    movdqu  xmm8, xmmword ptr [rax+30h]
    movdqu  xmm9, xmmword ptr [rax+20h]
    movdqu  xmm6, xmmword ptr [rax]
    movdqu  xmm7, xmmword ptr [rax+10h]
    pshufd  xmm3, xmm3, 0E5h
    punpckldq xmm2, xmm3
    pshufd  xmm3, xmm4, 0A4h
    punpckhdq xmm3, xmm5
    movsd   xmm3, xmm2
    paddd   xmm1, xmm3
    pshufd  xmm2, xmm7, 0E5h
    punpckldq xmm6, xmm2
    pshufd  xmm2, xmm9, 0A4h
    punpckhdq xmm2, xmm8
    movsd   xmm2, xmm6
    paddd   xmm0, xmm2
    add     rax, 0A0h
    add     rdx, 0FFFFFFFFFFFFFFF8h
    jnz     short loc_502FA0
    paddd   xmm0, xmm1
    pshufd  xmm1, xmm0, 4Eh ; 'N'
    paddd   xmm1, xmm0
    pshufd  xmm0, xmm1, 0E5h
    paddd   xmm0, xmm1
    movd    eax, xmm0
loc_503025:
    lea     rdx, [rcx+rcx*4]
    lea     rdx, [rsp+rdx*4+2C8h+var_2C8]
    add     rdx, 1B4h
    nop     word ptr [checksum+checksum+00000000h]
    xchg    ax, ax
loc_503040:
    add     eax, [rdx]
    add     i, 1
    add     rdx, 14h
    cmp     rcx, r13
    jl      short loc_503040
loc_50304F:
    mov     ecx, 0B1B0AFBAh
    sub     ecx, eax
    bswap   ecx
    mov     dword ptr [rsp+2C8h+data+8], ecx
    mov     rbx, [rsp+2C8h+var_230]
    test    rbx, rbx
    jz      short loc_5030B1
    mov     esi, 65DD2Eh
    mov     r15, [rsp+2C8h+var_2B0]
    mov     rdi, r15
    mov     edx, 1
    mov     rbp, [rsp+2C8h+var_2A8]
    call    rbp
    mov     rdi, rbx; this
    call    _ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5c_strEv; std::string::c_str(void)
    mov     r14, rax
    mov     rdi, rbx; this
    call    _ZNK9GooString9getLengthEv; GooString::getLength(void)
    mov     rdi, r15
    mov     rsi, r14
    mov     edx, eax
    call    rbp
    mov     esi, (offset aEncoding_0+9); " [\n"
    mov     rdi, r15
    mov     edx, 3
    jmp     short loc_5030C8
loc_5030B1:
    mov     esi, offset aSfnts; "/sfnts [\n"
    mov     r15, [rsp+2C8h+var_2B0]
    mov     rdi, r15; this
    mov     edx, 9
    mov     rbp, [rsp+2C8h+var_2A8]
loc_5030C8:
    call    rbp
    mov     rbx, [rsp+2C8h+var_278]
    lea     rsi, [rsp+2C8h+s]; s
    mov     rdx, qword ptr [rsp+2C8h+var_290]; length
    mov     rcx, rbp; outputFunc
    mov     r8, r15; outputStream
    call    _ZNK12FoFiTrueType10dumpStringEPKhiPFvPvPKciES2_; FoFiTrueType::dumpString(uchar const*,int,void (*)(void *,char const*,int),void *)
    test    r12d, r12d
    mov     rdi, [rsp+2C8h+var_2C0]; this
    jle     loc_503306
    mov     r14, [rsp+2C8h+p]
    add     r14, 0Ch
    xor     r12d, r12d
    cmp     r12d, 2
    jnz     short loc_503157
    jmp     short loc_503180
loc_503110:
    mov     eax, [rdi+34h]
    add     eax, 1
    xor     ecx, ecx
    cmp     dword ptr [rdi+38h], 0
    setnz   cl
    lea     edx, [rcx+rcx]
    add     edx, 2
    imul    edx, eax; length
    mov     rsi, rbx; s
loc_50312B:
    mov     rcx, [rsp+2C8h+var_2A8]; outputFunc
    mov     r8, [rsp+2C8h+var_2B0]; outputStream
    call    _ZNK12FoFiTrueType10dumpStringEPKhiPFvPvPKciES2_; FoFiTrueType::dumpString(uchar const*,int,void (*)(void *,char const*,int),void *)
    mov     rdi, [rsp+2C8h+var_2C0]; this
loc_50313F:
    add     i, 1
    cmp     r12, r13
    mov     rbx, [rsp+2C8h+var_278]
    jge     loc_503306
    cmp     r12d, 2
    jz      short loc_503180
loc_503157:
    cmp     r12d, 6
    jz      short loc_503110
    cmp     r12d, 3
    jnz     loc_503210
    lea     rsi, [rsp+2C8h+data]
    mov     edx, 36h ; '6'
    jmp     short loc_50312B
loc_503180:
    mov     rbx, [rdi+18h]
    mov     esi, offset aGlyf; "glyf"
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    mov     rdi, [rsp+2C8h+var_2C0]; this
    cmp     dword ptr [rdi+34h], 0
    jle     short loc_50313F
    cdqe
    lea     rax, [rax+rax*4]
    movsxd  rbx, dword ptr [rbx+rax*4+8]
    mov     rbp, r14
    xor     r15d, r15d
    jmp     short loc_5031C5
loc_5031B0:
    add     j, 1
    movsxd  rax, dword ptr [rdi+34h]
    add     rbp, 10h
    cmp     r15, rax
    jge     loc_50313F
loc_5031C5:
    mov     edx, [rbp+0]; size
    test    edx, edx
    jle     short loc_5031B0
    mov     esi, [rbp-8]
    add     esi, ebx; pos
    call    _ZNK8FoFiBase11checkRegionEii; FoFiBase::checkRegion(int,int)
    mov     rdi, [rsp+2C8h+var_2C0]; this
    test    al, al
    jz      short loc_5031B0
    mov     rax, [rdi+8]
    add     rax, rbx
    movsxd  rsi, dword ptr [rbp-8]
    add     rsi, rax; s
    mov     edx, [rbp+0]; length
    mov     rcx, [rsp+2C8h+var_2A8]; outputFunc
    mov     r8, [rsp+2C8h+var_2B0]; outputStream
    call    _ZNK12FoFiTrueType10dumpStringEPKhiPFvPvPKciES2_; FoFiTrueType::dumpString(uchar const*,int,void (*)(void *,char const*,int),void *)
    mov     rdi, [rsp+2C8h+var_2C0]
    jmp     short loc_5031B0
loc_503210:
    lea     rax, [i+i*4]
    mov     r15d, [rsp+rax*4+2C8h+var_108]
    test    r15d, r15d
    jle     loc_50313F
    mov     rax, i
    shl     rax, 4
    mov     rsi, qword ptr ds:_ZL9t42Tables.tag[rax]; tag
    mov     rbx, rdi
    call    _ZNK12FoFiTrueType9seekTableEPKc; FoFiTrueType::seekTable(char const*)
    test    eax, eax
    js      short loc_503285
    mov     rcx, [rbx+18h]
    cdqe
    lea     rbp, [rax+rax*4]
    mov     esi, [rcx+rbp*4+8]; pos
    mov     edx, [rcx+rbp*4+10h]; size
    mov     rdi, rbx; this
    call    _ZNK8FoFiBase11checkRegionEii; FoFiBase::checkRegion(int,int)
    test    al, al
    jz      short loc_503285
    mov     rax, [rbx+18h]
    movsxd  rsi, dword ptr [rax+rbp*4+8]
    add     rsi, [rbx+8]; s
    mov     edx, [rax+rbp*4+10h]; length
    mov     rcx, [rsp+2C8h+var_2A8]; outputFunc
    mov     r8, [rsp+2C8h+var_2B0]; outputStream
    call    _ZNK12FoFiTrueType10dumpStringEPKhiPFvPvPKciES2_; FoFiTrueType::dumpString(uchar const*,int,void (*)(void *,char const*,int),void *)
    mov     rdi, rbx
    jmp     loc_50313F
loc_503285:
    cmp     i, 9
    jnz     short loc_50329F
    cmp     byte ptr [rsp+2C8h+var_2B4], 0
    jz      short loc_50329F
    cmp     r15d, 25h ; '%'
    jge     short loc_5032CD
loc_503298:
    lea     rsi, [rsp+2C8h+var_258]
    jmp     short loc_5032C5
loc_50329F:
    cmp     i, 0Ah
    mov     rdi, [rsp+2C8h+var_2C0]
    jnz     loc_50313F
    cmp     byte ptr [rsp+2C8h+var_2B4], 0
    jz      loc_50313F
    cmp     r15d, [rsp+2C8h+var_294]
    jg      short loc_5032EA
loc_5032C0:
    mov     rsi, [rsp+2C8h+var_288]
loc_5032C5:
    mov     edx, r15d
    jmp     loc_50312B
loc_5032CD:
    mov     edx, offset aLengthBiggerTh; "length bigger than vheaTab size"
    xor     edi, edi; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    mov     r15d, 24h ; '$'
    jmp     short loc_503298
loc_5032EA:
    mov     edx, offset aLengthBiggerTh_0; "length bigger than vmtxTab size"
    xor     edi, edi; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    mov     r15d, [rsp+2C8h+var_294]
    jmp     short loc_5032C0
loc_503306:
    mov     esi, (offset aFontmatrix1001+18h); char *
    mov     rdi, [rsp+2C8h+var_2B0]; void *
    mov     edx, 6; int
    call    [rsp+2C8h+var_2A8]
    mov     rdi, rbx; p
    call    _Z5gfreePv; gfree(void *)
    mov     rdi, [rsp+2C8h+p]; p
    call    _Z5gfreePv; gfree(void *)
    mov     rdi, [rsp+2C8h+var_288]; p
    test    rdi, rdi
    jz      short loc_50333A
    call    _Z5gfreePv; gfree(void *)
loc_50333A:
    add     rsp, 298h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_50334C:
    mov     edx, offset aUnexpectedNumb; "unexpected number of tables"
    xor     edi, edi; category
    mov     rsi, 0FFFFFFFFFFFFFFFFh; pos
    xor     eax, eax
    call    _Z5error13ErrorCategoryxPKcz; error(ErrorCategory,long long,char const*,...)
    mov     eax, r13d
    shl     eax, 4
    mov     qword ptr [rsp+2C8h+var_290], rax
    mov     r12d, r13d
    jmp     loc_502EA8
FoFiTrueType::cvtSfnts(void (*)(void *,char const*,int),void *,GooString const*,bool,int *)const endp



FoFiTrueType::dumpString(unsigned char const*,int,void (*)(void *,char const*,int),void *)const proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 28h
    mov     rdi, outputStream
    mov     ebp, edx
    mov     [rsp+58h+var_38], s
    mov     esi, (offset asc_65E201+2); "<"
    mov     [rsp+58h+var_48], r8
    mov     edx, 1
    mov     [rsp+58h+var_40], outputFunc
    call    rcx
    test    ebp, ebp
    jle     loc_504475
    movsxd  r13, ebp
    xor     r14d, r14d
    mov     [rsp+58h+var_4C], ebp
    jmp     short loc_5043A4
loc_504380:
    mov     esi, offset asc_65E201; ">\n<"
    mov     rdi, [rsp+58h+var_48]
    mov     edx, 3
    call    [rsp+58h+var_40]
    add     i, 20h ; ' '
    mov     ebp, [rsp+58h+var_4C]
loc_50439B:
    cmp     r14d, ebp
    jge     loc_504475
loc_5043A4:
    mov     rax, [rsp+58h+var_38]
    lea     r15, [rax+i]
    xor     r12d, r12d
    jmp     short loc_5043CA
loc_5043C0:
    add     j, 1
    cmp     r12, 20h ; ' '
    jz      short loc_504420
loc_5043CA:
    lea     rax, [i+j]
    cmp     rax, r13
    jge     short loc_504420
    movzx   esi, byte ptr [r15+j]
    mov     edi, offset a002x_0; "{0:02x}"
    xor     eax, eax
    call    _ZN9GooString6formatEPKcz; GooString::format(char const*,...)
    mov     rbp, rax
    mov     rdi, rax; this
    call    _ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5c_strEv; std::string::c_str(void)
    mov     rbx, rax
    mov     rdi, buf; this
    call    _ZNK9GooString9getLengthEv; GooString::getLength(void)
    mov     rdi, [rsp+58h+var_48]
    mov     rsi, rbx
    mov     edx, eax
    call    [rsp+58h+var_40]
    test    buf, buf
    jz      short loc_5043C0
    mov     rdi, buf; void *
    call    __ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED2Ev; std::string::~string()
    mov     rdi, buf; void *
    call    __ZdlPv; operator delete(void *)
    jmp     short loc_5043C0
loc_504420:
    mov     eax, r14d
    shr     eax, 5
    imul    rax, 8010021h
    shr     rax, 26h
    imul    eax, 0FFE0h
    mov     ecx, r14d
    sub     ecx, eax
    cmp     ecx, 0FFC0h
    jz      loc_504380
    add     i, 20h ; ' '
    mov     ebp, [rsp+58h+var_4C]
    cmp     r14d, ebp
    jge     loc_50439B
    mov     esi, (offset asc_669771+1); "\n"
    mov     rdi, [rsp+58h+var_48]
    mov     edx, 1
    call    [rsp+58h+var_40]
    cmp     r14d, ebp
    jl      loc_5043A4
loc_504475:
    and     ebp, 3
    mov     rax, [rsp+58h+var_40]
    mov     r14, [rsp+58h+var_48]
    jz      short loc_5044A9
    cmp     ebp, 4
    jz      short loc_5044A9
    add     ebp, 0FFFFFFFCh
    nop     dword ptr [rax+00h]
loc_504490:
    mov     esi, 5F9121h
    mov     rdi, r14
    mov     edx, 2
    mov     rbx, rax
    call    rax
    mov     rax, rbx
    inc     ebp
    jnz     short loc_504490
loc_5044A9:
    mov     esi, offset a00; "00>\n"
    mov     rdi, r14
    mov     edx, 4
    add     rsp, 28h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    jmp     rax
FoFiTrueType::dumpString(unsigned char const*,int,void (*)(void *,char const*,int),void *)const endp

