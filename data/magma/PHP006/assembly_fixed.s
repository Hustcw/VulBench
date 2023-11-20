exif_scan_thumbnail proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 38h
    mov     r13, [ImageInfo+110h]
    test    data, data
    jz      loc_494EBE
    mov     rsi, ImageInfo; ImageInfo
    mov     rbx, [rdi+100h]
    cmp     rbx, 4
    jb      loc_494EBE
    movzx   eax, word ptr [data+0]
    xor     eax, 0D8FFh
    movzx   ecx, byte ptr [data+2]
    xor     ecx, 0FFh
    or      cx, ax
    jz      short loc_494DC5
    cmp     qword ptr [ImageInfo+0F0h], 0
    jnz     loc_494EBE
    cmp     qword ptr [ImageInfo+0F8h], 0
    jnz     loc_494EBE
    lea     rcx, aThumbnailIsNot; "Thumbnail is not a JPEG image"
    xor     r12d, r12d
    xor     edi, edi; docref
loc_494DB4:
    mov     edx, 2; type
    xor     eax, eax
    call    exif_error_docref
    jmp     loc_494EC1
loc_494DC5:
    mov     [rsp+68h+var_68], ImageInfo
    mov     ecx, 2
    xor     edi, edi
loc_494DD0:
    mov     rbp, length
    add     length, pos
    cmp     pos, rbx
    jnb     loc_494EBE
    lea     rax, [pos+1]
    cmp     pos, rbx
    jnb     loc_494EBE
    cmp     byte ptr [data+rbp+0], 0FFh
    jnz     loc_494EBE
    mov     pos, data
    add     rax, rbp
    xor     r15d, r15d
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+rax+00h]
loc_494E10:
    movzx   r14d, byte ptr [rax+r15+1]
    cmp     r15d, 8
    jz      short loc_494E38
    cmp     r14b, 0FFh
    jnz     short loc_494E38
    lea     rcx, [r15+rbp]
    add     rcx, 5
    add     r15, 1
    cmp     rcx, rbx
    jb      short loc_494E10
    jmp     loc_494EBE
loc_494E38:
    lea     rcx, [r15+rbp]
    add     rcx, 2
    xor     r12d, r12d
    cmp     rcx, rbx
    jnb     short loc_494EC1
    cmp     r14b, 0FFh
    jz      short loc_494EC1
    mov     [rsp+68h+var_58], rcx
    lea     rdi, [r15+rax]
    add     rdi, 2; value
    mov     [rsp+68h+var_60], rdi
    call    php_jpg_get16
    movsxd  rcx, eax
    xor     r12d, r12d
    mov     rdx, rbx
    sub     rdx, length
    jb      short loc_494EC1
    mov     rdi, [rsp+68h+var_58]
    cmp     rdi, rdx
    jnb     short loc_494EC1
    add     r14b, 40h ; '@'
    cmp     r14b, 1Ah
    ja      loc_494DD0
    movzx   edx, r14b; result
    mov     esi, 0EEEFh
    bt      rsi, rdx
    jb      short loc_494ED3
    mov     eax, 6000000h
    bt      rax, rdx
    jnb     loc_494DD0
    lea     length, aCouldNotComput; "Could not compute size of thumbnail"
    xor     r12d, r12d
    xor     edi, edi
    mov     rsi, [rsp+68h+var_68]
    jmp     loc_494DB4
loc_494EBE:
    xor     r12d, r12d
loc_494EC1:
    mov     eax, r12d
    add     rsp, 38h
    pop     rbx
    pop     r12
    pop     data
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_494ED3:
    add     rbx, 0FFFFFFFFFFFFFFF8h
    lea     length, [r15+rbp]
    add     rcx, 2
    xor     r12d, r12d
    cmp     rbx, rcx
    jb      short loc_494EC1
    cmp     eax, 8
    jb      short loc_494EC1
    lea     rsi, [rsp+68h+var_50]; marker
    mov     rdi, [rsp+68h+var_60]; Data
    call    exif_process_SOFn
    movups  xmm0, [rsp+68h+var_48]
    mov     rax, [rsp+68h+var_68]
    movups  xmmword ptr [sof_info+0F0h], xmm0
    mov     r12b, 1
    jmp     short loc_494EC1
exif_scan_thumbnail endp

