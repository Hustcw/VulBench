exif_offset_info_try_get proc
    add     length, offset
    mov     rcx, [info+10h]
    sub     rcx, [info+8]
    cmp     rdx, rcx
    jbe     short loc_496833
    xor     eax, eax
    retn
loc_496833:
    mov     rax, offset
    add     offset, [info]
    retn
exif_offset_info_try_get endp



exif_thumbnail_extract proc
    push    r14
    push    rbx
    push    rax
    mov     rbx, ImageInfo
    cmp     qword ptr [rdi+110h], 0
    jz      short loc_496861
    lea     rdi, aExifReadDataEr_1; "exif_read_data#error_mult_thumb"
    lea     rcx, aMultiplePossib; "Multiple possible thumbnails"
    jmp     short loc_4968C6
loc_496861:
    cmp     dword ptr [ImageInfo+200h], 0
    jz      short loc_4968DC
    mov     r14, [ImageInfo+100h]
    lea     rax, [r14-1]
    cmp     rax, 0FFFEh
    ja      short loc_4968BD
    mov     rax, [ImageInfo+108h]
    test    rax, rax
    jz      short loc_4968BD
    mov     rdi, info; info
    mov     info, rax; offset
    mov     rdx, r14; length
    call    exif_offset_info_try_get
    test    thumbnail, thumbnail
    jz      short loc_4968E4
    mov     rdi, thumbnail; s
    mov     rsi, r14; length
    call    _estrndup
    mov     [ImageInfo+110h], rax
    mov     rdi, ImageInfo; ImageInfo
    add     rsp, 8
    pop     ImageInfo
    pop     r14
    jmp     exif_thumbnail_build
loc_4968BD:
    lea     rcx, aIllegalThumbna; "Illegal thumbnail size/offset"
    xor     edi, edi
loc_4968C6:
    mov     info, ImageInfo
    mov     edx, 2
    xor     eax, eax
    add     rsp, 8
    pop     ImageInfo
    pop     r14
    jmp     exif_error_docref
loc_4968DC:
    add     rsp, 8
    pop     ImageInfo
    pop     r14
    retn
loc_4968E4:
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

