TIFFReadEncodedStripGetStripSize proc
    push    rbp
    push    r14
    push    rbx
    mov     r14, pplane
    mov     ebp, esi
    mov     rbx, tif
    xor     esi, esi; tiles
    call    TIFFCheckRead
    test    eax, eax
    jz      short loc_41B508
    mov     r8d, [tif+0E4h]
    cmp     r8d, ebp
    jbe     short loc_41B4EE
    mov     esi, [tif+5Ch]
    mov     edi, [tif+84h]
    cmp     edi, esi
    cmova   edi, esi
    mov     eax, esi
    xor     edx, edx
    div     edi
    mov     ecx, eax
    cmp     edx, 1
    sbb     ecx, 0FFFFFFFFh
    mov     eax, ebp
    xor     edx, edx
    div     ecx
    test    pplane, pplane
    jz      short loc_41B4CE
    mov     [pplane], ax
loc_41B4CE:
    imul    edx, edi
    sub     esi, edx
    cmp     esi, edi
    cmova   esi, edi; nrows
    mov     rowsperstrip, tif; tif
    call    TIFFVStripSize
    xor     ecx, ecx
    cmp     stripsize, 1
    sbb     rcx, rcx
    or      stripsize, rcx
    jmp     short loc_41B50F
loc_41B4EE:
    mov     rdi, [tif+458h]; fd
    mov     esi, offset TIFFReadEncodedStripGetStripSize_module; "TIFFReadEncodedStrip"
    mov     edx, offset aUStripOutOfRan; "%u: Strip out of range, max %u"
    mov     ecx, ebp
    xor     eax, eax
    call    TIFFErrorExt
loc_41B508:
    mov     rax, 0FFFFFFFFFFFFFFFFh
loc_41B50F:
    pop     tif
    pop     pplane
    pop     strip
    retn
TIFFReadEncodedStripGetStripSize endp

