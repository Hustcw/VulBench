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

