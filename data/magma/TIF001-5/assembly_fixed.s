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
    jz      loc_438EE3
    mov     rax, [sp_0+48h]
    test    rax, rax
    jz      loc_438EFC
    mov     rbx, occ0
    mov     rbp, op0
    mov     r15, tif
    movzx   ecx, cx
    call    rax
    xor     r14d, r14d
    test    eax, eax
    jz      loc_438ED1
    mov     r12, [sp_0+10h]
    test    rowsize, rowsize
    jle     loc_438F15
    mov     rax, occ0
    cqo
    idiv    rowsize
    test    rdx, rdx
    jz      short loc_438E7D
    mov     rdi, [tif+458h]; fd
    xor     r14d, r14d
    mov     esi, offset aPredictordecod; "PredictorDecodeTile"
    mov     edx, (offset aErrorInitializ+27h); fmt
    mov     ecx, offset aOcc0Rowsize0; "occ0%rowsize != 0"
    xor     eax, eax
    call    TIFFErrorExt
    jmp     short loc_438ED1
loc_438E7D:
    mov     rcx, [sp_0+50h]
    test    rcx, rcx
    jz      loc_438F2E
    test    occ0, occ0
    jle     short loc_438ECB
    mov     rdi, tif
    mov     rsi, op0
    mov     rdx, rowsize
    call    rcx
    test    eax, eax
    jz      short loc_438ED1
    add     op0, rowsize
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+rax+00h]
loc_438EB0:
    sub     occ0, rowsize
    jle     short loc_438ECB
    mov     rsi, rbp
    add     rbp, rowsize
    mov     rdi, tif
    mov     rdx, rowsize
    call    qword ptr [sp_0+50h]
    test    eax, eax
    jnz     short loc_438EB0
    jmp     short loc_438ED1
loc_438ECB:
    mov     r14d, 1
loc_438ED1:
    mov     eax, r14d
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     sp_0
    pop     r14
    pop     tif
    pop     rbp
    retn
loc_438EE3:
    mov     edi, offset aSpNull; "sp != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1F7h; line
    call    ___assert_fail
loc_438EFC:
    mov     edi, offset aSpDecodetileNu; "sp->decodetile != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1F8h; line
    call    ___assert_fail
loc_438F15:
    mov     edi, offset aRowsize0; "rowsize > 0"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 1FCh; line
    call    ___assert_fail
loc_438F2E:
    mov     edi, offset aSpDecodepfuncN; "sp->decodepfunc != NULL"
    mov     esi, offset aTifPredictC; "tif_predict.c"
    mov     ecx, offset aIntPredictorde_0; "int PredictorDecodeTile(TIFF *, uint8_t"...
    mov     edx, 20Ah; line
    call    ___assert_fail
PredictorDecodeTile endp

