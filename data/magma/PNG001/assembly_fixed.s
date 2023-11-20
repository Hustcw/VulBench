MAGMA_png_check_chunk_length proc
    push    rax
    mov     r8, [png_ptr+3B0h]
    lea     rax, [r8-1]
    cmp     rax, 7FFFFFFEh
    mov     r9d, 7FFFFFFFh
    cmovnb  r8, r9
    cmp     dword ptr [png_ptr+1C0h], 49444154h
    jnz     loc_41482F
    mov     eax, [png_ptr+1A0h]
    movzx   ecx, byte ptr [png_ptr+203h]
    imul    rcx, rax
    xor     eax, eax
    cmp     byte ptr [png_ptr+200h], 8
    setnbe  al
    add     rax, 1
    imul    rax, rcx
    xor     ecx, ecx
    cmp     byte ptr [png_ptr+1FCh], 0
    mov     r10d, [png_ptr+1A4h]
    mov     edx, 6
    cmovz   rdx, rcx
    lea     r11, [rax+rdx]
    add     r11, 1
    mov     eax, 0FFFFFFFFh
    xor     edx, edx
    div     row_factor
    mov     rcx, row_factor
    imul    rcx, r10
    cmp     rax, r10
    cmovb   rcx, r9
    cmp     row_factor, 7F36h
    mov     r10d, 7F36h
    cmovb   r10, row_factor
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
loc_41482F:
    mov     eax, esi
    cmp     limit, rax
    jb      short loc_414838
    pop     rax
    retn
loc_414838:
    mov     esi, offset aChunkDataIsToo; "chunk data is too large"
    call    MAGMA_png_chunk_error
MAGMA_png_check_chunk_length endp

