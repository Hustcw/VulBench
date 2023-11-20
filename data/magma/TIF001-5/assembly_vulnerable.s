PredictorDecodeTile proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     r13, [tif+3F0h]
    test    sp_0, sp_0
    jz      loc_438BB3
    mov     rax, [sp_0+48h]
    test    rax, rax
    jz      loc_438BCC
    mov     r14, occ0
    mov     rbx, op0
    mov     r15, tif
    movzx   ecx, cx
    call    rax
    xor     r12d, r12d
    test    eax, eax
    jz      short loc_438BA1
    mov     rbp, [sp_0+10h]
    test    rowsize, rowsize
    jle     loc_438BE5
    mov     rcx, [sp_0+50h]
    test    rcx, rcx
    jz      loc_438BFE
    test    occ0, occ0
    jle     short loc_438B9B
    mov     rdi, tif
    mov     rsi, op0
    mov     rdx, rowsize
    call    rcx
    test    eax, eax
    jz      short loc_438BA1
    add     op0, rowsize
    xchg    ax, ax
loc_438B80:
    sub     occ0, rowsize
    jle     short loc_438B9B
    mov     rsi, rbx
    add     rbx, rowsize
    mov     rdi, tif
    mov     rdx, rowsize
    call    qword ptr [sp_0+50h]
    test    eax, eax
    jnz     short loc_438B80
    jmp     short loc_438BA1
loc_438B9B:
    mov     r12d, 1
loc_438BA1:
    mov     eax, r12d
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     sp_0
    pop     r14
    pop     tif
    pop     rbp
    retn
loc_438BB3:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1F7h; line
    call    ___assert_fail
loc_438BCC:
    mov     edi, offset aSpDecodetileNu; "sp->decodetile != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1F8h; line
    call    ___assert_fail
loc_438BE5:
    mov     edi, offset aRowsize0; "rowsize > 0"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1FCh; line
    call    ___assert_fail
loc_438BFE:
    mov     edi, offset aSpDecodepfuncN; "sp->decodepfunc != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 20Ah; line
    call    ___assert_fail
PredictorDecodeTile endp

