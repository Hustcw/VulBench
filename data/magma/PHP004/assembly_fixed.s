exif_process_IFD_TAG proc
    push    rbx
    sub     rsp, 10h
    mov     rbx, ImageInfo
    mov     eax, [rdi+20Ch]
    lea     edi, [rax+1]
    mov     [ImageInfo+20Ch], edi
    cmp     eax, 3E9h
    jl      short loc_49680E
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     displacement, aCorruptExifHea; "corrupt EXIF header: maximum IFD tag co"...
    jmp     short loc_496827
loc_49680E:
    mov     eax, [ImageInfo+208h]
    cmp     eax, 0Bh
    jl      short loc_49683A
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     displacement, aCorruptExifHea_0; "corrupt EXIF header: maximum directory "...
loc_496827:
    mov     dir_entry, ImageInfo; ImageInfo
    mov     edx, 2; type
    xor     eax, eax
    call    exif_error_docref
    xor     eax, eax
    jmp     short loc_49685B
loc_49683A:
    mov     rdi, [rsp+18h+arg_0]
    add     eax, 1
    mov     [ImageInfo+208h], eax
    mov     [rsp+18h+var_18], rdi; tag_table
    mov     rdi, ImageInfo; ImageInfo
    call    exif_process_IFD_TAG_impl
    add     dword ptr [ImageInfo+208h], 0FFFFFFFFh
loc_49685B:
    add     rsp, 10h
    pop     ImageInfo
    retn
exif_process_IFD_TAG endp



exif_process_IFD_TAG_impl proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0B8h
    mov     [rsp+0E8h+var_A4], r9d
    mov     [rsp+0E8h+var_BC], r8d
    mov     [rsp+0E8h+var_B8], displacement
    mov     [rsp+0E8h+var_C8], info
    mov     rbx, dir_entry
    mov     r12, ImageInfo
    mov     r14, [rsp+0E8h+tag_table]
    mov     ebp, [rdi+70h]
    mov     rdi, rsi; value
    mov     esi, ebp; motorola_intel
    call    php_ifd_get16u
    mov     qword ptr [rsp+0E8h+var_B0], tag
    mov     r13d, eax
    lea     rdi, [dir_entry+2]; value
    mov     esi, ebp; motorola_intel
    call    php_ifd_get16u
    mov     r15d, eax
    mov     [rsp+0E8h+offset], dir_entry
    lea     rdi, [rbx+4]; void_value
    mov     esi, ebp; motorola_intel
    call    php_ifd_get32u
    mov     ebp, eax
    mov     eax, r15d
    add     eax, 0FFFFFFFFh
    cmp     eax, 0Dh
    jb      short loc_496A36
    mov     edi, r13d; tag_num
    mov     rsi, r14; tag_table
    call    exif_get_tagname_debug
    sub     rsp, 8
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x; "Process tag(x%04X=%s): Illegal format c"...
    mov     r14, ImageInfo
    mov     rsi, ImageInfo; ImageInfo
    mov     edx, 2; type
    mov     r8d, r13d
    mov     r9, rax
    xor     eax, eax
    push    format
    call    exif_error_docref
    add     rsp, 10h
    mov     r15d, 1
    jmp     short loc_496A39
loc_496A36:
    mov     r14, ImageInfo
loc_496A39:
    mov     ebx, r13d
    mov     edx, ebp
    mov     eax, r15d
    lea     rcx, php_tiff_bytes_per_format
    movsxd  components, dword ptr [rcx+rax*4]
    imul    rbp, rdx
    test    rbp, 0FFFFFFFF80000000h
    mov     r13d, [rsp+0E8h+var_BC]
    jz      short loc_496A98
    mov     edi, ebx; tag_num
    mov     rsi, [rsp+0E8h+tag_table]; tag_table
    call    exif_get_tagname_debug
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x_0; "Process tag(x%04X=%s): Illegal byte_cou"...
    xor     r15d, r15d
    mov     rsi, r14; ImageInfo
loc_496A81:
    mov     edx, 2; type
    mov     r8d, ebx
loc_496A89:
    mov     r9, rax
    xor     eax, eax
    call    exif_error_docref
    jmp     loc_4975E9
loc_496A98:
    mov     [rsp+0E8h+tag_num], ebx
    mov     [rsp+0E8h+var_A0], rdx
    mov     qword ptr [rsp+0E8h+var_D8], format
    mov     format, [rsp+0E8h+offset]
    add     r15, 8
    cmp     rbp, 5
    mov     r12, r14
    jb      short loc_496AEA
    mov     r14d, r13d
    mov     esi, [r12+70h]; motorola_intel
    mov     rdi, r15; void_value
    call    php_ifd_get32u
    mov     r13d, eax
    mov     rdi, [rsp+0E8h+var_C8]; info
    mov     rsi, offset_val; offset
    mov     rdx, rbp; length
    call    exif_offset_info_try_get
    test    value_ptr, value_ptr
    jz      loc_496BEF
    mov     r15, value_ptr
    mov     r13d, r14d
loc_496AEA:
    xor     r14d, r14d
loc_496AED:
    mov     rdx, qword ptr [rsp+0E8h+var_B0]
    mov     eax, [r12+118h]
    mov     ecx, eax
    or      ecx, 4
    mov     [r12+118h], ecx
    cmp     r13d, 4
    jnz     short loc_496B70
    cmp     qword ptr [r12+110h], 0
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    test    rbp, rbp
    jz      loc_49708D
    cmp     edx, 200h
    jg      loc_496D83
    add     edx, 0FFFFFF00h; switch 24 cases
    cmp     edx, 17h
    ja      def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    lea     rax, jpt_496B4E
    movsxd  rcx, ds:(jpt_496B4E - 7B70B8h)[rax+rdx*4]
    add     rcx, rax
def_496B4E:
    jmp     rcx; switch jump
    mov     eax, [r12+20h]; jumptable 0000000000496B4E case 279
    lea     ecx, [rax-7]
    cmp     ecx, 2
    mov     ecx, 8
    cmovb   ecx, eax
    mov     [r12+0E8h], ecx
    jmp     loc_496DC2
loc_496B70:
    mov     ecx, r13d
    or      ecx, 4
    cmp     ecx, 7
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    cmp     edx, 927Bh
    jg      loc_496C8D
    cmp     edx, 8768h
    jg      loc_496D0B
    cmp     edx, 8297h
    jg      loc_496EC6
    cmp     edx, 10Fh
    jz      loc_4971C9
    cmp     edx, 110h
    jz      loc_4971ED
    cmp     edx, 14Ah
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    cmp     [rsp+0E8h+var_D8], 0Dh
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    lea     rcx, aSkipSubIfd; "Skip SUB IFD"
    xor     edi, edi; docref
    mov     rsi, r12; ImageInfo
    mov     edx, 8; type
    xor     eax, eax
    call    exif_error_docref
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_496BEF:
    mov     value_ptr, [r12+18h]
    sub     rax, rbp
    mov     rsi, [rsp+0E8h+tag_table]; tag_table
    jb      short loc_496C3E
    cmp     rax, offset_val
    jb      short loc_496C3E
    mov     eax, [r12+20h]
    cmp     eax, 8
    ja      short loc_496C3E
    mov     ecx, 184h
    bt      ecx, eax
    jnb     short loc_496C3E
    cmp     rbp, 21h ; '!'
    jb      loc_496E11
    mov     esi, 1; size
    mov     rdi, rbp; nmemb
    xor     edx, edx; offset
    call    _safe_emalloc
    mov     r15, rax
    mov     rbx, rax
    jmp     loc_496E28
loc_496C3E:
    mov     r14d, [rsp+0E8h+tag_num]
    mov     edi, r14d; tag_num
    call    exif_get_tagname_debug
    mov     r10, rbp
    add     r10, offset_val
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x_1; "Process tag(x%04X=%s): Illegal pointer "...
    xor     r15d, r15d
    mov     rsi, r12; ImageInfo
    mov     edx, 2; type
    mov     r8d, r14d
    mov     r9, rax
    mov     eax, 0
    push    qword ptr [r12+18h]
    push    r10
    push    rbp
    push    offset_val
    call    exif_error_docref
    add     rsp, 20h
    jmp     loc_4975E9
loc_496C8D:
    cmp     edx, 0A001h
    jg      loc_496DE8
    lea     eax, [rdx-9C9Bh]
    cmp     eax, 5
    jnb     loc_496F9B
    mov     rdi, [r12+0E0h]; ptr
    movsxd  rsi, dword ptr [r12+0D8h]
    add     rsi, 1; nmemb
    mov     edx, 18h; size
    xor     ecx, ecx; offset
    call    _safe_erealloc
    or      byte ptr [r12+119h], 10h
    mov     [r12+0E0h], tmp_xp
    movsxd  rcx, dword ptr [r12+0D8h]
    lea     edx, [rcx+1]
    mov     [r12+0D8h], edx
    lea     rcx, [rcx+rcx*2]
    lea     rsi, [tmp_xp+rcx*8]; xp_field
    mov     rdi, r12; ImageInfo
    mov     edx, [rsp+0E8h+tag_num]; tag
    mov     rcx, value_ptr; szValuePtr
    mov     r8d, ebp; ByteCount
    call    exif_process_unicode
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_496D0B:
    lea     ecx, [rdx-9201h]; switch 6 cases
    cmp     ecx, 5
    ja      def_496D28; jumptable 0000000000496D28 default case
    lea     rax, jpt_496D28
    movsxd  rcx, ds:(jpt_496D28 - 7B708Ch)[rax+rcx*4]
    add     rcx, rax
def_496D28:
    jmp     rcx; switch jump
    movss   xmm0, dword ptr [r12+40h]; jumptable 0000000000496D28 cases 37378,37381
    xorps   xmm1, xmm1
    ucomiss xmm0, xmm1
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    jp      def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    test    rbp, rbp
    jz      loc_49708D
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     rsi, qword ptr [rsp+0E8h+var_D8]; format
    call    exif_convert_any_format
    mulsd   xmm0, cs:qword_7B6F48
    mulsd   xmm0, cs:qword_73C850
    cvtsd2ss xmm0, xmm0; x
    call    _expf
    movss   dword ptr [r12+40h], xmm0
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_496D83:
    cmp     edx, 0A001h
    jg      loc_496F15
    cmp     edx, 201h
    jz      loc_496F4F; jumptable 0000000000496B4E case 273
    cmp     edx, 202h
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    cmp     dword ptr [r12+0E8h], 0
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    mov     dword ptr [r12+0E8h], 2
loc_496DC2:
    mov     rdi, qword ptr [rsp+0E8h+var_D8]; format
    call    exif_rewrite_tag_format_to_unsigned
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     esi, eax; format
    call    exif_convert_any_to_int
    mov     [r12+100h], rax
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_496DE8:
    cmp     edx, 0A20Dh
    jg      loc_4970B9
    cmp     edx, 0A002h
    jz      loc_497211
    cmp     edx, 0A005h
    jz      loc_497041
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_496E11:
    lea     r15, [rsp+0E8h+var_98]
    xorpd   xmm0, xmm0
    movapd  [rsp+0E8h+var_88], xmm0
    movapd  [rsp+0E8h+var_98], xmm0
    xor     ebx, ebx
loc_496E28:
    mov     rdi, [r12]; stream
    call    _php_stream_tell
    mov     [rsp+0E8h+offset], rax
    mov     rdi, [r12]; stream
    add     offset_val, [rsp+0E8h+var_B8]
    mov     rsi, r13; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     rdi, [r12]; stream
    call    _php_stream_tell
    cmp     fgot, r13
    jnz     short loc_496E8D
    mov     rdi, [r12]; stream
    mov     rsi, value_ptr; buf
    mov     rdx, rbp; size
    call    _php_stream_read
    mov     r13, rax
    mov     rdi, [r12]; stream
    mov     rsi, [rsp+0E8h+offset]; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    cmp     fgot, rbp
    jnz     loc_497119
    mov     r13d, r14d
    mov     r14, outside
    jmp     loc_496AED
loc_496E8D:
    test    outside, outside
    jz      short loc_496EA0
    mov     rdi, outside; ptr
    mov     outside, fgot
    call    _efree
    mov     rax, fgot
loc_496EA0:
    lea     rcx, aWrongFilePoint; "Wrong file pointer: 0x%08X != 0x%08X"
    xor     r15d, r15d
    xor     edi, edi; docref
    mov     rsi, r12; ImageInfo
    mov     edx, 2; type
    mov     r8, rax
    mov     r9, r13
    xor     eax, eax
    call    exif_error_docref
    jmp     loc_4975E9
loc_496EC6:
    cmp     edx, 8298h
    jz      loc_49723D
    cmp     edx, 829Ah
    jz      loc_497302
    cmp     edx, 829Dh
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    test    rbp, rbp
    jz      loc_497391
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     rsi, qword ptr [rsp+0E8h+var_D8]; format
    call    exif_convert_any_format
    cvtsd2ss xmm0, xmm0
    movss   dword ptr [r12+40h], xmm0
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_496F15:
    cmp     edx, 0A003h
    jz      short loc_496F75; jumptable 0000000000496B4E case 257
    cmp     edx, 0A002h
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    mov     rdi, qword ptr [rsp+0E8h+var_D8]; jumptable 0000000000496B4E case 256
    call    exif_rewrite_tag_format_to_unsigned
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     esi, eax; format
    call    exif_convert_any_to_int
    mov     [r12+0F0h], rax
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_496F4F:
    mov     rdi, qword ptr [rsp+0E8h+var_D8]; jumptable 0000000000496B4E case 273
    call    exif_rewrite_tag_format_to_unsigned
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     esi, eax; format
    call    exif_convert_any_to_int
    mov     [r12+108h], rax
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_496F75:
    mov     rdi, qword ptr [rsp+0E8h+var_D8]; jumptable 0000000000496B4E case 257
    call    exif_rewrite_tag_format_to_unsigned
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     esi, eax; format
    call    exif_convert_any_to_int
    mov     [r12+0F8h], rax
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_496F9B:
    cmp     edx, 927Ch
    jz      loc_497310
    cmp     edx, 9286h
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    mov     [rsp+0E8h+offset], outside
    mov     r14d, r13d
    mov     rbx, value_ptr
    mov     rdi, [r12+78h]; ptr
    test    rdi, rdi
    jz      short loc_496FCD
    call    _efree
loc_496FCD:
    lea     r15, [r12+78h]
    mov     qword ptr [r12+78h], 0
    lea     r13, [r12+88h]
    mov     rdi, [r12+88h]; ptr
    test    rdi, rdi
    jz      short loc_496FF5
    call    _efree
loc_496FF5:
    mov     qword ptr [r12+88h], 0
    mov     rdi, r12; ImageInfo
    mov     rsi, r15; pszInfoPtr
    mov     rdx, r13; pszEncoding
    mov     r15, value_ptr
    mov     rcx, value_ptr; szValuePtr
    mov     r8d, ebp; ByteCount
    call    exif_process_user_comment
    mov     [r12+80h], eax
loc_497020:
    mov     r13d, r14d
    mov     r14, [rsp+0E8h+offset]
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    cmp     edx, 8769h; jumptable 0000000000496D28 default case
    jz      short loc_497041
    cmp     edx, 8825h
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_497041:
    cmp     [rsp+0E8h+var_A4], 0
    jz      def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    test    rbp, rbp
    jz      short loc_49708D
    cmp     edx, 8769h
    jz      loc_497469
    cmp     edx, 0A005h
    jz      loc_497476
    xor     r13d, r13d
    cmp     edx, 8825h
    mov     rbx, [rsp+0E8h+var_C8]
    jnz     loc_497490
    mov     r13d, 9
    mov     ecx, 204h
    jmp     loc_497486
loc_49708D:
    mov     ebx, [rsp+0E8h+tag_num]
    mov     edi, ebx; tag_num
    mov     rsi, [rsp+0E8h+tag_table]; tag_table
    call    exif_get_tagname_debug
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x_2; "Process tag(x%04X=%s): Cannot be empty"
    xor     r15d, r15d
    mov     rsi, r12
    jmp     loc_496A81
loc_4970B9:
    cmp     edx, 0A20Eh
    jz      loc_497334
    cmp     edx, 0A210h
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    test    rbp, rbp
    jz      loc_4973C7
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     rsi, qword ptr [rsp+0E8h+var_D8]; format
    call    exif_convert_any_to_int
    add     rax, 0FFFFFFFFFFFFFFFFh; switch 5 cases
    cmp     rax, 4
    ja      def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    lea     rcx, jpt_497108; tag_table
    movsxd  rax, dword ptr ds:(jpt_497108.Tag - 7B70A4h)[rcx+rax*4]
    add     rax, rcx
    jmp     rax; switch jump
    mov     rax, 4039666666666666h; jumptable 0000000000497108 cases 1,2
    jmp     loc_49759B
loc_497119:
    test    outside, outside
    jz      short loc_497126
    mov     rdi, outside; ptr
    call    _efree
loc_497126:
    lea     rcx, aXPhpOriginatin+22h; format
    lea     r8, aUnexpectedEndO; "Unexpected end of file reached"
    xor     r15d, r15d
    xor     edi, edi; docref
    mov     rsi, r12; ImageInfo
    mov     edx, 2; type
    xor     eax, eax
    call    exif_error_docref
    jmp     loc_4975E9
    movss   xmm0, dword ptr [r12+44h]; jumptable 0000000000496D28 case 37377
    xorps   xmm1, xmm1
    ucomiss xmm0, xmm1
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    jp      def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    test    rbp, rbp
    jz      loc_49751C
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     rsi, qword ptr [rsp+0E8h+var_D8]; format
    call    exif_convert_any_format
    mulsd   xmm0, cs:qword_7B6F40
    cvtsd2ss xmm0, xmm0; x
    call    _expf
    movss   dword ptr [r12+44h], xmm0
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    test    rbp, rbp; jumptable 0000000000496D28 case 37382
    jz      loc_49735B
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     rsi, qword ptr [rsp+0E8h+var_D8]; format
    call    exif_convert_any_format
    cvtsd2ss xmm0, xmm0
    movss   dword ptr [r12+6Ch], xmm0
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_4971C9:
    mov     rdi, [r12+30h]; ptr
    test    rdi, rdi
    jz      short loc_4971D8
    call    _efree
loc_4971D8:
    mov     rdi, value_ptr; s
    mov     rsi, rbp; length
    call    _estrndup
    mov     [r12+30h], rax
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_4971ED:
    mov     rdi, [r12+38h]; ptr
    test    rdi, rdi
    jz      short loc_4971FC
    call    _efree
loc_4971FC:
    mov     rdi, value_ptr; s
    mov     rsi, rbp; length
    call    _estrndup
    mov     [r12+38h], rax
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_497211:
    test    rbp, rbp
    jz      loc_4973FD
    mov     rdi, qword ptr [rsp+0E8h+var_D8]; format
    call    exif_rewrite_tag_format_to_unsigned
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     esi, eax; format
    call    exif_convert_any_to_int
    mov     [r12+60h], rax
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_49723D:
    cmp     rbp, 2
    jb      def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    mov     rdi, value_ptr; str
    mov     rsi, rbp; maxlen
    call    php_strnlen
    test    rax, rax
    jz      def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    mov     rbx, rax
    lea     rax, [rbp-1]
    cmp     length, rax
    jnb     loc_497552
    mov     [rsp+0E8h+offset], outside
    mov     rdi, [r12+0C8h]; ptr
    test    rdi, rdi
    jz      short loc_497282
    call    _efree
loc_497282:
    mov     r14d, r13d
    mov     rdi, [r12+0D0h]; ptr
    test    rdi, rdi
    jz      short loc_497297
    call    _efree
loc_497297:
    lea     r13, [r12+0C0h]
    mov     rdi, [r12+0C0h]; ptr
    test    rdi, rdi
    jz      short loc_4972B1
    call    _efree
loc_4972B1:
    mov     rdi, value_ptr; s
    call    _estrdup
    mov     [r12+0C8h], rax
    lea     rdi, [value_ptr+length]
    add     rdi, 1; s
    not     length
    add     rbx, rbp
    mov     rsi, rbx; length
    call    _estrndup
    mov     [r12+0D0h], rax
    mov     rcx, [r12+0C8h]
    lea     rdx, aSS; "%s, %s"
    mov     rdi, r13; message
    xor     esi, esi; max_len
    mov     r8, rax
    xor     eax, eax
    call    zend_spprintf
    jmp     loc_497020
loc_497302:
    mov     dword ptr [r12+44h], 0BF800000h
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_497310:
    mov     rdi, r12; ImageInfo
    mov     rsi, value_ptr; value_ptr
    mov     edx, ebp; value_len
    mov     rcx, [rsp+0E8h+var_C8]; info
    mov     r8, [rsp+0E8h+var_B8]; displacement
    call    exif_process_IFD_in_MAKERNOTE
    test    al, al
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    jmp     loc_4974D6
loc_497334:
    test    rbp, rbp
    jz      loc_497433
    mov     edx, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; value
    mov     rsi, qword ptr [rsp+0E8h+var_D8]; format
    call    exif_convert_any_format
    movsd   qword ptr [r12+58h], xmm0
    jmp     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_49735B:
    mov     edi, 9206h; tag_num
    mov     rsi, [rsp+0E8h+tag_table]; tag_table
    call    exif_get_tagname_debug
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x_2; "Process tag(x%04X=%s): Cannot be empty"
    xor     r15d, r15d
    mov     rsi, r12
    mov     edx, 2
    mov     r8d, 9206h
    jmp     loc_496A89
loc_497391:
    mov     edi, 829Dh; tag_num
    mov     rsi, [rsp+0E8h+tag_table]; tag_table
    call    exif_get_tagname_debug
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x_2; "Process tag(x%04X=%s): Cannot be empty"
    xor     r15d, r15d
    mov     rsi, r12
    mov     edx, 2
    mov     r8d, 829Dh
    jmp     loc_496A89
loc_4973C7:
    mov     edi, 0A210h; tag_num
    mov     rsi, [rsp+0E8h+tag_table]; tag_table
    call    exif_get_tagname_debug
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x_2; "Process tag(x%04X=%s): Cannot be empty"
    xor     r15d, r15d
    mov     rsi, r12
    mov     edx, 2
    mov     r8d, 0A210h
    jmp     loc_496A89
loc_4973FD:
    mov     edi, 0A002h; tag_num
    mov     rsi, [rsp+0E8h+tag_table]; tag_table
    call    exif_get_tagname_debug
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x_2; "Process tag(x%04X=%s): Cannot be empty"
    xor     r15d, r15d
    mov     rsi, r12
    mov     edx, 2
    mov     r8d, 0A002h
    jmp     loc_496A89
loc_497433:
    mov     edi, 0A20Eh; tag_num
    mov     rsi, [rsp+0E8h+tag_table]; tag_table
    call    exif_get_tagname_debug
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x_2; "Process tag(x%04X=%s): Cannot be empty"
    xor     r15d, r15d
    mov     rsi, r12
    mov     edx, 2
    mov     r8d, 0A20Eh
    jmp     loc_496A89
loc_497469:
    mov     r13d, 7
    mov     ecx, 84h
    jmp     short loc_497481
loc_497476:
    mov     r13d, 0Ah
    mov     ecx, 404h
loc_497481:
    mov     rbx, [rsp+0E8h+var_C8]
loc_497486:
    or      eax, ecx
    mov     [r12+118h], eax
loc_497490:
    mov     esi, [r12+70h]; motorola_intel
    mov     rdi, value_ptr; void_value
    call    php_ifd_get32u
    mov     esi, eax; offset
    mov     rdi, rbx; info
    xor     edx, edx; length
    call    exif_offset_info_try_get
    test    Subdir_start, Subdir_start
    jz      short loc_4974E3
    mov     rdi, r12; ImageInfo
    mov     rsi, Subdir_start; dir_start
    mov     rdx, rbx; info
    mov     rcx, [rsp+0E8h+var_B8]; displacement
    mov     r8d, r13d; section_index
    mov     r9d, [rsp+0E8h+tag_num]; tag
    call    exif_process_IFD_in_JPEG
    test    al, al
    mov     r13d, [rsp+0E8h+var_BC]
    jnz     def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
loc_4974D6:
    test    outside, outside
    jnz     short loc_49750C
    xor     r15d, r15d
    jmp     loc_4975E9
loc_4974E3:
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aIllegalIfdPoin; "Illegal IFD Pointer"
    xor     r15d, r15d
    mov     rsi, r12; ImageInfo
    mov     edx, 2; type
    xor     eax, eax
    call    exif_error_docref
    test    outside, outside
    jz      loc_4975E9
loc_49750C:
    mov     rdi, outside; ptr
    call    _efree
    xor     r15d, r15d
    jmp     loc_4975E9
loc_49751C:
    mov     edi, 9201h; tag_num
    mov     rsi, [rsp+0E8h+tag_table]; tag_table
    call    exif_get_tagname_debug
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aProcessTagX04x_2; "Process tag(x%04X=%s): Cannot be empty"
    xor     r15d, r15d
    mov     rsi, r12
    mov     edx, 2
    mov     r8d, 9201h
    jmp     loc_496A89
loc_497552:
    mov     rdi, [r12+0C0h]; ptr
    test    rdi, rdi
    jz      short loc_497564
    call    _efree
loc_497564:
    mov     rdi, value_ptr; s
    mov     rsi, rbp; length
    call    _estrndup
    mov     [r12+0C0h], rax
    jmp     short def_496B4E; jumptable 0000000000496B4E default case, cases 258-272,274-278
    mov     rax, 4024000000000000h; jumptable 0000000000497108 case 3
    jmp     short loc_49759B
    mov     rax, 3FF0000000000000h; jumptable 0000000000497108 case 4
    jmp     short loc_49759B
    mov     rax, 3F50624DD2F1A9FCh; jumptable 0000000000497108 case 5
loc_49759B:
    mov     [r12+48h], rax
    lea     rsi, [rsp+0E8h+buf]; jumptable 0000000000496B4E default case, cases 258-272,274-278
    mov     ebx, [rsp+0E8h+tag_num]
    mov     edi, ebx; tag_num
    mov     rdx, [rsp+0E8h+tag_table]; buf_size
    call    exif_get_tagname_key
    mov     rdi, r12; image_info
    mov     esi, r13d; section_index
    mov     rdx, rax; name
    mov     ecx, ebx; tag
    mov     r8, qword ptr [rsp+0E8h+var_D8]; format
    mov     r9, [rsp+0E8h+var_A0]; length
    push    rbp; value_len
    push    r15; value
    call    exif_iif_add_tag
    add     rsp, 10h
    mov     r15b, 1
    test    r14, r14
    jz      short loc_4975E9
    mov     rdi, r14; ptr
    call    _efree
loc_4975E9:
    mov     eax, r15d
    add     rsp, 0B8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
exif_process_IFD_TAG_impl endp



exif_process_IFD_in_MAKERNOTE proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 58h
    mov     [rsp+88h+var_50], displacement
    mov     [rsp+88h+var_60], info
    mov     ebx, edx
    mov     r13, value_ptr
    mov     [rsp+88h+var_68], ImageInfo
    mov     rbp, [rdi+30h]
    lea     r15, maker_note_array.byte_order
    xor     r14d, r14d
    mov     r12d, 0FEAACh
    test    rbp, rbp
    jnz     short loc_497B97
    nop     dword ptr [rax+rax+00h]
loc_497B80:
    add     i, 1
    add     r15, 28h ; '('
    cmp     i, 14h
    jz      loc_497CC4
    test    rbp, rbp
    jz      short loc_497B80
loc_497B97:
    mov     rdi, [r15-18h]; s1
    mov     rsi, rbp; s2
    call    _strcmp
    test    eax, eax
    jnz     short loc_497B80
    bt      r12, i
    jnb     short loc_497BC5
    movsxd  rdx, dword ptr [r15-8]; n
    cmp     edx, ebx
    jg      short loc_497BC5
    mov     rdi, [r15-10h]; s1
    mov     rsi, value_ptr; s2
    call    _strncmp
    test    eax, eax
    jnz     short loc_497B80
loc_497BC5:
    mov     ebp, [r15-4]
    cmp     ebx, 2
    jl      loc_497C9F
    lea     eax, [value_len-1]
    cmp     ebp, eax
    jge     loc_497C9F
    movsxd  rax, ebp
    mov     r12, [rsp+88h+var_68]
    or      byte ptr [r12+119h], 20h
    mov     [rsp+88h+var_58], rax
    add     rax, value_ptr
    mov     [rsp+88h+value], rax
    mov     esi, [r12+70h]
    mov     eax, 30007h
    bt      rax, i
    mov     [rsp+88h+var_6C], esi
    jnb     short loc_497C17
    mov     esi, [r15]; motorola_intel
    mov     [r12+70h], esi
loc_497C17:
    mov     rdi, [rsp+88h+value]; value
    call    php_ifd_get16u
    mov     r8d, eax
    shl     eax, 2
    lea     r9d, [rax+rax*2]
    or      r9d, 2
    cmp     r9d, ebx
    jle     short loc_497C75
    lea     rcx, aPotentiallyInv; "Potentially invalid endianess, trying a"...
    xor     edi, edi; docref
    mov     rsi, r12; ImageInfo
    mov     edx, 8; type
    xor     eax, eax
    call    exif_error_docref
    xor     esi, esi
    cmp     dword ptr [r12+70h], 0
    setz    sil; motorola_intel
    mov     [r12+70h], esi
    mov     rdi, [rsp+88h+value]; value
    call    php_ifd_get16u
    mov     r8d, eax
    shl     eax, 2
    lea     r9d, [rax+rax*2]
    or      r9d, 2
loc_497C75:
    cmp     r9d, ebx
    jle     short loc_497CD9
    mov     dword ptr [rsp+88h+tag_table], ebx
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aIllegalIfdSize_1; "Illegal IFD size: 2 + 0x%04X*12 = 0x%04"...
    xor     r15d, r15d
    mov     rsi, r12; ImageInfo
    mov     edx, 2; type
    xor     eax, eax
    call    exif_error_docref
    jmp     short loc_497CC7
loc_497C9F:
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aIfdDataTooShor; "IFD data too short: 0x%04X offset 0x%04"...
    mov     rsi, [rsp+88h+var_68]; ImageInfo
    mov     edx, 2; type
    mov     r8d, ebx
    mov     r9d, ebp
    xor     eax, eax
    call    exif_error_docref
loc_497CC4:
    mov     r15b, 1
loc_497CC7:
    mov     eax, r15d
    add     rsp, 58h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_497CD9:
    mov     eax, ebx
    sub     eax, r9d
    cmp     ebp, eax
    jle     short loc_497D0F
    movsxd  NumDirEntries, r9d
    add     r8, [rsp+88h+var_58]
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aIllegalIfdSize_2; "Illegal IFD size: 0x%04X > 0x%04X"
    xor     r15d, r15d
    mov     rsi, r12; ImageInfo
    mov     edx, 2; type
    mov     r9d, ebx
    xor     eax, eax
    call    exif_error_docref
    jmp     short loc_497CC7
loc_497D0F:
    cmp     i, 0Fh
    jz      short loc_497D1B
    cmp     i, 2
    jnz     short loc_497D39
loc_497D1B:
    movsxd  rcx, ebx; valid_length
    lea     rdi, [rsp+88h+var_48]; info
    mov     [rsp+88h+var_60], rdi
    mov     rsi, value_ptr; offset_base
    mov     rdx, value_ptr; valid_start
    mov     ebx, r8d
    call    exif_offset_info_init
    mov     r8d, ebx
loc_497D39:
    test    r8d, r8d
    mov     value_ptr, [rsp+88h+var_50]
    jle     short loc_497D91
    mov     i, [r15-20h]
    mov     ebx, r8d
    xor     ebp, ebp
    xor     r15d, r15d
    nop
loc_497D50:
    mov     eax, ebp
    and     eax, 0FFFFFFFCh
    mov     rcx, [rsp+88h+value]
    lea     rsi, [rcx+rax]
    add     rsi, 2; dir_entry
    mov     [rsp+88h+tag_table], r14; tag_table
    mov     rdi, r12; ImageInfo
    mov     rdx, [rsp+88h+var_60]; info
    mov     rcx, r13; displacement
    mov     r8d, 0Dh; section_index
    xor     r9d, r9d; ReadNextIFD
    call    exif_process_IFD_TAG
    test    al, al
    jz      loc_497CC7
    add     rbp, 0Ch
    add     rbx, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_497D50
loc_497D91:
    mov     eax, [rsp+88h+var_6C]
    mov     [r12+70h], eax
    jmp     loc_497CC4
exif_process_IFD_in_MAKERNOTE endp

