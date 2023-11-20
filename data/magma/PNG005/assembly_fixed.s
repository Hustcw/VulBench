MAGMA_png_check_IHDR proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     r12d, r8d
    mov     r13d, ecx
    mov     ebx, [rsp+48h+arg_8]
    mov     ebp, [rsp+48h+arg_0]
    or      r8d, 4
    cmp     ecx, 9
    jl      short loc_40582F
    cmp     r12d, 3
    jz      loc_4058F3
loc_40582F:
    mov     [rsp+48h+var_3C], r9d
    cmp     r12d, 6
    setnbe  al
    cmp     r8d, 5
    setz    bl
    or      bl, al
    lea     eax, [bit_depth-1]
    cmp     eax, 1
    mov     ebp, r8d
    setnbe  r8b
    cmp     r13d, 4
    setnz   cl
    cmp     r13d, 8
    setnz   al
    and     al, cl
    cmp     r13d, 10h
    setnz   r14b
    and     r14b, al
    and     r14b, r8b
    cmp     [png_ptr+3A8h], edx
    setb    r15b
    test    edx, edx
    setle   [rsp+48h+var_3D]
    mov     [rsp+48h+var_38], png_ptr
    cmp     [rdi+3A4h], esi
    setb    [rsp+48h+var_3E]
    test    esi, esi
    setle   [rsp+48h+var_3F]
    add     esi, 7
    and     esi, 0FFFFFFF8h; b
    mov     rdi, rsi; a
    call    png_gt
    mov     r8d, ebp
    test    eax, eax
    setnz   al
    or      al, [rsp+48h+var_3F]
    or      al, [rsp+48h+var_3D]
    or      al, [rsp+48h+var_3E]
    or      r15b, r14b
    or      r15b, al
    or      r15b, bl
    movzx   eax, r15b
    and     eax, 1
    cmp     r12d, 4
    setz    cl
    cmp     ebp, 6
    setz    dl
    cmp     r13d, 7
    jg      short loc_405951
    or      cl, dl
    mov     rdi, [rsp+48h+var_38]; png_ptr
    mov     ebx, [rsp+48h+arg_8]
    mov     r9d, [rsp+48h+var_3C]
    mov     ebp, [rsp+48h+arg_0]
    jz      short loc_4058F8
loc_4058F3:
    mov     eax, 1
loc_4058F8:
    cmp     r9d, 1
    mov     ecx, 1
    cmovg   eax, ecx
    test    ebp, ebp
    cmovnz  eax, ecx
    test    ebx, ebx
    jz      short loc_405943
    cmp     ebx, 40h ; '@'
    jnz     short loc_405947
    mov     ecx, [rdi+360h]
    and     ecx, 4
    jz      short loc_405947
    test    eax, eax
    jnz     short loc_405947
    cmp     r8d, 6
    jnz     short loc_405947
    mov     eax, [rdi+11Ch]
    and     eax, 1000h
    jnz     short loc_405947
loc_405934:
    add     rsp, 18h
    pop     rbx
    pop     color_type
    pop     bit_depth
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_405943:
    test    eax, eax
    jz      short loc_405934
loc_405947:
    mov     esi, offset aInvalidIhdrDat; "Invalid IHDR data"
    call    MAGMA_png_error
loc_405951:
    mov     rdi, [rsp+48h+var_38]
    mov     ebx, [rsp+48h+arg_8]
    mov     r9d, [rsp+48h+var_3C]
    mov     ebp, [rsp+48h+arg_0]
    jmp     short loc_4058F8
MAGMA_png_check_IHDR endp



MAGMA_png_read_start_row proc
    push    r14
    push    rbx
    push    rax
    mov     rbx, png_ptr
    call    MAGMA_png_init_read_transformations
    cmp     byte ptr [png_ptr+1FCh], 0
    jz      short loc_418762
    mov     edi, [png_ptr+124h]
    mov     esi, [png_ptr+1A0h]
    mov     eax, [png_ptr+1A4h]
    lea     ecx, [rax+7]
    shr     ecx, 3
    test    dil, 2
    cmovnz  ecx, eax
    mov     [png_ptr+1A8h], ecx
    movzx   eax, byte ptr [png_ptr+1FDh]
    movzx   ecx, ds:MAGMA_png_read_start_row_png_pass_inc[rax]
    lea     edx, [rsi+rcx]
    movzx   eax, ds:MAGMA_png_read_start_row_png_pass_start[rax]
    not     eax
    add     eax, edx
    xor     edx, edx
    div     ecx
    mov     [png_ptr+1B8h], eax
    jmp     short loc_418780
loc_418762:
    mov     eax, [png_ptr+1A4h]
    mov     [png_ptr+1A8h], eax
    mov     edi, [png_ptr+124h]
    mov     esi, [png_ptr+1A0h]
    mov     [png_ptr+1B8h], esi
loc_418780:
    mov     al, [png_ptr+202h]
    test    dil, 4
    jz      short loc_41879E
    cmp     byte ptr [png_ptr+200h], 8
    movzx   ecx, al
    mov     eax, 8
    cmovnb  eax, ecx
loc_41879E:
    movzx   eax, al
    test    edi, 1000h
    jnz     short loc_4187C7
loc_4187A9:
    test    edi, 200h
    jz      short loc_41880D
loc_4187B1:
    test    edi, 1000h
    jnz     short loc_418801
    and     edi, 0FFFFFDFFh
    mov     [png_ptr+124h], edi
    jmp     short loc_41880D
loc_4187C7:
    mov     cl, [png_ptr+1FFh]
    test    cl, cl
    jz      loc_418A1C
    cmp     cl, 2
    jz      loc_4189F4
    cmp     cl, 3
    jnz     short loc_4187A9
    xor     eax, eax
    cmp     word ptr [png_ptr+1F8h], 0
    setnz   al
    lea     eax, ds:18h[rax*8]
    test    edi, 200h
    jnz     short loc_4187B1
    jmp     short loc_41880D
loc_418801:
    cmp     byte ptr [png_ptr+200h], 10h
    setb    cl
    shl     eax, cl
loc_41880D:
    mov     ecx, [png_ptr+124h]
    test    cx, cx
    jns     short loc_41884B
    mov     dl, [png_ptr+1FFh]
    lea     edi, [rdx-2]
    cmp     dil, 2
    jnb     short loc_418837
    xor     edx, edx
    cmp     eax, 20h ; ' '
    setnbe  dl
    shl     edx, 5
    add     edx, 20h ; ' '
    jmp     short loc_418849
loc_418837:
    test    dl, dl
    jnz     short loc_41884B
    xor     edx, edx
    cmp     eax, 8
    setnbe  dl
    shl     edx, 4
    add     edx, 10h
loc_418849:
    mov     eax, edx
loc_41884B:
    test    ecx, 4000h
    jz      short loc_41888C
    cmp     word ptr [png_ptr+1F8h], 0
    setnz   dl
    test    cx, cx
    js      short loc_41887C
    mov     edi, ecx
    shr     edi, 0Ch
    and     dil, dl
    jnz     short loc_41887C
    mov     dl, [png_ptr+1FFh]
    cmp     dl, 4
    jnz     loc_418A47
loc_41887C:
    xor     edx, edx
    cmp     eax, 10h
    setnbe  dl
    shl     edx, 5
    add     edx, 20h ; ' '
    mov     eax, edx
loc_41888C:
    test    ecx, 100000h
    jz      short loc_4188AC
loc_418894:
    movzx   ecx, byte ptr [png_ptr+118h]
    movzx   edx, byte ptr [png_ptr+119h]
    imul    edx, ecx
    cmp     edx, eax
    cmovbe  edx, eax
    mov     eax, edx
loc_4188AC:
    mov     [png_ptr+205h], al
    mov     byte ptr [png_ptr+206h], 0
    add     esi, 7
    and     esi, 0FFFFFFF8h
    mov     ecx, eax
    mov     rdx, rcx
    shr     rdx, 3
    imul    rdx, row_bytes
    imul    row_bytes, rcx
    shr     rsi, 3
    cmp     eax, 7
    cmova   rsi, rdx
    add     eax, 7
    shr     eax, 3
    lea     r14, [rax+rsi]
    add     r14, 31h ; '1'
    cmp     r14, [png_ptr+3D8h]
    jbe     loc_41898C
    mov     rsi, [png_ptr+380h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rsi, [png_ptr+3F8h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    cmp     byte ptr [png_ptr+1FCh], 0
    jz      short loc_41892A
    mov     rdi, png_ptr; png_ptr
    mov     rsi, r14; size
    call    MAGMA_png_calloc
    jmp     short loc_418935
loc_41892A:
    mov     rdi, png_ptr; png_ptr
    mov     rsi, r14; size
    call    MAGMA_png_malloc
loc_418935:
    mov     [png_ptr+380h], rax
    mov     rdi, png_ptr; png_ptr
    mov     rsi, r14; size
    call    MAGMA_png_malloc
    mov     [png_ptr+3F8h], rax
    mov     rcx, [png_ptr+380h]
    lea     rdx, [rcx+20h]
    not     edx
    or      rdx, 0FFFFFFFFFFFFFFF0h
    add     rcx, rdx
    add     rcx, 20h ; ' '
    mov     [png_ptr+1D0h], rcx
    lea     rcx, [rax+20h]
    not     ecx
    or      rcx, 0FFFFFFFFFFFFFFF0h
    add     rax, rcx
    add     rax, 20h ; ' '
    mov     [png_ptr+1C8h], rax
    mov     [png_ptr+3D8h], r14
loc_41898C:
    mov     rdx, [png_ptr+1B0h]
    cmp     rdx, 0FFFFFFFFFFFFFFFFh
    jz      loc_418A8B
    mov     rdi, [png_ptr+1C8h]; s
    add     rdx, 1; n
    xor     esi, esi; c
    call    _memset
    mov     rsi, [png_ptr+3E0h]; ptr
    test    buffer, buffer
    jz      short loc_4189D0
    lea     rax, [png_ptr+3E0h]
    xorps   xmm0, xmm0
    movups  xmmword ptr [rax], xmm0
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
loc_4189D0:
    mov     rdi, png_ptr; png_ptr
    mov     esi, 49444154h; owner
    call    png_inflate_claim
    test    eax, eax
    jnz     loc_418A98
    or      byte ptr [png_ptr+120h], 40h
    add     rsp, 8
    pop     png_ptr
    pop     r14
    retn
loc_4189F4:
    cmp     word ptr [png_ptr+1F8h], 0
    jz      loc_4187A9
    imul    eax, 2AAACh
    shr     eax, 11h
    test    edi, 200h
    jnz     loc_4187B1
    jmp     loc_41880D
loc_418A1C:
    cmp     eax, 8
    mov     edx, 8
    cmova   edx, eax
    cmp     word ptr [png_ptr+1F8h], 0
    setnz   cl
    shl     edx, cl
    mov     eax, edx
    test    edi, 200h
    jnz     loc_4187B1
    jmp     loc_41880D
loc_418A47:
    cmp     eax, 8
    ja      short loc_418A6C
    xor     eax, eax
    cmp     dl, 6
    setz    al
    lea     eax, ds:18h[rax*8]
    test    ecx, 100000h
    jnz     loc_418894
    jmp     loc_4188AC
loc_418A6C:
    xor     eax, eax
    cmp     dl, 6
    setz    al
    shl     eax, 4
    add     eax, 30h ; '0'
    test    ecx, 100000h
    jnz     loc_418894
    jmp     loc_4188AC
loc_418A8B:
    mov     esi, offset aRowHasTooManyB; "Row has too many bytes to allocate in m"...
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_error
loc_418A98:
    mov     rsi, [png_ptr+160h]; error_message
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_error
MAGMA_png_read_start_row endp

