PredictorEncodeTile proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     r12, [tif+3F0h]
    test    sp_0, sp_0
    jz      loc_439B89
    cmp     qword ptr [sp_0+30h], 0
    jz      loc_439BA2
    cmp     qword ptr [sp_0+28h], 0
    jz      loc_439BBB
    mov     ebp, ecx
    mov     r14, cc0
    mov     r15, bp0
    mov     r13, tif
    mov     rdi, rdx; s
    call    _TIFFmalloc
    test    rax, rax
    jz      short loc_439B05
    mov     rbx, rax
    mov     [rsp+48h+var_3C], ebp
    mov     rdi, rax; dest
    mov     rsi, bp0; src
    mov     rdx, cc0; n
    call    _memcpy
    mov     rbp, [sp_0+10h]
    test    rowsize, rowsize
    jle     loc_439BD4
    mov     rax, cc0
    cqo
    idiv    rowsize
    test    rdx, rdx
    jz      short loc_439B24
    mov     rdi, [tif+458h]; fd
    mov     esi, offset aPredictorencod; "PredictorEncodeTile"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aCc0Rowsize0; "(cc0%rowsize)!=0"
    xor     eax, eax
    call    TIFFErrorExt
    mov     rdi, working_copy; p
    call    _TIFFfree
    jmp     short loc_439B20
loc_439B05:
    mov     rdi, [tif+458h]; fd
    mov     esi, offset aPredictorencod; "PredictorEncodeTile"
    mov     edx, offset aOutOfMemoryAll; "Out of memory allocating %ld byte temp "...
    mov     rcx, cc0
    xor     eax, eax
    call    TIFFErrorExt
loc_439B20:
    xor     eax, eax
    jmp     short loc_439B7A
loc_439B24:
    mov     [rsp+48h+p], working_copy
    test    cc, cc
    jle     short loc_439B56
    mov     working_copy, [rsp+48h+p]
    mov     bp0, cc
    nop     word ptr [rax+rax+00000000h]
loc_439B40:
    mov     rdi, tif
    mov     rsi, bp_0
    mov     rdx, rowsize
    call    qword ptr [sp_0+30h]
    add     bp_0, rowsize
    sub     cc, rowsize
    jg      short loc_439B40
loc_439B56:
    movzx   ecx, word ptr [rsp+48h+var_3C]
    mov     rdi, tif
    mov     rowsize, [rsp+48h+p]
    mov     rsi, rbp
    mov     rdx, cc0
    call    qword ptr [sp_0+28h]
    mov     ebx, eax
    mov     rdi, rbp; p
    call    _TIFFfree
    mov     eax, ebx
loc_439B7A:
    add     rsp, 18h
    pop     rbx
    pop     sp_0
    pop     tif
    pop     cc0
    pop     r15
    pop     rbp
    retn
loc_439B89:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F7h; line
    call    ___assert_fail
loc_439BA2:
    mov     edi, offset aSpEncodepfuncN; "sp->encodepfunc != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F8h; line
    call    ___assert_fail
loc_439BBB:
    mov     edi, offset aSpEncodetileNu; "sp->encodetile != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F9h; line
    call    ___assert_fail
loc_439BD4:
    mov     edi, offset aRowsize0; "rowsize > 0"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 30Bh; line
    call    ___assert_fail
PredictorEncodeTile endp

