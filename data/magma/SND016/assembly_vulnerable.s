double64_init proc
    push    rbp
    push    rbx
    push    rax
    mov     rbx, psf
    mov     edx, [rdi+1DB4h]
    test    edx, edx
    jle     short loc_435E7B
    mov     rdi, psf; psf
    call    double64_get_capability
    mov     edx, [psf+1DB4h]
    shl     edx, 3
    mov     [psf+1E38h], edx
    mov     esi, [psf+90Ch]
    cmp     esi, 10h
    jz      short loc_435E94
    cmp     esi, 30h ; '0'
    jz      short loc_435E94
    cmp     esi, 20h ; ' '
    jnz     loc_43606B
    mov     ecx, [psf+1D7Ch]
    jmp     loc_435F7D
loc_435E7B:
    mov     esi, offset aDouble64InitIn; "double64_init : internal error : channe"...
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     ecx, 1Dh
    jmp     loc_4360AB
loc_435E94:
    mov     ecx, [psf+1D7Ch]
    lea     ebp, [rcx+rax]
    mov     r8d, offset host_read_d
    mov     r9d, offset host_read_d2f
    mov     r11d, offset host_read_d2i
    mov     edi, offset host_read_d2s
    xor     r10d, r10d
    cmp     ebp, 20000022h
    jg      short loc_435EDC
    cmp     ebp, 10000044h
    jg      short loc_435EF6
    cmp     ebp, 10000023h
    jz      short loc_435F4E
    cmp     ebp, 10000034h
    jz      short loc_435F48
    jmp     loc_435F71
loc_435EDC:
    cmp     ebp, 20000044h
    jg      short loc_435F08
    cmp     ebp, 20000023h
    jz      short loc_435F48
    cmp     ebp, 20000034h
    jz      short loc_435F4E
    jmp     short loc_435F71
loc_435EF6:
    cmp     ebp, 10000045h
    jz      short loc_435F18
    cmp     ebp, 10000056h
    jz      short loc_435F31
    jmp     short loc_435F71
loc_435F08:
    cmp     ebp, 20000045h
    jz      short loc_435F31
    cmp     ebp, 20000056h
    jnz     short loc_435F71
loc_435F18:
    mov     r8d, offset replace_read_d
    mov     r9d, offset replace_read_d2f
    mov     r11d, offset replace_read_d2i
    mov     edi, offset replace_read_d2s
    jmp     short loc_435F4E
loc_435F31:
    mov     r8d, offset replace_read_d
    mov     r9d, offset replace_read_d2f
    mov     r11d, offset replace_read_d2i
    mov     edi, offset replace_read_d2s
loc_435F48:
    mov     r10d, 1
loc_435F4E:
    mov     [psf+1D80h], r10d
    mov     [psf+1EB8h], rdi
    mov     [psf+1EC0h], r11
    mov     [psf+1EC8h], r9
    mov     [psf+1ED0h], r8
loc_435F71:
    or      esi, 10h
    cmp     esi, 30h ; '0'
    jnz     loc_43606B
loc_435F7D:
    add     ecx, eax
    cmp     ecx, 20000022h
    jg      short loc_435FA4
    cmp     ecx, 10000044h
    jg      short loc_435FCC
    cmp     ecx, 10000023h
    jz      short loc_435FC0
    cmp     ecx, 10000034h
    jz      short loc_435FFD
    jmp     loc_43606B
loc_435FA4:
    cmp     ecx, 20000044h
    jg      short loc_435FE1
    cmp     ecx, 20000023h
    jz      short loc_435FFD
    cmp     ecx, 20000034h
    jnz     loc_43606B
loc_435FC0:
    mov     dword ptr [psf+1D80h], 0
    jmp     short loc_436007
loc_435FCC:
    cmp     ecx, 10000045h
    jz      short loc_435FF1
    cmp     ecx, 10000056h
    jz      short loc_436035
    jmp     loc_43606B
loc_435FE1:
    cmp     ecx, 20000045h
    jz      short loc_436035
    cmp     ecx, 20000056h
    jnz     short loc_43606B
loc_435FF1:
    mov     dword ptr [psf+1D80h], 0
    jmp     short loc_43603F
loc_435FFD:
    mov     dword ptr [psf+1D80h], 1
loc_436007:
    mov     qword ptr [psf+1ED8h], offset host_write_s2d
    mov     qword ptr [psf+1EE0h], offset host_write_i2d
    mov     qword ptr [psf+1EE8h], offset host_write_f2d
    mov     qword ptr [psf+1EF0h], offset host_write_d
    jmp     short loc_43606B
loc_436035:
    mov     dword ptr [psf+1D80h], 1
loc_43603F:
    mov     qword ptr [psf+1ED8h], offset replace_write_s2d
    mov     qword ptr [psf+1EE0h], offset replace_write_i2d
    mov     qword ptr [psf+1EE8h], offset replace_write_f2d
    mov     qword ptr [psf+1EF0h], offset replace_write_d
loc_43606B:
    mov     rax, [psf+1E08h]
    mov     rsi, [psf+1E20h]
    xor     ecx, ecx
    cmp     rax, rsi
    jle     short loc_436093
    mov     rdi, [psf+1E30h]
    test    rdi, rdi
    cmovg   rax, rdi
    sub     rax, rsi
    jmp     short loc_436095
loc_436093:
    xor     eax, eax
loc_436095:
    mov     [psf+1E28h], rax
    movsxd  rsi, edx
    cqo
    idiv    rsi
    mov     [psf+1DA8h], rax
loc_4360AB:
    mov     eax, ecx
    add     rsp, 8
    pop     psf
    pop     rbp
    retn
double64_init endp

