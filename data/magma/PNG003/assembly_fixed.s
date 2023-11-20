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
    jz      loc_414D4A
    test    al, 2
    jnz     loc_414D57
    mov     r15d, edx
    test    al, 4
    jnz     short loc_414BA8
    or      eax, 2
    mov     [png_ptr+11Ch], eax
    mov     al, [png_ptr+1FFh]
    test    al, 2
    jnz     short loc_414BD2
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    mov     esi, offset aIgnoredInGrays; "ignored in grayscale PNG"
    jmp     short loc_414BB8
loc_414BA8:
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    mov     esi, offset aOutOfPlace; "out of place"
loc_414BB8:
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_benign_error
loc_414BC0:
    add     rsp, 318h
    pop     rbx
    pop     r12
    pop     png_ptr
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_414BD2:
    cmp     r15d, 300h
    ja      loc_414CC2
    mov     ecx, r15d
    mov     edx, 0AAAAAAABh
    imul    rdx, rcx
    shr     rdx, 21h
    lea     ecx, [rdx+rdx*2]
    mov     edx, r15d
    sub     edx, ecx
    jnz     loc_414CC2
    mov     [rsp+348h+var_340], info_ptr
    movzx   ecx, r15w
    imul    ebp, ecx, 0AAABh
    shr     ebp, 11h
    mov     edx, 100h
    cmp     al, 3
    jnz     short loc_414C26
    mov     cl, [png_ptr+200h]
    mov     edx, 1
    shl     edx, cl
loc_414C26:
    cmp     edx, ebp
    cmovle  ebp, edx
    test    ebp, ebp
    jle     short loc_414C75
    xor     ebx, ebx
    lea     r14, [rsp+348h+var_338]
    lea     r12, [rsp+348h+var_343]
    nop     dword ptr [rax+rax+00h]
loc_414C40:
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
    jl      short loc_414C40
loc_414C75:
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
    jz      short loc_414CE5
    mov     word ptr [png_ptr+1F8h], 0
    test    rbx, rbx
    jnz     short loc_414D0F
    mov     esi, offset aTrnsMustBeAfte; "tRNS must be after"
    jmp     loc_414BB8
loc_414CC2:
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    cmp     byte ptr [png_ptr+1FFh], 3
    jz      loc_414D64
    mov     esi, offset aInvalid; "invalid"
    jmp     loc_414BB8
loc_414CE5:
    test    rbx, rbx
    jz      loc_414BC0
    mov     eax, [rbx+8]
    test    al, 10h
    jnz     short loc_414D05
    test    al, 40h
    jnz     short loc_414D29
loc_414CF9:
    test    byte ptr [rbx+8], 20h
    jz      loc_414BC0
    jmp     short loc_414D40
loc_414D05:
    mov     word ptr [png_ptr+1F8h], 0
loc_414D0F:
    mov     word ptr [rbx+22h], 0
    mov     esi, offset aTrnsMustBeAfte; "tRNS must be after"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_benign_error
    mov     eax, [rbx+8]
    test    al, 40h
    jz      short loc_414CF9
loc_414D29:
    mov     esi, offset aHistMustBeAfte; "hIST must be after"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_benign_error
    test    byte ptr [rbx+8], 20h
    jz      loc_414BC0
loc_414D40:
    mov     esi, offset aBkgdMustBeAfte; "bKGD must be after"
    jmp     loc_414BB8
loc_414D4A:
    mov     esi, offset aMissingIhdr; "missing IHDR"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_error
loc_414D57:
    mov     esi, offset message; "duplicate"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_error
loc_414D64:
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
    jz      loc_41A799
    mov     rbx, info_ptr
    test    rsi, rsi
    jz      loc_41A799
    mov     ebp, ecx
    mov     r15, palette
    mov     r14, png_ptr
    mov     al, [info_ptr+25h]
    mov     edx, 100h
    cmp     al, 3
    jnz     short loc_41A71B
    mov     cl, [info_ptr+24h]
    mov     edx, 1
    shl     edx, cl
loc_41A71B:
    test    ebp, ebp
    js      short loc_41A795
    cmp     edx, ebp
    jl      short loc_41A795
    test    palette, palette
    jnz     short loc_41A72C
    test    ebp, ebp
    jg      short loc_41A7A2
loc_41A72C:
    test    ebp, ebp
    jnz     short loc_41A73A
    test    byte ptr [png_ptr+360h], 1
    jz      short loc_41A7A2
loc_41A73A:
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
    test    ebp, ebp
    jle     short loc_41A778
    mov     eax, ebp
    lea     rdx, [rax+rax*2]; n
    mov     rdi, r12; dest
    mov     rsi, palette; src
    call    _memcpy
loc_41A778:
    mov     [info_ptr+18h], r12
    mov     [info_ptr+20h], bp
    or      byte ptr [info_ptr+12Dh], 10h
    mov     [png_ptr+1F0h], bp
    or      byte ptr [info_ptr+8], 8
    jmp     short loc_41A799
loc_41A795:
    cmp     al, 3
    jz      short loc_41A7AF
loc_41A799:
    pop     rbx
    pop     r12
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_41A7A2:
    mov     esi, offset aInvalidPalette; "Invalid palette"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_error
loc_41A7AF:
    mov     esi, offset aInvalidPalette_0; "Invalid palette length"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_error
MAGMA_png_set_PLTE endp

