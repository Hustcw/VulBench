wav_write_header proc
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    mov     ebx, esi
    mov     r15, psf
    call    psf_ftell
    mov     r14, rax
    mov     r12, [psf+1E20h]
    test    ebx, ebx
    jz      short loc_421C8B
    mov     rdi, psf; psf
    call    psf_get_filelen
    mov     [psf+1E08h], rax
    mov     rcx, [psf+1E20h]
    mov     rdx, [psf+1E30h]
    sub     rax, rcx
    mov     [psf+1E28h], rax
    test    rdx, rdx
    jz      loc_422097
    sub     rdx, rcx
    mov     [psf+1E28h], rdx
loc_421C8B:
    mov     rax, [psf+1B28h]
    mov     byte ptr [rax], 0
    mov     qword ptr [psf+1B30h], 0
    mov     rdi, psf; psf
    xor     esi, esi; offset
    xor     edx, edx; whence
    call    psf_fseek
    mov     rax, [psf+1E08h]
    cmp     rax, 8
    lea     rcx, [rax-8]
    mov     eax, 8
    cmovl   rcx, rax
    cmp     dword ptr [psf+1D7Ch], 10000000h
    jnz     short loc_421CE0
    mov     esi, offset aEtm8_0; "etm8"
    mov     rdi, psf
    mov     edx, 46464952h
    jmp     short loc_421CED
loc_421CE0:
    mov     esi, offset aEtm8; "Etm8"
    mov     rdi, psf; psf
    mov     edx, 58464952h
loc_421CED:
    xor     eax, eax
    call    psf_binheader_writef
    mov     esi, (offset aEo2mm+3); format
    mov     rdi, psf; psf
    mov     edx, 45564157h
    mov     ecx, 20746D66h
    xor     eax, eax
    call    psf_binheader_writef
    mov     ecx, 0FFF0000h
    and     ecx, [psf+1DB8h]
    cmp     ecx, 130000h
    jz      loc_421FE1
    mov     eax, 12h
    cmp     ecx, 10000h
    jnz     loc_422117
    mov     rdi, psf; psf
    call    wav_write_fmt_chunk
    test    eax, eax
    jnz     loc_422117
loc_421D46:
    test    byte ptr [psf+1D69h], 4
    jz      short loc_421D5D
    mov     rdi, psf; psf
    mov     esi, 400h; location
    call    wavlike_write_strings
loc_421D5D:
    mov     rax, [psf+1DD0h]
    test    rax, rax
    jz      short loc_421D76
    cmp     dword ptr [rax], 2Ah ; '*'
    jnz     short loc_421D76
    mov     rdi, psf; psf
    call    wavlike_write_peak_chunk
loc_421D76:
    cmp     qword ptr [psf+1DF0h], 0
    jz      short loc_421D88
    mov     rdi, psf; psf
    call    wavlike_write_bext_chunk
loc_421D88:
    cmp     qword ptr [psf+1DF8h], 0
    jz      short loc_421D9A
    mov     rdi, psf; psf
    call    wavlike_write_cart_chunk
loc_421D9A:
    mov     rax, [psf+1DD8h]
    test    rax, rax
    jz      loc_421E3E
    mov     r8d, [rax]
    lea     eax, ds:0[r8*8]
    lea     ecx, [rax+rax*2]
    or      ecx, 4
    mov     esi, offset aEm44_0; "em44"
    mov     rdi, psf; psf
    mov     edx, 20657563h
    xor     eax, eax
    call    psf_binheader_writef
    mov     rax, [psf+1DD8h]
    cmp     dword ptr [rax], 0
    jz      short loc_421E3E
    mov     ebx, 18h
    xor     r13d, r13d
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax]
loc_421DF0:
    mov     edx, [rax+rbx-14h]
    mov     ecx, [rax+rbx-10h]
    mov     r8d, [rax+rbx-0Ch]
    mov     r9d, [rax+rbx-8]
    mov     r10d, [rax+rbx-4]
    mov     r11d, [rax+rbx]
    mov     esi, offset aE44m444; "e44m444"
    mov     rdi, psf; psf
    mov     eax, 0
    push    r11
    push    r10
    call    psf_binheader_writef
    add     rsp, 10h
    add     k, 1
    mov     rax, [psf+1DD8h]
    mov     ecx, [rax]
    add     rbx, 118h
    cmp     r13, rcx
    jb      short loc_421DF0
loc_421E3E:
    mov     rax, [psf+1DE8h]
    test    rax, rax
    jz      loc_421FF6
    mov     eax, [rax+0Ch]
    lea     eax, [rax+rax*2]
    lea     ecx, ds:24h[rax*8]
    mov     esi, (offset aEm4+1); format
    mov     rdi, psf; psf
    mov     edx, 6C706D73h
    xor     eax, eax
    call    psf_binheader_writef
    mov     esi, (offset a42244+3); format
    mov     rdi, psf; psf
    xor     edx, edx
    xor     ecx, ecx
    xor     eax, eax
    call    psf_binheader_writef
    cvtsi2sd xmm0, dword ptr [psf+1DB0h]
    movsd   xmm1, cs:qword_46E4D8
    divsd   xmm1, xmm0
    cvttsd2si edx, xmm1
    mov     rax, [psf+1DE8h]
    movsx   ecx, byte ptr [rax+4]
    mov     esi, (offset a42244+3); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_writef
    mov     rax, [psf+1DE8h]
    movsx   eax, byte ptr [rax+5]
    xorps   xmm0, xmm0
    cvtsi2sd xmm0, eax
    mulsd   xmm0, cs:qword_46E4E0
    addsd   xmm0, cs:qword_46E4E8
    cvttsd2si rdx, xmm0
    mov     esi, (offset aScalauto4+0Ch); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_writef
    mov     esi, (offset a42244+3); format
    mov     rdi, psf; psf
    xor     edx, edx
    xor     ecx, ecx
    xor     eax, eax
    call    psf_binheader_writef
    mov     rax, [psf+1DE8h]
    mov     edx, [rax+0Ch]
    mov     esi, (offset a42244+3); format
    mov     rdi, psf; psf
    xor     ecx, ecx
    xor     eax, eax
    call    psf_binheader_writef
    mov     rax, [psf+1DE8h]
    cmp     dword ptr [rax+0Ch], 0
    jle     loc_421FF6
    xor     ebx, ebx
    xor     r13d, r13d
    jmp     short loc_421FAC
loc_421F40:
    mov     ecx, 2
loc_421F45:
    mov     esi, (offset a42244+3); format
    mov     rdi, psf; psf
    mov     edx, r13d
    xor     eax, eax
    call    psf_binheader_writef
    mov     rax, [psf+1DE8h]
    mov     edx, [rax+rbx+14h]
    mov     ecx, [rax+rbx+18h]
    add     ecx, 0FFFFFFFFh
    mov     esi, (offset a42244+3); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_writef
    mov     rax, [psf+1DE8h]
    mov     ecx, [rax+rbx+1Ch]
    mov     esi, (offset a42244+3); format
    mov     rdi, psf; psf
    xor     edx, edx
    xor     eax, eax
    call    psf_binheader_writef
    add     tmp, 1
    mov     rax, [psf+1DE8h]
    movsxd  rcx, dword ptr [rax+0Ch]
    add     rbx, 10h
    cmp     r13, rcx
    jge     short loc_421FF6
loc_421FAC:
    mov     eax, [rax+rbx+10h]
    mov     ecx, 0
    cmp     eax, 321h
    jz      short loc_421F45
    cmp     eax, 322h
    jz      loc_421F40
    mov     ecx, 1
    cmp     eax, 323h
    jz      loc_421F45
    mov     ecx, 20h ; ' '
    jmp     loc_421F45
loc_421FE1:
    mov     rdi, psf; psf
    call    wavex_write_fmt_chunk
    test    eax, eax
    jnz     loc_422117
    jmp     loc_421D46
loc_421FF6:
    cmp     dword ptr [psf+1F84h], 0
    jz      short loc_422008
    mov     rdi, psf; psf
    call    wavlike_write_custom_chunks
loc_422008:
    mov     rax, [psf+1B30h]
    add     rax, 10h
    mov     rcx, [psf+1E20h]
    sub     rcx, rax
    jle     short loc_422036
    mov     esi, offset aM4z; "m4z"
    mov     rdi, psf; psf
    mov     edx, 20444150h
    mov     r8, k
    xor     eax, eax
    call    psf_binheader_writef
loc_422036:
    mov     rcx, [psf+1E28h]
    mov     esi, (offset aEtm8+1); format
    mov     rdi, psf; psf
    mov     edx, 61746164h
    xor     eax, eax
    call    psf_binheader_writef
    mov     rdi, [psf+1B28h]; ptr
    mov     rsi, [psf+1B30h]; bytes
    mov     edx, 1; items
    mov     rcx, psf; psf
    call    psf_fwrite
    mov     eax, [psf+1D78h]
    test    eax, eax
    jnz     loc_422117
    cmp     current, r12
    jle     short loc_4220D4
    mov     rax, [psf+1E20h]
    cmp     rax, [psf+1B30h]
    jnz     short loc_4220F8
    test    current, current
    jg      short loc_4220E2
    jmp     short loc_4220EF
loc_422097:
    movsxd  rax, dword ptr [psf+1E3Ch]
    test    rax, rax
    jle     loc_421C8B
    cmp     dword ptr [psf+1DC0h], 1
    jnz     loc_421C8B
    imul    rax, [psf+1DA8h]
    movsxd  rcx, dword ptr [psf+1DB4h]
    imul    rcx, rax
    mov     [psf+1E28h], rcx
    jmp     loc_421C8B
loc_4220D4:
    mov     current, [psf+1B30h]
    mov     [psf+1E20h], r14
loc_4220E2:
    mov     rdi, psf; psf
    mov     rsi, r14; offset
    xor     edx, edx; whence
    call    psf_fseek
loc_4220EF:
    mov     eax, [psf+1D78h]
    jmp     short loc_422117
loc_4220F8:
    mov     esi, offset aOooopsHasDataP; "Oooops : has_data && psf->dataoffset !="...
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     dword ptr [psf+1D78h], 1Dh
    mov     eax, 1Dh
loc_422117:
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     psf
    retn
wav_write_header endp

