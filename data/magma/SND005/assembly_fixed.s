aiff_caf_of_channel_layout_tag proc
    movzx   eax, di
    cmp     eax, 8
    jbe     short loc_43128B
    xor     eax, eax
    retn
loc_43128B:
    mov     ecx, eax
    shl     rcx, 4
    mov     channels, qword ptr ds:map.map[rcx]
    mov     ecx, [rcx+471A58h]
    xor     edx, edx
loc_4312A0:
    cmp     [curr_map], edi
    jz      short locret_4312B3
    add     rdx, 1
    add     curr_map, 18h
    cmp     rdx, rcx
    jb      short loc_4312A0
    xor     eax, eax
locret_4312B3:
    retn
aiff_caf_of_channel_layout_tag endp



aiff_read_chanmap proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     r15d, esi
    mov     rbx, psf
    xor     r14d, r14d
    lea     rdx, [rsp+48h+tag]
    lea     rcx, [rsp+48h+var_34]
    lea     r8, [rsp+48h+var_38]
    mov     esi, (offset a444444+3); format
    xor     eax, eax
    call    psf_binheader_readf
    mov     r12d, eax
    mov     edi, [rsp+48h+tag]; tag
    call    aiff_caf_of_channel_layout_tag
    test    rax, rax
    jz      loc_40DD12
    mov     r13, rax
    mov     edx, [rsp+48h+tag]
    xor     r14d, r14d
    mov     esi, offset aTagX; "  Tag    : %x\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     rdx, [map_info+10h]
    mov     esi, offset aLayoutS; "  Layout : %s\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    cmp     r12d, r15d
    jnb     short loc_40DCBD
    sub     r15d, r12d
    mov     esi, (offset aE2j+2); format
    mov     rdi, psf; psf
    mov     edx, r15d
    xor     eax, eax
    call    psf_binheader_readf
loc_40DCBD:
    cmp     qword ptr [map_info+8], 0
    jz      short loc_40DD12
    mov     eax, [psf+1DB4h]
    movzx   ecx, word ptr [rsp+48h+tag]
    cmp     eax, ecx
    cmovle  ecx, eax
    movsxd  rbp, ecx
    shl     rbp, 2
    mov     rdi, [psf+1E00h]; ptr
    call    _free
    mov     rdi, chanmap_size; size
    call    _malloc
    mov     [psf+1E00h], rax
    test    rax, rax
    jz      short loc_40DD0C
    mov     rsi, [map_info+8]; src
    mov     rdi, rax; dest
    mov     rdx, chanmap_size; n
    call    _memcpy
    jmp     short loc_40DD12
loc_40DD0C:
    mov     r14d, 11h
loc_40DD12:
    mov     eax, r14d
    add     rsp, 18h
    pop     psf
    pop     bytesread
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
aiff_read_chanmap endp

