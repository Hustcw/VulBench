double64_init proc
    push    rbp
    push    rbx
    push    rax
    mov     rbx, psf
    mov     edx, [rdi+1DB4h]
    lea     eax, [rdx-1]
    cmp     eax, 400h
    jb      short loc_435F4F
    mov     esi, offset aDouble64InitIn; "double64_init : internal error : channe"...
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     ecx, 1Dh
    jmp     loc_4361A1
loc_435F4F:
    mov     rdi, psf; psf
    call    double64_get_capability
    mov     edx, [psf+1DB4h]
    shl     edx, 3
    mov     [psf+1E38h], edx
    mov     esi, [psf+90Ch]
    cmp     esi, 10h
    jz      short loc_435F8A
    cmp     esi, 30h ; '0'
    jz      short loc_435F8A
    cmp     esi, 20h ; ' '
    jnz     loc_436161
    mov     ecx, [psf+1D7Ch]
    jmp     loc_436073
loc_435F8A:
    mov     ecx, [psf+1D7Ch]
    lea     ebp, [rcx+rax]
    mov     r8d, offset host_read_d
    mov     r9d, offset host_read_d2f
    mov     r11d, offset host_read_d2i
    mov     edi, offset host_read_d2s
    xor     r10d, r10d
    cmp     ebp, 20000022h
    jg      short loc_435FD2
    cmp     ebp, 10000044h
    jg      short loc_435FEC
    cmp     ebp, 10000023h
    jz      short loc_436044
    cmp     ebp, 10000034h
    jz      short loc_43603E
    jmp     loc_436067
loc_435FD2:
    cmp     ebp, 20000044h
    jg      short loc_435FFE
    cmp     ebp, 20000023h
    jz      short loc_43603E
    cmp     ebp, 20000034h
    jz      short loc_436044
    jmp     short loc_436067
loc_435FEC:
    cmp     ebp, 10000045h
    jz      short loc_43600E
    cmp     ebp, 10000056h
    jz      short loc_436027
    jmp     short loc_436067
loc_435FFE:
    cmp     ebp, 20000045h
    jz      short loc_436027
    cmp     ebp, 20000056h
    jnz     short loc_436067
loc_43600E:
    mov     r8d, offset replace_read_d
    mov     r9d, offset replace_read_d2f
    mov     r11d, offset replace_read_d2i
    mov     edi, offset replace_read_d2s
    jmp     short loc_436044
loc_436027:
    mov     r8d, offset replace_read_d
    mov     r9d, offset replace_read_d2f
    mov     r11d, offset replace_read_d2i
    mov     edi, offset replace_read_d2s
loc_43603E:
    mov     r10d, 1
loc_436044:
    mov     [psf+1D80h], r10d
    mov     [psf+1EB8h], rdi
    mov     [psf+1EC0h], r11
    mov     [psf+1EC8h], r9
    mov     [psf+1ED0h], r8
loc_436067:
    or      esi, 10h
    cmp     esi, 30h ; '0'
    jnz     loc_436161
loc_436073:
    add     ecx, eax
    cmp     ecx, 20000022h
    jg      short loc_43609A
    cmp     ecx, 10000044h
    jg      short loc_4360C2
    cmp     ecx, 10000023h
    jz      short loc_4360B6
    cmp     ecx, 10000034h
    jz      short loc_4360F3
    jmp     loc_436161
loc_43609A:
    cmp     ecx, 20000044h
    jg      short loc_4360D7
    cmp     ecx, 20000023h
    jz      short loc_4360F3
    cmp     ecx, 20000034h
    jnz     loc_436161
loc_4360B6:
    mov     dword ptr [psf+1D80h], 0
    jmp     short loc_4360FD
loc_4360C2:
    cmp     ecx, 10000045h
    jz      short loc_4360E7
    cmp     ecx, 10000056h
    jz      short loc_43612B
    jmp     loc_436161
loc_4360D7:
    cmp     ecx, 20000045h
    jz      short loc_43612B
    cmp     ecx, 20000056h
    jnz     short loc_436161
loc_4360E7:
    mov     dword ptr [psf+1D80h], 0
    jmp     short loc_436135
loc_4360F3:
    mov     dword ptr [psf+1D80h], 1
loc_4360FD:
    mov     qword ptr [psf+1ED8h], offset host_write_s2d
    mov     qword ptr [psf+1EE0h], offset host_write_i2d
    mov     qword ptr [psf+1EE8h], offset host_write_f2d
    mov     qword ptr [psf+1EF0h], offset host_write_d
    jmp     short loc_436161
loc_43612B:
    mov     dword ptr [psf+1D80h], 1
loc_436135:
    mov     qword ptr [psf+1ED8h], offset replace_write_s2d
    mov     qword ptr [psf+1EE0h], offset replace_write_i2d
    mov     qword ptr [psf+1EE8h], offset replace_write_f2d
    mov     qword ptr [psf+1EF0h], offset replace_write_d
loc_436161:
    mov     rax, [psf+1E08h]
    mov     rsi, [psf+1E20h]
    xor     ecx, ecx
    cmp     rax, rsi
    jle     short loc_436189
    mov     rdi, [psf+1E30h]
    test    rdi, rdi
    cmovg   rax, rdi
    sub     rax, rsi
    jmp     short loc_43618B
loc_436189:
    xor     eax, eax
loc_43618B:
    mov     [psf+1E28h], rax
    movsxd  rsi, edx
    cqo
    idiv    rsi
    mov     [psf+1DA8h], rax
loc_4361A1:
    mov     eax, ecx
    add     rsp, 8
    pop     psf
    pop     rbp
    retn
double64_init endp

