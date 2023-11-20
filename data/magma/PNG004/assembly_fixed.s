MAGMA_png_combine_row proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 28h
    movzx   r15d, byte ptr [png_ptr+206h]
    test    r15d, r15d
    jz      loc_417E53
    mov     r10, dp
    mov     r8, [png_ptr+1D0h]
    mov     ebp, [png_ptr+1A0h]
    movzx   r9d, byte ptr [png_ptr+1FDh]
    mov     rax, [png_ptr+1D8h]
    test    rax, rax
    jz      short loc_417656
    cmp     r15b, 8
    jb      short loc_41763E
    mov     rcx, pixel_depth
    shr     rcx, 3
    imul    rcx, row_width
    cmp     rax, rcx
    jz      short loc_417656
    jmp     loc_417E67
loc_41763E:
    mov     rcx, row_width
    imul    rcx, pixel_depth
    add     rcx, 7
    shr     rcx, 3
    cmp     rax, rcx
    jnz     loc_417E67
loc_417656:
    test    ebp, ebp
    jz      loc_417E5D
    mov     rax, row_width
    imul    rax, pixel_depth
    mov     ecx, eax
    and     ecx, 7
    jz      short loc_4176AD
    mov     rsi, pixel_depth
    shr     rsi, 3
    imul    rsi, row_width
    lea     rbx, [rax+7]
    shr     rbx, 3
    cmp     r15b, 7
    cmova   rbx, rsi
    lea     r13, [dp+rbx]
    add     r13, 0FFFFFFFFFFFFFFFFh
    mov     sil, [dp+rbx-1]
    mov     [rsp+58h+var_50], rsi
    test    byte ptr [png_ptr+126h], 1
    jnz     short loc_4176BC
    mov     r12d, 0FFh
    shr     r12d, cl
    jmp     short loc_4176C5
loc_4176AD:
    xor     ecx, ecx
    mov     [rsp+58h+var_50], rcx
    xor     r12d, r12d
    xor     r13d, r13d
    jmp     short loc_4176C5
loc_4176BC:
    mov     r12d, 0FFh
    shl     r12d, cl
loc_4176C5:
    lea     rbx, [r8+1]
    cmp     byte ptr [png_ptr+1FCh], 0
    jz      short loc_417703
    cmp     r9b, 5
    ja      short loc_417703
    mov     esi, [png_ptr+124h]
    mov     ecx, esi
    and     ecx, 2
    jz      short loc_417703
    cmp     edx, 1
    jz      short loc_4176F7
    test    edx, edx
    jnz     short loc_417703
    mov     r14d, r9d
    and     r14d, 1
    jmp     short loc_41775A
loc_4176F7:
    mov     r14d, 1
    test    r9b, 1
    jnz     short loc_41775A
loc_417703:
    mov     rcx, pixel_depth
    shr     rcx, 3
    imul    rcx, row_width
    add     rax, 7
    shr     rax, 3
    cmp     r15b, 7
    cmova   rax, rcx
    mov     png_ptr, dp; dest
    mov     rsi, sp_0; src
    mov     display, rax; n
    call    _memcpy
loc_41772C:
    test    end_ptr, end_ptr
    jz      short loc_41774B
    movzx   eax, byte ptr [rsp+58h+var_50]
    and     eax, r12d
    movzx   ecx, byte ptr [end_ptr+0]
    not     r12d
    and     r12d, ecx
    or      r12d, eax
    mov     [end_ptr+0], r12b
loc_41774B:
    add     rsp, 28h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_41775A:
    lea     eax, [pass+1]
    shr     eax, 1
    mov     cl, 3
    sub     cl, al
    shl     r14d, cl
    and     r14d, 7
    cmp     ebp, r14d
    jbe     short loc_41774B
    cmp     r15b, 7
    ja      short loc_4177C8
    mov     al, 8
    movzx   eax, al
    div     r15b
    xor     ecx, ecx
    cmp     r15b, 2
    setz    cl
    mov     edi, 2
    sub     rdi, rcx
    xor     ecx, ecx
    cmp     r15b, 1
    cmovnz  rcx, rdi
    test    esi, 10000h
    jnz     loc_417889
    test    edx, edx
    jz      loc_417A99
    lea     edx, [pass+pass]
    and     edx, 0FFFFFFFCh
    lea     rcx, [rcx+rcx*2]
    lea     rcx, [rdx+rcx*4]
    add     rcx, 422744h
    jmp     loc_417AC8
loc_4177C8:
    test    r15b, 7
    jnz     loc_417E71
    shr     pixel_depth, 3
    mov     r11d, r15d
    mov     rax, row_width
    imul    rax, r15
    imul    r14d, r15d
    mov     end_ptr, row_width
    sub     r13, offset
    mov     r12d, r15d
    test    edx, edx
    jz      short loc_41780A
    mov     ecx, 6
    sub     ecx, r9d
    shr     ecx, 1
    mov     edx, r11d
    shl     edx, cl
    cmp     row_width, bytes_to_copy
    mov     r12d, r13d
    cmovnb  r12d, edx
loc_41780A:
    lea     png_ptr, [dp+r14]; dest
    lea     rsi, [sp_0+r14]; src
    mov     ecx, 7
    sub     ecx, r9d
    shr     ecx, 1
    shl     r11d, cl
    cmp     r12d, 1
    jz      loc_4178E4
    cmp     r12d, 2
    jz      short loc_4178AC
    mov     r9d, r11d
    cmp     r12d, 3
    jnz     loc_417910
    mov     al, [sp_0]
    mov     [dp], al
    mov     al, [sp_0+1]
    mov     [dp+1], al
    mov     al, [sp_0+2]
    mov     [dp+2], al
    cmp     row_width, r9
    jbe     loc_41774B
    lea     rax, [r9+r14]
loc_417859:
    sub     row_width, r9
    movzx   ecx, byte ptr [r8+rax+1]
    mov     [r10+rax], cl
    movzx   ecx, byte ptr [r8+rax+2]
    mov     [r10+rax+1], cl
    movzx   ecx, byte ptr [r8+rax+3]
    mov     [r10+rax+2], cl
    add     rax, r9
    cmp     row_width, r9
    ja      short loc_417859
    jmp     loc_41774B
loc_417889:
    test    edx, edx
    jz      loc_417AB2
    lea     edx, [pass+pass]
    and     edx, 0FFFFFFFCh
    lea     rcx, [rcx+rcx*2]
    lea     rcx, [rdx+rcx*4]
    add     rcx, 422720h
    jmp     loc_417AC8
loc_4178AC:
    mov     eax, r11d
loc_4178AF:
    movzx   ecx, byte ptr [r8+r14+1]
    mov     [r10+r14], cl
    movzx   ecx, byte ptr [r8+r14+2]
    mov     [r10+r14+1], cl
    sub     row_width, rax
    jbe     loc_41774B
    add     r14, rax
    cmp     row_width, 1
    ja      short loc_4178AF
    mov     al, [r8+r14+1]
    mov     [r10+r14], al
    jmp     loc_41774B
loc_4178E4:
    mov     al, [sp_0]
    mov     [dp], al
    mov     eax, r11d
    cmp     row_width, rax
    jbe     loc_41774B
    lea     rcx, [rax+r14]
loc_4178F8:
    sub     row_width, rax
    movzx   edx, byte ptr [rbx+rcx]
    mov     [r10+rcx], dl
    add     rcx, rax
    cmp     row_width, rax
    ja      short loc_4178F8
    jmp     loc_41774B
loc_417910:
    mov     edx, r12d; n
    cmp     r12d, 0Fh
    ja      loc_417A02
    test    dil, 1
    jnz     loc_417A02
    test    sil, 1
    jnz     loc_417A02
    test    r12b, 1
    jnz     loc_417A02
    test    r11b, 1
    jnz     loc_417A02
    mov     ecx, esi
    or      ecx, r9d
    mov     ebp, edx
    or      ebp, edi
    or      ebp, ecx
    sub     r11d, r12d
    test    bpl, 3
    jz      loc_417B1F
    shr     r11d, 1
    sub     rax, r9
    sub     rax, r14
loc_417966:
    mov     r14, rax
    mov     rcx, dp16
    mov     rbp, sp16
    mov     rax, rdx
loc_417972:
    movzx   esi, word ptr [sp16+0]
    add     sp16, 2
    mov     [dp16], si
    add     dp16, 2
    add     c, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_417972
    sub     row_width, r9
    jbe     loc_41774B
    lea     dp, [dp16+skip*2]
    lea     rsi, ds:0[skip*2]
    add     rsi, sp16
    mov     rax, r14
    sub     rax, r9
    cmp     row_width, rdx
    jnb     short loc_417966
    cmp     row_width, 20h ; ' '
    jb      loc_417C83
    lea     rax, [sp16+row_width]
    cmp     rax, dp16
    jbe     short loc_4179CA
    lea     rax, [dp16+row_width]
    cmp     rax, sp16
    ja      loc_417C83
loc_4179CA:
    mov     r8, row_width
    and     r8, 0FFFFFFFFFFFFFFE0h
    lea     rbx, [r8-20h]
    mov     rax, rbx
    shr     rax, 5
    add     rax, 1
    mov     r9d, eax
    and     r9d, 3
    cmp     rbx, 60h ; '`'
    jnb     loc_417BC3
    xor     r10d, r10d
    test    r9, r9
    jnz     loc_417C33
    jmp     loc_417C71
loc_417A02:
    mov     [rsp+58h+var_50], r10
    mov     qword ptr [rsp+58h+var_38], bytes_to_jump
    mov     [rsp+58h+var_40], rbx
    mov     [rsp+58h+var_48], r9
    mov     rbx, rdx
    call    _memcpy
    mov     rcx, [rsp+58h+var_48]
    mov     rdi, [rsp+58h+var_40]
    mov     r8, qword ptr [rsp+58h+var_38]
    mov     rax, [rsp+58h+var_50]
    cmp     row_width, rcx
    jbe     loc_41774B
    mov     rdx, rbx
    lea     rbx, [rcx+r14]
    mov     rsi, rcx
    neg     rsi
    imul    r15d, ebp
    sub     r15d, r14d
    mov     rbp, rsi
    sub     r15d, r8d
loc_417A55:
    lea     rsi, [rdi+rbx]; src
    lea     rdi, [rax+rbx]; dest
    mov     rax, rbp
    add     rax, row_width
    sub     row_width, rcx
    cmp     rax, rdx
    cmovb   r12d, r15d
    mov     rdx, bytes_to_copy; n
    call    _memcpy
    mov     rcx, [rsp+58h+var_48]
    mov     rdi, [rsp+58h+var_40]
    mov     rax, [rsp+58h+var_50]
    add     rbx, rcx
    sub     r15d, [rsp+58h+var_38]
    mov     rdx, bytes_to_copy
    cmp     row_width, rcx
    ja      short loc_417A55
    jmp     loc_41774B
loc_417A99:
    lea     rcx, [rcx+rcx*2]
    lea     display, ds:0[pass*4]
    lea     rcx, [rdx+rcx*8]
    add     rcx, 4226D8h
    jmp     short loc_417AC8
loc_417AB2:
    mov     edx, r9d
    lea     rcx, [rcx+rcx*2]
    shl     rdx, 2
    lea     rcx, [rdx+rcx*8]
    add     rcx, 422690h
loc_417AC8:
    mov     ecx, [rcx]
    movzx   eax, al
    xor     edx, edx
    cmp     cl, 0FFh
    jz      short loc_417B00
    nop     word ptr [rax+rax+00000000h]
    xchg    ax, ax
loc_417AE0:
    test    cl, cl
    jz      short loc_417B08
    movzx   esi, byte ptr [r10+rdx]
    mov     edi, ecx
    not     edi
    and     edi, esi
    movzx   esi, byte ptr [rbx+rdx]
    and     esi, ecx
    or      esi, edi
    jmp     short loc_417B04
loc_417B00:
    mov     sil, [rbx+rdx]
loc_417B04:
    mov     [r10+rdx], sil
loc_417B08:
    sub     row_width, rax
    jbe     loc_41772C
    rol     ecx, 18h
    add     rdx, 1
    cmp     cl, 0FFh
    jnz     short loc_417AE0
    jmp     short loc_417B00
loc_417B1F:
    shr     r11d, 2
    sub     rax, r9
    sub     rax, r14
loc_417B29:
    mov     r14, rax
    mov     rcx, dp32
    mov     rbp, sp32
    mov     rax, rdx
loc_417B35:
    mov     esi, [sp32+0]
    add     sp32, 4
    mov     [dp32], esi
    add     dp32, 4
    add     c, 0FFFFFFFFFFFFFFFCh
    jnz     short loc_417B35
    sub     row_width, r9
    jbe     loc_41774B
    lea     dp, [dp32+skip*4]
    lea     rsi, ds:0[skip*4]
    add     rsi, sp32
    mov     rax, r14
    sub     rax, r9
    cmp     row_width, rdx
    jnb     short loc_417B29
    cmp     row_width, 20h ; ' '
    jb      loc_417DCB
    lea     rax, [sp32+row_width]
    cmp     rax, dp32
    jbe     short loc_417B8B
    lea     rax, [dp32+row_width]
    cmp     rax, sp32
    ja      loc_417DCB
loc_417B8B:
    mov     r8, row_width
    and     r8, 0FFFFFFFFFFFFFFE0h
    lea     rbx, [r8-20h]
    mov     rax, rbx
    shr     rax, 5
    add     rax, 1
    mov     r9d, eax
    and     r9d, 3
    cmp     rbx, 60h ; '`'
    jnb     loc_417D0B
    xor     r10d, r10d
    test    r9, r9
    jnz     loc_417D7B
    jmp     loc_417DB9
loc_417BC3:
    sub     rax, r9
    lea     rbx, [skip+skip]
    add     rbx, 70h ; 'p'
    xor     r10d, r10d
loc_417BD1:
    movups  xmm0, xmmword ptr [rbp+rbx-70h]
    movups  xmm1, xmmword ptr [rbp+rbx-60h]
    movups  xmmword ptr [rcx+rbx-70h], xmm0
    movups  xmmword ptr [rcx+rbx-60h], xmm1
    movups  xmm0, xmmword ptr [rbp+rbx-50h]
    movups  xmm1, xmmword ptr [rbp+rbx-40h]
    movups  xmmword ptr [rcx+rbx-50h], xmm0
    movups  xmmword ptr [rcx+rbx-40h], xmm1
    movups  xmm0, xmmword ptr [rbp+rbx-30h]
    movups  xmm1, xmmword ptr [rbp+rbx-20h]
    movups  xmmword ptr [rcx+rbx-30h], xmm0
    movups  xmmword ptr [rcx+rbx-20h], xmm1
    movups  xmm0, xmmword ptr [rbp+rbx-10h]
    movups  xmm1, xmmword ptr [rbp+rbx+0]
    movups  xmmword ptr [rcx+rbx-10h], xmm0
    movups  xmmword ptr [rcx+rbx], xmm1
    sub     r10, 0FFFFFFFFFFFFFF80h
    sub     rbx, 0FFFFFFFFFFFFFF80h
    add     rax, 0FFFFFFFFFFFFFFFCh
    jnz     short loc_417BD1
    test    r9, r9
    jz      short loc_417C71
loc_417C33:
    lea     rax, [r10+skip*2]
    add     rax, 10h
    and     r14b, 60h
    add     r14b, 0E0h
    shr     r14b, 5
    add     r14b, 1
    movzx   edx, r14b
    and     edx, 3
    neg     rdx
loc_417C55:
    movups  xmm0, xmmword ptr [rbp+rax-10h]
    movups  xmm1, xmmword ptr [rbp+rax+0]
    movups  xmmword ptr [rcx+rax-10h], xmm0
    movups  xmmword ptr [rcx+rax], xmm1
    add     rax, 20h ; ' '
    inc     rdx
    jnz     short loc_417C55
loc_417C71:
    cmp     row_width, r8
    jz      loc_41774B
    sub     row_width, r8
    add     sp16, r8
    add     dp16, r8
loc_417C83:
    lea     rax, [r13-1]
    mov     rdx, r13
    and     rdx, 7
    jz      short loc_417CAB
    xor     ecx, ecx
loc_417C92:
    movzx   ebx, byte ptr [rsi+rcx]
    mov     [rdi+rcx], bl
    add     rcx, 1
    cmp     rdx, rcx
    jnz     short loc_417C92
    sub     r13, rcx
    add     rsi, rcx
    add     rdi, rcx
loc_417CAB:
    cmp     rax, 7
    jb      loc_41774B
    xor     eax, eax
loc_417CB7:
    movzx   ecx, byte ptr [rsi+rax]
    mov     [rdi+rax], cl
    movzx   ecx, byte ptr [rsi+rax+1]
    mov     [rdi+rax+1], cl
    movzx   ecx, byte ptr [rsi+rax+2]
    mov     [rdi+rax+2], cl
    movzx   ecx, byte ptr [rsi+rax+3]
    mov     [rdi+rax+3], cl
    movzx   ecx, byte ptr [rsi+rax+4]
    mov     [rdi+rax+4], cl
    movzx   ecx, byte ptr [rsi+rax+5]
    mov     [rdi+rax+5], cl
    movzx   ecx, byte ptr [rsi+rax+6]
    mov     [rdi+rax+6], cl
    movzx   ecx, byte ptr [rsi+rax+7]
    mov     [rdi+rax+7], cl
    add     rax, 8
    cmp     r13, rax
    jnz     short loc_417CB7
    jmp     loc_41774B
loc_417D0B:
    sub     rax, r9
    lea     rbx, ds:70h[skip*4]
    xor     r10d, r10d
loc_417D19:
    movups  xmm0, xmmword ptr [rbp+rbx-70h]
    movups  xmm1, xmmword ptr [rbp+rbx-60h]
    movups  xmmword ptr [rcx+rbx-70h], xmm0
    movups  xmmword ptr [rcx+rbx-60h], xmm1
    movups  xmm0, xmmword ptr [rbp+rbx-50h]
    movups  xmm1, xmmword ptr [rbp+rbx-40h]
    movups  xmmword ptr [rcx+rbx-50h], xmm0
    movups  xmmword ptr [rcx+rbx-40h], xmm1
    movups  xmm0, xmmword ptr [rbp+rbx-30h]
    movups  xmm1, xmmword ptr [rbp+rbx-20h]
    movups  xmmword ptr [rcx+rbx-30h], xmm0
    movups  xmmword ptr [rcx+rbx-20h], xmm1
    movups  xmm0, xmmword ptr [rbp+rbx-10h]
    movups  xmm1, xmmword ptr [rbp+rbx+0]
    movups  xmmword ptr [rcx+rbx-10h], xmm0
    movups  xmmword ptr [rcx+rbx], xmm1
    sub     r10, 0FFFFFFFFFFFFFF80h
    sub     rbx, 0FFFFFFFFFFFFFF80h
    add     rax, 0FFFFFFFFFFFFFFFCh
    jnz     short loc_417D19
    test    r9, r9
    jz      short loc_417DB9
loc_417D7B:
    lea     rax, [r10+skip*4]
    add     rax, 10h
    and     r14b, 60h
    add     r14b, 0E0h
    shr     r14b, 5
    add     r14b, 1
    movzx   edx, r14b
    and     edx, 3
    neg     rdx
loc_417D9D:
    movups  xmm0, xmmword ptr [rbp+rax-10h]
    movups  xmm1, xmmword ptr [rbp+rax+0]
    movups  xmmword ptr [rcx+rax-10h], xmm0
    movups  xmmword ptr [rcx+rax], xmm1
    add     rax, 20h ; ' '
    inc     rdx
    jnz     short loc_417D9D
loc_417DB9:
    cmp     row_width, r8
    jz      loc_41774B
    sub     row_width, r8
    add     sp32, r8
    add     dp32, r8
loc_417DCB:
    lea     rax, [r13-1]
    mov     rdx, r13
    and     rdx, 7
    jz      short loc_417DF3
    xor     ecx, ecx
loc_417DDA:
    movzx   ebx, byte ptr [rsi+rcx]
    mov     [rdi+rcx], bl
    add     rcx, 1
    cmp     rdx, rcx
    jnz     short loc_417DDA
    sub     r13, rcx
    add     rsi, rcx
    add     rdi, rcx; png_ptr
loc_417DF3:
    cmp     rax, 7
    jb      loc_41774B
    xor     eax, eax
loc_417DFF:
    movzx   ecx, byte ptr [rsi+rax]
    mov     [rdi+rax], cl
    movzx   ecx, byte ptr [rsi+rax+1]
    mov     [rdi+rax+1], cl
    movzx   ecx, byte ptr [rsi+rax+2]
    mov     [rdi+rax+2], cl
    movzx   ecx, byte ptr [rsi+rax+3]
    mov     [rdi+rax+3], cl
    movzx   ecx, byte ptr [rsi+rax+4]
    mov     [rdi+rax+4], cl
    movzx   ecx, byte ptr [rsi+rax+5]
    mov     [rdi+rax+5], cl
    movzx   ecx, byte ptr [rsi+rax+6]
    mov     [rdi+rax+6], cl
    movzx   ecx, byte ptr [rsi+rax+7]
    mov     [rdi+rax+7], cl
    add     rax, 8
    cmp     r13, rax
    jnz     short loc_417DFF
    jmp     loc_41774B
loc_417E53:
    mov     esi, offset aInternalRowLog; "internal row logic error"
    call    MAGMA_png_error
loc_417E5D:
    mov     esi, offset aInternalRowWid; "internal row width error"
    call    MAGMA_png_error
loc_417E67:
    mov     esi, offset aInternalRowSiz; "internal row size calculation error"
    call    MAGMA_png_error
loc_417E71:
    mov     esi, offset aInvalidUserTra; "invalid user transform pixel depth"
    call    MAGMA_png_error
MAGMA_png_combine_row endp

