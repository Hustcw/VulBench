MAGMA_png_read_transform_info proc
    mov     r9d, [png_ptr+124h]
    test    r9d, 1000h
    jz      short loc_4101E4
    mov     al, [info_ptr+25h]
    movzx   edx, word ptr [png_ptr+1F8h]
    cmp     al, 3
    jnz     short loc_4101BE
    test    dx, dx
    setnz   al
    shl     al, 2
    or      al, 2
    mov     [info_ptr+25h], al
    jmp     short loc_4101D7
loc_4101BE:
    test    r9d, 2000000h
    jz      short loc_4101D1
    test    dx, dx
    jz      short loc_4101D1
    or      al, 4
    mov     [info_ptr+25h], al
loc_4101D1:
    cmp     byte ptr [info_ptr+24h], 7
    ja      short loc_4101DE
loc_4101D7:
    lea     rax, [info_ptr+24h]
    mov     byte ptr [rax], 8
loc_4101DE:
    mov     word ptr [info_ptr+22h], 0
loc_4101E4:
    test    r9b, r9b
    jns     short loc_410205
    movzx   eax, word ptr [png_ptr+218h]
    mov     [info_ptr+0D2h], ax
    mov     rax, [png_ptr+210h]
    mov     [info_ptr+0CAh], rax
loc_410205:
    mov     eax, [png_ptr+420h]
    mov     [info_ptr+34h], eax
    mov     al, [info_ptr+24h]
    test    r9d, 4000400h
    jz      short loc_410224
    cmp     al, 10h
    jnz     short loc_410224
    mov     byte ptr [info_ptr+24h], 8
    mov     al, 8
loc_410224:
    test    r9d, 4000h
    jz      short loc_410231
    or      byte ptr [info_ptr+25h], 2
loc_410231:
    test    r9d, 600000h
    jz      short loc_41023E
    and     byte ptr [info_ptr+25h], 0FDh
loc_41023E:
    test    r9b, 40h
    jz      short loc_410261
    mov     dl, [info_ptr+25h]
    or      dl, 4
    cmp     dl, 6
    jnz     short loc_410261
    cmp     qword ptr [png_ptr+300h], 0
    jz      short loc_410261
    cmp     al, 8
    jnz     short loc_410261
    mov     byte ptr [info_ptr+25h], 3
loc_410261:
    test    r9d, 200h
    jz      short loc_41027C
    cmp     al, 8
    jnz     short loc_41027C
    mov     al, 8
    cmp     byte ptr [info_ptr+25h], 3
    jz      short loc_41027C
    mov     byte ptr [info_ptr+24h], 10h
    mov     al, 10h
loc_41027C:
    test    r9b, 4
    jz      short loc_41028C
    cmp     al, 7
    ja      short loc_41028C
    mov     byte ptr [info_ptr+24h], 8
    mov     al, 8
loc_41028C:
    mov     cl, [info_ptr+25h]
    cmp     cl, 3
    jz      short loc_41029D
    test    cl, 2
    jnz     loc_410352
loc_41029D:
    mov     byte ptr [info_ptr+29h], 1
    mov     r8b, 1
    test    r9d, 40000h
    jz      short loc_4102B9
loc_4102AD:
    and     cl, 0FBh
    mov     [info_ptr+25h], cl
    mov     word ptr [info_ptr+22h], 0
loc_4102B9:
    test    cl, 4
    jnz     short loc_4102C6
    test    r9w, r9w
    jns     short loc_4102F5
    jmp     short loc_4102D4
loc_4102C6:
    add     r8b, 1
    mov     [info_ptr+29h], r8b
    test    r9w, r9w
    jns     short loc_4102F5
loc_4102D4:
    mov     edx, ecx
    or      dl, 2
    cmp     dl, 2
    jnz     short loc_4102F5
    add     r8b, 1
    mov     [info_ptr+29h], r8b
    test    r9d, 1000000h
    jz      short loc_4102F5
    or      cl, 4
    mov     [info_ptr+25h], cl
loc_4102F5:
    test    r9d, 100000h
    jz      short loc_41031C
    mov     cl, [png_ptr+118h]
    test    cl, cl
    jz      short loc_41030D
    mov     [info_ptr+24h], cl
    mov     eax, ecx
loc_41030D:
    mov     cl, [png_ptr+119h]
    test    cl, cl
    jz      short loc_41031C
    mov     [info_ptr+29h], cl
    jmp     short loc_41031F
loc_41031C:
    mov     ecx, r8d
loc_41031F:
    mul     cl
    mov     [info_ptr+2Ah], al
    mov     ecx, [info_ptr]
    movzx   edx, al
    cmp     al, 8
    jb      short loc_410337
    shr     rdx, 3
    imul    rdx, rcx
    jmp     short loc_410346
loc_410337:
    imul    rcx, rdx
    add     rcx, 7
    shr     rcx, 3
    mov     rdx, rcx
loc_410346:
    mov     [info_ptr+10h], rdx
    mov     [png_ptr+1D8h], rdx
    retn
loc_410352:
    mov     byte ptr [info_ptr+29h], 3
    mov     r8b, 3
    test    r9d, 40000h
    jnz     loc_4102AD
    jmp     loc_4102B9
MAGMA_png_read_transform_info endp



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

