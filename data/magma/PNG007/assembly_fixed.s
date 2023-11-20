MAGMA_png_read_transform_info proc
    push    rax
    mov     r9d, [png_ptr+124h]
    test    r9d, 1000h
    jz      short loc_410259
    mov     al, [info_ptr+25h]
    movzx   edx, word ptr [png_ptr+1F8h]
    cmp     al, 3
    jnz     loc_4103C8
    test    dx, dx
    setnz   al
    shl     al, 2
    or      al, 2
    mov     [info_ptr+25h], al
    mov     byte ptr [info_ptr+24h], 8
    mov     word ptr [info_ptr+22h], 0
    cmp     qword ptr [png_ptr+1E8h], 0
    jz      loc_410412
loc_410259:
    test    r9b, r9b
    jns     short loc_41027A
loc_41025E:
    movzx   eax, word ptr [png_ptr+218h]
    mov     [info_ptr+0D2h], ax
    mov     rax, [png_ptr+210h]
    mov     [info_ptr+0CAh], rax
loc_41027A:
    mov     eax, [png_ptr+420h]
    mov     [info_ptr+34h], eax
    mov     al, [info_ptr+24h]
    test    r9d, 4000400h
    jz      short loc_410299
    cmp     al, 10h
    jnz     short loc_410299
    mov     byte ptr [info_ptr+24h], 8
    mov     al, 8
loc_410299:
    test    r9d, 4000h
    jz      short loc_4102A6
    or      byte ptr [info_ptr+25h], 2
loc_4102A6:
    test    r9d, 600000h
    jz      short loc_4102B3
    and     byte ptr [info_ptr+25h], 0FDh
loc_4102B3:
    test    r9b, 40h
    jz      short loc_4102D6
    mov     dl, [info_ptr+25h]
    or      dl, 4
    cmp     dl, 6
    jnz     short loc_4102D6
    cmp     qword ptr [png_ptr+300h], 0
    jz      short loc_4102D6
    cmp     al, 8
    jnz     short loc_4102D6
    mov     byte ptr [info_ptr+25h], 3
loc_4102D6:
    test    r9d, 200h
    jz      short loc_4102F1
    cmp     al, 8
    jnz     short loc_4102F1
    mov     al, 8
    cmp     byte ptr [info_ptr+25h], 3
    jz      short loc_4102F1
    mov     byte ptr [info_ptr+24h], 10h
    mov     al, 10h
loc_4102F1:
    test    r9b, 4
    jz      short loc_410301
    cmp     al, 7
    ja      short loc_410301
    mov     byte ptr [info_ptr+24h], 8
    mov     al, 8
loc_410301:
    mov     cl, [info_ptr+25h]
    cmp     cl, 3
    jz      short loc_410312
    test    cl, 2
    jnz     loc_4103F9
loc_410312:
    mov     byte ptr [info_ptr+29h], 1
    mov     r8b, 1
    test    r9d, 40000h
    jz      short loc_41032E
loc_410322:
    and     cl, 0FBh
    mov     [info_ptr+25h], cl
    mov     word ptr [info_ptr+22h], 0
loc_41032E:
    test    cl, 4
    jnz     short loc_41033B
    test    r9w, r9w
    jns     short loc_41036A
    jmp     short loc_410349
loc_41033B:
    add     r8b, 1
    mov     [info_ptr+29h], r8b
    test    r9w, r9w
    jns     short loc_41036A
loc_410349:
    mov     edx, ecx
    or      dl, 2
    cmp     dl, 2
    jnz     short loc_41036A
    add     r8b, 1
    mov     [info_ptr+29h], r8b
    test    r9d, 1000000h
    jz      short loc_41036A
    or      cl, 4
    mov     [info_ptr+25h], cl
loc_41036A:
    test    r9d, 100000h
    jz      short loc_410391
    mov     cl, [png_ptr+118h]
    test    cl, cl
    jz      short loc_410382
    mov     [info_ptr+24h], cl
    mov     eax, ecx
loc_410382:
    mov     cl, [png_ptr+119h]
    test    cl, cl
    jz      short loc_410391
    mov     [info_ptr+29h], cl
    jmp     short loc_410394
loc_410391:
    mov     ecx, r8d
loc_410394:
    mul     cl
    mov     [info_ptr+2Ah], al
    mov     ecx, [info_ptr]
    movzx   edx, al
    cmp     al, 8
    jb      short loc_4103AC
    shr     rdx, 3
    imul    rdx, rcx
    jmp     short loc_4103BB
loc_4103AC:
    imul    rcx, rdx
    add     rcx, 7
    shr     rcx, 3
    mov     rdx, rcx
loc_4103BB:
    mov     [info_ptr+10h], rdx
    mov     [png_ptr+1D8h], rdx
    pop     rax
    retn
loc_4103C8:
    test    r9d, 2000000h
    jz      short loc_4103DB
    test    dx, dx
    jz      short loc_4103DB
    or      al, 4
    mov     [info_ptr+25h], al
loc_4103DB:
    cmp     byte ptr [info_ptr+24h], 7
    ja      short loc_4103E5
    mov     byte ptr [info_ptr+24h], 8
loc_4103E5:
    mov     word ptr [info_ptr+22h], 0
    test    r9b, r9b
    jns     loc_41027A
    jmp     loc_41025E
loc_4103F9:
    mov     byte ptr [info_ptr+29h], 3
    mov     r8b, 3
    test    r9d, 40000h
    jnz     loc_410322
    jmp     loc_41032E
loc_410412:
    mov     esi, offset aPaletteIsNullI; "Palette is NULL in indexed image"
    call    MAGMA_png_error
MAGMA_png_read_transform_info endp



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

