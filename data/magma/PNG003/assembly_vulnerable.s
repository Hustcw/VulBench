MAGMA_png_handle_PLTE proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 318h
    mov     r13, png_ptr
    mov     eax, [rdi+11Ch]
    test    al, 1
    jz      loc_414C6A
    test    al, 2
    jnz     loc_414C77
    mov     r15d, edx
    test    al, 4
    jnz     short loc_414AE7
    or      eax, 2
    mov     [png_ptr+11Ch], eax
    test    byte ptr [png_ptr+1FFh], 2
    jnz     short loc_414B11
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    mov     esi, offset aIgnoredInGrays; "ignored in grayscale PNG"
    jmp     short loc_414AF7
loc_414AE7:
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    mov     esi, offset aOutOfPlace; "out of place"
loc_414AF7:
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_benign_error
loc_414AFF:
    add     rsp, 318h
    pop     rbx
    pop     r12
    pop     png_ptr
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_414B11:
    cmp     r15d, 300h
    ja      loc_414BE2
    mov     eax, r15d
    mov     ecx, 0AAAAAAABh
    imul    rcx, rax
    shr     rcx, 21h
    lea     eax, [rcx+rcx*2]
    mov     ecx, r15d
    sub     ecx, eax
    jnz     loc_414BE2
    mov     [rsp+348h+var_340], info_ptr
    movzx   eax, r15w
    imul    ebp, eax, 0AAABh
    shr     ebp, 11h
    cmp     ax, 3
    jb      short loc_414B95
    xor     ebx, ebx
    lea     r14, [rsp+348h+var_338]
    lea     r12, [rsp+348h+var_343]
loc_414B60:
    mov     rdi, png_ptr; png_ptr
    mov     rsi, r12; buf
    mov     edx, 3; length
    call    MAGMA_png_crc_read
    movzx   eax, [rsp+348h+var_343]
    mov     [pal_ptr], al
    movzx   eax, [rsp+348h+var_342]
    mov     [pal_ptr+1], al
    movzx   eax, [rsp+348h+var_341]
    mov     [pal_ptr+2], al
    add     ebx, 1
    add     pal_ptr, 3
    cmp     ebx, ebp
    jb      short loc_414B60
loc_414B95:
    lea     eax, [num+num*2+0]
    sub     r15d, eax
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    lea     rdx, [rsp+348h+var_338]; palette
    mov     rdi, png_ptr; png_ptr
    mov     rbx, [rsp+348h+var_340]
    mov     rsi, rbx; info_ptr
    mov     ecx, ebp; num_palette
    call    MAGMA_png_set_PLTE
    cmp     word ptr [png_ptr+1F8h], 0
    jz      short loc_414C05
    mov     word ptr [png_ptr+1F8h], 0
    test    rbx, rbx
    jnz     short loc_414C2F
    mov     esi, offset aTrnsMustBeAfte; "tRNS must be after"
    jmp     loc_414AF7
loc_414BE2:
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    cmp     byte ptr [png_ptr+1FFh], 3
    jz      loc_414C84
    mov     esi, offset aInvalid; "invalid"
    jmp     loc_414AF7
loc_414C05:
    test    rbx, rbx
    jz      loc_414AFF
    mov     eax, [rbx+8]
    test    al, 10h
    jnz     short loc_414C25
    test    al, 40h
    jnz     short loc_414C49
loc_414C19:
    test    byte ptr [rbx+8], 20h
    jz      loc_414AFF
    jmp     short loc_414C60
loc_414C25:
    mov     word ptr [png_ptr+1F8h], 0
loc_414C2F:
    mov     word ptr [rbx+22h], 0
    mov     esi, offset aTrnsMustBeAfte; "tRNS must be after"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_benign_error
    mov     eax, [rbx+8]
    test    al, 40h
    jz      short loc_414C19
loc_414C49:
    mov     esi, offset aHistMustBeAfte; "hIST must be after"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_benign_error
    test    byte ptr [rbx+8], 20h
    jz      loc_414AFF
loc_414C60:
    mov     esi, offset aBkgdMustBeAfte; "bKGD must be after"
    jmp     loc_414AF7
loc_414C6A:
    mov     esi, offset aMissingIhdr; "missing IHDR"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_error
loc_414C77:
    mov     esi, offset message; "duplicate"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_error
loc_414C84:
    mov     esi, offset aInvalid; "invalid"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_error
MAGMA_png_handle_PLTE endp



MAGMA_png_set_PLTE proc
    push    rbp
    push    r15
    push    r14
    push    r12
    push    rbx
    test    png_ptr, png_ptr
    jz      loc_41A6C3
    mov     rbp, info_ptr
    test    rsi, rsi
    jz      loc_41A6C3
    mov     r14d, ecx
    mov     rbx, png_ptr
    cmp     ecx, 101h
    jb      short loc_41A632
    cmp     byte ptr [info_ptr+25h], 3
    jnz     loc_41A6C3
    mov     esi, offset aInvalidPalette; "Invalid palette length"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_error
loc_41A632:
    mov     r15, palette
    test    rdx, rdx
    jnz     short loc_41A659
    test    r14d, r14d
    jz      short loc_41A659
loc_41A63F:
    mov     esi, offset aInvalidPalette_0; "Invalid palette"
    mov     rdi, png_ptr
    mov     edx, 2
    pop     png_ptr
    pop     r12
    pop     num_palette
    pop     palette
    pop     info_ptr
    jmp     MAGMA_png_chunk_report
loc_41A659:
    test    r14d, r14d
    jnz     short loc_41A667
    test    byte ptr [png_ptr+360h], 1
    jz      short loc_41A63F
loc_41A667:
    mov     rdi, png_ptr; png_ptr
    mov     rsi, info_ptr; info_ptr
    mov     edx, 1000h; mask
    xor     ecx, ecx; num
    call    MAGMA_png_free_data
    mov     esi, 300h; size
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_calloc
    mov     r12, rax
    mov     [png_ptr+1E8h], rax
    test    r14d, r14d
    jz      short loc_41A6A7
    mov     eax, r14d
    lea     rdx, [rax+rax*2]; n
    mov     rdi, r12; dest
    mov     rsi, palette; src
    call    _memcpy
loc_41A6A7:
    mov     [info_ptr+18h], r12
    mov     [info_ptr+20h], r14w
    or      byte ptr [info_ptr+12Dh], 10h
    mov     [png_ptr+1F0h], r14w
    or      byte ptr [info_ptr+8], 8
loc_41A6C3:
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    pop     rbp
    retn
MAGMA_png_set_PLTE endp

