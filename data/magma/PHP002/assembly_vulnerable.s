exif_process_IFD_in_TIFF_impl proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 78h
    mov     r15d, edx
    mov     r13, dir_offset
    mov     rbx, ImageInfo
    mov     edi, edx; section
    call    exif_get_tag_table
    mov     [rsp+0A8h+var_5C+4], rax
    mov     r8, [ImageInfo+18h]
    lea     r9, [dir_offset+2]
    cmp     r8, r9
    jnb     short loc_4984B4
    lea     rcx, aErrorInTiffFil; "Error in TIFF: filesize(x%04X) less tha"...
    xor     r15d, r15d
    xor     edi, edi
    mov     rsi, ImageInfo
    jmp     loc_49858C
loc_4984B4:
    mov     edx, 2; size
    mov     rdi, ImageInfo; ImageInfo
    mov     esi, 123h; type
    call    exif_file_sections_add
    mov     ebp, eax
    mov     rdi, [ImageInfo]; stream
    mov     rsi, dir_offset; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     rdi, [ImageInfo]; stream
    mov     rax, [ImageInfo+220h]
    mov     [rsp+0A8h+var_7C], ebp
    movsxd  rcx, ebp
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
    movsxd  rcx, eax
    shl     rcx, 2
    lea     r14, [rcx+rcx*2]
    or      r14, 2
    lea     r9, [r14+4]
    mov     [rsp+0A8h+var_98], ImageInfo
    mov     r8, [rbx+18h]
    mov     rcx, r8
    sub     rcx, ifd_size
    jb      short loc_498578
    cmp     rcx, dir_offset
    jb      short loc_498578
    mov     [rsp+0A8h+var_90], eax
    mov     [rsp+0A8h+var_8C], r15d
    mov     [rsp+0A8h+size], ifd_size
    mov     [rsp+0A8h+var_70], dir_offset
    mov     rbp, [rsp+0A8h+size]
    mov     r15, [rsp+0A8h+var_98]
    mov     rdi, r15; ImageInfo
    mov     esi, [rsp+0A8h+var_7C]; section_index
    mov     rdx, dir_size; size
    call    exif_file_sections_realloc
    test    eax, eax
    jz      short loc_4985AA
loc_498573:
    xor     r15d, r15d
    jmp     short loc_498598
loc_498578:
    add     ifd_size, dir_offset
    lea     rcx, aErrorInTiffFil_0; "Error in TIFF: filesize(x%04X) less tha"...
    xor     r15d, r15d
    xor     edi, edi; docref
    mov     rsi, [rsp+0A8h+var_98]; ImageInfo
loc_49858C:
    mov     edx, 2; type
    xor     eax, eax
    call    exif_error_docref
loc_498598:
    mov     eax, r15d
    add     rsp, 78h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_4985AA:
    mov     rdi, [r15]; stream
    mov     rax, [r15+220h]
    mov     rsi, [rax+r12+10h]
    add     rsi, 2; buf
    lea     rdx, [r14+2]; size
    call    _php_stream_read
    mov     rbx, [r15+220h]
    mov     r13, dir_size
    mov     rbp, [rbx+r12+10h]
    add     r14, rbp
    mov     r15d, [r15+70h]
    mov     rdi, r14; void_value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32u
    mov     dword ptr [rsp+0A8h+var_5C], eax
    mov     r14, dir_size
    cmp     [rsp+0A8h+var_90], 0
    jle     loc_498843
    mov     eax, [rsp+0A8h+var_90]
    add     rax, 0FFFFFFFFFFFFFFFFh
    mov     [rsp+0A8h+var_A0], rax
    xor     r14d, r14d
    xor     eax, eax
    mov     [rsp+0A8h+var_68], rax
    mov     rax, [rsp+0A8h+size]
    mov     [rsp+0A8h+valid_length], rax
    nop     word ptr [rax+rax+00h]
loc_498620:
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
    jl      short loc_4986A0
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
    jmp     short loc_4986A5
loc_4986A0:
    mov     rbp, [rsp+0A8h+var_98]
loc_4986A5:
    lea     rdi, [dir_entry+4]; void_value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32u
    movsxd  rcx, ebx
    lea     rdx, php_tiff_bytes_per_format
    imul    eax, [rdx+rcx*4]
    cmp     eax, 4
    ja      short loc_498700
    add     ebx, 0FFFFFFFDh; switch 7 cases
    cmp     ebx, 6
    ja      def_4986E7; jumptable 00000000004986E7 default case
    lea     entry_length, jpt_4986E7
    mov     rcx, rax
    movsxd  rax, ds:(jpt_4986E7 - 7B5BE0h)[rax+rbx*4]
    add     rax, rcx
    mov     rdx, [rsp+0A8h+var_68]
def_4986E7:
    jmp     rax; switch jump
    add     dir_entry, 8; jumptable 00000000004986E7 case 3
    mov     rdi, r12; value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get16u
    movsxd  rdx, eax
    jmp     short loc_498779; jumptable 00000000004986E7 cases 5-7
loc_498700:
    mov     ebx, eax
    add     dir_entry, 8
    mov     rdi, r12; void_value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32u
    mov     eax, eax
    add     entry_length, entry_offset
    mov     rsi, [rsp+0A8h+var_70]
    mov     rdi, [rsp+0A8h+valid_length]
    lea     rcx, [rdi+rsi]
    mov     rdx, rbx
    sub     rdx, rsi
    cmp     rbx, rcx
    cmovbe  rdx, rdi
    cmp     rcx, entry_offset
    cmovz   rdi, rdx
    mov     [rsp+0A8h+valid_length], rdi
    jmp     loc_4987D0
    add     dir_entry, 8; jumptable 00000000004986E7 case 4
    mov     rdi, r12; void_value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32u
    jmp     short loc_498777
    add     dir_entry, 8; jumptable 00000000004986E7 case 8
    mov     rdi, r12; value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get16s
    movsx   rdx, ax
    jmp     short loc_498779; jumptable 00000000004986E7 cases 5-7
    add     dir_entry, 8; jumptable 00000000004986E7 case 9
    mov     rdi, r12; value
    mov     esi, r15d; motorola_intel
    call    php_ifd_get32s
loc_498777:
    mov     edx, eax
loc_498779:
    cmp     r13d, 105h; jumptable 00000000004986E7 cases 5-7
    mov     [rsp+0A8h+var_68], entry_value
    jle     short loc_4987B0
    cmp     r13d, 106h
    jz      short loc_498801
    cmp     r13d, 0A003h
    jz      short loc_4987C2
    cmp     r13d, 0A002h
    jz      short loc_4987C7
    jmp     short loc_4987D0
loc_4987B0:
    cmp     r13d, 100h
    jz      short loc_4987C7
    cmp     r13d, 101h
    jnz     short loc_4987D0
loc_4987C2:
    mov     [rbp+24h], edx
    jmp     short loc_4987D0
loc_4987C7:
    mov     [rbp+28h], edx
    nop     word ptr [rax+rax+00h]
loc_4987D0:
    mov     rcx, [rsp+0A8h+var_A0]
loc_4987D5:
    mov     rbx, [rbp+220h]
    test    rcx, rcx
    jz      short loc_49883E
    mov     rax, [rsp+0A8h+var_50]
    lea     rax, [rax+rax*2]
    mov     rbp, [rbx+rax*8+10h]
    add     r14, 0Ch
    add     rcx, 0FFFFFFFFFFFFFFFFh
    mov     [rsp+0A8h+var_A0], rcx
    jmp     loc_498620
loc_498801:
    cmp     entry_value, 8
    mov     rcx, [rsp+0A8h+var_A0]
    ja      short loc_4987D5
    mov     eax, 16Ch
    bt      rax, entry_value
    jnb     short loc_49882A
    mov     dword ptr [rbp+2Ch], 1
    jmp     short loc_4987D5
    mov     rdx, [rsp+0A8h+var_68]; jumptable 00000000004986E7 default case
    jmp     loc_498779; jumptable 00000000004986E7 cases 5-7
loc_49882A:
    mov     eax, 13h
    bt      rax, entry_value
    jnb     short loc_4987D5
    mov     dword ptr [rbp+2Ch], 0
    jmp     short loc_4987D5
loc_49883E:
    mov     r14, [rsp+0A8h+valid_length]
loc_498843:
    mov     rbp, [rsp+0A8h+var_98]
    mov     r8, [rbp+18h]
    mov     rax, [rsp+0A8h+var_50]
    lea     rax, [rax+rax*2]
    mov     [rsp+0A8h+var_A0], rax
    mov     r9, [rbx+rax*8+8]
    mov     rax, r8
    sub     rax, r9
    mov     rdx, [rsp+0A8h+var_70]
    jb      loc_498AFD
    cmp     rax, rdx
    jb      loc_498AFD
    mov     rbx, ifd_size
    sub     rbx, [rsp+0A8h+size]
    jbe     short loc_4988D1
    mov     rax, r8
    sub     rax, ifd_size
    jb      loc_498BBE
    cmp     rax, rdx
    jb      loc_498BBE
    mov     rdi, rbp; ImageInfo
    mov     esi, [rsp+0A8h+var_7C]; section_index
    mov     rdx, ifd_size; size
    call    exif_file_sections_realloc
    test    eax, eax
    jnz     loc_498573
    mov     rdi, [rbp+0]; stream
    mov     rax, [rbp+220h]
    mov     rsi, [rsp+0A8h+size]
    mov     rcx, [rsp+0A8h+var_A0]
    add     rsi, [rax+rcx*8+10h]; buf
    mov     rdx, rbx; size
    call    _php_stream_read
loc_4988D1:
    mov     [rsp+0A8h+valid_length], ifd_size
    mov     eax, [rsp+0A8h+var_90]
    test    eax, eax
    jle     loc_498B0C
    neg     [rsp+0A8h+var_70]
    mov     r14d, eax
    xor     r12d, r12d
    jmp     short loc_49894E
loc_4988EF:
    mov     rax, [rsp+0A8h+var_70]
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
    jz      loc_498598
    xchg    ax, ax
loc_498940:
    add     r12, 0Ch
    add     r14, 0FFFFFFFFFFFFFFFFh
    jz      loc_498B0C
loc_49894E:
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
    jg      short loc_4989B0
    cmp     ebx, 14Ah
    jz      short loc_4989D1
    cmp     ebx, 8769h
    jnz     loc_4988EF
    mov     r13d, 7
    mov     eax, 80h
    jmp     short loc_4989E9
loc_4989B0:
    cmp     ebx, 0A005h
    jz      short loc_4989DE
    cmp     ebx, 8825h
    jnz     loc_4988EF
    mov     r13d, 9
    mov     eax, 200h
    jmp     short loc_4989E9
loc_4989D1:
    mov     r13d, 4
    mov     eax, 10h
    jmp     short loc_4989E9
loc_4989DE:
    mov     r13d, 0Ah
    mov     eax, 400h
loc_4989E9:
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
    jz      loc_498940
    cmp     ebx, 14Ah
    jnz     loc_498940
    cmp     dword ptr [rbp+0E8h], 0
    jz      loc_498940
    mov     rdi, [rbp+100h]; nmemb
    test    rdi, rdi
    jz      loc_498940
    cmp     qword ptr [rbp+108h], 0
    jz      loc_498940
    cmp     dword ptr [rbp+200h], 0
    jz      loc_498940
    cmp     qword ptr [rbp+110h], 0
    jnz     loc_498940
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
    jnz     short loc_498AC2
    mov     rdi, rbp; ImageInfo
    call    exif_thumbnail_build
    jmp     loc_498940
loc_498AC2:
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
    jmp     loc_498940
loc_498AFD:
    add     r9, rdx
    lea     rcx, aErrorInTiffFil_1; "Error in TIFF: filesize(x%04X) less tha"...
    jmp     loc_498BCC
loc_498B0C:
    mov     r15b, 1
    cmp     [rsp+0A8h+var_8C], 4
    jz      loc_498598
    mov     esi, dword ptr [rsp+0A8h+var_5C]; dir_offset
    test    esi, esi
    jz      loc_498598
    mov     rdi, rbp; ImageInfo
    mov     edx, 4; section_index
    call    exif_process_IFD_in_TIFF
    cmp     qword ptr [rbp+110h], 0
    jnz     loc_498598
    cmp     qword ptr [rbp+108h], 0
    jz      loc_498598
    mov     rdi, [rbp+100h]; nmemb
    test    rdi, rdi
    jz      loc_498598
    cmp     dword ptr [rbp+200h], 0
    jz      loc_498598
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
    jnz     short loc_498BD9
    mov     rdi, rbp; ImageInfo
    call    exif_thumbnail_build
    jmp     loc_498598
loc_498BBE:
    mov     [rsp+0A8h+var_A8], ifd_size
    lea     rcx, aErrorInTiffFil_2; "Error in TIFF: filesize(x%04X) less tha"...
    mov     r9, rdx
loc_498BCC:
    xor     r15d, r15d
    xor     edi, edi
    mov     rsi, rbp
    jmp     loc_49858C
loc_498BD9:
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
    jmp     loc_498598
exif_process_IFD_in_TIFF_impl endp

