paf_read_header proc
    push    rbp
    push    rbx
    sub     rsp, 28h
    mov     ebp, 65h ; 'e'
    cmp     qword ptr [psf+1E08h], 800h
    jl      loc_416FF3
    mov     rbx, psf
    xorps   xmm0, xmm0
    movaps  [rsp+38h+var_38], xmm0
    mov     [rsp+38h+var_28], 0
    lea     rcx, [rsp+38h+var_14]
    mov     esi, offset aPm; "pm"
    xor     edx, edx
    xor     eax, eax
    call    psf_binheader_readf
    mov     edx, [rsp+38h+var_14]
    mov     esi, offset aSignatureM; "Signature   : '%M'\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     eax, [rsp+38h+var_14]
    cmp     eax, 66617020h
    jz      short loc_416D77
    mov     ebp, 62h ; 'b'
    cmp     eax, 20706166h
    jnz     loc_416FF3
    mov     esi, offset aE444444; "e444444"
    jmp     short loc_416D7C
loc_416D77:
    mov     esi, offset aE; "E"
loc_416D7C:
    lea     rcx, [rsp+38h+var_38+4]
    lea     r8, [rsp+38h+var_38+8]
    lea     r9, [rsp+38h+var_38+0Ch]
    lea     r10, [rsp+38h+var_28]
    lea     rbp, [rsp+38h+var_28+4]
    mov     rdx, rsp
    mov     rdi, psf; psf
    mov     eax, 0
    push    rbp
    push    r10
    call    psf_binheader_readf
    add     rsp, 10h
    mov     edx, dword ptr [rsp+38h+var_38]
    mov     esi, offset aVersionD_0; "Version     : %d\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    cmp     dword ptr [rsp+38h+var_38], 0
    jz      short loc_416DDD
    mov     esi, offset aBadVersionNumb; "*** Bad version number. should be zero."...
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     ebp, 63h ; 'c'
    jmp     loc_416FF3
loc_416DDD:
    mov     edx, dword ptr [rsp+38h+var_38+8]
    mov     esi, (offset aSampleRateD+2); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     edx, dword ptr [rsp+38h+var_28]
    mov     esi, (offset aChannelsD+2); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     edx, dword ptr [rsp+38h+var_38+4]
    mov     esi, offset aEndiannessD; "Endianness  : %d => "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     edx, dword ptr [rsp+38h+var_38+4]
    test    edx, edx
    jz      short loc_416E34
    mov     esi, offset aLittle_0; "Little\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     eax, 10000000h
    jmp     short loc_416E4A
loc_416E34:
    mov     esi, offset aBig; "Big\n"
    mov     rdi, psf; psf
    xor     edx, edx
    xor     eax, eax
    call    psf_log_printf
    mov     eax, 20000000h
loc_416E4A:
    mov     [psf+1D7Ch], eax
    mov     rax, [psf+1E08h]
    mov     rdx, [psf+1E20h]
    sub     rax, rdx
    mov     [psf+1E28h], rax
    mov     esi, (offset aE24p+3); format
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_binheader_readf
    mov     eax, dword ptr [rsp+38h+var_38+8]
    mov     [psf+1DB0h], eax
    mov     eax, dword ptr [rsp+38h+var_28]
    mov     [psf+1DB4h], eax
    mov     dword ptr [psf+1DB8h], 50000h
    mov     edx, dword ptr [rsp+38h+var_38+0Ch]
    mov     esi, offset aFormatD; "Format      : %d => "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    xor     eax, eax
    cmp     dword ptr [rsp+38h+var_38+4], 0
    setz    al
    shl     eax, 1Ch
    add     eax, 10000000h
    or      [psf+1DB8h], eax
    mov     eax, dword ptr [rsp+38h+var_38+0Ch]
    test    eax, eax
    jz      short loc_416EFE
    cmp     eax, 1
    jz      short loc_416F35
    cmp     eax, 2
    jnz     loc_416FB3
    mov     esi, offset a8BitLinearPcm_0; "8 bit linear PCM\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     dword ptr [psf+1E3Ch], 1
    or      byte ptr [psf+1DB8h], 1
    mov     ecx, [psf+1DB4h]
    jmp     short loc_416F26
loc_416EFE:
    mov     esi, offset a16BitLinearPcm_0; "16 bit linear PCM\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     dword ptr [psf+1E3Ch], 2
    or      byte ptr [psf+1DB8h], 2
    mov     ecx, [psf+1DB4h]
    add     ecx, ecx
loc_416F26:
    mov     [psf+1E38h], ecx
    mov     rax, [psf+1E28h]
    jmp     short loc_416F73
loc_416F35:
    mov     esi, offset a24BitLinearPcm_0; "24 bit linear PCM\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    or      byte ptr [psf+1DB8h], 3
    mov     rax, 300000000h
    mov     [psf+1E38h], rax
    mov     rax, [psf+1E28h]
    add     rax, rax
    lea     rax, [rax+rax*4]
    mov     ecx, [psf+1DB4h]
    shl     ecx, 5
loc_416F73:
    movsxd  rcx, ecx
    cqo
    idiv    rcx
    mov     [psf+1DA8h], rax
    mov     edx, dword ptr [rsp+38h+var_28+4]
    xor     ebp, ebp
    mov     esi, offset aSourceD; "Source      : %d => "
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     eax, dword ptr [rsp+38h+var_28+4]
    add     eax, 0FFFFFFFFh; switch 5 cases
    cmp     eax, 4
    ja      short def_416FA3; jumptable 0000000000416FA3 default case, case 4
def_416FA3:
    jmp     ds:jpt_416FA3[rax*8]; switch jump
    xor     ebp, ebp; jumptable 0000000000416FA3 case 1
    mov     esi, offset aAnalogRecordin; "Analog Recording\n"
    jmp     short loc_416FE9
loc_416FB3:
    mov     esi, offset aUnknown_1; "Unknown\n"
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     ebp, 64h ; 'd'
    jmp     short loc_416FF3
    xor     ebp, ebp; jumptable 0000000000416FA3 case 2
    mov     esi, offset aDigitalTransfe; "Digital Transfer\n"
    jmp     short loc_416FE9
    xor     ebp, ebp; jumptable 0000000000416FA3 case 3
    mov     esi, offset aMultiTrackMixd; "Multi-track Mixdown\n"
    jmp     short loc_416FE9
    mov     esi, offset aUnknown_1; jumptable 0000000000416FA3 default case, case 4
    jmp     short loc_416FE9
    xor     ebp, ebp; jumptable 0000000000416FA3 case 5
    mov     esi, offset aAudioResulting; "Audio Resulting From DSP Processing\n"
loc_416FE9:
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
loc_416FF3:
    mov     eax, ebp
    add     rsp, 28h
    pop     rbx
    pop     rbp
    retn
paf_read_header endp

