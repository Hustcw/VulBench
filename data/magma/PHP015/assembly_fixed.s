phar_parse_pharfile proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 198h
    mov     r12, halt_offset
    mov     rbp, alias_len
    mov     r14, alias
    mov     [rsp+1C8h+length], fname_len
    mov     [rsp+1C8h+s], fname
    mov     rbx, fp
    mov     r15, [rsp+1C8h+error]
    mov     r13, [rsp+1C8h+pphar_0]
    mov     [rsp+1C8h+ptr], 0
    test    r13, r13
    jz      short loc_52951C
    mov     qword ptr [r13+0], 0
loc_52951C:
    test    r15, r15
    jz      short loc_529528
    mov     qword ptr [r15], 0
loc_529528:
    mov     rdi, fp; stream
    mov     rsi, halt_offset; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      loc_529649
    lea     rsi, [rsp+1C8h+buf]; buf
    mov     edx, 3; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 3
    jnz     short loc_5295A9
    mov     al, [rsp+1C8h+buf]
    cmp     al, 20h ; ' '
    jz      short loc_529566
    cmp     al, 0Ah
    jnz     loc_5295E9
loc_529566:
    cmp     [rsp+1C8h+buf+1], 3Fh ; '?'
    jnz     short loc_5295E9
    cmp     [rsp+1C8h+buf+2], 3Eh ; '>'
    jnz     short loc_5295E9
    mov     rdi, fp; stream
    call    _php_stream_getc
    cmp     eax, 0FFFFFFFFh
    jz      short loc_5295A9
    movzx   eax, al
    cmp     eax, 0Dh
    jnz     short loc_5295D5
    mov     rdi, fp; stream
    call    _php_stream_getc
    cmp     eax, 0FFFFFFFFh
    jz      short loc_5295A9
    movzx   eax, al
    cmp     eax, 0Ah
    jnz     short loc_5295A9
    add     r12, 4
    mov     eax, 0Ah
    jmp     short loc_5295D9
loc_5295A9:
    test    fp, fp
    jz      short loc_5295BB
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_5295BB:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aInternalCorrup_1; "internal corruption of phar \"%s\" (tru"...
    jmp     loc_52966C
loc_5295D5:
    add     r12, 3
loc_5295D9:
    mov     rcx, r12
    xor     r12d, r12d
    cmp     eax, 0Ah
    setz    r12b
    add     r12, halt_offset
loc_5295E9:
    mov     rdi, fp; stream
    mov     rsi, halt_offset; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      short loc_529649
    lea     rsi, [rsp+1C8h+buf]; buf
    mov     edx, 4; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 4
    jnz     short loc_529690
    mov     edi, dword ptr [rsp+1C8h+buf]; size
    cmp     rdi, 6400001h
    jb      loc_5296B5
    test    fp, fp
    jz      short loc_529636
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_529636:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      short loc_52967C
    lea     rdx, aManifestCannot; "manifest cannot be larger than 100 MB i"...
    jmp     short loc_52966C
loc_529649:
    test    fp, fp
    jz      short loc_52965B
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52965B:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      short loc_52967C
    lea     rdx, aCannotSeekToHa; "cannot seek to __HALT_COMPILER(); locat"...
loc_52966C:
    mov     rdi, r15; message
    xor     esi, esi; max_len
    mov     rcx, [rsp+1C8h+s]
    xor     eax, eax
    call    zend_spprintf
loc_52967C:
    mov     eax, ebx
    add     rsp, 198h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_529690:
    test    fp, fp
    jz      short loc_5296A2
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_5296A2:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      short loc_52967C
    lea     rdx, aInternalCorrup_2; "internal corruption of phar \"%s\" (tru"...
    jmp     short loc_52966C
loc_5296B5:
    mov     [rsp+1C8h+size], rdi
    call    _emalloc
    mov     rdx, [rsp+1C8h+size]; size
    mov     rcx, rax
    cmp     edx, 12h
    jb      loc_529A02
    mov     rdi, fp; stream
    mov     [rsp+1C8h+var_1B0], savebuf
    mov     rsi, [rsp+1C8h+var_1B0]; buf
    call    _php_stream_read
    mov     rdx, [rsp+1C8h+size]
    mov     rcx, [rsp+1C8h+var_1B0]
    cmp     rax, rdx
    jnz     loc_529A02
    mov     r8d, [rcx]
    test    r8d, r8d
    jz      loc_529788
    movzx   r10d, byte ptr [rcx+4]
    mov     eax, r10d
    shl     eax, 8
    movzx   r11d, byte ptr [rcx+5]
    mov     edi, r11d
    and     edi, 0FFFFFFF0h
    or      edi, eax
    cmp     edi, 0FFFh
    ja      loc_5297BE
    mov     ebp, r10d
    mov     alias, r11
    mov     rdi, rcx; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    mov     r9d, ebp
    mov     r8d, ebp
    shr     r8d, 4
    and     r9d, 0Fh
    mov     rbp, r14
    shr     ebp, 4
    sub     rsp, 8
    lea     rdx, aPharSIsApiVers; "phar \"%s\" is API version %1.u.%1.u.%1"...
    mov     rdi, r15; message
    xor     esi, esi; max_len
    mov     rcx, [rsp+1D0h+s]
    xor     eax, eax
    push    rbp
    call    zend_spprintf
    add     rsp, 10h
    jmp     loc_52967C
loc_529788:
    mov     rdi, rcx; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_52995C
    cmp     cs:phar_globals.persist, 0
    jz      loc_529957
    call    free
    test    fp, fp
    jnz     loc_529961
    jmp     loc_52996E
loc_5297BE:
    mov     esi, 0FF0F0FFFh
    and     esi, [rcx+6]
    or      esi, [rsp+1C8h+compression]
    test    esi, 10000h
    jnz     short loc_529811
    cmp     cs:phar_globals.require_hash, 0
    jz      loc_529988
    mov     rdi, rcx; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aTarBasedPharSD+0Ah; "phar \"%s\" does not have a signature"
    jmp     loc_52966C
loc_529811:
    mov     [rsp+1C8h+var_1B4], esi
    mov     [rsp+1C8h+var_194], edi
    mov     qword ptr [rsp+1C8h+nSize], manifest_count
    mov     [rsp+1C8h+var_184], r10d
    mov     [rsp+1C8h+var_150], r11
    mov     rdi, fp; stream
    mov     rsi, 0FFFFFFFFFFFFFFF8h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      loc_529DB5
    mov     rdi, fp; stream
    call    _php_stream_tell
    cmp     read_len, 14h
    jl      loc_529DB5
    lea     rsi, [rsp+1C8h+var_138]; buf
    mov     edx, 8; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 8
    jnz     loc_529DB5
    cmp     dword ptr [rsp+1C8h+var_138+4], 424D4247h
    jnz     loc_529DB5
    mov     eax, dword ptr [rsp+1C8h+var_138]
    add     eax, 0FFFFFFFFh; switch 16 cases
    cmp     eax, 0Fh
    ja      def_5298A8; jumptable 00000000005298A8 default case, cases 5-15
    lea     rcx, jpt_5298A8
    movsxd  rax, ds:(jpt_5298A8 - 893420h)[rcx+rax*4]
    add     rax, rcx
def_5298A8:
    jmp     rax; switch jump
    mov     rdi, fp; jumptable 00000000005298A8 case 1
    mov     rsi, 0FFFFFFFFFFFFFFE8h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     [rsp+1C8h+sig_len], rax
    lea     rsi, [rsp+1C8h+sig]; buf
    mov     edx, 10h; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 10h
    jnz     loc_529DB5
    sub     rsp, 8
    lea     rax, [rsp+1D0h+var_140]
    lea     r10, [rsp+1D0h+ptr]
    lea     rcx, [rsp+1D0h+sig]; sig
    mov     r8d, 10h; sig_len
    mov     rdi, fp; fp
    mov     rsi, [rsp+1D0h+sig_len]; end_of_phar
    mov     edx, 1; sig_type
    mov     r9, [rsp+1D0h+s]; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jz      loc_52A88B
    mov     rcx, [rsp+1C8h+var_1B0]
    mov     r11, [rsp+1C8h+var_150]
    mov     r10d, [rsp+1C8h+var_184]
    mov     r8, qword ptr [rsp+1C8h+nSize]
    mov     edi, [rsp+1C8h+var_194]
    mov     [rsp+1C8h+var_174], 1
    jmp     loc_529DA7
loc_529957:
    call    _efree
loc_52995C:
    test    fp, fp
    jz      short loc_52996E
loc_529961:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52996E:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aInPharSManifes; "in phar \"%s\", manifest claims to have"...
    jmp     loc_52966C
loc_529988:
    mov     [rsp+1C8h+var_140], 0
    mov     [rsp+1C8h+var_174], 0
loc_52999C:
    lea     rax, [rcx+rdx]
    mov     r9d, [rcx+0Ah]
    mov     [rsp+1C8h+var_1C0], r9
    add     r9, rcx
    add     r9, 0Eh
    mov     [rsp+1C8h+var_170], endbuffer
    mov     [rsp+1C8h+sig_len], r9
    cmp     r9, rax
    jbe     short loc_5299F5
    mov     rdi, rcx; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_529B27
    cmp     cs:phar_globals.persist, 0
    jz      loc_529B22
    call    free
    test    fp, fp
    jnz     loc_529B2C
    jmp     loc_529B39
loc_5299F5:
    mov     r9, [rsp+1C8h+var_1C0]
    lea     eax, [r9+12h]
    cmp     edx, eax
    jnb     short loc_529A5A
loc_529A02:
    mov     rdi, rcx; ptr
    call    _efree
loc_529A0A:
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      short loc_529A2E
    cmp     cs:phar_globals.persist, 0
    jz      short loc_529A29
    call    free
    test    fp, fp
    jnz     short loc_529A33
    jmp     short loc_529A40
loc_529A29:
    call    _efree
loc_529A2E:
    test    fp, fp
    jz      short loc_529A40
loc_529A33:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_529A40:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aInternalCorrup_3; "internal corruption of phar \"%s\" (tru"...
    jmp     loc_52966C
loc_529A5A:
    mov     rax, rcx
    add     rax, 0Eh
    test    r9d, r9d
    mov     [rsp+1C8h+var_150], r11
    mov     [rsp+1C8h+var_184], r10d
    mov     [rsp+1C8h+var_194], edi
    mov     [rsp+1C8h+var_1B4], esi
    jz      loc_529B53
    mov     [rsp+1C8h+s2], buffer
    mov     [rsp+1C8h+var_144], 0
    mov     [rsp+1C8h+var_11C], 1
    test    alias, alias
    jz      loc_529B8F
    mov     qword ptr [rsp+1C8h+nSize], r8
    test    alias_len, alias_len
    jz      loc_529B97
    cmp     r9, alias_len
    jnz     short loc_529ACB
    mov     rdi, alias; s1
    mov     rsi, [rsp+1C8h+s2]; s2
    mov     rdx, alias_len; n
    call    _strncmp
    test    eax, eax
    jz      loc_529F5C
loc_529ACB:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      short loc_529AE7
    call    _efree
loc_529AE7:
    test    r15, r15
    jz      short loc_529B18
    sub     rsp, 8
    lea     rdx, aCannotLoadPhar; "cannot load phar \"%s\" with implicit a"...
    mov     rdi, r15; message
    xor     esi, esi; max_len
    mov     rcx, [rsp+1D0h+s]
    mov     r8, [rsp+1D0h+var_1C0]
    mov     r9, [rsp+1D0h+s2]
    xor     eax, eax
    push    alias
    call    zend_spprintf
    add     rsp, 10h
loc_529B18:
    mov     rdi, [rsp+1C8h+var_1B0]
    jmp     loc_52A952
loc_529B22:
    call    _efree
loc_529B27:
    test    fp, fp
    jz      short loc_529B39
loc_529B2C:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_529B39:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aInternalCorrup_4; "internal corruption of phar \"%s\" (buf"...
    jmp     loc_52966C
loc_529B53:
    test    alias_len, alias_len
    setnz   sil
    test    alias, alias
    setnz   cl
    and     cl, sil
    movzx   ecx, cl
    mov     [rsp+1C8h+sig_len], buffer
    xor     eax, eax
    test    cl, cl
    cmovz   alias_len, rax
    cmovnz  rax, alias
    mov     [rsp+1C8h+var_11C], ecx
    mov     [rsp+1C8h+var_144], ecx
    mov     [rsp+1C8h+s2], rax
    jmp     loc_529F76
loc_529B8F:
    mov     alias_len, r9
    jmp     loc_529F76
loc_529B97:
    mov     alias_len, r9
    mov     r8, qword ptr [rsp+1C8h+nSize]
    mov     rdx, [rsp+1C8h+size]
    jmp     loc_529F76
    mov     rdi, fp; jumptable 00000000005298A8 case 2
    mov     rsi, 0FFFFFFFFFFFFFFE4h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     [rsp+1C8h+sig_len], rax
    lea     rsi, [rsp+1C8h+sig]; buf
    mov     edx, 14h; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 14h
    jnz     loc_529DB5
    sub     rsp, 8
    lea     rax, [rsp+1D0h+var_140]
    lea     r10, [rsp+1D0h+ptr]
    lea     rcx, [rsp+1D0h+sig]; sig
    mov     r8d, 14h; sig_len
    mov     rdi, fp; fp
    mov     rsi, [rsp+1D0h+sig_len]; end_of_phar
    mov     edx, 2; sig_type
    mov     r9, [rsp+1D0h+s]; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jz      loc_52A8BA
    mov     rcx, [rsp+1C8h+var_1B0]
    mov     r11, [rsp+1C8h+var_150]
    mov     r10d, [rsp+1C8h+var_184]
    mov     r8, qword ptr [rsp+1C8h+nSize]
    mov     edi, [rsp+1C8h+var_194]
    mov     [rsp+1C8h+var_174], 2
    jmp     loc_529DA7
    mov     rdi, fp; jumptable 00000000005298A8 case 3
    mov     rsi, 0FFFFFFFFFFFFFFD8h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     [rsp+1C8h+sig_len], rax
    lea     rsi, [rsp+1C8h+sig]; buf
    mov     edx, 20h ; ' '; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 20h ; ' '
    jnz     loc_529DB5
    sub     rsp, 8
    lea     rax, [rsp+1D0h+var_140]
    lea     r10, [rsp+1D0h+ptr]
    lea     rcx, [rsp+1D0h+sig]; sig
    mov     r8d, 20h ; ' '; sig_len
    mov     rdi, fp; fp
    mov     rsi, [rsp+1D0h+sig_len]; end_of_phar
    mov     edx, 3; sig_type
    mov     r9, [rsp+1D0h+s]; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jz      loc_52A8E6
    mov     rcx, [rsp+1C8h+var_1B0]
    mov     r11, [rsp+1C8h+var_150]
    mov     r10d, [rsp+1C8h+var_184]
    mov     r8, qword ptr [rsp+1C8h+nSize]
    mov     edi, [rsp+1C8h+var_194]
    mov     [rsp+1C8h+var_174], 3
    jmp     loc_529DA7
    mov     rdi, fp; jumptable 00000000005298A8 case 4
    mov     rsi, 0FFFFFFFFFFFFFFB8h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     [rsp+1C8h+sig_len], rax
    lea     rsi, [rsp+1C8h+sig]; buf
    mov     edx, 40h ; '@'; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 40h ; '@'
    jnz     short loc_529DB5
    sub     rsp, 8
    lea     rax, [rsp+1D0h+var_140]
    lea     r10, [rsp+1D0h+ptr]
    lea     rcx, [rsp+1D0h+sig]; sig
    mov     r8d, 40h ; '@'; sig_len
    mov     rdi, fp; fp
    mov     rsi, [rsp+1D0h+sig_len]; end_of_phar
    mov     edx, 4; sig_type
    mov     r9, [rsp+1D0h+s]; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jz      loc_52A912
    mov     rcx, [rsp+1C8h+var_1B0]
    mov     r11, [rsp+1C8h+var_150]
    mov     r10d, [rsp+1C8h+var_184]
    mov     r8, qword ptr [rsp+1C8h+nSize]
    mov     edi, [rsp+1C8h+var_194]
    mov     [rsp+1C8h+var_174], 4
loc_529DA7:
    mov     esi, [rsp+1C8h+var_1B4]
    mov     rdx, [rsp+1C8h+size]
    jmp     loc_52999C
loc_529DB5:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      short loc_529DE8
    lea     rdx, aPharSHasA; "phar \"%s\" has a "
loc_529DD8:
    mov     rdi, r15; message
    xor     esi, esi; max_len
    mov     rcx, [rsp+1C8h+s]
    xor     eax, eax
    call    zend_spprintf
loc_529DE8:
    mov     ebx, 0FFFFFFFFh
    jmp     loc_52967C
    mov     rdi, [rsp+1C8h+var_1B0]; jumptable 00000000005298A8 default case, cases 5-15
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      short loc_529DE8
    lea     rdx, aPharSHasA_0; "phar \"%s\" has a "
    jmp     short loc_529DD8
    mov     rdi, fp; jumptable 00000000005298A8 case 16
    mov     rsi, 0FFFFFFFFFFFFFFF4h; offset
    mov     edx, 1; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      loc_529F30
    lea     rsi, [rsp+1C8h+var_138]; buf
    mov     edx, 4; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 4
    jnz     loc_529F30
    mov     edi, dword ptr [rsp+1C8h+var_138]; size
    mov     [rsp+1C8h+sig_len], signature_len
    call    _emalloc
    mov     [rsp+1C8h+var_170], rax
    mov     rax, [rsp+1C8h+sig_len]
    lea     esi, [rax+4]
    neg     whence; offset
    mov     rdi, fp; stream
    mov     edx, 1; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      loc_52A6D6
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     [rsp+1C8h+var_1C0], end_of_phar
    test    rax, rax
    jz      loc_52A6D6
    mov     rdi, fp; stream
    mov     rsi, [rsp+1C8h+var_170]; buf
    mov     rdx, [rsp+1C8h+sig_len]; size
    call    _php_stream_read
    cmp     rax, [rsp+1C8h+sig_len]
    jnz     loc_52A6D6
    sub     rsp, 8
    lea     rax, [rsp+1D0h+var_140]
    lea     r10, [rsp+1D0h+ptr]
    mov     rdi, fp; fp
    mov     rsi, [rsp+1D0h+var_1C0]; end_of_phar
    mov     edx, 10h; sig_type
    mov     rcx, [rsp+1D0h+var_170]; sig
    mov     r8, [rsp+1D0h+sig_len]; sig_len
    mov     r9, [rsp+1D0h+s]; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jz      loc_52ADD0
    mov     rdi, [rsp+1C8h+var_170]; ptr
    call    _efree
    mov     rcx, [rsp+1C8h+var_1B0]
    mov     r11, [rsp+1C8h+var_150]
    mov     r10d, [rsp+1C8h+var_184]
    mov     r8, qword ptr [rsp+1C8h+nSize]
    mov     edi, [rsp+1C8h+var_194]
    mov     [rsp+1C8h+var_174], 10h
    jmp     loc_529DA7
loc_529F30:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529DE8
    lea     rdx, aPharSOpensslSi; "phar \"%s\" openssl signature length co"...
    jmp     loc_529DD8
loc_529F5C:
    mov     [rsp+1C8h+var_144], 0
    mov     r8, qword ptr [rsp+1C8h+nSize]
    mov     rdx, [rsp+1C8h+size]
    mov     r9, [rsp+1C8h+var_1C0]
loc_529F76:
    mov     eax, edx
    sub     eax, r9d
    add     eax, 0FFFFFFEEh
    mov     ecx, 86186187h
    imul    rcx, rax
    shr     rcx, 20h
    sub     eax, ecx
    shr     eax, 1
    add     eax, ecx
    shr     eax, 4
    cmp     r8d, eax
    jbe     short loc_529FD1
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_52A664
    cmp     cs:phar_globals.persist, 0
    jz      loc_52A65F
    call    free
    test    fp, fp
    jnz     loc_52A669
    jmp     loc_52A676
loc_529FD1:
    mov     qword ptr [rsp+1C8h+nSize], r8
    cmp     cs:phar_globals.persist, 0
    jz      short loc_529FF0
    mov     edi, 1; nmemb
    mov     esi, 148h; len
    call    __zend_calloc
    jmp     short loc_529FFF
loc_529FF0:
    mov     edi, 1; nmemb
    mov     esi, 148h; size
    call    _ecalloc
loc_529FFF:
    mov     esi, cs:phar_globals.persist
    mov     ecx, esi
    and     ecx, 1; persistent
    mov     edi, ecx
    shl     edi, 8
    mov     edx, 0FFFFFEFFh
    and     edx, [mydata+144h]
    or      edx, edi
    mov     [rsp+1C8h+var_1C0], mydata
    mov     [rax+144h], dx
    mov     rdx, [rsp+1C8h+sig_len]
    lea     rax, [rdx+4]
    cmp     buffer, [rsp+1C8h+var_170]
    ja      loc_52AFCB
    mov     edx, [rdx]
    test    sil, 1
    jz      short loc_52A065
    test    edx, edx
    jnz     short loc_52A065
    mov     len, [rsp+1C8h+sig_len]
    add     rdx, 8
    mov     [rsp+1C8h+sig_len], buffer
    cmp     rdx, [rsp+1C8h+var_170]
    ja      loc_52AFCB
    mov     edx, [rax]
    jmp     short loc_52A06A
loc_52A065:
    mov     [rsp+1C8h+sig_len], buffer
loc_52A06A:
    mov     edx, edx
    mov     rax, [rsp+1C8h+var_170]
    sub     rax, [rsp+1C8h+sig_len]
    mov     qword ptr [rsp+1C8h+zip_metadata_len], rdx
    cmp     rax, rdx
    jnb     short loc_52A0CD
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    cmp     [rsp+1C8h+var_1C0], 0
    jz      short loc_52A09F
    mov     rdi, [rsp+1C8h+var_1C0]; phar
    call    phar_destroy_phar_data
loc_52A09F:
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_52A695
    cmp     cs:phar_globals.persist, 0
    jz      loc_52A690
    call    free
    test    fp, fp
    jnz     loc_52A69A
    jmp     loc_52A6A7
loc_52A0CD:
    mov     r14, [rsp+1C8h+var_1C0]
    lea     rsi, [r14+128h]; tracker
    mov     rdi, [rsp+1C8h+sig_len]; buffer
    mov     rdx, qword ptr [rsp+1C8h+zip_metadata_len]; zip_metadata_len
    call    phar_parse_metadata_lazy
    lea     rdi, [r14+48h]; ht
    movzx   ecx, word ptr [r14+144h]
    shr     ecx, 8
    and     ecx, 1; persistent
    lea     rdx, destroy_phar_manifest_entry; pDestructor
    mov     [rsp+1C8h+ht], rdi
    mov     rsi, qword ptr [rsp+1C8h+nSize]; nSize
    call    _zend_hash_init
    lea     rdi, [r14+0B8h]; ht
    movzx   ecx, word ptr [r14+144h]
    shr     ecx, 8
    and     ecx, 1; persistent
    mov     esi, 5; nSize
    xor     edx, edx; pDestructor
    call    _zend_hash_init
    lea     rdi, [r14+80h]; ht
    mov     rax, qword ptr [rsp+1C8h+nSize]
    lea     esi, [rax+rax]; nSize
    movzx   ecx, word ptr [r14+144h]
    shr     ecx, 8
    and     ecx, 1; persistent
    xor     edx, edx; pDestructor
    call    _zend_hash_init
    test    byte ptr [r14+145h], 1
    jnz     short loc_52A175
    mov     rdi, [rsp+1C8h+s]; s
    mov     rsi, [rsp+1C8h+length]; length
    call    _estrndup
    jmp     short loc_52A183
loc_52A175:
    mov     rdi, [rsp+1C8h+s]; s
    mov     rsi, [rsp+1C8h+length]; length
    call    zend_strndup
loc_52A183:
    mov     rsi, [rsp+1C8h+sig_len]
    add     rsi, qword ptr [rsp+1C8h+zip_metadata_len]
    mov     r8, [rsp+1C8h+var_1C0]
    mov     [r8], rax
    mov     rax, [rsp+1C8h+length]
    mov     [r8+8], eax
    mov     rax, [rsp+1C8h+size]
    lea     rdx, [halt_offset+rax+4]
    xorps   xmm0, xmm0
    movaps  [rsp+1C8h+var_88], xmm0
    movaps  [rsp+1C8h+var_C8], xmm0
    movaps  [rsp+1C8h+var_78], xmm0
    movaps  [rsp+1C8h+var_98], xmm0
    movaps  [rsp+1C8h+var_A8], xmm0
    movaps  [rsp+1C8h+var_B8], xmm0
    movaps  xmmword ptr [rsp+1C8h+var_D8], xmm0
    movaps  xmmword ptr [rsp+1C8h+tracker.str], xmm0
    movaps  xmmword ptr [rsp+1C8h+tracker.val.value], xmm0
    movaps  xmmword ptr [rsp+1C8h+sig], xmm0
    mov     qword ptr [rsp+1C8h+var_88], r8
    mov     dword ptr [rsp+1C8h+var_C8], 0
    movzx   eax, word ptr [r8+144h]
    and     eax, 100h
    mov     word ptr [rsp+1C8h+var_78+0Ah], ax
    mov     rax, [rsp+1C8h+var_170]
    add     rax, 0FFFFFFFFFFFFFFE8h
    mov     [rsp+1C8h+var_48], rax
    xor     ecx, ecx
    mov     [rsp+1C8h+var_60], offset
    mov     [rsp+1C8h+size], rdx
    mov     edi, [rsp+1C8h+var_194]
    mov     r10d, [rsp+1C8h+var_1B4]
    jmp     short loc_52A29D
loc_52A251:
    call    _efree
loc_52A256:
    mov     r8, [rsp+1C8h+var_1C0]
    mov     rdx, qword ptr [rsp+1C8h+nSize]
    mov     edi, [rsp+1C8h+var_194]
    mov     r10d, [rsp+1C8h+var_1B4]
    mov     rsi, [rsp+1C8h+sig_len]
loc_52A26E:
    add     rsi, [rsp+1C8h+var_38]
    mov     rax, [rsp+1C8h+var_40]
    add     [rsp+1C8h+size], rax
    or      r10d, [rsp+1C8h+zip_metadata_len]
    mov     ecx, [rsp+1C8h+var_10C]
    add     ecx, 1
    cmp     edx, ecx
    jz      loc_52A788
loc_52A29D:
    mov     [rsp+1C8h+zip_metadata_len], r10d
    lea     rax, [buffer+1Ch]
    cmp     rax, [rsp+1C8h+var_170]
    ja      loc_52A6C1
    mov     r14d, [buffer]
    mov     dword ptr [rsp+1C8h+var_D8], r14d
    test    r14, r14
    jz      loc_52A70C
    add     buffer, 4; filename
    movzx   edx, word ptr [rsp+1C8h+var_78+0Ah]
    test    edx, 100h
    jz      short loc_52A2E3
    mov     dword ptr [rsp+1C8h+var_78+4], ecx
loc_52A2E3:
    mov     rax, [rsp+1C8h+var_48]
    sub     rax, buffer
    cmp     rax, r14
    jb      loc_52A74F
    cmp     edi, 1110h
    mov     [rsp+1C8h+var_10C], ecx
    jb      short loc_52A315
    lea     eax, [r14-1]
    cmp     byte ptr [buffer+rax], 2Fh ; '/'
    jnz     short loc_52A315
    or      edx, 8
    jmp     short loc_52A31B
loc_52A315:
    and     edx, 0FFF7h
loc_52A31B:
    mov     [rsp+1C8h+var_1B4], edx
    mov     word ptr [rsp+1C8h+var_78+0Ah], dx
    mov     rdi, r8; phar
    mov     rdx, r14; filename_len
    mov     [rsp+1C8h+sig_len], buffer
    call    phar_add_virtual_dirs
    test    [rsp+1C8h+var_1B4], 100h
    jnz     short loc_52A350
    mov     rdi, [rsp+1C8h+sig_len]; s
    mov     rsi, r14; length
    call    _estrndup
    jmp     short loc_52A35D
loc_52A350:
    mov     rdi, [rsp+1C8h+sig_len]; s
    mov     rsi, r14; length
    call    zend_strndup
loc_52A35D:
    mov     [rsp+1C8h+var_D8+8], rax
    mov     rdi, [rsp+1C8h+sig_len]
    mov     ecx, [rdi+r14]
    mov     dword ptr [rsp+1C8h+sig], ecx
    mov     esi, [rdi+r14+4]
    mov     dword ptr [rsp+1C8h+sig+4], esi
    mov     r8, r14
    add     rdi, r14
    add     rdi, 8
    mov     rdx, [rsp+1C8h+size]
    cmp     rdx, [rsp+1C8h+var_60]
    mov     rdx, [rsp+1C8h+var_1C0]
    jnz     short loc_52A3B1
    mov     [rdx+0F4h], esi
    mov     [rdx+0F8h], esi
    mov     ecx, [rsp+1C8h+var_1B4]
    jmp     short loc_52A3D7
loc_52A3B1:
    cmp     [rdx+0F4h], esi
    jbe     short loc_52A3C5
    mov     [rdx+0F4h], esi
    mov     ecx, [rsp+1C8h+var_1B4]
    jmp     short loc_52A3D7
loc_52A3C5:
    cmp     [rdx+0F8h], esi
    mov     ecx, [rsp+1C8h+var_1B4]
    jnb     short loc_52A3D7
    mov     [rdx+0F8h], esi
loc_52A3D7:
    mov     edx, [buffer]
    mov     dword ptr [rsp+1C8h+sig+8], edx
    mov     edx, [rdi+4]
    mov     dword ptr [rsp+1C8h+sig+0Ch], edx
    mov     edx, [rdi+8]
    mov     dword ptr [rsp+1C8h+tracker.val.value], edx
    add     rdi, 0Ch
    test    cl, 8
    jz      short loc_52A416
    add     r8d, 0FFFFFFFFh
    mov     dword ptr [rsp+1C8h+var_D8], r8d
    or      edx, 1FFh
    mov     dword ptr [rsp+1C8h+tracker.val.value], edx
loc_52A416:
    mov     r14d, [buffer]
    add     buffer, 4; buffer
    mov     rdx, [rsp+1C8h+var_170]
    sub     rdx, buffer
    cmp     rdx, r14
    jb      loc_52A76F
    mov     dword ptr [rsp+1C8h+tracker.str], 0
    mov     qword ptr [rsp+0E8h], 0
    shr     ecx, 8
    and     ecx, 1; persistent
    mov     [rsp+1C8h+sig_len], buffer
    lea     rsi, [rsp+1C8h+tracker.val.u1]; tracker
    mov     edx, r14d; zip_metadata_len
    call    phar_parse_metadata_lazy
    mov     rax, [rsp+1C8h+size]
    mov     qword ptr [rsp+1C8h+var_C8+8], rax
    mov     qword ptr [rsp+1C8h+var_B8], rax
    mov     ecx, dword ptr [rsp+1C8h+sig+8]
    mov     eax, dword ptr [rsp+1C8h+tracker.val.value]
    and     eax, 0F000h
    cmp     eax, 2000h
    mov     [rsp+1C8h+var_1B4], eax
    mov     [rsp+1C8h+var_38], r14
    mov     [rsp+1C8h+var_40], rcx
    jz      short loc_52A4BB
    movzx   eax, ax
    cmp     eax, 1000h
    jnz     short loc_52A4C9
    cmp     cs:phar_globals.has_zlib, 0
    jnz     short loc_52A4D6
    jmp     loc_52A9E7
loc_52A4BB:
    cmp     cs:phar_globals.has_bz2, 0
    jnz     short loc_52A4D6
    jmp     loc_52AA22
loc_52A4C9:
    cmp     dword ptr [rsp+1C8h+sig], ecx
    jnz     loc_52AA5D
loc_52A4D6:
    mov     eax, [rsp+1C8h+zip_metadata_len]
    shr     eax, 10h
    and     eax, 1
    movzx   ecx, word ptr [rsp+1C8h+var_78+0Ah]
    and     ecx, 0FFFFFFFEh
    or      ecx, eax
    mov     word ptr [rsp+1C8h+var_78+0Ah], cx
    lea     rdi, [rsp+1C8h+sig]; entry
    call    phar_set_inode_1
    mov     rax, [rsp+1C8h+var_1C0]
    test    byte ptr [rax+145h], 1
    jnz     short loc_52A584
    mov     rax, [rsp+1C8h+var_D8+8]
    mov     [rsp+1C8h+src], rax
    mov     eax, dword ptr [rsp+1C8h+var_D8]
    mov     [rsp+1C8h+n], rax
    lea     rdi, [rax+20h]
    and     rdi, 0FFFFFFFFFFFFFFF8h; size
    call    _emalloc
    mov     r14, rax
    mov     rax, 1600000001h
    mov     [str], rax
    mov     qword ptr [str+8], 0
    mov     rdx, [rsp+1C8h+n]; n
    mov     [str+10h], rdx
    lea     rdi, [str+18h]; dest
    mov     rsi, [rsp+1C8h+src]; src
    call    _memcpy
    mov     rax, [rsp+1C8h+n]
    mov     byte ptr [str+rax+18h], 0
    jmp     short loc_52A5A4
loc_52A584:
    mov     rdi, [rsp+1C8h+var_D8+8]
    mov     esi, dword ptr [rsp+1C8h+var_D8]
    mov     edx, 1
    lea     rax, zend_string_init_interned
    call    qword ptr [rax]
    mov     r14, rax
loc_52A5A4:
    mov     [rsp+1C8h+var_138], 0
    mov     [rsp+1C8h+var_130], 0Dh
    mov     rdi, [rsp+1C8h+ht]; ht
    mov     rsi, str; key
    lea     rdx, [rsp+1C8h+var_138]; pData
    call    zend_hash_add
    test    rax, rax
    jz      short loc_52A61C
    mov     [rsp+1C8h+n], rax
    mov     rax, [rsp+1C8h+var_1C0]
    cmp     byte ptr [rax+4Ch], 0
    js      short loc_52A5F2
    call    _emalloc_160
    jmp     short loc_52A5FC
loc_52A5F2:
    mov     edi, 0A0h; len
    call    __zend_malloc
loc_52A5FC:
    mov     rcx, [rsp+1C8h+n]
    mov     [rcx], rax
    mov     edx, 0A0h; n
    mov     rdi, rax; dest
    lea     rsi, [rsp+1C8h+sig]; src
    call    _memcpy
loc_52A61C:
    mov     eax, [str+4]
    test    al, 40h
    mov     r8, [rsp+1C8h+var_1C0]
    mov     rdx, qword ptr [rsp+1C8h+nSize]
    mov     edi, [rsp+1C8h+var_194]
    mov     r10d, [rsp+1C8h+var_1B4]
    mov     rsi, [rsp+1C8h+sig_len]
    jnz     loc_52A26E
    add     dword ptr [str], 0FFFFFFFFh
    jnz     loc_52A26E
    mov     rdi, str; ptr
    test    al, al
    jns     loc_52A251
    call    free
    jmp     loc_52A256
loc_52A65F:
    call    _efree
loc_52A664:
    test    fp, fp
    jz      short loc_52A676
loc_52A669:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52A676:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aInternalCorrup_5; "internal corruption of phar \"%s\" (too"...
    jmp     loc_52966C
loc_52A690:
    call    _efree
loc_52A695:
    test    fp, fp
    jz      short loc_52A6A7
loc_52A69A:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52A6A7:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aInternalCorrup_6; "internal corruption of phar \"%s\" (try"...
    jmp     loc_52966C
loc_52A6C1:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    mov     alias_len, r8
    call    _efree
    mov     rdi, rbp
    jmp     loc_52A975
loc_52A6D6:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+var_170]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529DE8
    lea     rdx, aPharSOpensslSi_0; "phar \"%s\" openssl signature could not"...
    jmp     loc_529DD8
loc_52A70C:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    mov     alias_len, r8
    call    _efree
    mov     rdi, rbp; phar
    call    phar_destroy_phar_data
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_52AAA7
    cmp     cs:phar_globals.persist, 0
    jz      loc_52AAA2
    call    free
    test    fp, fp
    jnz     loc_52AAAC
    jmp     loc_52AAB9
loc_52A74F:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    mov     alias_len, r8
    call    _efree
    test    rbp, rbp
    jz      loc_52A97A
    mov     rdi, [rsp+1C8h+var_1C0]
    jmp     loc_52A975
loc_52A76F:
    mov     buffer, rax; ptr
    test    ecx, 100h
    jnz     loc_52A961
    call    _efree
    jmp     loc_52A966
loc_52A788:
    lea     rdi, [r8+2Ch]; buf
    mov     str, r8
    mov     r8d, [rsp+1C8h+var_184]
    mov     ecx, r8d
    shr     ecx, 4
    and     r8d, 0Fh
    mov     r9, [rsp+1C8h+var_150]
    shr     r9d, 4
    lea     rdx, aUUU; "%u.%u.%u"
    mov     esi, 0Ch; len
    xor     eax, eax
    mov     [rsp+1C8h+var_1B4], r10d
    call    ap_php_snprintf
    mov     rax, [rsp+1C8h+var_60]
    mov     [r14+38h], rax
    mov     [r14+40h], halt_offset
    mov     eax, [rsp+1C8h+var_1B4]
    mov     [r14+0F0h], eax
    mov     r14, [r14]
    mov     rdi, r14; s
    mov     esi, 2Fh ; '/'; c
    call    _strrchr
    test    rax, rax
    jz      short loc_52A856
    mov     halt_offset, rax
    mov     rax, [rsp+1C8h+length]
    lea     rdx, [r14+rax]
    mov     [rsp+1C8h+size], rdx
    sub     rdx, endbuffer; n
    mov     rdi, endbuffer; s
    mov     esi, 2Eh ; '.'; c
    call    _memchr
    mov     rcx, [rsp+1C8h+var_1C0]
    mov     [rcx+10h], rax
    cmp     rax, endbuffer
    jnz     short loc_52A841
    lea     rdi, [endbuffer+1]; s
    not     endbuffer
    add     r12, [rsp+1C8h+size]
    mov     esi, 2Eh ; '.'; c
    mov     rdx, r12; n
    call    _memchr
    mov     rcx, [rsp+1C8h+var_1C0]
    mov     [rcx+10h], rax
loc_52A841:
    test    rax, rax
    jz      short loc_52A856
    mov     rdx, [rsp+1C8h+var_1C0]
    mov     ecx, [rdx+8]
    add     ecx, r14d
    sub     ecx, eax
    mov     [rdx+18h], ecx
loc_52A856:
    mov     rax, [rsp+1C8h+var_1C0]
    movzx   eax, word ptr [rax+144h]
    cmp     [rsp+1C8h+s2], 0
    jz      loc_52A9CA
    test    eax, 100h
    jz      loc_52AA98
    mov     rdi, [rsp+1C8h+s2]; s
    mov     rsi, alias_len; length
    call    zend_strndup
    jmp     loc_52AADD
loc_52A88B:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529DE8
    mov     fp, [r15]
    lea     rdx, aPharSMd5Signat; "phar \"%s\" MD5 signature could not be "...
    jmp     loc_52A93C
loc_52A8BA:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529DE8
    mov     fp, [r15]
    lea     rdx, aPharSSha1Signa; "phar \"%s\" SHA1 signature could not be"...
    jmp     short loc_52A93C
loc_52A8E6:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529DE8
    mov     fp, [r15]
    lea     rdx, aPharSSha256Sig; "phar \"%s\" SHA256 signature could not "...
    jmp     short loc_52A93C
loc_52A912:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529DE8
    mov     fp, [r15]
    lea     rdx, aPharSSha512Sig; "phar \"%s\" SHA512 signature could not "...
loc_52A93C:
    mov     rdi, r15; message
    xor     esi, esi; max_len
    mov     rcx, [rsp+1C8h+s]
    mov     r8, rbx
    xor     eax, eax
    call    zend_spprintf
    mov     rdi, rbx; ptr
loc_52A952:
    call    _efree
    mov     ebx, 0FFFFFFFFh
    jmp     loc_52967C
loc_52A961:
    call    free
loc_52A966:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+var_1C0]; phar
loc_52A975:
    call    phar_destroy_phar_data
loc_52A97A:
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      short loc_52A99E
    cmp     cs:phar_globals.persist, 0
    jz      short loc_52A999
    call    free
    test    fp, fp
    jnz     short loc_52A9A3
    jmp     short loc_52A9B0
loc_52A999:
    call    _efree
loc_52A99E:
    test    fp, fp
    jz      short loc_52A9B0
loc_52A9A3:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52A9B0:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aInternalCorrup_7; "internal corruption of phar \"%s\" (tru"...
    jmp     loc_52966C
loc_52A9CA:
    mov     rdi, r14; s
    test    eax, 100h
    jz      loc_52AAD3
    mov     rsi, [rsp+1C8h+length]; length
    call    zend_strndup
    jmp     loc_52AADD
loc_52A9E7:
    movzx   esi, word ptr [rsp+1C8h+var_78+0Ah]
    shr     esi, 8
    and     esi, 1; persistent
    lea     rdi, [rsp+1C8h+tracker.val.u1]; tracker
    call    phar_metadata_tracker_free
    test    byte ptr [rsp+1C8h+var_78+0Bh], 1
    mov     rdi, [rsp+1C8h+var_D8+8]; ptr
    jnz     loc_52AC87
    call    _efree
    jmp     loc_52AC8C
loc_52AA22:
    movzx   esi, word ptr [rsp+1C8h+var_78+0Ah]
    shr     esi, 8
    and     esi, 1; persistent
    lea     rdi, [rsp+1C8h+tracker.val.u1]; tracker
    call    phar_metadata_tracker_free
    test    byte ptr [rsp+1C8h+var_78+0Bh], 1
    mov     rdi, [rsp+1C8h+var_D8+8]; ptr
    jnz     loc_52ACCE
    call    _efree
    jmp     loc_52ACD3
loc_52AA5D:
    movzx   esi, word ptr [rsp+1C8h+var_78+0Ah]
    shr     esi, 8
    and     esi, 1; persistent
    lea     rdi, [rsp+1C8h+tracker.val.u1]; tracker
    call    phar_metadata_tracker_free
    test    byte ptr [rsp+1C8h+var_78+0Bh], 1
    mov     rdi, [rsp+1C8h+var_D8+8]; ptr
    jnz     loc_52AD15
    call    _efree
    jmp     loc_52AD1A
loc_52AA98:
    mov     rdi, [rsp+1C8h+s2]
    mov     rsi, alias_len
    jmp     short loc_52AAD8
loc_52AAA2:
    call    _efree
loc_52AAA7:
    test    fp, fp
    jz      short loc_52AAB9
loc_52AAAC:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52AAB9:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aZeroLengthFile; "zero-length filename encountered in pha"...
    jmp     loc_52966C
loc_52AAD3:
    mov     rsi, [rsp+1C8h+length]; length
loc_52AAD8:
    call    _estrndup
loc_52AADD:
    cmp     [rsp+1C8h+s2], 0
    mov     rcx, [rsp+1C8h+length]
    cmovnz  ecx, ebp
    mov     r14, [rsp+1C8h+var_1C0]
    mov     [r14+20h], rax
    mov     [r14+28h], ecx
    mov     eax, [rsp+1C8h+var_174]
    mov     [r14+114h], eax
    mov     [r14+100h], fp
    mov     eax, dword ptr [rsp+1C8h+var_140]
    mov     [r14+118h], eax
    mov     rax, [rsp+1C8h+ptr]
    mov     [r14+120h], rax
    call    phar_request_initialize
    movzx   eax, word ptr [r14+144h]
    cmp     [rsp+1C8h+var_11C], 0
    jz      loc_52ABDB
    and     eax, 0FFFFFFFEh
    movzx   ecx, word ptr [rsp+1C8h+var_144]
    or      ecx, eax
    mov     rax, [rsp+1C8h+var_1C0]
    mov     [rax+144h], cx
    mov     rdi, [rax+20h]; alias
    mov     esi, [rax+28h]; alias_len
    call    phar_validate_alias_1
    test    eax, eax
    jz      loc_52AC45
    lea     rdi, phar_globals.phar_alias_map; ht
    mov     rsi, [rsp+1C8h+s2]; str
    mov     rdx, alias_len; len
    call    zend_hash_str_find
    test    rax, rax
    jz      short loc_52ABEF
    mov     rdi, [rax]; phar
    mov     rsi, [rsp+1C8h+s2]; alias
    mov     rdx, alias_len; alias_len
    call    phar_free_alias
    test    eax, eax
    jz      short loc_52ABEF
    mov     [rsp+1C8h+ptr], 0
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+var_1C0]; phar
    call    phar_destroy_phar_data
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_52AEC0
    cmp     cs:phar_globals.persist, 0
    jz      loc_52AEBB
    call    free
    jmp     loc_52AEC0
loc_52ABDB:
    or      eax, 1
    mov     rcx, [rsp+1C8h+var_1C0]
    mov     [rcx+144h], ax
    jmp     loc_52AEDF
loc_52ABEF:
    mov     rax, [rsp+1C8h+var_1C0]
    test    byte ptr [rax+145h], 1
    jnz     loc_52AD5C
    lea     rdi, [alias_len+20h]
    and     rdi, 0FFFFFFFFFFFFFFF8h; size
    call    _emalloc
    mov     fp, rax
    mov     rax, 1600000001h
    mov     [str], rax
    mov     qword ptr [str+8], 0
    mov     [str+10h], alias_len
    lea     rdi, [str+18h]; dest
    mov     rsi, [rsp+1C8h+s2]; src
    mov     rdx, alias_len; n
    call    _memcpy
    mov     byte ptr [str+alias_len+18h], 0
    jmp     loc_52AD75
loc_52AC45:
    mov     [rsp+1C8h+ptr], 0
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+var_1C0]; phar
    call    phar_destroy_phar_data
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_52AEA1
    cmp     cs:phar_globals.persist, 0
    jz      loc_52AE9C
    call    free
    jmp     loc_52AEA1
loc_52AC87:
    call    free
loc_52AC8C:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+var_1C0]; phar
    call    phar_destroy_phar_data
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_52AE0E
    cmp     cs:phar_globals.persist, 0
    jz      loc_52AE09
    call    free
    test    fp, fp
    jnz     loc_52AE13
    jmp     loc_52AE20
loc_52ACCE:
    call    free
loc_52ACD3:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+var_1C0]; phar
    call    phar_destroy_phar_data
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_52AE3F
    cmp     cs:phar_globals.persist, 0
    jz      loc_52AE3A
    call    free
    test    fp, fp
    jnz     loc_52AE44
    jmp     loc_52AE51
loc_52AD15:
    call    free
loc_52AD1A:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+var_1C0]; phar
    call    phar_destroy_phar_data
    mov     rdi, [rsp+1C8h+ptr]; ptr
    test    signature, signature
    jz      loc_52AE70
    cmp     cs:phar_globals.persist, 0
    jz      loc_52AE6B
    call    free
    test    fp, fp
    jnz     loc_52AE75
    jmp     loc_52AE82
loc_52AD5C:
    mov     rdi, [rsp+1C8h+s2]
    mov     rsi, alias_len
    mov     edx, 1
    lea     rax, zend_string_init_interned
    call    qword ptr [rax]
    mov     fp, rax
loc_52AD75:
    mov     rax, [rsp+1C8h+var_1C0]
    mov     [rsp+1C8h+var_138], rax
    mov     [rsp+1C8h+var_130], 0Dh
    lea     rdi, phar_globals.phar_alias_map; ht
    lea     rdx, [rsp+1C8h+var_138]; pData
    mov     rsi, str; key
    call    zend_hash_add
    test    rax, rax
    mov     eax, [str+4]
    test    al, 40h
    jnz     loc_52AEDF
    add     dword ptr [str], 0FFFFFFFFh
    jnz     loc_52AEDF
    mov     rdi, str; ptr
    test    al, al
    js      loc_52AEDA
    call    _efree
    jmp     loc_52AEDF
loc_52ADD0:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    mov     rdi, [rsp+1C8h+var_170]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529DE8
    mov     fp, [r15]
    lea     rdx, aPharSOpensslSi_1; "phar \"%s\" openssl signature could not"...
    jmp     loc_52A93C
loc_52AE09:
    call    _efree
loc_52AE0E:
    test    fp, fp
    jz      short loc_52AE20
loc_52AE13:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52AE20:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aZlibExtensionI_0; "zlib extension is required for gz compr"...
    jmp     loc_52966C
loc_52AE3A:
    call    _efree
loc_52AE3F:
    test    fp, fp
    jz      short loc_52AE51
loc_52AE44:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52AE51:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aBz2ExtensionIs; "bz2 extension is required for bzip2 com"...
    jmp     loc_52966C
loc_52AE6B:
    call    _efree
loc_52AE70:
    test    fp, fp
    jz      short loc_52AE82
loc_52AE75:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52AE82:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aInternalCorrup_8; "internal corruption of phar \"%s\" (com"...
    jmp     loc_52966C
loc_52AE9C:
    call    _efree
loc_52AEA1:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aCannotOpenArch; "Cannot open archive \"%s\", invalid ali"...
    jmp     loc_52966C
loc_52AEBB:
    call    _efree
loc_52AEC0:
    mov     ebx, 0FFFFFFFFh
    test    r15, r15
    jz      loc_52967C
    lea     rdx, aCannotOpenArch_0; "Cannot open archive \"%s\", alias is al"...
    jmp     loc_52966C
loc_52AEDA:
    call    free
loc_52AEDF:
    mov     rax, [rsp+1C8h+var_1C0]
    test    byte ptr [rax+145h], 1
    jnz     short loc_52AF39
    mov     rax, [rsp+1C8h+var_1C0]
    mov     r14, [rax]
    mov     alias_len, [rsp+1C8h+length]
    lea     rdi, [rbp+20h]
    and     rdi, 0FFFFFFFFFFFFFFF8h; size
    call    _emalloc
    mov     rbx, rax
    mov     rax, 1600000001h
    mov     [str], rax
    mov     qword ptr [str+8], 0
    mov     [str+10h], rbp
    lea     rdi, [str+18h]; dest
    mov     rsi, r14; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     byte ptr [str+rbp+18h], 0
    jmp     short loc_52AF57
loc_52AF39:
    mov     rax, [rsp+1C8h+var_1C0]
    mov     rdi, [rax]
    mov     rsi, [rsp+1C8h+length]
    mov     edx, 1
    lea     rax, zend_string_init_interned
    call    qword ptr [rax]
    mov     rbx, rax
loc_52AF57:
    mov     rax, [rsp+1C8h+var_1C0]
    mov     [rsp+1C8h+var_138], rax
    mov     [rsp+1C8h+var_130], 0Dh
    lea     rdi, phar_globals.phar_fname_map; ht
    lea     rdx, [rsp+1C8h+var_138]; pData
    mov     rsi, str; key
    call    zend_hash_add
    test    rax, rax
    mov     eax, [str+4]
    test    al, 40h
    jnz     short loc_52AFA8
    add     dword ptr [str], 0FFFFFFFFh
    jnz     short loc_52AFA8
    mov     rdi, str; ptr
    test    al, al
    js      short loc_52AFA3
    call    _efree
    jmp     short loc_52AFA8
loc_52AFA3:
    call    free
loc_52AFA8:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    xor     ebx, ebx
    test    r13, r13
    jz      loc_52967C
    mov     rax, [rsp+1C8h+var_1C0]
    mov     [r13+0], rax
    jmp     loc_52967C
loc_52AFCB:
    mov     rdi, [rsp+1C8h+var_1B0]; ptr
    call    _efree
    cmp     [rsp+1C8h+var_1C0], 0
    jz      loc_529A0A
    mov     rdi, [rsp+1C8h+var_1C0]; phar
    call    phar_destroy_phar_data
    jmp     loc_529A0A
phar_parse_pharfile endp

