php_ifd_get16u proc
    xor     eax, eax
    xor     ecx, ecx
    test    esi, esi
    setz    al
    setnz   cl
    movzx   edx, byte ptr [value+rax]
    shl     edx, 8
    movzx   eax, byte ptr [value+rcx]
    or      eax, edx
    retn
php_ifd_get16u endp



exif_process_IFD_in_MAKERNOTE proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 48h
    mov     [rsp+78h+var_50], displacement
    mov     [rsp+78h+var_58], info
    mov     ebp, edx
    mov     r14, value_ptr
    mov     [rsp+78h+var_68], ImageInfo
    mov     rbx, [rdi+30h]
    lea     r15, maker_note_array.byte_order
    xor     r12d, r12d
    mov     r13d, 0FEAACh
    test    rbx, rbx
    jnz     short loc_497B27
    nop     dword ptr [rax+rax+00h]
loc_497B10:
    add     i, 1
    add     r15, 28h ; '('
    cmp     i, 14h
    jz      loc_497CC3
    test    rbx, rbx
    jz      short loc_497B10
loc_497B27:
    mov     rdi, [r15-18h]; s1
    mov     rsi, rbx; s2
    call    _strcmp
    test    eax, eax
    jnz     short loc_497B10
    bt      r13, i
    jnb     short loc_497B55
    movsxd  rdx, dword ptr [r15-8]; n
    cmp     edx, ebp
    jg      short loc_497B55
    mov     rdi, [r15-10h]; s1
    mov     rsi, value_ptr; s2
    call    _strncmp
    test    eax, eax
    jnz     short loc_497B10
loc_497B55:
    movsxd  r13, dword ptr [r15-4]
    cmp     r13d, ebp
    jge     loc_497C19
    mov     rax, [rsp+78h+var_68]
    or      byte ptr [rax+119h], 20h
    add     r13, value_ptr
    mov     esi, [rax+70h]
    mov     eax, 30007h
    bt      rax, i
    mov     [rsp+78h+var_5C], esi
    jnb     short loc_497B8E
    mov     esi, [r15]; motorola_intel
    mov     rax, [rsp+78h+var_68]
    mov     [rax+70h], esi
loc_497B8E:
    mov     rdi, dir_start; value
    call    php_ifd_get16u
    mov     ebx, eax
    shl     eax, 2
    lea     r9d, [rax+rax*2]
    or      r9d, 2
    cmp     r9d, ebp
    jle     short loc_497BE7
    lea     rcx, aPotentiallyInv; "Potentially invalid endianess, trying a"...
    xor     edi, edi; docref
    mov     NumDirEntries, [rsp+78h+var_68]
    mov     rsi, rbx; ImageInfo
    mov     edx, 8; type
    xor     eax, eax
    call    exif_error_docref
    xor     esi, esi
    cmp     dword ptr [rbx+70h], 0
    setz    sil; motorola_intel
    mov     [rbx+70h], esi
    mov     rdi, dir_start; value
    call    php_ifd_get16u
    mov     ebx, eax
    shl     eax, 2
    lea     r9d, [rax+rax*2]
    or      r9d, 2
loc_497BE7:
    cmp     r9d, ebp
    jle     short loc_497C43
    mov     dword ptr [rsp+78h+tag_table], ebp
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aIllegalIfdSize_1; "Illegal IFD size: 2 + 0x%04X*12 = 0x%04"...
    xor     r15d, r15d
    mov     rsi, [rsp+78h+var_68]; ImageInfo
    mov     edx, 2; type
    mov     r8d, ebx
    xor     eax, eax
    call    exif_error_docref
    jmp     loc_497CC6
loc_497C19:
    lea     rdi, aExifReadDataEr_0; "exif_read_data#error_ifd"
    lea     rcx, aIfdDataTooShor; "IFD data too short: 0x%04X offset 0x%04"...
    mov     rsi, [rsp+78h+var_68]; ImageInfo
    mov     edx, 2; type
    mov     r8d, ebp
    mov     r9d, r13d
    xor     eax, eax
    call    exif_error_docref
    jmp     loc_497CC3
loc_497C43:
    cmp     i, 0Fh
    jz      short loc_497C4F
    cmp     i, 2
    jnz     short loc_497C67
loc_497C4F:
    movsxd  rcx, ebp; valid_length
    lea     rdi, [rsp+78h+var_48]; info
    mov     [rsp+78h+var_58], rdi
    mov     rsi, value_ptr; offset_base
    mov     rdx, value_ptr; valid_start
    call    exif_offset_info_init
loc_497C67:
    test    ebx, ebx
    mov     i, [rsp+78h+var_68]
    jle     short loc_497CBA
    mov     value_ptr, [r15-20h]
    mov     ebx, ebx
    xor     ebp, ebp
    xor     r15d, r15d
    nop     dword ptr [rax+rax+00h]
loc_497C80:
    mov     eax, ebp
    and     eax, 0FFFFFFFCh
    lea     rsi, [rax+dir_start]
    add     rsi, 2; dir_entry
    mov     [rsp+78h+tag_table], r14; tag_table
    mov     rdi, r12; ImageInfo
    mov     rdx, [rsp+78h+var_58]; info
    mov     rcx, [rsp+78h+var_50]; displacement
    mov     r8d, 0Dh; section_index
    xor     r9d, r9d; ReadNextIFD
    call    exif_process_IFD_TAG
    test    al, al
    jz      short loc_497CC6
    add     rbp, 0Ch
    add     rbx, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_497C80
loc_497CBA:
    mov     eax, [rsp+78h+var_5C]
    mov     [r12+70h], eax
loc_497CC3:
    mov     r15b, 1
loc_497CC6:
    mov     eax, r15d
    add     rsp, 48h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
exif_process_IFD_in_MAKERNOTE endp

