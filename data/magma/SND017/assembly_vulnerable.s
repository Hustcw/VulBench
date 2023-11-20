wavlike_read_fmt_chunk proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 238h
    mov     rbp, [psf+1E68h]
    test    wpriv, wpriv
    jz      loc_41DE02
    mov     ebx, esi
    mov     r14, psf
    lea     r15, [wpriv+0Ch]
    mov     edx, 200h; n
    mov     rdi, wav_fmt; s
    xor     esi, esi; c
    call    _memset
    mov     r12d, 41h ; 'A'
    cmp     ebx, 10h
    jl      loc_41E9FB
    mov     [rsp+268h+var_24C], ebx
    lea     r12, [wpriv+0Eh]
    lea     r8, [wpriv+10h]
    lea     r9, [wpriv+14h]
    lea     rbx, [wpriv+18h]
    lea     r13, [wpriv+1Ah]
    mov     esi, offset a224422; "224422"
    mov     rdi, psf; psf
    mov     rdx, wav_fmt
    mov     rcx, r12
    mov     [rsp+268h+var_240], r8
    mov     [rsp+268h+var_248], r9
    mov     eax, 0
    push    r13
    mov     [rsp+270h+var_258], rbx
    push    rbx
    call    psf_binheader_readf
    add     rsp, 10h
    mov     [rsp+268h+var_25C], eax
    movzx   ebx, word ptr [wpriv+0Ch]
    mov     edi, ebx; k
    call    wavlike_format_str
    mov     esi, offset aFormat0xXS; "  Format        : 0x%X => %s\n"
    mov     rdi, psf; psf
    mov     edx, ebx
    mov     rcx, rax
    xor     eax, eax
    call    psf_log_printf
    movzx   edx, word ptr [wpriv+0Eh]
    mov     esi, offset aChannelsD_1; "  Channels      : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     edx, [wpriv+10h]
    mov     esi, offset aSampleRateD_3; "  Sample Rate   : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    movzx   eax, word ptr [wpriv+18h]
    cmp     word ptr [wpriv+0Ch], 1
    mov     esi, offset aBlockAlignD; "  Block Align   : %d\n"
    jnz     short loc_41DE0F
    test    ax, ax
    jnz     short loc_41DE0F
    movzx   ecx, word ptr [r13+0]
    test    cx, cx
    jz      short loc_41DE0D
    movzx   eax, word ptr [r12]
    test    ax, ax
    jz      short loc_41DE0D
    movzx   edx, cx
    shr     edx, 3
    and     ecx, 7
    cmp     cx, 1
    sbb     dx, 0FFFFh
    imul    eax, edx
    mov     rcx, [rsp+268h+var_258]
    mov     [rcx], ax
    mov     esi, offset aBlockAlign0Sho; "  Block Align   : 0 (should be %d)\n"
    jmp     short loc_41DE0F
loc_41DE02:
    mov     r12d, 1Dh
    jmp     loc_41E9FB
loc_41DE0D:
    xor     eax, eax
loc_41DE0F:
    movzx   edx, ax
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    movzx   eax, word ptr [wav_fmt]
    movzx   ecx, word ptr [r13+0]
    cmp     ax, 1
    jnz     short loc_41DE71
    cmp     cx, 18h
    jnz     short loc_41DE71
    mov     rax, [rsp+268h+var_258]
    movzx   eax, word ptr [rax]
    movzx   ecx, word ptr [r12]
    shl     ecx, 2
    mov     edx, 18h
    cmp     ecx, eax
    jnz     short loc_41DEA6
    mov     esi, offset aBitWidth24; "  Bit Width     : 24\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     esi, offset aAmbiguousInfor; "\n  Ambiguous information in 'fmt ' chu"...
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     dword ptr [wpriv+8], 1
    jmp     short loc_41DEB5
loc_41DE71:
    movzx   edx, cx
    test    cx, cx
    jz      short loc_41DE91
    movzx   ecx, ax
    cmp     ecx, 7230h
    jz      short loc_41DE8A
    cmp     ax, 31h ; '1'
    jnz     short loc_41DEA6
loc_41DE8A:
    mov     esi, offset aBitWidthDShoul_0; "  Bit Width     : %d (should be 0)\n"
    jmp     short loc_41DEAB
loc_41DE91:
    movzx   ecx, ax
    cmp     ecx, 7230h
    jz      short loc_41DEA6
    cmp     ax, 31h ; '1'
    jnz     loc_41E2E6
loc_41DEA6:
    mov     esi, offset asc_46CC74; " "
loc_41DEAB:
    mov     rdi, psf; psf
loc_41DEAE:
    xor     eax, eax
    call    psf_log_printf
loc_41DEB5:
    mov     rsi, [rsp+268h+var_240]
    mov     eax, [rsi]
    mov     [psf+1DB0h], eax
    mov     qword ptr [psf+1DA8h], 0
    movzx   eax, word ptr [r12]
    mov     [psf+1DB4h], eax
    mov     eax, [wav_fmt]
    add     eax, 2; switch 67 cases
    cmp     ax, 42h
    ja      def_41DEED; jumptable 000000000041DEED default case, cases -1,0,4,5,8-16,18-48,50-55,57-63
    movzx   eax, ax
def_41DEED:
    jmp     ds:jpt_41DEED[rax*8]; switch jump
    mov     rax, [rsp+268h+var_258]; jumptable 000000000041DEED cases 1,3
    movzx   ecx, word ptr [rax]
    imul    ecx, [rsi]
    mov     rax, [rsp+268h+var_248]
    mov     edx, [rax]
    cmp     edx, ecx
    jnz     loc_41E270
    mov     esi, offset aBytesSecD; "  Bytes/sec     : %d\n"
    mov     rdi, psf; psf
    mov     edx, ecx
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_41E27F
    mov     rax, [rsp+268h+var_248]; jumptable 000000000041DEED cases 6,7
    mov     edx, [rax]
    mov     rax, [rsp+268h+var_258]
    movzx   ecx, word ptr [rax]
    imul    ecx, [rsi]
    cmp     edx, ecx
    jnz     loc_41E296
    mov     esi, offset aBytesSecD; "  Bytes/sec     : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_41E2A5
    mov     rax, [rsp+268h+var_248]; jumptable 000000000041DEED case -2
    mov     edx, [rax]
    mov     rax, [rsp+268h+var_258]
    movzx   ecx, word ptr [rax]
    imul    ecx, [rsi]
    cmp     edx, ecx
    jnz     loc_41E2F5
    mov     esi, offset aBytesSecD; "  Bytes/sec     : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_41E304
    mov     esi, offset aNoFmtChunkDump; jumptable 000000000041DEED default case, cases -1,0,4,5,8-16,18-48,50-55,57-63
    jmp     loc_41E9BF
    mov     rbx, r12; jumptable 000000000041DEED case 2
    mov     r12d, 49h ; 'I'
    cmp     word ptr [r13+0], 4
    jnz     loc_41E9FB
    movzx   eax, word ptr [rbx]
    add     eax, 0FFFFFFFFh
    mov     r12d, 4Ah ; 'J'
    cmp     ax, 1
    ja      loc_41E9FB
    lea     rdx, [wpriv+1Ch]
    lea     r12, [wpriv+1Eh]
    lea     r13, [wpriv+20h]
    mov     esi, (offset aE2422222+5); format
    mov     rdi, psf; psf
    mov     rcx, r12
    mov     r8, r13
    xor     eax, eax
    call    psf_binheader_readf
    mov     r15d, eax
    movzx   edx, word ptr [wpriv+1Ch]
    mov     esi, offset aExtraBytesD; "  Extra Bytes   : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    movzx   edx, word ptr [wpriv+1Eh]
    test    edx, edx
    jz      loc_41E73B
    mov     esi, offset aSamplesBlockD_0; "  Samples/Block : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     rax, [rsp+268h+var_240]
    mov     esi, [rax]
    mov     rax, [rsp+268h+var_258]
    movzx   edi, word ptr [rax]
    mov     eax, esi
    imul    eax, edi
    movzx   ecx, word ptr [r12]
    xor     edx, edx
    div     ecx
    mov     r8d, eax
    mov     rax, [rsp+268h+var_248]
    mov     r9d, [rax]
    cmp     r9d, r8d
    jnz     loc_41E7B8
    mov     esi, offset aBytesSecD; "  Bytes/sec     : %d\n"
    mov     rdi, psf; psf
    mov     edx, r8d
    xor     eax, eax
    call    psf_log_printf
    mov     r12, rbx
    jmp     loc_41E89C
    mov     rbx, r12; jumptable 000000000041DEED case 17
    mov     r12d, 49h ; 'I'
    cmp     word ptr [r13+0], 4
    jnz     loc_41E9FB
    movzx   eax, word ptr [rbx]
    add     eax, 0FFFFFFFFh
    mov     r12d, 4Ah ; 'J'
    cmp     ax, 1
    ja      loc_41E9FB
    lea     rdx, [wpriv+1Ch]
    lea     wav_fmt, [wpriv+1Eh]
    mov     esi, (offset aE2422222+6); format
    mov     rdi, psf; psf
    mov     rcx, r15
    xor     eax, eax
    call    psf_binheader_readf
    mov     r12d, eax
    movzx   edx, word ptr [wpriv+1Ch]
    mov     esi, offset aExtraBytesD; "  Extra Bytes   : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    movzx   edx, word ptr [wpriv+1Eh]
    test    edx, edx
    jz      loc_41E73B
    add     [rsp+268h+var_25C], r12d
    mov     esi, offset aSamplesBlockD_0; "  Samples/Block : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     rax, [rsp+268h+var_258]
    movzx   eax, word ptr [rax]
    mov     rcx, [rsp+268h+var_240]
    imul    eax, [rcx]
    movzx   ecx, word ptr [r15]
    xor     edx, edx
    div     ecx
    mov     rcx, [rsp+268h+var_248]
    mov     edx, [rcx]
    cmp     edx, eax
    jnz     loc_41E7D7
    mov     esi, offset aBytesSecD; "  Bytes/sec     : %d\n"
    mov     rdi, psf; psf
    mov     edx, eax
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_41E7E8
    mov     rax, r12; jumptable 000000000041DEED case 49
    mov     r12d, 4Ch ; 'L'
    cmp     word ptr [rax], 1
    jnz     loc_41E9FB
    mov     rbx, rax
    mov     rax, [rsp+268h+var_258]
    cmp     word ptr [rax], 41h ; 'A'
    jnz     loc_41E9FB
    lea     wav_fmt, [wpriv+1Ch]
    lea     r13, [wpriv+1Eh]
    mov     esi, (offset aE2422222+6); format
    mov     rdi, psf; psf
    mov     rdx, r15
    mov     rcx, r13
    xor     eax, eax
    call    psf_binheader_readf
    mov     rcx, [rsp+268h+var_240]
    movzx   edx, word ptr [wpriv+1Eh]
    cmp     edx, 140h
    jnz     loc_41E9FB
    mov     ebp, eax
    mov     rax, [rsp+268h+var_258]
    movzx   eax, word ptr [rax]
    imul    eax, [rcx]
    mov     ecx, 0CCCCCCCDh
    imul    rcx, rax
    shr     rcx, 28h
    mov     rax, [rsp+268h+var_248]
    mov     edx, [rax]
    cmp     edx, ecx
    jnz     loc_41E7F0
    mov     esi, offset aBytesSecD; "  Bytes/sec     : %d\n"
    mov     rdi, psf; psf
    mov     edx, ecx
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_41E7FF
    mov     rax, r12; jumptable 000000000041DEED case 56
    mov     r12d, 4Fh ; 'O'
    cmp     word ptr [rax], 1
    jnz     loc_41E9FB
    mov     rbx, rax
    movzx   eax, word ptr [r13+0]
    cmp     eax, 2
    jb      loc_41E9FB
    shl     eax, 2
    lea     eax, [rax+rax*4]
    or      eax, 2
    mov     rcx, [rsp+268h+var_258]
    movzx   ecx, word ptr [rcx]
    cmp     eax, ecx
    mov     r15d, [rsp+268h+var_24C]
    jnz     loc_41E9FB
    imul    eax, [rsi]
    mov     ecx, 0CCCCCCCDh
    imul    rcx, rax
    shr     rcx, 27h
    mov     rax, [rsp+268h+var_248]
    mov     edx, [rax]
    cmp     edx, ecx
    jnz     loc_41E837
    mov     esi, offset aBytesSecD; "  Bytes/sec     : %d\n"
    mov     rdi, psf; psf
    mov     edx, ecx
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_41E846
    mov     rax, [rsp+268h+var_248]; jumptable 000000000041DEED case 64
    mov     edx, [rax]
    mov     esi, offset aBytesSecD; "  Bytes/sec     : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     eax, [rsp+268h+var_24C]
    cmp     eax, 14h
    jl      loc_41E432
    lea     rdx, [wpriv+1Ch]
    lea     rbx, [wpriv+1Eh]
    mov     esi, (offset aE2422222+6); format
    mov     rdi, psf; psf
    mov     rcx, rbx
    xor     eax, eax
    call    psf_binheader_readf
    mov     r13d, eax
    movzx   edx, word ptr [wpriv+1Ch]
    test    edx, edx
    jz      loc_41E755
    mov     esi, offset aExtraBytesD; "  Extra Bytes   : %d\n"
    mov     rdi, psf
    jmp     loc_41E75F
loc_41E270:
    mov     esi, offset aBytesSecDShoul; "  Bytes/sec     : %d (should be %d)\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_41E27F:
    movzx   eax, word ptr [r13+0]
    add     eax, 7
    shr     eax, 3
    mov     [psf+1E3Ch], eax
    jmp     loc_41E9AC
loc_41E296:
    mov     esi, offset aBytesSecDShoul; "  Bytes/sec     : %d (should be %d)\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_41E2A5:
    mov     eax, [rsp+268h+var_24C]
    mov     dword ptr [psf+1E3Ch], 1
    cmp     eax, 12h
    mov     r15d, [rsp+268h+var_25C]
    jl      loc_41E9B1
loc_41E2C2:
    lea     rdx, [wpriv+1Ch]
    mov     esi, (offset aWaveFormatInte+1Ah); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    add     r15d, eax
    movzx   edx, word ptr [wpriv+1Ch]
    mov     esi, offset aExtraBytesD; "  Extra Bytes   : %d\n"
    jmp     loc_41E776
loc_41E2E6:
    mov     esi, offset aBitWidthDShoul_1; "  Bit Width     : %d (should not be 0)"...
    mov     rdi, psf
    xor     edx, edx
    jmp     loc_41DEAE
loc_41E2F5:
    mov     esi, offset aBytesSecDShoul; "  Bytes/sec     : %d (should be %d)\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_41E304:
    lea     rdx, [wpriv+1Ch]
    lea     rcx, [wpriv+1Eh]
    lea     r13, [wpriv+20h]
    mov     esi, (offset a4224+1); format
    mov     rdi, psf; psf
    mov     r8, r13
    xor     eax, eax
    call    psf_binheader_readf
    mov     ebx, eax
    movzx   edx, word ptr [wpriv+1Eh]
    mov     esi, offset aValidBitsD; "  Valid Bits    : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     eax, [wpriv+20h]
    test    eax, eax
    jz      loc_41E47A
    mov     [wpriv+4], eax
    mov     rdi, [psf+1E00h]; ptr
    call    _free
    movsxd  rdi, dword ptr [psf+1DB4h]; nmemb
    mov     esi, 4; size
    call    _calloc
    mov     [psf+1E00h], rax
    test    rax, rax
    jz      loc_41E49E
    mov     dword ptr [rsp+268h+var_240], ebx
    mov     [rsp+268h+var_258], r12
    mov     [rsp+268h+dest], 0
    mov     r15d, 46C298h
    xor     r12d, r12d
    xor     ebx, ebx
    jmp     short loc_41E3C8
loc_41E38D:
    mov     eax, [r15-8]
    mov     rcx, [psf+1E00h]
    movsxd  rdx, ebx
    add     ebx, 1
    mov     [rcx+rdx*4], eax
    mov     rcx, [r15]
    mov     esi, 200h; maxlen
    mov     edx, offset fmt; "%s, "
    lea     rdi, [rsp+268h+dest]; dest
    xor     eax, eax
    call    append_snprintf
loc_41E3BA:
    add     bit, 1
    add     r15, 10h
    cmp     r12, 12h
    jz      short loc_41E3EA
loc_41E3C8:
    mov     eax, [r13+0]
    bt      eax, r12d
    jnb     short loc_41E3BA
    cmp     ebx, [psf+1DB4h]
    jle     short loc_41E38D
    mov     esi, offset aMoreChannelMap; "*** More channel map bits than there ar"...
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_41E3EA:
    lea     rdi, [rsp+268h+dest]; s
    call    _strlen
    lea     ecx, [rax-1]
    mov     [rsp+bit+268h+dest], 0
    mov     ecx, 0FFFFFFFEh
    add     ecx, eax
    mov     [rsp+bit+268h+dest], 0
    mov     edx, [r13+0]
    cmp     ebx, [psf+1DB4h]
    jnz     loc_41E4A9
    lea     bit, [rsp+268h+dest]
    mov     esi, offset aChannelMask0xX; "  Channel Mask  : 0x%X (%s)\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_41E4C7
loc_41E432:
    cmp     eax, 12h
    jnz     short loc_41E494
    lea     rdx, [wpriv+1Ch]
    mov     esi, (offset aWaveFormatInte+1Ah); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    mov     r15d, [rsp+268h+var_25C]
    add     r15d, eax
    movzx   edx, word ptr [wpriv+1Ch]
    test    edx, edx
    mov     eax, 46CC73h
    mov     ecx, offset aShouldBe0; " (should be 0)"
    cmovz   rcx, rax
    mov     esi, offset aExtraBytesDS; "  Extra Bytes   : %d%s\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_41E9B1
loc_41E47A:
    mov     [rsp+268h+var_258], r12
    mov     esi, offset aChannelMask0x0; "  Channel Mask  : 0x0 (should not be ze"...
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     eax, [rsp+268h+var_25C]
    jmp     short loc_41E4CF
loc_41E494:
    mov     esi, offset aFmtChunkShould; "*** 'fmt ' chunk should be bigger than "...
    jmp     loc_41E9A2
loc_41E49E:
    mov     r12d, 11h
    jmp     loc_41E9FB
loc_41E4A9:
    mov     esi, offset aChannelMask0xX_0; "  Channel Mask  : 0x%X\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     esi, offset aLessChannelMap; "*** Less channel map bits than there ar"...
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_41E4C7:
    mov     eax, [rsp+268h+var_25C]
    mov     ebx, dword ptr [rsp+268h+var_240]
loc_41E4CF:
    add     ebx, eax
    lea     r13, [wpriv+24h]
    lea     rcx, [wpriv+28h]
    lea     r8, [wpriv+2Ah]
    mov     esi, (offset aEo1422+3); format
    mov     rdi, psf; psf
    mov     rdx, r13
    xor     eax, eax
    call    psf_binheader_readf
    mov     r12d, eax
    add     r12d, ebx
    mov     esi, offset aSubformat; "  Subformat\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     edx, [wpriv+24h]
    mov     esi, offset aEsfField10xX; "    esf_field1 : 0x%X\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    movzx   edx, word ptr [wpriv+28h]
    mov     esi, offset aEsfField20xX; "    esf_field2 : 0x%X\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    movzx   edx, word ptr [wpriv+2Ah]
    mov     esi, offset aEsfField30xX; "    esf_field3 : 0x%X\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     esi, offset aEsfField4; "    esf_field4 : "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    lea     rdx, [wpriv+2Ch]
    mov     esi, (offset aSample1+8); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    mov     r15d, eax
    add     r15d, r12d
    movzx   edx, byte ptr [wpriv+2Ch]
    mov     esi, offset a0xX; "0x%X "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    lea     rdx, [wpriv+2Dh]
    mov     esi, (offset aSample1+8); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    mov     ebx, eax
    add     ebx, r15d
    movzx   edx, byte ptr [wpriv+2Dh]
    mov     esi, offset a0xX; "0x%X "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    lea     rdx, [wpriv+2Eh]
    mov     esi, (offset aSample1+8); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    mov     r15d, eax
    add     r15d, ebx
    movzx   edx, byte ptr [wpriv+2Eh]
    mov     esi, offset a0xX; "0x%X "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    lea     rdx, [wpriv+2Fh]
    mov     esi, (offset aSample1+8); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    mov     ebx, eax
    add     ebx, r15d
    movzx   edx, byte ptr [wpriv+2Fh]
    mov     esi, offset a0xX; "0x%X "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    lea     rdx, [wpriv+30h]
    mov     esi, (offset aSample1+8); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    mov     r15d, eax
    add     r15d, ebx
    movzx   edx, byte ptr [wpriv+30h]
    mov     esi, offset a0xX; "0x%X "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    lea     rdx, [wpriv+31h]
    mov     esi, (offset aSample1+8); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    mov     ebx, eax
    add     ebx, r15d
    movzx   edx, byte ptr [wpriv+31h]
    mov     esi, offset a0xX; "0x%X "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    lea     rdx, [wpriv+32h]
    mov     esi, (offset aSample1+8); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    mov     r15d, eax
    add     r15d, ebx
    movzx   edx, byte ptr [wpriv+32h]
    mov     esi, offset a0xX; "0x%X "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    lea     rdx, [wpriv+33h]
    mov     esi, (offset aSample1+8); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    add     eax, r15d
    mov     [rsp+268h+var_25C], eax
    movzx   edx, byte ptr [wpriv+33h]
    mov     esi, offset a0xX; "0x%X "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     esi, (offset aAmbiguousInfor+111h); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    movzx   r15d, word ptr [wpriv+1Ah]
    add     r15d, 7
    mov     ebx, r15d
    shr     ebx, 3
    mov     [psf+1E3Ch], ebx
    mov     esi, offset MSGUID_SUBTYPE_PCM; second
    mov     rdi, r13; first
    call    wavex_guid_equal
    test    eax, eax
    jz      short loc_41E710
    and     r15d, 0FFFFFFF8h
    mov     edi, r15d; bits
    call    u_bitwidth_to_subformat
    or      eax, 130000h
    mov     [psf+1DB8h], eax
    mov     esi, offset aFormatPcm; "    format : pcm\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     r12, [rsp+268h+var_258]
    jmp     loc_41E9AC
loc_41E710:
    mov     esi, offset MSGUID_SUBTYPE_MS_ADPCM; second
    mov     rdi, r13; first
    call    wavex_guid_equal
    test    eax, eax
    mov     r12, [rsp+268h+var_258]
    jz      short loc_41E785
    mov     dword ptr [psf+1DB8h], 130013h
    mov     esi, offset aFormatMsAdpcm; "    format : ms adpcm\n"
    jmp     loc_41E9A2
loc_41E73B:
    mov     esi, offset aSamplesBlockDS; "  Samples/Block : %d (should be > 0)\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     r12d, 4Bh ; 'K'
    jmp     loc_41E9FB
loc_41E755:
    mov     esi, offset aExtraBytesDSho; "  Extra Bytes   : %d (should be 2)\n"
    mov     rdi, psf; psf
    xor     edx, edx
loc_41E75F:
    xor     eax, eax
    call    psf_log_printf
    mov     r15d, [rsp+268h+var_25C]
    add     r15d, r13d
    movzx   edx, word ptr [rbx]
    mov     esi, offset aAuxBlkSizeD; "  Aux Blk Size  : %d\n"
loc_41E776:
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    jmp     loc_41E9B1
loc_41E785:
    mov     esi, offset MSGUID_SUBTYPE_IEEE_FLOAT; second
    mov     rdi, r13; first
    call    wavex_guid_equal
    test    eax, eax
    jz      loc_41E85D
    xor     eax, eax
    cmp     ebx, 8
    setz    al
    or      eax, 130006h
    mov     [psf+1DB8h], eax
    mov     esi, offset aFormatIeeeFloa; "    format : IEEE float\n"
    jmp     loc_41E9A2
loc_41E7B8:
    mov     eax, esi
    xor     edx, edx
    div     ecx
    imul    eax, edi
    cmp     r9d, eax
    mov     r12, rbx
    jnz     loc_41E887
    mov     esi, offset aBytesSecDShoul_0; "  Bytes/sec     : %d (should be %d (MS "...
    jmp     loc_41E88C
loc_41E7D7:
    mov     esi, offset aBytesSecDShoul; "  Bytes/sec     : %d (should be %d)\n"
    mov     rdi, psf; psf
    mov     ecx, eax
    xor     eax, eax
    call    psf_log_printf
loc_41E7E8:
    mov     r12, rbx
    jmp     loc_41E9AC
loc_41E7F0:
    mov     esi, offset aBytesSecDShoul; "  Bytes/sec     : %d (should be %d)\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_41E7FF:
    mov     r12, rbx
    mov     ebx, [rsp+268h+var_25C]
    add     ebx, ebp
    movzx   edx, word ptr [r15]
    mov     esi, offset aExtraBytesD; "  Extra Bytes   : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    movzx   edx, word ptr [r13+0]
    mov     esi, offset aSamplesBlockD_0; "  Samples/Block : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     r15d, ebx
    jmp     loc_41E9B1
loc_41E837:
    mov     esi, offset aBytesSecDShoul; "  Bytes/sec     : %d (should be %d)\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_41E846:
    mov     r12, rbx
    cmp     r15d, 12h
    mov     r15d, [rsp+268h+var_25C]
    jge     loc_41E2C2
    jmp     loc_41E9B1
loc_41E85D:
    mov     esi, offset MSGUID_SUBTYPE_ALAW; second
    mov     rdi, r13; first
    call    wavex_guid_equal
    test    eax, eax
    jz      loc_41E981
    mov     dword ptr [psf+1DB8h], 130011h
    mov     esi, offset aFormatALaw; "    format : A-law\n"
    jmp     loc_41E9A2
loc_41E887:
    mov     esi, offset aBytesSecDShoul; "  Bytes/sec     : %d (should be %d)\n"
loc_41E88C:
    mov     rdi, psf; psf
    mov     edx, r9d
    mov     ecx, r8d
    xor     eax, eax
    call    psf_log_printf
loc_41E89C:
    mov     ebx, [rsp+268h+var_25C]
    movzx   edx, word ptr [r13+0]
    cmp     edx, 8
    jb      short loc_41E8C7
    mov     esi, offset aNoOfCoeffsDSho; "  No. of Coeffs : %d (should be <= %d)"...
    mov     rdi, psf; psf
    mov     ecx, 7
    xor     eax, eax
    call    psf_log_printf
    mov     word ptr [r13+0], 7
    jmp     short loc_41E8D6
loc_41E8C7:
    mov     esi, offset aNoOfCoeffsD; "  No. of Coeffs : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_41E8D6:
    add     ebx, r15d
    mov     r15d, ebx
    mov     esi, offset aIndexCoeffs1Co; "    Index   Coeffs1   Coeffs2\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    cmp     word ptr [r13+0], 0
    jz      loc_41E9B1
    add     wpriv, 24h ; '$'
    mov     [rsp+268h+var_258], r13
    xor     ebx, ebx
loc_41E902:
    lea     rdx, [rbp-2]
    mov     esi, (offset aE2422222+6); format
    mov     rdi, psf; psf
    mov     rcx, rbp
    xor     eax, eax
    call    psf_binheader_readf
    add     r15d, eax
    movsx   r10d, word ptr [rbp-2]
    movsx   r11d, word ptr [rbp+0]
    mov     esi, 80h
    mov     ecx, 80h
    mov     r8d, offset a2d7d7d; "     %2d     %7d   %7d\n"
    mov     r13, r12
    lea     r12, [rsp+268h+dest]
    mov     rdi, r12
    mov     edx, 1
    mov     r9d, ebx
    mov     eax, 0
    push    r11
    push    r10
    call    ___snprintf_chk
    add     rsp, 10h
    mov     rdi, psf; psf
    mov     rsi, r12; format
    mov     r12, r13
    xor     eax, eax
    call    psf_log_printf
    add     k, 1
    mov     rax, [rsp+268h+var_258]
    movzx   eax, word ptr [rax]
    add     rbp, 4
    cmp     rbx, rax
    jb      short loc_41E902
    jmp     short loc_41E9B1
loc_41E981:
    mov     esi, offset MSGUID_SUBTYPE_MULAW; second
    mov     rdi, r13; first
    call    wavex_guid_equal
    test    eax, eax
    jz      short loc_41EA10
    mov     dword ptr [psf+1DB8h], 130010h
    mov     esi, offset aFormatULaw; "    format : u-law\n"
loc_41E9A2:
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_41E9AC:
    mov     r15d, [rsp+268h+var_25C]
loc_41E9B1:
    mov     edx, [rsp+268h+var_24C]
    cmp     r15d, edx
    jle     short loc_41E9D1
    mov     esi, offset aWavlikeReadFmt; "*** wavlike_read_fmt_chunk (bytesread >"...
loc_41E9BF:
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     r12d, 40h ; '@'
    jmp     short loc_41E9FB
loc_41E9D1:
    sub     edx, r15d
    mov     rbx, r12
    xor     r12d, r12d
    mov     esi, (offset aE2j+2); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    movzx   eax, word ptr [rbx]
    imul    eax, [psf+1E3Ch]
    mov     [psf+1E38h], eax
loc_41E9FB:
    mov     eax, r12d
    add     rsp, 238h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_41EA10:
    mov     esi, offset MSGUID_SUBTYPE_AMBISONIC_B_FORMAT_PCM; second
    mov     rdi, r13; first
    call    wavex_guid_equal
    test    eax, eax
    jz      short loc_41EA40
    and     r15d, 0FFFFFFF8h
    mov     edi, r15d; bits
    call    u_bitwidth_to_subformat
    or      eax, 130000h
    mov     [psf+1DB8h], eax
    mov     esi, offset aFormatPcmAmbis; "    format : pcm (Ambisonic B)\n"
    jmp     short loc_41EA6A
loc_41EA40:
    mov     esi, offset MSGUID_SUBTYPE_AMBISONIC_B_FORMAT_IEEE_FLOAT; second
    mov     rdi, r13; first
    call    wavex_guid_equal
    test    eax, eax
    jz      short loc_41EA80
    xor     eax, eax
    cmp     ebx, 8
    setz    al
    or      eax, 130006h
    mov     [psf+1DB8h], eax
    mov     esi, offset aFormatIeeeFloa_0; "    format : IEEE float (Ambisonic B)\n"
loc_41EA6A:
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     dword ptr [wpriv+0], 41h ; 'A'
    jmp     loc_41E9AC
loc_41EA80:
    mov     r12d, 12h
    jmp     loc_41E9FB
wavlike_read_fmt_chunk endp

