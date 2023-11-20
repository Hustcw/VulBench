MAGMA_png_check_chunk_length proc
    push    rax
    mov     r8, [png_ptr+3B0h]
    lea     rax, [r8-1]
    cmp     rax, 7FFFFFFEh
    mov     r9d, 7FFFFFFFh
    cmovnb  r8, r9
    cmp     dword ptr [png_ptr+1C0h], 49444154h
    jnz     loc_414779
    movzx   eax, byte ptr [png_ptr+203h]
    imul    eax, [png_ptr+1A0h]
    xor     ecx, ecx
    cmp     byte ptr [png_ptr+200h], 8
    setnbe  cl
    add     ecx, 1
    imul    ecx, eax
    xor     eax, eax
    cmp     byte ptr [png_ptr+1FCh], 0
    mov     edx, 6
    cmovz   edx, eax
    lea     r10d, [rcx+rdx]
    add     r10d, 1
    mov     r11d, [png_ptr+1A4h]
    mov     eax, 0FFFFFFFFh
    xor     edx, edx
    div     r10d
    mov     rcx, r11
    imul    rcx, row_factor
    cmp     eax, r11d
    cmovb   rcx, r9
    cmp     r10d, 7F36h
    mov     r11d, 7F36h
    cmovb   r11, row_factor
    mov     rax, idat_limit
    xor     edx, edx
    div     row_factor
    lea     rax, [rax+rax*4]
    add     rax, idat_limit
    add     rax, 0Bh
    cmp     idat_limit, 7FFFFFFFh
    cmovb   r9, idat_limit
    cmp     idat_limit, r9
    cmovb   idat_limit, r9
loc_414779:
    mov     eax, esi
    cmp     limit, rax
    jb      short loc_414782
    pop     rax
    retn
loc_414782:
    mov     esi, offset aChunkDataIsToo; "chunk data is too large"
    call    MAGMA_png_chunk_error
MAGMA_png_check_chunk_length endp

