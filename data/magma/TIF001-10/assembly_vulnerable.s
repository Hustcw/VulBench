PredictorEncodeTile proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     r14, [tif+3F0h]
    test    sp_0, sp_0
    jz      loc_439713
    cmp     qword ptr [sp_0+30h], 0
    jz      loc_43972C
    cmp     qword ptr [sp_0+28h], 0
    jz      loc_439745
    mov     ebx, ecx
    mov     rbp, cc0
    mov     r15, bp0
    mov     r13, tif
    mov     rdi, rdx; s
    call    _TIFFmalloc
    test    rax, rax
    jz      short loc_4396E7
    mov     r12, rax
    mov     [rsp+48h+var_3C], ebx
    mov     rdi, rax; dest
    mov     rsi, bp0; src
    mov     rdx, cc0; n
    call    _memcpy
    mov     rbx, [sp_0+10h]
    test    rowsize, rowsize
    jle     loc_43975E
    mov     [rsp+48h+var_38], cc
    test    cc0, cc0
    jle     short loc_4396C5
    mov     cc0, working_copy
    mov     bp0, [rsp+48h+var_38]
loc_4396B0:
    mov     rdi, tif
    mov     rsi, bp_0
    mov     rdx, rowsize
    call    qword ptr [sp_0+30h]
    add     bp_0, rowsize
    sub     cc, rowsize
    jg      short loc_4396B0
loc_4396C5:
    movzx   ecx, word ptr [rsp+48h+var_3C]
    mov     rdi, tif
    mov     rsi, working_copy
    mov     rdx, [rsp+48h+var_38]
    call    qword ptr [sp_0+28h]
    mov     ebx, eax
    mov     rdi, working_copy; p
    call    _TIFFfree
    mov     eax, ebx
    jmp     short loc_439704
loc_4396E7:
    mov     rdi, [tif+458h]; fd
    mov     esi, offset PredictorEncodeTile_module; "PredictorEncodeTile"
    mov     edx, offset aOutOfMemoryAll; "Out of memory allocating %ld byte temp "...
    mov     rcx, cc0
    xor     eax, eax
    call    TIFFErrorExt
    xor     eax, eax
loc_439704:
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     tif
    pop     sp_0
    pop     r15
    pop     rbp
    retn
loc_439713:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F7h; line
    call    ___assert_fail
loc_43972C:
    mov     edi, offset aSpEncodepfuncN; "sp->encodepfunc != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F8h; line
    call    ___assert_fail
loc_439745:
    mov     edi, offset aSpEncodetileNu; "sp->encodetile != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 2F9h; line
    call    ___assert_fail
loc_43975E:
    mov     edi, offset aRowsize0; "rowsize > 0"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictoren_0; "int PredictorEncodeTile(TIFF *, uint8_t"...
    mov     edx, 30Bh; line
    call    ___assert_fail
PredictorEncodeTile endp

