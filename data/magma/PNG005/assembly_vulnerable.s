MAGMA_png_check_IHDR proc
    push    rbx
    test    esi, esi
    setle   r10b
    cmp     [png_ptr+3A4h], esi
    setb    al
    test    edx, edx
    setle   r11b
    cmp     [png_ptr+3A8h], edx
    setb    dl
    cmp     ecx, 10h
    ja      loc_4058D7
    mov     esi, 10116h
    bt      esi, ecx
    jnb     loc_4058D7
    or      r10b, r11b
    or      al, r10b
    or      dl, al
    movzx   eax, dl
loc_405841:
    mov     ebx, [rsp+8+arg_8]
    mov     r10d, [rsp+8+arg_0]
    mov     edx, r8d
    or      edx, 4
    cmp     ecx, 9
    jl      short loc_40585B
    cmp     r8d, 3
    jz      short loc_405886
loc_40585B:
    cmp     edx, 5
    mov     esi, 1
    cmovz   eax, esi
    cmp     r8d, 6
    cmova   eax, esi
    cmp     r8d, 4
    setz    r8b
    cmp     edx, 6
    setz    r11b
    cmp     ecx, 7
    jg      short loc_40588B
    or      r8b, r11b
    jz      short loc_40588B
loc_405886:
    mov     eax, 1
loc_40588B:
    cmp     r9d, 1
    mov     ecx, 1
    cmovg   eax, ecx
    test    r10d, r10d
    cmovnz  eax, ecx
    test    ebx, ebx
    jz      short loc_4058C9
    cmp     ebx, 40h ; '@'
    jnz     short loc_4058CD
    mov     ecx, [png_ptr+360h]
    and     ecx, 4
    jz      short loc_4058CD
    test    eax, eax
    jnz     short loc_4058CD
    cmp     edx, 6
    jnz     short loc_4058CD
    mov     eax, [png_ptr+11Ch]
    and     eax, 1000h
    jnz     short loc_4058CD
loc_4058C7:
    pop     rbx
    retn
loc_4058C9:
    test    eax, eax
    jz      short loc_4058C7
loc_4058CD:
    mov     esi, offset aInvalidIhdrDat; "Invalid IHDR data"
    call    MAGMA_png_error
loc_4058D7:
    mov     eax, 1
    jmp     loc_405841
MAGMA_png_check_IHDR endp



MAGMA_png_read_start_row proc
    push    r14
    push    rbx
    push    rax
    mov     rbx, png_ptr
    call    MAGMA_png_init_read_transformations
    cmp     byte ptr [png_ptr+1FCh], 0
    jz      short loc_418672
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
    jmp     short loc_418690
loc_418672:
    mov     eax, [png_ptr+1A4h]
    mov     [png_ptr+1A8h], eax
    mov     edi, [png_ptr+124h]
    mov     esi, [png_ptr+1A0h]
    mov     [png_ptr+1B8h], esi
loc_418690:
    mov     al, [png_ptr+202h]
    test    dil, 4
    jz      short loc_4186AE
    cmp     byte ptr [png_ptr+200h], 8
    movzx   ecx, al
    mov     eax, 8
    cmovnb  eax, ecx
loc_4186AE:
    movzx   eax, al
    test    edi, 1000h
    jnz     short loc_4186D7
loc_4186B9:
    test    edi, 200h
    jz      short loc_41871D
loc_4186C1:
    test    edi, 1000h
    jnz     short loc_418711
    and     edi, 0FFFFFDFFh
    mov     [png_ptr+124h], edi
    jmp     short loc_41871D
loc_4186D7:
    mov     cl, [png_ptr+1FFh]
    test    cl, cl
    jz      loc_41892C
    cmp     cl, 2
    jz      loc_418904
    cmp     cl, 3
    jnz     short loc_4186B9
    xor     eax, eax
    cmp     word ptr [png_ptr+1F8h], 0
    setnz   al
    lea     eax, ds:18h[rax*8]
    test    edi, 200h
    jnz     short loc_4186C1
    jmp     short loc_41871D
loc_418711:
    cmp     byte ptr [png_ptr+200h], 10h
    setb    cl
    shl     eax, cl
loc_41871D:
    mov     ecx, [png_ptr+124h]
    test    cx, cx
    jns     short loc_41875B
    mov     dl, [png_ptr+1FFh]
    lea     edi, [rdx-2]
    cmp     dil, 2
    jnb     short loc_418747
    xor     edx, edx
    cmp     eax, 20h ; ' '
    setnbe  dl
    shl     edx, 5
    add     edx, 20h ; ' '
    jmp     short loc_418759
loc_418747:
    test    dl, dl
    jnz     short loc_41875B
    xor     edx, edx
    cmp     eax, 8
    setnbe  dl
    shl     edx, 4
    add     edx, 10h
loc_418759:
    mov     eax, edx
loc_41875B:
    test    ecx, 4000h
    jz      short loc_41879C
    cmp     word ptr [png_ptr+1F8h], 0
    setnz   dl
    test    cx, cx
    js      short loc_41878C
    mov     edi, ecx
    shr     edi, 0Ch
    and     dil, dl
    jnz     short loc_41878C
    mov     dl, [png_ptr+1FFh]
    cmp     dl, 4
    jnz     loc_418957
loc_41878C:
    xor     edx, edx
    cmp     eax, 10h
    setnbe  dl
    shl     edx, 5
    add     edx, 20h ; ' '
    mov     eax, edx
loc_41879C:
    test    ecx, 100000h
    jz      short loc_4187BC
loc_4187A4:
    movzx   ecx, byte ptr [png_ptr+118h]
    movzx   edx, byte ptr [png_ptr+119h]
    imul    edx, ecx
    cmp     edx, eax
    cmovbe  edx, eax
    mov     eax, edx
loc_4187BC:
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
    jbe     loc_41889C
    mov     rsi, [png_ptr+380h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rsi, [png_ptr+3F8h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    cmp     byte ptr [png_ptr+1FCh], 0
    jz      short loc_41883A
    mov     rdi, png_ptr; png_ptr
    mov     rsi, r14; size
    call    MAGMA_png_calloc
    jmp     short loc_418845
loc_41883A:
    mov     rdi, png_ptr; png_ptr
    mov     rsi, r14; size
    call    MAGMA_png_malloc
loc_418845:
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
loc_41889C:
    mov     rdx, [png_ptr+1B0h]
    cmp     rdx, 0FFFFFFFFFFFFFFFFh
    jz      loc_41899B
    mov     rdi, [png_ptr+1C8h]; s
    add     rdx, 1; n
    xor     esi, esi; c
    call    _memset
    mov     rsi, [png_ptr+3E0h]; ptr
    test    buffer, buffer
    jz      short loc_4188E0
    lea     rax, [png_ptr+3E0h]
    xorps   xmm0, xmm0
    movups  xmmword ptr [rax], xmm0
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
loc_4188E0:
    mov     rdi, png_ptr; png_ptr
    mov     esi, 49444154h; owner
    call    png_inflate_claim
    test    eax, eax
    jnz     loc_4189A8
    or      byte ptr [png_ptr+120h], 40h
    add     rsp, 8
    pop     png_ptr
    pop     r14
    retn
loc_418904:
    cmp     word ptr [png_ptr+1F8h], 0
    jz      loc_4186B9
    imul    eax, 2AAACh
    shr     eax, 11h
    test    edi, 200h
    jnz     loc_4186C1
    jmp     loc_41871D
loc_41892C:
    cmp     eax, 8
    mov     edx, 8
    cmova   edx, eax
    cmp     word ptr [png_ptr+1F8h], 0
    setnz   cl
    shl     edx, cl
    mov     eax, edx
    test    edi, 200h
    jnz     loc_4186C1
    jmp     loc_41871D
loc_418957:
    cmp     eax, 8
    ja      short loc_41897C
    xor     eax, eax
    cmp     dl, 6
    setz    al
    lea     eax, ds:18h[rax*8]
    test    ecx, 100000h
    jnz     loc_4187A4
    jmp     loc_4187BC
loc_41897C:
    xor     eax, eax
    cmp     dl, 6
    setz    al
    shl     eax, 4
    add     eax, 30h ; '0'
    test    ecx, 100000h
    jnz     loc_4187A4
    jmp     loc_4187BC
loc_41899B:
    mov     esi, offset aRowHasTooManyB; "Row has too many bytes to allocate in m"...
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_error
loc_4189A8:
    mov     rsi, [png_ptr+160h]; error_message
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_error
MAGMA_png_read_start_row endp

