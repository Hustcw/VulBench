exif_scan_thumbnail proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 28h
    mov     r12, [ImageInfo+110h]
    test    data, data
    jz      loc_494EB6
    mov     r15, ImageInfo
    movzx   eax, word ptr [data]
    xor     eax, 0D8FFh
    movzx   ecx, byte ptr [data+2]
    xor     ecx, 0FFh
    or      cx, ax
    jz      short loc_494DB5
    cmp     qword ptr [ImageInfo+0F0h], 0
    jnz     loc_494EB6
    cmp     qword ptr [ImageInfo+0F8h], 0
    jnz     loc_494EB6
    lea     rcx, aThumbnailIsNot; "Thumbnail is not a JPEG image"
loc_494D9F:
    xor     edi, edi; docref
    mov     rsi, ImageInfo; ImageInfo
    mov     edx, 2; type
    xor     eax, eax
    call    exif_error_docref
    jmp     loc_494EB6
loc_494DB5:
    mov     rbx, [ImageInfo+100h]
    mov     eax, 2
    xor     ecx, ecx
loc_494DC3:
    mov     rbp, length
    add     length, pos
    cmp     pos, rbx
    jnb     loc_494EB6
    lea     rax, [pos+1]
    cmp     pos, rbx
    jnb     loc_494EB6
    cmp     byte ptr [data+rbp], 0FFh
    jnz     loc_494EB6
    lea     pos, [data+rbp]
    xor     r13d, r13d
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+rax+00h]
loc_494E00:
    movzx   r14d, byte ptr [rax+r13+1]
    cmp     r13d, 8
    jz      short loc_494E2B
    cmp     r14b, 0FFh
    jnz     short loc_494E2B
    lea     rcx, ds:5[r13]
    add     rcx, rbp
    add     r13, 1
    cmp     rcx, rbx
    jb      short loc_494E00
    jmp     loc_494EB6
loc_494E2B:
    cmp     r14b, 0FFh
    jz      loc_494EB6
    lea     rdi, [rax+r13]
    add     rdi, 2; value
    mov     [rsp+58h+var_58], rdi
    call    php_jpg_get16
    cdqe
    lea     rcx, [length+rbp]
    add     rcx, r13
    add     rcx, 2
    cmp     rcx, rbx
    jnb     short loc_494EB6
    lea     rcx, ds:2[r13]
    add     rcx, rbp
    add     r14b, 40h ; '@'
    cmp     r14b, 1Ah
    ja      loc_494DC3
    movzx   edx, r14b; result
    mov     esi, 0EEEFh
    bt      rsi, rdx
    jb      short loc_494E9B
    mov     esi, 6000000h
    bt      rsi, rdx
    jnb     loc_494DC3
    lea     rcx, aCouldNotComput; "Could not compute size of thumbnail"
    jmp     loc_494D9F
loc_494E9B:
    lea     rsi, [rsp+58h+var_50]; marker
    mov     rdi, [rsp+58h+var_58]; Data
    call    exif_process_SOFn
    movups  xmm0, [rsp+58h+var_48]
    movups  xmmword ptr [ImageInfo+0F0h], xmm0
loc_494EB6:
    add     rsp, 28h
    pop     rbx
    pop     data
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
exif_scan_thumbnail endp

