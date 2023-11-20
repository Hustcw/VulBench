phar_parse_pharfile proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 78h
    mov     rbx, halt_offset
    mov     r14, fname
    mov     rbp, fp
    mov     r15, [rsp+0A8h+error]
    mov     rax, [rsp+0A8h+pphar]
    mov     [rsp+0A8h+ptr], 0
    test    rax, rax
    jz      short loc_52934C
    mov     qword ptr [rax], 0
loc_52934C:
    test    r15, r15
    jz      short loc_529358
    mov     qword ptr [r15], 0
loc_529358:
    mov     rdi, fp; stream
    mov     rsi, halt_offset; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      loc_52946A
    lea     rsi, [rsp+0A8h+buf]; buf
    mov     edx, 3; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 3
    jnz     short loc_5293D5
    mov     al, [rsp+0A8h+buf]
    cmp     al, 20h ; ' '
    jz      short loc_529392
    cmp     al, 0Ah
    jnz     short loc_52940E
loc_529392:
    cmp     [rsp+0A8h+buf+1], 3Fh ; '?'
    jnz     short loc_52940E
    cmp     [rsp+0A8h+buf+2], 3Eh ; '>'
    jnz     short loc_52940E
    mov     rdi, fp; stream
    call    _php_stream_getc
    cmp     eax, 0FFFFFFFFh
    jz      short loc_5293D5
    movzx   eax, al
    cmp     eax, 0Dh
    jnz     short loc_5293FC
    mov     rdi, fp; stream
    call    _php_stream_getc
    cmp     eax, 0FFFFFFFFh
    jz      short loc_5293D5
    movzx   eax, al
    cmp     eax, 0Ah
    jnz     short loc_5293D5
    add     rbx, 4
    mov     eax, 0Ah
    jmp     short loc_529400
loc_5293D5:
    test    fp, fp
    jz      short loc_5293E7
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_5293E7:
    test    r15, r15
    jz      loc_529497
    lea     rdx, aInternalCorrup_1; "internal corruption of phar \"%s\" (tru"...
    jmp     loc_529488
loc_5293FC:
    add     rbx, 3
loc_529400:
    mov     rcx, rbx
    xor     ebx, ebx
    cmp     eax, 0Ah
    setz    bl
    add     rbx, halt_offset
loc_52940E:
    mov     rdi, fp; stream
    mov     rsi, halt_offset; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      short loc_52946A
    lea     rsi, [rsp+0A8h+buf]; buf
    mov     edx, 4; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 4
    jnz     short loc_5294AB
    mov     r13d, dword ptr [rsp+0A8h+buf]
    cmp     r13, 6400001h
    jb      loc_5294CB
    test    fp, fp
    jz      short loc_52945C
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52945C:
    test    r15, r15
    jz      short loc_529497
    lea     rdx, aManifestCannot; "manifest cannot be larger than 100 MB i"...
    jmp     short loc_529488
loc_52946A:
    test    fp, fp
    jz      short loc_52947C
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52947C:
    test    r15, r15
    jz      short loc_529497
    lea     rdx, aCannotSeekToHa; "cannot seek to __HALT_COMPILER(); locat"...
loc_529488:
    mov     rdi, r15; message
    xor     esi, esi; max_len
    mov     rcx, fname
    xor     eax, eax
    call    zend_spprintf
loc_529497:
    mov     eax, 0FFFFFFFFh
    add     rsp, 78h
    pop     rbx
    pop     r12
    pop     r13
    pop     fname
    pop     r15
    pop     fp
    retn
loc_5294AB:
    test    fp, fp
    jz      short loc_5294BD
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_5294BD:
    test    r15, r15
    jz      short loc_529497
    lea     rdx, aInternalCorrup_2; "internal corruption of phar \"%s\" (tru"...
    jmp     short loc_529488
loc_5294CB:
    mov     rdi, r13; size
    call    _emalloc
    mov     r12, rax
    cmp     r13d, 0Ah
    jb      loc_529567
    mov     rdi, fp; stream
    mov     rsi, savebuf; buf
    mov     rdx, r13; size
    call    _php_stream_read
    cmp     rax, r13
    jnz     short loc_529567
    cmp     dword ptr [savebuf], 0
    jz      loc_5295BA
    movzx   ebx, byte ptr [savebuf+4]
    cmp     ebx, 0Fh
    ja      loc_5295F0
    movzx   r13d, byte ptr [savebuf+5]
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    mov     r8d, ebx
    shr     r8d, 4
    and     ebx, 0Fh
    shr     r13d, 4
    sub     rsp, 8
    lea     rdx, aPharSIsApiVers; "phar \"%s\" is API version %1.u.%1.u.%1"...
    mov     rdi, r15; message
    xor     esi, esi; max_len
    mov     rcx, fname
    mov     r9d, ebx
    xor     eax, eax
    push    r13
    call    zend_spprintf
    add     rsp, 10h
    jmp     loc_529497
loc_529567:
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, [rsp+0A8h+ptr]; ptr
    test    signature, signature
    jz      short loc_529593
    cmp     cs:phar_globals.persist, 0
    jz      short loc_52958E
    call    free
    test    fp, fp
    jnz     short loc_529598
    jmp     short loc_5295A5
loc_52958E:
    call    _efree
loc_529593:
    test    fp, fp
    jz      short loc_5295A5
loc_529598:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_5295A5:
    test    r15, r15
    jz      loc_529497
    lea     rdx, aInternalCorrup_3; "internal corruption of phar \"%s\" (tru"...
    jmp     loc_529488
loc_5295BA:
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, [rsp+0A8h+ptr]; ptr
    test    signature, signature
    jz      loc_52975A
    cmp     cs:phar_globals.persist, 0
    jz      loc_529755
    call    free
    test    fp, fp
    jnz     loc_52975F
    jmp     loc_52976C
loc_5295F0:
    mov     eax, [rsp+0A8h+compression]
    or      eax, [savebuf+6]
    test    eax, 10000h
    jnz     short loc_52963A
    cmp     cs:phar_globals.require_hash, 0
    jz      loc_529781
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    lea     rdx, aTarBasedPharSD+0Ah; "phar \"%s\" does not have a signature"
    jmp     loc_529488
loc_52963A:
    mov     rdi, fp; stream
    mov     rsi, 0FFFFFFFFFFFFFFF8h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      loc_529A35
    mov     rdi, fp; stream
    call    _php_stream_tell
    cmp     read_len, 14h
    jl      loc_529A35
    lea     rsi, [rsp+0A8h+size]; buf
    mov     edx, 8; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 8
    jnz     loc_529A35
    cmp     dword ptr [rsp+0A8h+size+4], 424D4247h
    jnz     loc_529A35
    mov     eax, dword ptr [rsp+0A8h+size]
    add     eax, 0FFFFFFFFh; switch 16 cases
    cmp     eax, 0Fh
    ja      def_5296B1; jumptable 00000000005296B1 default case, cases 5-15
    lea     rcx, jpt_5296B1
    movsxd  rax, ds:(jpt_5296B1 - 891DF0h)[rcx+rax*4]
    add     rax, rcx
def_5296B1:
    jmp     rax; switch jump
    mov     rdi, fp; jumptable 00000000005296B1 case 1
    mov     rsi, 0FFFFFFFFFFFFFFE8h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     rbx, rax
    lea     rsi, [rsp+0A8h+sig]; buf
    mov     edx, 10h; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 10h
    jnz     loc_529A35
    sub     rsp, 8
    lea     rax, [rsp+0B0h+var_90]
    lea     r10, [rsp+0B0h+ptr]
    lea     rcx, [rsp+0B0h+sig]; sig
    mov     r8d, 10h; sig_len
    mov     rdi, fp; fp
    mov     rsi, read_len; end_of_phar
    mov     edx, 1; sig_type
    mov     r9, fname; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_52978A
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    mov     read_len, [r15]
    lea     rdx, aPharSMd5Signat; "phar \"%s\" MD5 signature could not be "...
    jmp     loc_529A16
loc_529755:
    call    _efree
loc_52975A:
    test    fp, fp
    jz      short loc_52976C
loc_52975F:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_52976C:
    test    r15, r15
    jz      loc_529497
    lea     rdx, aInPharSManifes; "in phar \"%s\", manifest claims to have"...
    jmp     loc_529488
loc_529781:
    mov     [rsp+0A8h+var_90], 0
loc_52978A:
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, [rsp+0A8h+ptr]; ptr
    cmp     r13d, 0Dh
    ja      short loc_5297B7
    test    signature, signature
    jz      short loc_5297D6
    cmp     cs:phar_globals.persist, 0
    jz      short loc_5297D1
    call    free
    test    fp, fp
    jnz     short loc_5297DB
    jmp     short loc_5297E8
loc_5297B7:
    test    signature, signature
    jz      short loc_529802
    cmp     cs:phar_globals.persist, 0
    jz      short loc_5297FD
    call    free
    test    fp, fp
    jnz     short loc_529807
    jmp     short loc_529814
loc_5297D1:
    call    _efree
loc_5297D6:
    test    fp, fp
    jz      short loc_5297E8
loc_5297DB:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_5297E8:
    test    r15, r15
    jz      loc_529497
    lea     rdx, aInternalCorrup_4; "internal corruption of phar \"%s\" (buf"...
    jmp     loc_529488
loc_5297FD:
    call    _efree
loc_529802:
    test    fp, fp
    jz      short loc_529814
loc_529807:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_529814:
    test    r15, r15
    jz      loc_529497
    lea     rdx, aInternalCorrup_5; "internal corruption of phar \"%s\" (too"...
    jmp     loc_529488
    mov     rdi, fp; jumptable 00000000005296B1 case 2
    mov     rsi, 0FFFFFFFFFFFFFFE4h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     rbx, rax
    lea     rsi, [rsp+0A8h+sig]; buf
    mov     edx, 14h; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 14h
    jnz     loc_529A35
    sub     rsp, 8
    lea     rax, [rsp+0B0h+var_90]
    lea     r10, [rsp+0B0h+ptr]
    lea     rcx, [rsp+0B0h+sig]; sig
    mov     r8d, 14h; sig_len
    mov     rdi, fp; fp
    mov     rsi, read_len; end_of_phar
    mov     edx, 2; sig_type
    mov     r9, fname; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jnz     loc_52978A
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    mov     read_len, [r15]
    lea     rdx, aPharSSha1Signa; "phar \"%s\" SHA1 signature could not be"...
    jmp     loc_529A16
    mov     rdi, fp; jumptable 00000000005296B1 case 3
    mov     rsi, 0FFFFFFFFFFFFFFD8h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     rbx, rax
    lea     rsi, [rsp+0A8h+sig]; buf
    mov     edx, 20h ; ' '; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 20h ; ' '
    jnz     loc_529A35
    sub     rsp, 8
    lea     rax, [rsp+0B0h+var_90]
    lea     r10, [rsp+0B0h+ptr]
    lea     rcx, [rsp+0B0h+sig]; sig
    mov     r8d, 20h ; ' '; sig_len
    mov     rdi, fp; fp
    mov     rsi, read_len; end_of_phar
    mov     edx, 3; sig_type
    mov     r9, fname; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jnz     loc_52978A
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    mov     read_len, [r15]
    lea     rdx, aPharSSha256Sig; "phar \"%s\" SHA256 signature could not "...
    jmp     loc_529A16
    mov     rdi, fp; jumptable 00000000005296B1 case 4
    mov     rsi, 0FFFFFFFFFFFFFFB8h; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     rbx, rax
    lea     rsi, [rsp+0A8h+sig]; buf
    mov     edx, 40h ; '@'; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 40h ; '@'
    jnz     loc_529A35
    sub     rsp, 8
    lea     rax, [rsp+0B0h+var_90]
    lea     r10, [rsp+0B0h+ptr]
    lea     rcx, [rsp+0B0h+sig]; sig
    mov     r8d, 40h ; '@'; sig_len
    mov     rdi, fp; fp
    mov     rsi, read_len; end_of_phar
    mov     edx, 4; sig_type
    mov     r9, fname; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jnz     loc_52978A
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    mov     read_len, [r15]
    lea     rdx, aPharSSha512Sig; "phar \"%s\" SHA512 signature could not "...
loc_529A16:
    mov     rdi, r15; message
    xor     esi, esi; max_len
    mov     rcx, fname
    mov     r8, rbx
    xor     eax, eax
    call    zend_spprintf
    mov     rdi, rbx; ptr
    call    _efree
    jmp     loc_529497
loc_529A35:
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    lea     rdx, aPharSHasA; "phar \"%s\" has a "
    jmp     loc_529488
    mov     rdi, savebuf; jumptable 00000000005296B1 default case, cases 5-15
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    lea     rdx, aPharSHasA_0; "phar \"%s\" has a "
    jmp     loc_529488
    mov     rdi, fp; jumptable 00000000005296B1 case 16
    mov     rsi, 0FFFFFFFFFFFFFFF4h; offset
    mov     edx, 1; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      loc_529B62
    lea     rsi, [rsp+0A8h+size]; buf
    mov     edx, 4; size
    mov     rdi, fp; stream
    call    _php_stream_read
    cmp     rax, 4
    jnz     loc_529B62
    mov     ebx, dword ptr [rsp+0A8h+size]
    mov     rdi, signature_len; size
    call    _emalloc
    mov     [rsp+0A8h+var_98], rax
    lea     esi, [signature_len+4]
    neg     whence; offset
    mov     rdi, fp; stream
    mov     edx, 1; whence
    call    _php_stream_seek
    cmp     eax, 0FFFFFFFFh
    jz      loc_529B8C
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     [rsp+0A8h+var_80], end_of_phar
    test    rax, rax
    jz      loc_529B8C
    mov     rdi, fp; stream
    mov     rsi, [rsp+0A8h+var_98]; buf
    mov     rdx, signature_len; size
    call    _php_stream_read
    cmp     rax, signature_len
    jnz     short loc_529B8C
    sub     rsp, 8
    lea     rax, [rsp+0B0h+var_90]
    lea     r10, [rsp+0B0h+ptr]
    mov     rdi, fp; fp
    mov     rsi, [rsp+0B0h+var_80]; end_of_phar
    mov     edx, 10h; sig_type
    mov     rcx, [rsp+0B0h+var_98]; sig
    mov     r8, signature_len; sig_len
    mov     r9, fname; fname
    push    r15; error
    push    rax; signature_len
    push    r10; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jz      short loc_529BC0
    mov     rdi, [rsp+0A8h+var_98]; ptr
    call    _efree
    jmp     loc_52978A
loc_529B62:
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    lea     rdx, aPharSOpensslSi; "phar \"%s\" openssl signature length co"...
    jmp     loc_529488
loc_529B8C:
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, [rsp+0A8h+var_98]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    lea     rdx, aPharSOpensslSi_0; "phar \"%s\" openssl signature could not"...
    jmp     loc_529488
loc_529BC0:
    mov     rdi, savebuf; ptr
    call    _efree
    mov     rdi, [rsp+0A8h+var_98]; ptr
    call    _efree
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    r15, r15
    jz      loc_529497
    mov     signature_len, [r15]
    lea     rdx, aPharSOpensslSi_1; "phar \"%s\" openssl signature could not"...
    jmp     loc_529A16
phar_parse_pharfile endp

