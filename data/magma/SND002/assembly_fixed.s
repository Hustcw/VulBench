sd2_parse_rsrc_fork proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 58h
    mov     r14, psf
    mov     ebp, 1
    mov     esi, 1; on_off
    call    psf_use_rsrc
    xorps   xmm0, xmm0
    movaps  xmmword ptr [rsp+88h+prsrc.str_count], xmm0
    movaps  xmmword ptr [rsp+88h+prsrc.type_count], xmm0
    movaps  xmmword ptr [rsp+88h+prsrc.data_offset], xmm0
    movaps  xmmword ptr [rsp+88h+prsrc.rsrc_data], xmm0
    mov     qword ptr [rsp+88h+prsrc.channels], 0
    mov     rdi, psf; psf
    call    psf_get_filelen
    mov     r15, rax
    mov     [rsp+88h+prsrc.rsrc_len], r15d
    mov     esi, offset aResourceLength; "Resource length : %d (0x%04X)\n"
    mov     rdi, psf; psf
    mov     edx, r15d
    mov     ecx, r15d
    xor     eax, eax
    call    psf_log_printf
    movsxd  rbx, r15d
    cmp     [psf+1B40h], rbx
    jge     short loc_418858
    mov     edi, 1; nmemb
    mov     rsi, rbx; size
    call    _calloc
    mov     rdi, rax
    mov     [rsp+88h+prsrc.rsrc_data], rax
    jmp     short loc_418866
loc_418858:
    mov     rdi, [psf+1B28h]; ptr
    mov     [rsp+88h+prsrc.rsrc_data], rdi
    xor     ebp, ebp
loc_418866:
    mov     [rsp+88h+var_7C], ebp
    mov     [rsp+88h+prsrc.need_to_free_rsrc_data], ebp
    mov     edx, 1; items
    mov     rsi, rbx; bytes
    mov     rcx, psf; psf
    call    psf_fread
    movsxd  rax, r15d
    mov     [psf+1B38h], rax
    mov     [psf+1B30h], rax
    lea     rbx, [rsp+88h+prsrc]
    mov     rdi, rbx; prsrc
    xor     esi, esi; offset
    call    read_rsrc_int
    mov     ebp, eax
    mov     [rsp+88h+prsrc.data_offset], eax
    mov     rdi, rbx; prsrc
    mov     esi, 4; offset
    call    read_rsrc_int
    mov     r12d, eax
    mov     [rsp+88h+prsrc.map_offset], eax
    mov     rdi, rbx; prsrc
    mov     esi, 8; offset
    call    read_rsrc_int
    mov     r13d, eax
    mov     [rsp+88h+prsrc.data_length], eax
    mov     rdi, rbx; prsrc
    mov     esi, 0Ch; offset
    call    read_rsrc_int
    mov     ebx, eax
    mov     [rsp+88h+prsrc.map_length], eax
    cmp     ebp, 51607h
    jnz     short loc_41895A
    cmp     r12d, 20000h
    jnz     short loc_41895A
    mov     esi, offset aTryingOffsetOf; "Trying offset of 0x52 bytes.\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    lea     rbx, [rsp+88h+prsrc]
    mov     rdi, rbx; prsrc
    mov     esi, 52h ; 'R'; offset
    call    read_rsrc_int
    mov     ebp, eax
    add     ebp, 52h ; 'R'
    mov     [rsp+88h+prsrc.data_offset], ebp
    mov     rdi, rbx; prsrc
    mov     esi, 56h ; 'V'; offset
    call    read_rsrc_int
    mov     r12d, eax
    add     r12d, 52h ; 'R'
    mov     [rsp+88h+prsrc.map_offset], r12d
    mov     rdi, rbx; prsrc
    mov     esi, 5Ah ; 'Z'; offset
    call    read_rsrc_int
    mov     r13d, eax
    mov     [rsp+88h+prsrc.data_length], eax
    mov     rdi, rbx; prsrc
    mov     esi, 5Eh ; '^'; offset
    call    read_rsrc_int
    mov     ebx, eax
    mov     [rsp+88h+prsrc.map_length], eax
loc_41895A:
    mov     esi, offset aDataOffset0x04; "  data offset : 0x%04X\n  map  offset :"...
    mov     rdi, psf; psf
    mov     edx, ebp
    mov     ecx, r12d
    mov     r8d, r13d
    mov     r9d, ebx
    xor     eax, eax
    call    psf_log_printf
    cmp     ebp, r15d
    jle     short loc_418996
    mov     esi, offset aErrorRsrcDataO; "Error : rsrc.data_offset (%d, 0x%x) > l"...
    mov     rdi, psf; psf
    mov     edx, ebp
    mov     ecx, ebp
    xor     eax, eax
    call    psf_log_printf
    mov     ebx, 95h
    jmp     loc_418AF7
loc_418996:
    cmp     r12d, r15d
    jle     short loc_4189B4
    mov     esi, offset aErrorRsrcMapOf; "Error : rsrc.map_offset > len\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     ebx, 96h
    jmp     loc_418AF7
loc_4189B4:
    cmp     r13d, r15d
    jle     short loc_4189D2
    mov     esi, offset aErrorRsrcDataL; "Error : rsrc.data_length > len\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     ebx, 97h
    jmp     loc_418AF7
loc_4189D2:
    cmp     ebx, r15d
    jle     short loc_4189F0
    mov     esi, offset aErrorRsrcMapLe; "Error : rsrc.map_length > len\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     ebx, 98h
    jmp     loc_418AF7
loc_4189F0:
    add     r13d, ebp
    cmp     r13d, r12d
    jnz     short loc_418A34
    add     ebx, r12d
    cmp     ebx, r15d
    jnz     short loc_418A34
    lea     ebx, [r12+1Ch]
    cmp     ebx, r15d
    jge     short loc_418A48
    lea     esi, [r12+1Ah]; offset
    lea     rdi, [rsp+88h+prsrc]; prsrc
    call    read_rsrc_short
    add     eax, r12d
    mov     [rsp+88h+prsrc.string_offset], eax
    cmp     eax, r15d
    jle     short loc_418A62
    mov     esi, offset aBadStringOffse; "Bad string offset (%d).\n"
    mov     rdi, psf
    mov     edx, eax
    jmp     loc_418AEB
loc_418A34:
    mov     esi, offset aErrorThisDoesN; "Error : This does not look like a MacOS"...
loc_418A39:
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_418AF2
loc_418A48:
    mov     esi, offset aBadMapOffsetD2; "Bad map offset (%d + 28 > %d).\n"
    mov     rdi, psf; psf
    mov     edx, r12d
    mov     ecx, r15d
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_418AF2
loc_418A62:
    lea     r13d, [r12+1Eh]
    mov     [rsp+88h+prsrc.type_offset], r13d
    lea     rdi, [rsp+88h+prsrc]; prsrc
    mov     esi, ebx; offset
    call    read_rsrc_short
    lea     ebp, [rax+1]
    mov     [rsp+88h+prsrc.type_count], ebp
    test    eax, eax
    js      short loc_418AD9
    lea     edx, ds:0[rbp*8]
    add     edx, r13d
    mov     [rsp+88h+prsrc.item_offset], edx
    js      short loc_418AE3
    cmp     edx, r15d
    jg      short loc_418AE3
    mov     [rsp+88h+prsrc.str_index], 0FFFFFFFFh
    add     r12d, 22h ; '"'
    xor     ebx, ebx
    lea     r13, [rsp+88h+prsrc]
loc_418AAB:
    lea     esi, [r12-4]; offset
    cmp     esi, r15d
    jg      short loc_418B24
    mov     rdi, r13; prsrc
    call    read_rsrc_marker
    cmp     eax, 20525453h
    jz      short loc_418B37
    add     ebx, 1
    add     r12d, 8
    cmp     ebp, ebx
    jnz     short loc_418AAB
    mov     esi, offset aNoStrResource; "No 'STR ' resource.\n"
    jmp     loc_418A39
loc_418AD9:
    mov     esi, offset aBadTypeCount; "Bad type count.\n"
    jmp     loc_418A39
loc_418AE3:
    mov     esi, offset aBadItemOffsetD; "Bad item offset (%d).\n"
    mov     rdi, psf; psf
loc_418AEB:
    xor     eax, eax
    call    psf_log_printf
loc_418AF2:
    mov     ebx, 99h
loc_418AF7:
    mov     ebp, [rsp+88h+var_7C]
    mov     rdi, psf; psf
    xor     esi, esi; on_off
    call    psf_use_rsrc
    test    ebp, ebp
    jz      short loc_418B13
    mov     rdi, [rsp+88h+prsrc.rsrc_data]; ptr
    call    _free
loc_418B13:
    mov     eax, ebx
    add     rsp, 58h
    pop     error
    pop     r12
    pop     r13
    pop     psf
    pop     r15
    pop     rbp
    retn
loc_418B24:
    xor     ebx, ebx
    mov     esi, offset aBadRsrcMarker; "Bad rsrc marker.\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    jmp     short loc_418AF7
loc_418B37:
    mov     [rsp+88h+prsrc.str_index], ebx
    lea     k, [rsp+88h+prsrc]
    mov     rdi, rbx; prsrc
    mov     esi, r12d; offset
    call    read_rsrc_short
    add     eax, 1
    mov     [rsp+88h+prsrc.str_count], eax
    mov     rdi, psf; psf
    mov     rsi, rbx; rsrc
    call    parse_str_rsrc
    mov     ebx, eax
    mov     ebp, [rsp+88h+prsrc.need_to_free_rsrc_data]
    jmp     short parse_rsrc_fork_cleanup
sd2_parse_rsrc_fork endp



read_rsrc_short proc
    xor     eax, eax
    test    esi, esi
    js      short locret_419092
    movsxd  rdx, esi
    lea     rcx, [rdx+1]
    cmp     ecx, [prsrc+8]
    jge     short locret_419092
    mov     rax, [prsrc]
    movzx   edx, byte ptr [data+rdx]
    shl     edx, 8
    movzx   eax, byte ptr [data+rcx]
    or      eax, edx
locret_419092:
    retn
read_rsrc_short endp

