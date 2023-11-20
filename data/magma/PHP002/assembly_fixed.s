exif_process_IFD_in_TIFF_impl proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 78h
    mov     r15d, edx
    mov     rbp, dir_offset
    mov     rbx, ImageInfo
    mov     edi, edx; section
    call    exif_get_tag_table
    mov     [rsp+0A8h+var_5C+4], rax
    mov     r8, [ImageInfo+18h]
    mov     rax, r8
    sub     rax, 2
    jb      loc_49862B
    cmp     rax, dir_offset
    jb      loc_49862B
    mov     edx, 2; size
    mov     rdi, ImageInfo; ImageInfo
    mov     esi, 123h; type
    call    exif_file_sections_add
    mov     r14d, eax
    mov     rdi, [ImageInfo]; stream
    mov     rsi, dir_offset; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     rdi, [ImageInfo]; stream
    mov     rax, [ImageInfo+220h]
    mov     [rsp+0A8h+var_7C], r14d
    movsxd  rcx, r14d
    mov     [rsp+0A8h+var_50], rcx
    lea     rcx, ds:0[rcx*8]
    lea     r12, [rcx+rcx*2]
    mov     rsi, [rax+r12+10h]; buf
    mov     edx, 2; size
    call    _php_stream_read
    mov     rax, [ImageInfo+220h]
    mov     rdi, [rax+r12+10h]; value
    mov     esi, [ImageInfo+70h]; motorola_intel
    call    php_ifd_get16u
    mov     [rsp+0A8h+var_90], eax
    cdqe
    shl     rax, 2
    lea     r14, [rax+rax*2]
    or      r14, 2
    lea     rax, [r14+4]
    mov     [rsp+0A8h+var_98], ImageInfo
    mov     r8, [rbx+18h]
    mov     rbx, ifd_size
    mov     rax, r8
    sub     rax, ifd_size
    jb      short loc_498648
    cmp     rax, dir_offset
    jb      short loc_498648
    mov     [rsp+0A8h+var_8C], r15d
    mov     [rsp+0A8h+var_78], dir_offset
    mov     r15, [rsp+0A8h+var_98]
    mov     rdi, r15; ImageInfo
    mov     esi, [rsp+0A8h+var_7C]; section_index
    mov     rdx, ifd_size; size
    call    exif_file_sections_realloc
    test    eax, eax
    jz      short loc_49867D
loc_498626:
    xor     r15d, r15d
    jmp     short loc_49866B
loc_49862B:
    add     dir_offset, 2
    lea     rcx, aErrorInTiffFil; "Error in TIFF: filesize(x%04X) less tha"...
    xor     r15d, r15d
    xor     edi, edi
    mov     rsi, ImageInfo
    mov     edx, 2
    mov     r9, rbp
    jmp     short loc_498664
loc_498648:
    add     ifd_size, dir_offset
    lea     rcx, aErrorInTiffFil_0; "Error in TIFF: filesize(x%04X) less tha"...
    xor     r15d, r15d
    xor     edi, edi; docref
    mov     rsi, [rsp+0A8h+var_98]; ImageInfo
    mov     edx, 2; type
    mov     r9, rbx
loc_498664:
    xor     eax, eax
    call    exif_error_docref
loc_49866B:
    mov     eax, r15d
    add     rsp, 78h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_49867D:
    mov     rdi, [r15]; stream
    mov     rax, [r15+220h]
    mov     rsi, [rax+r12+10h]
    add     rsi, 2; buf
    lea     rdx, [r14+2]; size
    call    _php_stream_read
    mov     r13, ifd_size
    mov     ifd_size, [r15+220h]
    mov     rbp, [rbx+r12+10h]
    add     r14, rbp
    mov     r15d, [r15+70h]
    mov     rdi, r14; void_value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32u
    mov     dword ptr [rsp+0A8h+var_5C], eax
    mov     [rsp+0A8h+var_70], dir_size
    mov     r14, r13
    cmp     [rsp+0A8h+var_90], 0
    jle     loc_498923
    mov     eax, [rsp+0A8h+var_90]
    add     rax, 0FFFFFFFFFFFFFFFFh
    mov     [rsp+0A8h+var_A0], rax
    xor     r14d, r14d
    xor     eax, eax
    mov     [rsp+0A8h+var_68], rax
    mov     rax, [rsp+0A8h+var_70]
    mov     [rsp+0A8h+valid_length], rax
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+00h]
loc_498700:
    mov     ebx, r14d
    and     ebx, 0FFFFFFFCh
    lea     r12, [rbx+rbp]
    add     r12, 2
    mov     rdi, dir_entry; value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get16u
    mov     r13d, eax
    lea     rdi, [rbx+rbp]
    add     rdi, 4; value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get16u
    mov     ebx, eax
    cmp     eax, 0Eh
    jl      short loc_498780
    mov     edi, r13d; tag_num
    mov     rsi, [rsp+0A8h+var_5C+4]; tag_table
    call    exif_get_tagname_debug
    mov     dword ptr [rsp+0A8h+var_A8], ebx
    xor     edi, edi; docref
    mov     rbp, [rsp+0A8h+var_98]
    mov     rsi, rbp; ImageInfo
    mov     edx, 8; type
    lea     rcx, aReadFromTiffTa; "Read from TIFF: tag(0x%04X,%12s): Illeg"...
    mov     r8d, r13d
    mov     r9, rax
    xor     eax, eax
    call    exif_error_docref
    mov     r15d, [rbp+70h]
    mov     ebx, 1
    jmp     short loc_498785
loc_498780:
    mov     rbp, [rsp+0A8h+var_98]
loc_498785:
    lea     rdi, [dir_entry+4]; void_value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32u
    movsxd  rcx, ebx
    lea     rdx, php_tiff_bytes_per_format
    imul    eax, [rdx+rcx*4]
    cmp     eax, 4
    ja      short loc_4987E0
    add     ebx, 0FFFFFFFDh; switch 7 cases
    cmp     ebx, 6
    ja      def_4987C7; jumptable 00000000004987C7 default case
    lea     entry_length, jpt_4987C7
    mov     rcx, rax
    movsxd  rax, ds:(jpt_4987C7 - 7B71A0h)[rax+rbx*4]
    add     rax, rcx
    mov     rdx, [rsp+0A8h+var_68]
def_4987C7:
    jmp     rax; switch jump
    add     dir_entry, 8; jumptable 00000000004987C7 case 3
    mov     rdi, r12; value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get16u
    movsxd  rdx, eax
    jmp     short loc_498859; jumptable 00000000004987C7 cases 5-7
loc_4987E0:
    mov     ebx, eax
    add     dir_entry, 8
    mov     rdi, r12; void_value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32u
    mov     eax, eax
    add     entry_length, entry_offset
    mov     rsi, [rsp+0A8h+var_78]
    mov     rdi, [rsp+0A8h+valid_length]
    lea     rcx, [rdi+rsi]
    mov     rdx, rbx
    sub     rdx, rsi
    cmp     rbx, rcx
    cmovbe  rdx, rdi
    cmp     rcx, entry_offset
    cmovz   rdi, rdx
    mov     [rsp+0A8h+valid_length], rdi
    jmp     loc_4988B0
    add     dir_entry, 8; jumptable 00000000004987C7 case 4
    mov     rdi, r12; void_value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32u
    jmp     short loc_498857
    add     dir_entry, 8; jumptable 00000000004987C7 case 8
    mov     rdi, r12; value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get16s
    movsx   rdx, ax
    jmp     short loc_498859; jumptable 00000000004987C7 cases 5-7
    add     dir_entry, 8; jumptable 00000000004987C7 case 9
    mov     rdi, r12; value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32s
loc_498857:
    mov     edx, eax
loc_498859:
    cmp     r13d, 105h; jumptable 00000000004987C7 cases 5-7
    mov     [rsp+0A8h+var_68], entry_value
    jle     short loc_498890
    cmp     r13d, 106h
    jz      short loc_4988E1
    cmp     r13d, 0A003h
    jz      short loc_4988A2
    cmp     r13d, 0A002h
    jz      short loc_4988A7
    jmp     short loc_4988B0
loc_498890:
    cmp     r13d, 100h
    jz      short loc_4988A7
    cmp     r13d, 101h
    jnz     short loc_4988B0
loc_4988A2:
    mov     [rbp+24h], edx
    jmp     short loc_4988B0
loc_4988A7:
    mov     [rbp+28h], edx
    nop     word ptr [rax+rax+00h]
loc_4988B0:
    mov     rcx, [rsp+0A8h+var_A0]
loc_4988B5:
    mov     rbx, [rbp+220h]
    test    rcx, rcx
    jz      short loc_49891E
    mov     rax, [rsp+0A8h+var_50]
    lea     rax, [rax+rax*2]
    mov     rbp, [rbx+rax*8+10h]
    add     r14, 0Ch
    add     rcx, 0FFFFFFFFFFFFFFFFh
    mov     [rsp+0A8h+var_A0], rcx
    jmp     loc_498700
loc_4988E1:
    cmp     entry_value, 8
    mov     rcx, [rsp+0A8h+var_A0]
    ja      short loc_4988B5
    mov     eax, 16Ch
    bt      rax, entry_value
    jnb     short loc_49890A
    mov     dword ptr [rbp+2Ch], 1
    jmp     short loc_4988B5
    mov     rdx, [rsp+0A8h+var_68]; jumptable 00000000004987C7 default case
    jmp     loc_498859; jumptable 00000000004987C7 cases 5-7
loc_49890A:
    mov     eax, 13h
    bt      rax, entry_value
    jnb     short loc_4988B5
    mov     dword ptr [rbp+2Ch], 0
    jmp     short loc_4988B5
loc_49891E:
    mov     r14, [rsp+0A8h+valid_length]
loc_498923:
    mov     rbp, [rsp+0A8h+var_98]
    mov     r8, [rbp+18h]
    mov     rax, [rsp+0A8h+var_50]
    lea     rax, [rax+rax*2]
    mov     [rsp+0A8h+var_A0], rax
    mov     r9, [rbx+rax*8+8]
    mov     rax, r8
    sub     rax, r9
    mov     rdx, [rsp+0A8h+var_78]
    jb      loc_498BDD
    cmp     rax, rdx
    jb      loc_498BDD
    mov     rbx, ifd_size
    sub     rbx, [rsp+0A8h+var_70]
    jbe     short loc_4989B1
    mov     rax, r8
    sub     rax, ifd_size
    jb      loc_498C9E
    cmp     rax, rdx
    jb      loc_498C9E
    mov     rdi, rbp; ImageInfo
    mov     esi, [rsp+0A8h+var_7C]; section_index
    mov     rdx, ifd_size; size
    call    exif_file_sections_realloc
    test    eax, eax
    jnz     loc_498626
    mov     rdi, [rbp+0]; stream
    mov     rax, [rbp+220h]
    mov     rsi, [rsp+0A8h+var_70]
    mov     rcx, [rsp+0A8h+var_A0]
    add     rsi, [rax+rcx*8+10h]; buf
    mov     rdx, rbx; size
    call    _php_stream_read
loc_4989B1:
    mov     [rsp+0A8h+valid_length], ifd_size
    mov     eax, [rsp+0A8h+var_90]
    test    eax, eax
    jle     loc_498BEC
    neg     [rsp+0A8h+var_78]
    mov     r14d, eax
    xor     r12d, r12d
    jmp     short loc_498A2E
loc_4989CF:
    mov     rax, [rsp+0A8h+var_78]
    lea     rsi, [rax+r13]; offset_base
    lea     entry_tag, [rsp+0A8h+info]
    mov     rdi, rbx; info
    mov     rdx, r13; valid_start
    mov     rcx, [rsp+0A8h+valid_length]; valid_length
    call    exif_offset_info_init
    mov     rax, [rsp+0A8h+var_5C+4]
    mov     [rsp+0A8h+var_A8], rax; tag_table
    xor     r15d, r15d
    mov     rdi, [rsp+0A8h+var_98]; ImageInfo
    mov     rsi, dir_entry; dir_entry
    mov     dir_entry, rdi
    mov     rdx, rbx; info
    xor     ecx, ecx; displacement
    mov     r8d, [rsp+0A8h+var_8C]; section_index
    xor     r9d, r9d; ReadNextIFD
    call    exif_process_IFD_TAG
    test    al, al
    jz      loc_49866B
    xchg    ax, ax
loc_498A20:
    add     r12, 0Ch
    add     r14, 0FFFFFFFFFFFFFFFFh
    jz      loc_498BEC
loc_498A2E:
    mov     rax, [rbp+220h]
    mov     rcx, [rsp+0A8h+var_A0]
    mov     r13, [rax+rcx*8+10h]
    mov     eax, r12d
    and     eax, 0FFFFFFFCh
    mov     rcx, rbp
    lea     rbp, [rax+r13]
    add     rbp, 2
    mov     r15d, [rcx+70h]
    mov     rdi, dir_entry; value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get16u
    mov     ebx, eax
    cmp     eax, 8824h
    jg      short loc_498A90
    cmp     ebx, 14Ah
    jz      short loc_498AB1
    cmp     ebx, 8769h
    jnz     loc_4989CF
    mov     r13d, 7
    mov     eax, 80h
    jmp     short loc_498AC9
loc_498A90:
    cmp     ebx, 0A005h
    jz      short loc_498ABE
    cmp     ebx, 8825h
    jnz     loc_4989CF
    mov     r13d, 9
    mov     eax, 200h
    jmp     short loc_498AC9
loc_498AB1:
    mov     r13d, 4
    mov     eax, 10h
    jmp     short loc_498AC9
loc_498ABE:
    mov     r13d, 0Ah
    mov     eax, 400h
loc_498AC9:
    mov     rcx, [rsp+0A8h+var_98]
    or      [rcx+118h], eax
    add     dir_entry, 8
    mov     rdi, rbp; void_value
    mov     rbp, rcx
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32u
    mov     esi, eax; dir_offset
    mov     rdi, rbp; ImageInfo
    mov     edx, r13d; section_index
    call    exif_process_IFD_in_TIFF
    cmp     [rsp+0A8h+var_8C], 4
    jz      loc_498A20
    cmp     ebx, 14Ah
    jnz     loc_498A20
    cmp     dword ptr [rbp+0E8h], 0
    jz      loc_498A20
    mov     rdi, [rbp+100h]; nmemb
    test    rdi, rdi
    jz      loc_498A20
    cmp     qword ptr [rbp+108h], 0
    jz      loc_498A20
    cmp     dword ptr [rbp+200h], 0
    jz      loc_498A20
    cmp     qword ptr [rbp+110h], 0
    jnz     loc_498A20
    mov     esi, 1; size
    xor     edx, edx; offset
    call    _safe_emalloc
    mov     [rbp+110h], rax
    mov     rdi, [rbp+0]; stream
    mov     rsi, [rbp+108h]; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     rsi, [rbp+110h]; buf
    mov     rdi, [rbp+0]; stream
    mov     rdx, [rbp+100h]; size
    call    _php_stream_read
    cmp     fgot, [rbp+100h]
    jnz     short loc_498BA2
    mov     rdi, rbp; ImageInfo
    call    exif_thumbnail_build
    jmp     loc_498A20
loc_498BA2:
    xor     edi, edi; docref
    mov     rsi, rbp; ImageInfo
    mov     edx, 2; type
    lea     rcx, aXPhpOriginatin+22h; format
    lea     r8, aThumbnailGoesI; "Thumbnail goes IFD boundary or end of f"...
    xor     eax, eax
    call    exif_error_docref
    mov     rdi, [rbp+110h]; ptr
    call    _efree
    mov     qword ptr [rbp+110h], 0
    jmp     loc_498A20
loc_498BDD:
    add     r9, rdx
    lea     rcx, aErrorInTiffFil_1; "Error in TIFF: filesize(x%04X) less tha"...
    jmp     loc_498CAC
loc_498BEC:
    mov     r15b, 1
    cmp     [rsp+0A8h+var_8C], 4
    jz      loc_49866B
    mov     esi, dword ptr [rsp+0A8h+var_5C]; dir_offset
    test    esi, esi
    jz      loc_49866B
    mov     rdi, rbp; ImageInfo
    mov     edx, 4; section_index
    call    exif_process_IFD_in_TIFF
    cmp     qword ptr [rbp+110h], 0
    jnz     loc_49866B
    cmp     qword ptr [rbp+108h], 0
    jz      loc_49866B
    mov     rdi, [rbp+100h]; nmemb
    test    rdi, rdi
    jz      loc_49866B
    cmp     dword ptr [rbp+200h], 0
    jz      loc_49866B
    mov     esi, 1; size
    xor     edx, edx; offset
    call    _safe_emalloc
    mov     [rbp+110h], rax
    mov     rdi, [rbp+0]; stream
    mov     rsi, [rbp+108h]; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     rsi, [rbp+110h]; buf
    mov     rdi, [rbp+0]; stream
    mov     rdx, [rbp+100h]; size
    call    _php_stream_read
    cmp     fgot, [rbp+100h]
    jnz     short loc_498CBE
    mov     rdi, rbp; ImageInfo
    call    exif_thumbnail_build
    jmp     loc_49866B
loc_498C9E:
    mov     [rsp+0A8h+var_A8], ifd_size
    lea     rcx, aErrorInTiffFil_2; "Error in TIFF: filesize(x%04X) less tha"...
    mov     r9, rdx
loc_498CAC:
    xor     r15d, r15d
    xor     edi, edi
    mov     rsi, rbp
    mov     edx, 2
    jmp     loc_498664
loc_498CBE:
    lea     rcx, aXPhpOriginatin+22h; format
    lea     r8, aThumbnailGoesI; "Thumbnail goes IFD boundary or end of f"...
    xor     edi, edi; docref
    mov     rsi, rbp; ImageInfo
    mov     edx, 2; type
    xor     eax, eax
    call    exif_error_docref
    mov     rdi, [rbp+110h]; ptr
    call    _efree
    mov     qword ptr [rbp+110h], 0
    jmp     loc_49866B
exif_process_IFD_in_TIFF_impl endp

