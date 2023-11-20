MAGMA_png_combine_row proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    movzx   ebx, byte ptr [png_ptr+206h]
    test    ebx, ebx
    jz      loc_417D5D
    mov     r14, dp
    mov     r9, [png_ptr+1D0h]
    mov     r13d, [png_ptr+1A0h]
    movzx   r8d, byte ptr [png_ptr+1FDh]
    mov     rcx, [png_ptr+1D8h]
    test    rcx, rcx
    jz      short loc_417574
    cmp     bl, 8
    jb      short loc_41755C
    mov     rsi, pixel_depth
    shr     rsi, 3
    imul    rsi, row_width
    cmp     rcx, rsi
    jz      short loc_417574
    jmp     loc_417D71
loc_41755C:
    mov     rsi, row_width
    imul    rsi, pixel_depth
    add     rsi, 7
    shr     rsi, 3
    cmp     rcx, rsi
    jnz     loc_417D71
loc_417574:
    test    r13d, r13d
    jz      loc_417D67
    mov     ecx, r13d
    imul    ecx, ebx
    and     ecx, 7
    jz      short loc_41759A
    cmp     bl, 8
    jb      short loc_4175A8
    mov     rsi, pixel_depth
    shr     rsi, 3
    imul    rsi, row_width
    jmp     short loc_4175B7
loc_41759A:
    xor     eax, eax
    mov     [rsp+48h+var_40], rax
    xor     ebp, ebp
    xor     r12d, r12d
    jmp     short loc_4175E2
loc_4175A8:
    mov     rsi, row_width
    imul    rsi, pixel_depth
    add     rsi, 7
    shr     rsi, 3
loc_4175B7:
    lea     r12, [dp+rsi]
    add     r12, 0FFFFFFFFFFFFFFFFh
    mov     al, [dp+rsi-1]
    mov     [rsp+48h+var_40], rax
    test    byte ptr [png_ptr+126h], 1
    jnz     short loc_4175DB
    mov     ebp, 0FFh
    shr     ebp, cl
    jmp     short loc_4175E2
loc_4175DB:
    mov     ebp, 0FFh
    shl     ebp, cl
loc_4175E2:
    lea     r10, [r9+1]
    cmp     byte ptr [png_ptr+1FCh], 0
    jz      short loc_41761E
    cmp     r8b, 5
    ja      short loc_41761E
    mov     esi, [png_ptr+124h]
    mov     ecx, esi
    and     ecx, 2
    jz      short loc_41761E
    cmp     edx, 1
    jz      short loc_417613
    test    edx, edx
    jnz     short loc_41761E
    mov     ecx, r8d
    and     ecx, 1
    jmp     short loc_417674
loc_417613:
    mov     ecx, 1
    test    r8b, 1
    jnz     short loc_417674
loc_41761E:
    cmp     bl, 8
    jb      short loc_41762D
    shr     pixel_depth, 3
    imul    rbx, row_width
    jmp     short loc_41763C
loc_41762D:
    imul    row_width, pixel_depth
    add     r13, 7
    shr     r13, 3
    mov     pixel_depth, r13
loc_41763C:
    mov     png_ptr, dp; dest
    mov     rsi, sp_0; src
    mov     display, rbx; n
    call    _memcpy
loc_41764A:
    test    end_ptr, end_ptr
    jz      short loc_417665
    movzx   eax, byte ptr [rsp+48h+var_40]
    and     eax, ebp
    movzx   ecx, byte ptr [end_ptr]
    not     ebp
    and     ebp, ecx
    or      ebp, eax
    mov     [end_ptr], bpl
loc_417665:
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_417674:
    lea     eax, [pass+1]
    shr     eax, 1
    mov     r15d, ecx
    mov     cl, 3
    sub     cl, al
    shl     r15, cl
    and     r15d, 7
    cmp     r13d, r15d
    jbe     short loc_417665
    cmp     bl, 7
    ja      short loc_4176E1
    mov     al, 8
    movzx   eax, al
    div     bl
    xor     ecx, ecx
    cmp     bl, 2
    setz    cl
    mov     edi, 2
    sub     rdi, rcx
    xor     ecx, ecx
    cmp     bl, 1
    cmovnz  rcx, rdi
    test    esi, 10000h
    jnz     loc_417793
    test    edx, edx
    jz      loc_417963
    lea     edx, [pass+pass]
    and     edx, 0FFFFFFFCh
    lea     rcx, [rcx+rcx*2]
    lea     rcx, [rdx+rcx*4]
    add     rcx, 422634h
    jmp     loc_417992
loc_4176E1:
    test    bl, 7
    jnz     loc_417D7B
    shr     pixel_depth, 3
    imul    r13d, ebx
    imul    r15, pixel_depth
    sub     r13d, r15d
    mov     r12d, ebx
    test    edx, edx
    jz      short loc_417717
    mov     ecx, 6
    sub     ecx, r8d
    shr     ecx, 1
    mov     r12d, ebx
    shl     r12d, cl
    cmp     r12d, r13d
    cmova   r12d, r13d
loc_417717:
    lea     png_ptr, [dp+r15]; dest
    lea     rsi, [sp_0+r15]; src
    mov     ecx, 7
    sub     ecx, r8d
    shr     ecx, 1
    shl     ebx, cl
    cmp     r12d, 1
    jz      loc_4177ED
    cmp     r12d, 2
    jz      short loc_4177B6
    cmp     r12d, 3
    jnz     loc_417818
    mov     al, [sp_0]
    mov     [dp], al
    mov     al, [sp_0+1]
    mov     [dp+1], al
    mov     al, [sp_0+2]
    mov     [dp+2], al
    cmp     r13d, ebx
    jbe     loc_417665
    mov     ecx, ebx
    add     r15, rcx
loc_417763:
    sub     r13d, ebx
    movzx   eax, byte ptr [r9+r15+1]
    mov     [r14+r15], al
    movzx   eax, byte ptr [r9+r15+2]
    mov     [r14+r15+1], al
    movzx   eax, byte ptr [r9+r15+3]
    mov     [r14+r15+2], al
    add     r15, rcx
    cmp     r13d, ebx
    ja      short loc_417763
    jmp     loc_417665
loc_417793:
    test    edx, edx
    jz      loc_41797C
    lea     edx, [pass+pass]
    and     edx, 0FFFFFFFCh
    lea     rcx, [rcx+rcx*2]
    lea     rcx, [rdx+rcx*4]
    add     rcx, 422610h
    jmp     loc_417992
loc_4177B6:
    mov     ecx, ebx
loc_4177B8:
    movzx   eax, byte ptr [r9+r15+1]
    mov     [r14+r15], al
    movzx   eax, byte ptr [r9+r15+2]
    mov     [r14+r15+1], al
    sub     r13d, ebx
    jbe     loc_417665
    add     r15, rcx
    cmp     r13d, 1
    ja      short loc_4177B8
    mov     al, [r9+r15+1]
    mov     [r14+r15], al
    jmp     loc_417665
loc_4177ED:
    mov     al, [sp_0]
    mov     [dp], al
    cmp     r13d, ebx
    jbe     loc_417665
    mov     eax, ebx
    add     r15, rax
loc_4177FF:
    sub     r13d, ebx
    movzx   ecx, byte ptr [r10+r15]
    mov     [r14+r15], cl
    add     r15, rax
    cmp     r13d, ebx
    ja      short loc_4177FF
    jmp     loc_417665
loc_417818:
    mov     edx, r12d; n
    cmp     r12d, 0Fh
    ja      loc_41790A
    test    dil, 1
    jnz     loc_41790A
    test    sil, 1
    jnz     loc_41790A
    test    r12b, 1
    jnz     loc_41790A
    test    bl, 1
    jnz     loc_41790A
    mov     eax, ebx
    or      eax, esi
    mov     ecx, edx
    or      ecx, edi
    or      ecx, eax
    mov     r15d, ebx
    sub     r15d, r12d
    test    cl, 3
    jz      loc_4179DF
    shr     r15d, 1
    mov     ebp, ebx
    not     ebp
    add     ebp, r13d
loc_41786F:
    mov     r8d, ebp
    mov     rax, dp16
    mov     rcx, sp16
    mov     sp_0, rdx
loc_41787B:
    movzx   edi, word ptr [sp16]
    add     sp16, 2
    mov     [dp16], di
    add     dp16, 2
    add     c, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_41787B
    sub     r13d, ebx
    jbe     loc_417665
    lea     rdi, [dp16+skip*2]
    lea     rsi, [sp16+skip*2]
    mov     ebp, r8d
    sub     ebp, ebx
    cmp     r12d, r13d
    jbe     short loc_41786F
    lea     edx, [row_width-1]
    lea     r11, [rdx+1]
    cmp     r11, 20h ; ' '
    jb      loc_417B65
    lea     rbp, [sp16+rdx]
    add     rbp, 1
    cmp     rbp, dp16
    jbe     short loc_4178D9
    add     rdx, dp16
    add     rdx, 1
    cmp     rdx, sp16
    ja      loc_417B65
loc_4178D9:
    mov     r9, r11
    and     r9, 0FFFFFFFFFFFFFFE0h
    lea     rdx, [r9-20h]
    mov     r10, rdx
    shr     r10, 5
    add     r10, 1
    cmp     rdx, 60h ; '`'
    jnb     loc_417A83
    xor     edx, edx
    test    r10b, 3
    jnz     loc_417B12
    jmp     loc_417B53
loc_41790A:
    mov     [rsp+48h+var_40], r10
    call    _memcpy
    mov     rax, [rsp+48h+var_40]
    cmp     r13d, ebx
    jbe     loc_417665
    mov     ecx, ebx
    mov     [rsp+48h+var_38], rcx
    add     r15, rcx
    mov     ebp, ebx
    neg     ebp
loc_417930:
    lea     rsi, [rax+r15]; src
    lea     rdi, [r14+r15]; dest
    lea     eax, [rbp+row_width+0]
    sub     r13d, ebx
    cmp     r12d, eax
    cmova   r12d, eax
    mov     rdx, bytes_to_copy; n
    call    _memcpy
    mov     rax, [rsp+48h+var_40]
    add     r15, [rsp+48h+var_38]
    cmp     r13d, ebx
    ja      short loc_417930
    jmp     loc_417665
loc_417963:
    lea     rcx, [rcx+rcx*2]
    lea     display, ds:0[pass*4]
    lea     rcx, [rdx+rcx*8]
    add     rcx, 4225C8h
    jmp     short loc_417992
loc_41797C:
    mov     edx, r8d
    lea     rcx, [rcx+rcx*2]
    shl     rdx, 2
    lea     rcx, [rdx+rcx*8]
    add     rcx, 422580h
loc_417992:
    movzx   eax, al
    mov     ecx, [rcx]
    xor     edx, edx
    cmp     cl, 0FFh
    jz      short loc_4179C0
    xchg    ax, ax
loc_4179A0:
    test    cl, cl
    jz      short loc_4179C8
    movzx   esi, byte ptr [r14+rdx]
    mov     edi, ecx
    not     edi
    and     edi, esi
    movzx   esi, byte ptr [r10+rdx]
    and     esi, ecx
    or      esi, edi
    jmp     short loc_4179C4
loc_4179C0:
    mov     sil, [r10+rdx]
loc_4179C4:
    mov     [r14+rdx], sil
loc_4179C8:
    sub     r13d, eax
    jbe     loc_41764A
    rol     ecx, 18h
    add     rdx, 1
    cmp     cl, 0FFh
    jnz     short loc_4179A0
    jmp     short loc_4179C0
loc_4179DF:
    shr     r15d, 2
    mov     ebp, ebx
    not     ebp
    add     ebp, r13d
loc_4179EA:
    mov     r8d, ebp
    mov     rax, dp32
    mov     rcx, sp32
    mov     sp_0, rdx
loc_4179F6:
    mov     edi, [sp32]
    add     sp32, 4
    mov     [dp32], edi
    add     dp32, 4
    add     c, 0FFFFFFFFFFFFFFFCh
    jnz     short loc_4179F6
    sub     r13d, ebx
    jbe     loc_417665
    lea     rdi, [dp32+skip*4]
    lea     rsi, [sp32+skip*4]
    mov     ebp, r8d
    sub     ebp, ebx
    cmp     r12d, r13d
    jbe     short loc_4179EA
    lea     edx, [row_width-1]
    lea     r11, [rdx+1]
    cmp     r11, 20h ; ' '
    jb      loc_417CD2
    lea     rbp, [sp32+rdx]
    add     rbp, 1
    cmp     rbp, dp32
    jbe     short loc_417A52
    add     rdx, dp32
    add     rdx, 1
    cmp     rdx, sp32
    ja      loc_417CD2
loc_417A52:
    mov     r9, r11
    and     r9, 0FFFFFFFFFFFFFFE0h
    lea     rdx, [r9-20h]
    mov     r10, rdx
    shr     r10, 5
    add     r10, 1
    cmp     rdx, 60h ; '`'
    jnb     loc_417BF0
    xor     edx, edx
    test    r10b, 3
    jnz     loc_417C7F
    jmp     loc_417CC0
loc_417A83:
    lea     bytes_to_jump, [skip+skip]
    add     rbx, 70h ; 'p'
    mov     r14d, r8d
    add     r14, 1
    and     r14, 0FFFFFFFFFFFFFFE0h
    add     r14, 0FFFFFFFFFFFFFFE0h
    shr     r14, 5
    lea     edx, [r14+1]
    movzx   edx, dl
    and     edx, 3
    not     r14
    add     r14, rdx
    xor     edx, edx
loc_417AB0:
    movups  xmm0, xmmword ptr [rcx+rbx-70h]
    movups  xmm1, xmmword ptr [rcx+rbx-60h]
    movups  xmmword ptr [rax+rbx-70h], xmm0
    movups  xmmword ptr [rax+rbx-60h], xmm1
    movups  xmm0, xmmword ptr [rcx+rbx-50h]
    movups  xmm1, xmmword ptr [rcx+rbx-40h]
    movups  xmmword ptr [rax+rbx-50h], xmm0
    movups  xmmword ptr [rax+rbx-40h], xmm1
    movups  xmm0, xmmword ptr [rcx+rbx-30h]
    movups  xmm1, xmmword ptr [rcx+rbx-20h]
    movups  xmmword ptr [rax+rbx-30h], xmm0
    movups  xmmword ptr [rax+rbx-20h], xmm1
    movups  xmm0, xmmword ptr [rcx+rbx-10h]
    movups  xmm1, xmmword ptr [rcx+rbx]
    movups  xmmword ptr [rax+rbx-10h], xmm0
    movups  xmmword ptr [rax+rbx], xmm1
    sub     rdx, 0FFFFFFFFFFFFFF80h
    sub     rbx, 0FFFFFFFFFFFFFF80h
    add     r14, 4
    jnz     short loc_417AB0
    test    r10b, 3
    jz      short loc_417B53
loc_417B12:
    lea     rdx, [rdx+skip*2]
    add     rdx, 10h
    add     r8b, 1
    and     r8b, 60h
    add     r8b, 0E0h
    shr     r8b, 5
    add     r8b, 1
    movzx   ebp, r8b
    and     ebp, 3
    neg     rbp
loc_417B38:
    movups  xmm0, xmmword ptr [rcx+rdx-10h]
    movups  xmm1, xmmword ptr [rcx+rdx]
    movups  xmmword ptr [rax+rdx-10h], xmm0
    movups  xmmword ptr [rax+rdx], xmm1
    add     rdx, 20h ; ' '
    inc     rbp
    jnz     short loc_417B38
loc_417B53:
    cmp     r11, r9
    jz      loc_417665
    sub     r13d, r9d
    add     sp16, r9
    add     dp16, r9
loc_417B65:
    lea     eax, [r13-1]
    test    r13b, 7
    jz      short loc_417B8F
    mov     edx, r13d
    and     edx, 7
    xor     ecx, ecx
loc_417B77:
    movzx   ebx, byte ptr [rsi+rcx]
    mov     [rdi+rcx], bl
    add     rcx, 1
    cmp     edx, ecx
    jnz     short loc_417B77
    sub     r13d, ecx
    add     rsi, rcx
    add     rdi, rcx
loc_417B8F:
    cmp     eax, 7
    jb      loc_417665
    mov     eax, r13d
    xor     ecx, ecx
loc_417B9D:
    movzx   edx, byte ptr [rsi+rcx]
    mov     [rdi+rcx], dl
    movzx   edx, byte ptr [rsi+rcx+1]
    mov     [rdi+rcx+1], dl
    movzx   edx, byte ptr [rsi+rcx+2]
    mov     [rdi+rcx+2], dl
    movzx   edx, byte ptr [rsi+rcx+3]
    mov     [rdi+rcx+3], dl
    movzx   edx, byte ptr [rsi+rcx+4]
    mov     [rdi+rcx+4], dl
    movzx   edx, byte ptr [rsi+rcx+5]
    mov     [rdi+rcx+5], dl
    movzx   edx, byte ptr [rsi+rcx+6]
    mov     [rdi+rcx+6], dl
    movzx   edx, byte ptr [rsi+rcx+7]
    mov     [rdi+rcx+7], dl
    add     rcx, 8
    cmp     eax, ecx
    jnz     short loc_417B9D
    jmp     loc_417665
loc_417BF0:
    lea     bytes_to_jump, ds:70h[skip*4]
    mov     r14d, r8d
    add     r14, 1
    and     r14, 0FFFFFFFFFFFFFFE0h
    add     r14, 0FFFFFFFFFFFFFFE0h
    shr     r14, 5
    lea     edx, [r14+1]
    movzx   edx, dl
    and     edx, 3
    not     r14
    add     r14, rdx
    xor     edx, edx
loc_417C1D:
    movups  xmm0, xmmword ptr [rcx+rbx-70h]
    movups  xmm1, xmmword ptr [rcx+rbx-60h]
    movups  xmmword ptr [rax+rbx-70h], xmm0
    movups  xmmword ptr [rax+rbx-60h], xmm1
    movups  xmm0, xmmword ptr [rcx+rbx-50h]
    movups  xmm1, xmmword ptr [rcx+rbx-40h]
    movups  xmmword ptr [rax+rbx-50h], xmm0
    movups  xmmword ptr [rax+rbx-40h], xmm1
    movups  xmm0, xmmword ptr [rcx+rbx-30h]
    movups  xmm1, xmmword ptr [rcx+rbx-20h]
    movups  xmmword ptr [rax+rbx-30h], xmm0
    movups  xmmword ptr [rax+rbx-20h], xmm1
    movups  xmm0, xmmword ptr [rcx+rbx-10h]
    movups  xmm1, xmmword ptr [rcx+rbx]
    movups  xmmword ptr [rax+rbx-10h], xmm0
    movups  xmmword ptr [rax+rbx], xmm1
    sub     rdx, 0FFFFFFFFFFFFFF80h
    sub     rbx, 0FFFFFFFFFFFFFF80h
    add     r14, 4
    jnz     short loc_417C1D
    test    r10b, 3
    jz      short loc_417CC0
loc_417C7F:
    lea     rdx, [rdx+skip*4]
    add     rdx, 10h
    add     r8b, 1
    and     r8b, 60h
    add     r8b, 0E0h
    shr     r8b, 5
    add     r8b, 1
    movzx   ebp, r8b
    and     ebp, 3
    neg     rbp
loc_417CA5:
    movups  xmm0, xmmword ptr [rcx+rdx-10h]
    movups  xmm1, xmmword ptr [rcx+rdx]
    movups  xmmword ptr [rax+rdx-10h], xmm0
    movups  xmmword ptr [rax+rdx], xmm1
    add     rdx, 20h ; ' '
    inc     rbp
    jnz     short loc_417CA5
loc_417CC0:
    cmp     r11, r9
    jz      loc_417665
    sub     r13d, r9d
    add     sp32, r9
    add     dp32, r9
loc_417CD2:
    lea     eax, [r13-1]
    test    r13b, 7
    jz      short loc_417CFC
    mov     edx, r13d
    and     edx, 7
    xor     ecx, ecx
loc_417CE4:
    movzx   ebx, byte ptr [rsi+rcx]
    mov     [rdi+rcx], bl
    add     rcx, 1
    cmp     edx, ecx
    jnz     short loc_417CE4
    sub     r13d, ecx
    add     rsi, rcx
    add     rdi, rcx; png_ptr
loc_417CFC:
    cmp     eax, 7
    jb      loc_417665
    mov     eax, r13d
    xor     ecx, ecx
loc_417D0A:
    movzx   edx, byte ptr [rsi+rcx]
    mov     [rdi+rcx], dl
    movzx   edx, byte ptr [rsi+rcx+1]
    mov     [rdi+rcx+1], dl
    movzx   edx, byte ptr [rsi+rcx+2]
    mov     [rdi+rcx+2], dl
    movzx   edx, byte ptr [rsi+rcx+3]
    mov     [rdi+rcx+3], dl
    movzx   edx, byte ptr [rsi+rcx+4]
    mov     [rdi+rcx+4], dl
    movzx   edx, byte ptr [rsi+rcx+5]
    mov     [rdi+rcx+5], dl
    movzx   edx, byte ptr [rsi+rcx+6]
    mov     [rdi+rcx+6], dl
    movzx   edx, byte ptr [rsi+rcx+7]
    mov     [rdi+rcx+7], dl
    add     rcx, 8
    cmp     eax, ecx
    jnz     short loc_417D0A
    jmp     loc_417665
loc_417D5D:
    mov     esi, offset aInternalRowLog; "internal row logic error"
    call    MAGMA_png_error
loc_417D67:
    mov     esi, offset aInternalRowWid; "internal row width error"
    call    MAGMA_png_error
loc_417D71:
    mov     esi, offset aInternalRowSiz; "internal row size calculation error"
    call    MAGMA_png_error
loc_417D7B:
    mov     esi, offset aInvalidUserTra; "invalid user transform pixel depth"
    call    MAGMA_png_error
MAGMA_png_combine_row endp

