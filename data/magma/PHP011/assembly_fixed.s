exif_offset_info_try_get proc
    mov     rcx, [info]
    mov     rax, rcx
    not     rax
    cmp     rax, offset
    jb      short loc_496892
    add     rcx, offset
    mov     rax, start
    not     rax
    cmp     rax, length
    jb      short loc_496892
    cmp     start, [info+8]
    jnb     short loc_496895
loc_496892:
    xor     eax, eax
    retn
loc_496895:
    add     length, start
    xor     eax, eax
    cmp     end, [info+10h]
    cmovbe  rax, start
    retn
exif_offset_info_try_get endp



exif_thumbnail_extract proc
    push    r14
    push    rbx
    push    rax
    mov     rbx, ImageInfo
    cmp     qword ptr [rdi+110h], 0
    jz      short loc_4968D1
    lea     rdi, aExifReadDataEr_1; "exif_read_data#error_mult_thumb"
    lea     rcx, aMultiplePossib; "Multiple possible thumbnails"
    jmp     short loc_496936
loc_4968D1:
    cmp     dword ptr [ImageInfo+200h], 0
    jz      short loc_49694C
    mov     r14, [ImageInfo+100h]
    lea     rax, [r14-1]
    cmp     rax, 0FFFEh
    ja      short loc_49692D
    mov     rax, [ImageInfo+108h]
    test    rax, rax
    jz      short loc_49692D
    mov     rdi, info; info
    mov     info, rax; offset
    mov     rdx, r14; length
    call    exif_offset_info_try_get
    test    thumbnail, thumbnail
    jz      short loc_496954
    mov     rdi, thumbnail; s
    mov     rsi, r14; length
    call    _estrndup
    mov     [ImageInfo+110h], rax
    mov     rdi, ImageInfo; ImageInfo
    add     rsp, 8
    pop     ImageInfo
    pop     r14
    jmp     exif_thumbnail_build
loc_49692D:
    lea     rcx, aIllegalThumbna; "Illegal thumbnail size/offset"
    xor     edi, edi
loc_496936:
    mov     info, ImageInfo
    mov     edx, 2
    xor     eax, eax
    add     rsp, 8
    pop     ImageInfo
    pop     r14
    jmp     exif_error_docref
loc_49694C:
    add     rsp, 8
    pop     ImageInfo
    pop     r14
    retn
loc_496954:
    lea     rcx, aXPhpOriginatin+22h; "%s"
    lea     r8, aThumbnailGoesI; "Thumbnail goes IFD boundary or end of f"...
    xor     edi, edi
    mov     rsi, ImageInfo
    mov     edx, 2
    xor     eax, eax
    add     rsp, 8
    pop     ImageInfo
    pop     r14
    jmp     exif_error_docref
exif_thumbnail_extract endp

