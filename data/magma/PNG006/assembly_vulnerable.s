MAGMA_png_free_data proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    test    png_ptr, png_ptr
    jz      loc_4043CB
    mov     r13, info_ptr
    test    rsi, rsi
    jz      loc_4043CB
    mov     r14d, ecx
    mov     r15d, edx
    mov     r12, png_ptr
    mov     rsi, [info_ptr+0A0h]
    test    rsi, rsi
    jz      loc_403FA5
    mov     eax, [info_ptr+12Ch]
    and     eax, r15d
    test    eax, 4000h
    jz      loc_403FA5
    cmp     r14d, 0FFFFFFFFh
    jz      short loc_403F4A
    movsxd  rax, r14d
    imul    rbx, rax, 38h ; '8'
    mov     rsi, [rsi+rbx+8]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rax, [info_ptr+0A0h]
    mov     qword ptr [rax+rbx+8], 0
    jmp     short loc_403FA5
loc_403F4A:
    cmp     dword ptr [info_ptr+94h], 0
    jle     short loc_403F87
    mov     ebx, 8
    xor     ebp, ebp
    nop     dword ptr [rax+rax+00h]
loc_403F60:
    mov     rsi, [rsi+rbx]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    add     i, 1
    movsxd  rax, dword ptr [info_ptr+94h]
    mov     rsi, [info_ptr+0A0h]; ptr
    add     rbx, 38h ; '8'
    cmp     rbp, rax
    jl      short loc_403F60
loc_403F87:
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+0A0h], 0
    mov     qword ptr [info_ptr+94h], 0
loc_403FA5:
    mov     eax, [info_ptr+12Ch]
    mov     ecx, r15d
    and     ecx, eax
    test    ecx, 2000h
    jz      short loc_403FE6
    and     byte ptr [info_ptr+8], 0EFh
    mov     rsi, [info_ptr+0B8h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+0B8h], 0
    mov     word ptr [info_ptr+22h], 0
    mov     eax, [info_ptr+12Ch]
loc_403FE6:
    mov     ecx, r15d
    and     ecx, eax
    test    ecx, 100h
    jz      short loc_404028
    mov     rsi, [info_ptr+150h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rsi, [info_ptr+158h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    xorps   xmm0, xmm0
    movups  xmmword ptr [info_ptr+150h], xmm0
    and     byte ptr [info_ptr+9], 0BFh
    mov     eax, [info_ptr+12Ch]
loc_404028:
    mov     ecx, r15d
    and     ecx, eax
    test    cl, 80h
    jz      loc_4040D3
    mov     rsi, [info_ptr+108h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rsi, [info_ptr+118h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+108h], 0
    mov     qword ptr [info_ptr+118h], 0
    mov     rsi, [info_ptr+120h]
    test    rsi, rsi
    jz      short loc_4040C7
    cmp     byte ptr [info_ptr+129h], 0
    jz      short loc_4040B4
    xor     ebx, ebx
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+00h]
loc_404090:
    mov     rsi, [rsi+i*8]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    add     i, 1
    movzx   eax, byte ptr [info_ptr+129h]
    mov     rsi, [info_ptr+120h]; ptr
    cmp     rbx, rax
    jb      short loc_404090
loc_4040B4:
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+120h], 0
loc_4040C7:
    and     byte ptr [info_ptr+9], 0FBh
    mov     eax, [info_ptr+12Ch]
loc_4040D3:
    and     eax, r15d
    test    al, 10h
    jz      short loc_404108
    mov     rsi, [info_ptr+80h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rsi, [info_ptr+88h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    xorps   xmm0, xmm0
    movups  xmmword ptr [info_ptr+80h], xmm0
    and     byte ptr [info_ptr+9], 0EFh
loc_404108:
    mov     rsi, [info_ptr+140h]
    test    rsi, rsi
    jz      loc_4041DE
    mov     eax, [info_ptr+12Ch]
    and     eax, r15d
    test    al, 20h
    jz      loc_4041DE
    cmp     r14d, 0FFFFFFFFh
    jz      short loc_404171
    movsxd  rbx, r14d
    shl     rbx, 5
    mov     rsi, [rsi+rbx]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rax, [info_ptr+140h]
    mov     rsi, [rax+rbx+10h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rax, [info_ptr+140h]
    mov     qword ptr [rax+rbx], 0
    mov     qword ptr [rax+rbx+10h], 0
    jmp     short loc_4041DE
loc_404171:
    cmp     dword ptr [info_ptr+148h], 0
    jle     short loc_4041BB
    xor     ebp, ebp
    xor     ebx, ebx
    nop
loc_404180:
    mov     rsi, [rsi+rbp]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rax, [info_ptr+140h]
    mov     rsi, [rax+rbp+10h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    add     i, 1
    movsxd  rax, dword ptr [info_ptr+148h]
    mov     rsi, [info_ptr+140h]; ptr
    add     rbp, 20h ; ' '
    cmp     rbx, rax
    jl      short loc_404180
loc_4041BB:
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+140h], 0
    mov     dword ptr [info_ptr+148h], 0
    and     byte ptr [info_ptr+9], 0DFh
loc_4041DE:
    mov     rsi, [info_ptr+130h]
    test    rsi, rsi
    jz      loc_404285
    mov     eax, [info_ptr+12Ch]
    and     eax, r15d
    test    eax, 200h
    jz      loc_404285
    cmp     r14d, 0FFFFFFFFh
    jz      short loc_40422F
    movsxd  rbx, r14d
    shl     rbx, 5
    mov     rsi, [rsi+rbx+8]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     rax, [info_ptr+130h]
    mov     qword ptr [rax+rbx+8], 0
    jmp     short loc_404285
loc_40422F:
    cmp     dword ptr [info_ptr+138h], 0
    jle     short loc_404267
    mov     ebx, 8
    xor     ebp, ebp
loc_404240:
    mov     rsi, [rsi+rbx]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    add     i, 1
    movsxd  rax, dword ptr [info_ptr+138h]
    mov     rsi, [info_ptr+130h]; ptr
    add     rbx, 20h ; ' '
    cmp     rbp, rax
    jl      short loc_404240
loc_404267:
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+130h], 0
    mov     dword ptr [info_ptr+138h], 0
loc_404285:
    mov     eax, [info_ptr+12Ch]
    mov     ecx, r15d
    and     ecx, eax
    test    ecx, 8000h
    jz      short loc_4042E3
    mov     rsi, [info_ptr+0F8h]; ptr
    test    rsi, rsi
    jz      short loc_4042B8
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+0F8h], 0
loc_4042B8:
    mov     rsi, [info_ptr+0F0h]; ptr
    test    rsi, rsi
    jz      short loc_4042D7
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+0F0h], 0
loc_4042D7:
    and     byte ptr [info_ptr+0Ah], 0FEh
    mov     eax, [info_ptr+12Ch]
loc_4042E3:
    mov     ecx, r15d
    and     ecx, eax
    test    cl, 8
    jz      short loc_404313
    mov     rsi, [info_ptr+100h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+100h], 0
    and     byte ptr [info_ptr+8], 0BFh
    mov     eax, [info_ptr+12Ch]
loc_404313:
    mov     ecx, r15d
    and     ecx, eax
    test    ecx, 1000h
    jz      short loc_404347
    mov     rsi, [info_ptr+18h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+18h], 0
    and     byte ptr [info_ptr+8], 0F7h
    mov     word ptr [info_ptr+20h], 0
    mov     eax, [info_ptr+12Ch]
loc_404347:
    mov     ecx, r15d
    and     ecx, eax
    test    cl, 40h
    jz      short loc_4043AF
    mov     rsi, [info_ptr+160h]
    test    rsi, rsi
    jz      short loc_4043AA
    cmp     dword ptr [info_ptr+4], 0
    jz      short loc_404390
    xor     ebx, ebx
    nop     word ptr [rax+rax+00000000h]
loc_404370:
    mov     rsi, [rsi+row*8]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    add     row, 1
    mov     eax, [info_ptr+4]
    mov     rsi, [info_ptr+160h]; ptr
    cmp     rbx, rax
    jb      short loc_404370
loc_404390:
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+160h], 0
    mov     eax, [info_ptr+12Ch]
loc_4043AA:
    and     byte ptr [info_ptr+9], 7Fh
loc_4043AF:
    mov     ecx, r15d
    and     ecx, 0FFFFBDDFh
    cmp     r14d, 0FFFFFFFFh
    cmovz   ecx, r15d
    not     ecx
    and     ecx, eax
    mov     [info_ptr+12Ch], ecx
loc_4043CB:
    add     rsp, 8
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
MAGMA_png_free_data endp



MAGMA_png_handle_eXIf proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    push    rax
    mov     rbx, png_ptr
    test    byte ptr [rdi+11Ch], 1
    jz      loc_4161BE
    mov     r15d, edx
    cmp     edx, 1
    ja      short loc_416088
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    mov     esi, offset aTooShort; "too short"
    jmp     loc_41614A
loc_416088:
    mov     r14, info_ptr
    test    rsi, rsi
    jz      loc_41613A
    test    byte ptr [info_ptr+0Ah], 1
    jnz     loc_41613A
    mov     r13d, r15d
    mov     rdi, png_ptr; png_ptr
    mov     rsi, r13; size
    call    MAGMA_png_malloc_warn
    mov     [info_ptr+0F8h], rax
    test    rax, rax
    jz      loc_4161AC
    xor     ebp, ebp
    lea     r12, [rsp+38h+var_31]
    jmp     short loc_4160DD
loc_4160D0:
    add     i, 1
    cmp     r13, rbp
    jz      loc_416160
loc_4160DD:
    mov     rdi, png_ptr; png_ptr
    mov     rsi, r12; buf
    mov     edx, 1; length
    call    MAGMA_png_crc_read
    movzx   eax, [rsp+38h+var_31]
    mov     rcx, [info_ptr+0F8h]
    mov     [rcx+i], al
    cmp     i, 1
    jnz     short loc_4160D0
    movzx   eax, [rsp+38h+var_31]
    mov     ecx, eax
    or      cl, 4
    cmp     cl, 4Dh ; 'M'
    jz      short loc_4160D0
    mov     rcx, [info_ptr+0F8h]
    cmp     [rcx], al
    jz      short loc_4160D0
    add     r15d, 0FFFFFFFEh
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    mov     esi, offset aIncorrectByteO; "incorrect byte-order specifier"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_benign_error
    jmp     short loc_416183
loc_41613A:
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    mov     esi, offset message; "duplicate"
loc_41614A:
    mov     rdi, png_ptr
    add     rsp, 8
    pop     png_ptr
    pop     r12
    pop     r13
    pop     r14
    pop     length
    pop     rbp
    jmp     MAGMA_png_chunk_benign_error
loc_416160:
    mov     rdi, png_ptr; png_ptr
    xor     esi, esi; skip
    call    MAGMA_png_crc_finish
    test    eax, eax
    jnz     short loc_416183
    mov     rcx, [info_ptr+0F8h]; eXIf_buf
    mov     rdi, png_ptr; png_ptr
    mov     rsi, info_ptr; info_ptr
    mov     edx, r15d; num_exif
    call    MAGMA_png_set_eXIf_1
loc_416183:
    mov     rsi, [info_ptr+0F8h]; ptr
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_free
    mov     qword ptr [info_ptr+0F8h], 0
    add     rsp, 8
    pop     png_ptr
    pop     r12
    pop     r13
    pop     info_ptr
    pop     r15
    pop     rbp
    retn
loc_4161AC:
    mov     rdi, png_ptr; png_ptr
    mov     esi, r15d; skip
    call    MAGMA_png_crc_finish
    mov     esi, 421813h
    jmp     short loc_41614A
loc_4161BE:
    mov     esi, offset aMissingIhdr; "missing IHDR"
    mov     rdi, png_ptr; png_ptr
    call    MAGMA_png_chunk_error
MAGMA_png_handle_eXIf endp

