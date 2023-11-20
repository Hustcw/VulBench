phar_parse_zipfile proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 101A8h
    mov     rbx, pphar
    mov     [rsp+101D8h+len], alias_len
    mov     [rsp+101D8h+var_10078], alias
    mov     rbp, fname_len
    mov     r14, fname
    mov     r15, fp
    mov     r12, [rsp+101D8h+error_0]
    xorps   xmm0, xmm0
    movaps  [rsp+101D8h+var_100D8], xmm0
    movaps  [rsp+101D8h+var_100E8], xmm0
    movaps  [rsp+101D8h+var_100F8], xmm0
    movaps  [rsp+101D8h+var_10108], xmm0
    movaps  xmmword ptr [rsp+101D8h+maxlen], xmm0
    movaps  [rsp+101D8h+var_10128], xmm0
    movaps  xmmword ptr [rsp+101D8h+filename_len], xmm0
    movaps  xmmword ptr [rsp+101D8h+tracker.str], xmm0
    movaps  xmmword ptr [rsp+101D8h+tracker.val.value], xmm0
    movaps  [rsp+101D8h+src], xmm0
    call    _php_stream_tell
    cmp     rax, 10017h
    jb      short loc_518188
    mov     rdi, fp; stream
    mov     rsi, 0FFFFFFFFFFFEFFEAh; offset
    mov     edx, 2; whence
    call    _php_stream_seek
    mov     r13d, 10016h
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_518197
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     ebx, 0FFFFFFFFh
    test    r12, r12
    jz      loc_518281
    lea     rdx, aPharErrorUnabl_8; "phar error: unable to search for end of"...
    jmp     loc_518242
loc_518188:
    mov     r13, rax
    mov     rdi, fp; stream
    xor     esi, esi; offset
    xor     edx, edx; whence
    call    _php_stream_seek
loc_518197:
    lea     rsi, [rsp+101D8h+s]; buf
    mov     rdi, fp; stream
    mov     rdx, size; size
    call    _php_stream_read
    test    rax, rax
    jz      short loc_518224
    mov     [rsp+101D8h+length], fname_len
    mov     [rsp+101D8h+var_101B0], fname
    mov     [rsp+101D8h+var_100A8], pphar
    lea     r14, [rsp+101D8h+s]
    mov     rdi, r14; s
    mov     rsi, size; n
    call    phar_find_eocd
    test    rax, rax
    jz      short loc_51824F
    mov     rbx, rax
    movzx   eax, byte ptr [rax+6]
    movzx   ecx, byte ptr [p+7]
    shl     ecx, 8
    movzx   ecx, cx
    or      ecx, eax
    jnz     short loc_518204
    movzx   eax, byte ptr [p+4]
    movzx   ecx, byte ptr [p+5]
    shl     ecx, 8
    movzx   ecx, cx
    or      ecx, eax
    jz      loc_518295
loc_518204:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     ebx, 0FFFFFFFFh
    test    r12, r12
    jz      short loc_518281
    lea     rdx, aPharErrorSplit; "phar error: split archives spanning mul"...
    jmp     short loc_51826D
loc_518224:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     ebx, 0FFFFFFFFh
    test    r12, r12
    jz      short loc_518281
    lea     rdx, aPharErrorUnabl_9; "phar error: unable to read in data to s"...
loc_518242:
    mov     esi, 1000h
    mov     rdi, r12
    mov     rcx, fname
    jmp     short loc_51827A
loc_51824F:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     ebx, 0FFFFFFFFh
    test    r12, r12
    jz      short loc_518281
    lea     rdx, aPharErrorEndOf; "phar error: end of central directory no"...
loc_51826D:
    mov     esi, 1000h; max_len
    mov     rdi, r12; message
    mov     rcx, [rsp+101D8h+var_101B0]
loc_51827A:
    xor     eax, eax
    call    zend_spprintf
loc_518281:
    mov     eax, ebx
    add     rsp, 101A8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_518295:
    movzx   eax, byte ptr [p+8]
    movsx   ecx, byte ptr [p+9]
    movzx   edx, byte ptr [p+0Ah]
    movsx   esi, byte ptr [p+0Bh]
    shl     ecx, 8
    movzx   ecx, cx
    or      ecx, eax
    shl     esi, 8
    movzx   eax, si
    or      eax, edx
    mov     qword ptr [rsp+101D8h+nSize], rcx
    cmp     ecx, eax
    jnz     short loc_518315
    movzx   eax, byte ptr [p+10h]
    mov     [rsp+101D8h+ht], rax
    movzx   eax, byte ptr [p+11h]
    mov     [rsp+101D8h+var_100C8], rax
    movzx   eax, byte ptr [p+12h]
    mov     [rsp+101D8h+var_101A0], rax
    movzx   eax, byte ptr [p+13h]
    mov     [rsp+101D8h+offset], rax
    movzx   ebp, byte ptr [p+14h]
    movsx   r12d, byte ptr [p+15h]
    lea     rax, phar_globals
    cmp     dword ptr [rax+0C4h], 0
    jz      short loc_51834C
    mov     edi, 1; nmemb
    mov     esi, 148h; len
    call    __zend_calloc
    jmp     short loc_51835B
loc_518315:
    test    r12, r12
    jz      short loc_518335
    lea     rdx, aPharErrorCorru; "phar error: corrupt zip archive, confli"...
    mov     esi, 1000h; max_len
    mov     rdi, r12; message
    mov     rcx, [rsp+101D8h+var_101B0]
    xor     eax, eax
    call    zend_spprintf
loc_518335:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     ebx, 0FFFFFFFFh
    jmp     loc_518281
loc_51834C:
    mov     edi, 1; nmemb
    mov     esi, 148h; size
    call    _ecalloc
loc_51835B:
    lea     rcx, phar_globals
    mov     ecx, [rcx+0C4h]
    lea     rdx, [mydata+144h]
    mov     [rsp+101D8h+var_101D0], rdx
    and     ecx, 1; persistent
    mov     edx, ecx
    shl     edx, 8
    mov     esi, 0FFFFFEFFh
    and     esi, [mydata+144h]
    or      esi, edx
    mov     [mydata+144h], si
    shl     r12d, 8
    or      r12, rbp
    test    r12w, r12w
    mov     [rsp+101D8h+phar], mydata
    jz      short loc_5183DF
    add     p, 16h
    movzx   edx, r12w; zip_metadata_len
    add     size, r14
    sub     r13, metadata
    cmp     r13, rdx
    mov     rdi, [rsp+101D8h+error_0]; message
    jnz     loc_518E69
    mov     rbp, [rsp+101D8h+phar]
    lea     rsi, [error+128h]; tracker
    mov     rdi, metadata; buffer
    call    phar_parse_metadata_lazy
    mov     r13, error
    movzx   esi, word ptr [error+144h]
    jmp     short loc_5183EE
loc_5183DF:
    mov     dword ptr [rax+130h], 0
    xor     ebx, ebx
    mov     size, rax
loc_5183EE:
    mov     rdi, [rsp+101D8h+var_101B0]; s
    test    esi, 100h
    mov     rbp, [rsp+101D8h+length]
    mov     rsi, rbp; length
    jnz     short loc_51840A
    call    _estrndup
    jmp     short loc_51840F
loc_51840A:
    call    zend_strndup
loc_51840F:
    mov     r14, rax
    mov     [rsp+101D8h+var_100B8], r12
    mov     r12, r13
    mov     [r13+0], rax
    or      byte ptr [r13+144h], 20h
    mov     [r13+8], ebp
    mov     rdi, rax; s
    mov     esi, 2Fh ; '/'; c
    call    _strrchr
    test    rax, rax
    jz      short loc_51848D
    mov     rbp, rax
    add     r14, [rsp+101D8h+length]
    mov     rdx, r14
    sub     rdx, rax; n
    mov     rdi, rax; s
    mov     esi, 2Eh ; '.'; c
    call    _memchr
    mov     [r12+10h], rax
    cmp     rax, ext
    jnz     short loc_518480
    lea     rdi, [ext+1]; s
    not     ext
    add     rbp, r14
    mov     esi, 2Eh ; '.'; c
    mov     rdx, rbp; n
    call    _memchr
    mov     [r12+10h], rax
loc_518480:
    test    rax, rax
    jz      short loc_51848D
    sub     r14d, eax
    mov     [r12+18h], r14d
loc_51848D:
    mov     rax, [rsp+101D8h+var_100C8]
    mov     rcx, rax
    shl     rcx, 8
    add     rcx, [rsp+101D8h+ht]
    mov     rax, [rsp+101D8h+var_101A0]
    shl     rax, 10h
    or      rax, rcx
    mov     rsi, [rsp+101D8h+offset]
    shl     rsi, 18h
    or      rsi, rax; offset
    xor     r14d, r14d
    mov     rdi, fp; stream
    mov     [rsp+101D8h+offset], rsi
    xor     edx, edx; whence
    call    _php_stream_seek
    lea     rdi, [r12+48h]; ht
    movzx   ecx, word ptr [r12+144h]
    shr     ecx, 8
    and     ecx, 1; persistent
    lea     rdx, destroy_phar_manifest_entry; pDestructor
    mov     [rsp+101D8h+ht], rdi
    mov     rbp, qword ptr [rsp+101D8h+nSize]
    mov     esi, ebp; nSize
    call    _zend_hash_init
    lea     rdi, [r12+0B8h]; ht
    movzx   ecx, word ptr [r12+144h]
    shr     ecx, 8
    and     ecx, 1; persistent
    mov     [rsp+101D8h+var_101C8], rdi
    mov     esi, 5; nSize
    xor     edx, edx; pDestructor
    call    _zend_hash_init
    lea     rdi, [r12+80h]; ht
    lea     esi, [rbp+rbp+0]; nSize
    movzx   ecx, word ptr [r12+144h]
    shr     ecx, 8
    and     ecx, 1; persistent
    mov     [rsp+101D8h+var_101C0], rdi
    xor     edx, edx; pDestructor
    call    _zend_hash_init
    mov     qword ptr [rsp+101D8h+var_100E8], r12
    movzx   eax, word ptr [rsp+101D8h+var_100D8+0Ah]
    mov     dword ptr [rsp+101D8h+var_10128], 0
    movzx   ecx, word ptr [r12+144h]
    and     ecx, 100h
    and     eax, 0FFFFFE7Fh
    lea     eax, [rax+rcx]
    add     eax, 80h
    mov     word ptr [rsp+101D8h+var_100D8+0Ah], ax
    mov     r13d, 0
    test    ebp, ebp
    mov     rbp, [rsp+101D8h+error_0]
    jz      loc_518EAE
    lea     rax, [fp+0B0h]
    mov     [rsp+101D8h+var_10068], rax
    lea     rax, [fp+10h]
    mov     [rsp+101D8h+chain], rax
    movzx   eax, word ptr [rsp+101D8h+var_100B8]
    mov     [rsp+101D8h+count], rax
    lea     rax, [r12+120h]
    mov     [rsp+101D8h+signature], rax
    mov     rax, qword ptr [rsp+101D8h+nSize]
    neg     eax
    mov     qword ptr [rsp+101D8h+nSize], rax
    xor     r13d, r13d
    jmp     short loc_51862E
loc_5185F6:
    call    _emalloc_160
loc_5185FB:
    mov     [rbp+0], rax
    mov     edx, 0A0h; n
    mov     rdi, rax; dest
    lea     rsi, [rsp+101D8h+src]; src
    call    _memcpy
loc_518611:
    add     r14d, 1
    mov     rax, qword ptr [rsp+101D8h+nSize]
    add     eax, r14d
    mov     rbp, [rsp+101D8h+error_0]
    jz      loc_518EAE
loc_51862E:
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     [rsp+101D8h+var_100B8], rax
    mov     dword ptr [rsp+101D8h+tracker.str], 0
    mov     qword ptr [rsp+98h], 0
    mov     edx, 2Eh ; '.'; size
    mov     rdi, fp; stream
    lea     rsi, [rsp+101D8h+var_10198]; buf
    call    _php_stream_read
    cmp     rax, 2Eh ; '.'
    jnz     loc_519141
    cmp     dword ptr [rsp+101D8h+var_10198.value], 2014B50h
    jnz     loc_5191DF
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    jz      short loc_518691
    mov     dword ptr [rsp+101D8h+var_100D8+4], r14d
loc_518691:
    mov     eax, [rsp+101D8h+var_10188]
    mov     ecx, [rsp+101D8h+var_10184]
    mov     dword ptr [rsp+101D8h+src+8], ecx
    mov     ecx, [rsp+101D8h+var_10180]
    mov     dword ptr [rsp+101D8h+src], ecx
    mov     dword ptr [rsp+101D8h+src+0Ch], eax
    lea     rdi, [rsp+101D8h+var_10198.u2]; cdtime
    lea     rsi, [rsp+101D8h+var_10198.u2+2]; cddate
    call    phar_zip_d2u_time
    mov     dword ptr [rsp+101D8h+src+4], eax
    mov     dword ptr [rsp+101D8h+tracker.val.value], 1B6h
    movzx   eax, byte ptr [rsp+101D8h+var_1016E]
    movzx   ecx, byte ptr [rsp+101D8h+var_1016E+1]
    shl     rcx, 8
    or      rcx, rax
    movzx   eax, [rsp+101D8h+var_1016C]
    shl     rax, 10h
    or      rax, rcx
    movzx   edx, [rsp+101D8h+var_1016B]
    shl     rdx, 18h
    or      rdx, rax
    mov     [rsp+101D8h+maxlen+8], rdx
    movzx   eax, byte ptr [rsp+101D8h+var_1017C]
    movzx   ecx, byte ptr [rsp+101D8h+var_1017C+1]
    mov     rsi, rcx
    shl     rsi, 8
    or      rsi, rax
    add     rsi, rdx
    movzx   edx, byte ptr [rsp+101D8h+var_1017A]
    movzx   edi, byte ptr [rsp+101D8h+var_1017A+1]
    shl     rdi, 8
    or      rdi, rdx
    lea     rdx, [rsi+rdi]
    add     rdx, 1Eh
    mov     qword ptr [rsp+101D8h+var_10128+8], rdx
    mov     [rsp+101D8h+maxlen], rdx
    test    byte ptr [rsp+101D8h+var_10198.u1], 1
    jnz     loc_51927D
    movsx   ecx, cl
    shl     ecx, 8
    or      rcx, rax
    test    cx, cx
    jz      loc_51931B
    movzx   edi, cx
    mov     dword ptr [rsp+101D8h+filename_len], edi
    add     rdi, 1; len
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    jnz     short loc_518776
    mov     edi, edi; size
    call    _emalloc
    jmp     short loc_51877B
loc_518776:
    call    __zend_malloc
loc_51877B:
    mov     [rsp+101D8h+filename_len+8], rax
    mov     ebp, dword ptr [rsp+101D8h+filename_len]
    mov     rdi, fp; stream
    mov     rsi, rax; buf
    mov     rdx, rbp; size
    call    _php_stream_read
    cmp     rax, rbp
    jnz     loc_5193C1
    mov     [rsp+101D8h+var_101A0], actual_alias
    mov     [rsp+101D8h+var_100C8], i
    mov     rax, [rsp+101D8h+filename_len+8]
    mov     ecx, dword ptr [rsp+101D8h+filename_len]
    mov     byte ptr [rax+rcx], 0
    mov     i, [rsp+101D8h+filename_len+8]
    mov     ebp, dword ptr [rsp+101D8h+filename_len]
    lea     eax, [rbp-1]
    cmp     byte ptr [r14+rax], 2Fh ; '/'
    movzx   r13d, word ptr [rsp+101D8h+var_100D8+0Ah]
    jnz     short loc_518810
    or      r13d, 8
    mov     word ptr [rsp+101D8h+var_100D8+0Ah], r13w
    cmp     ebp, 2
    jb      short loc_5187FE
    mov     dword ptr [rsp+101D8h+filename_len], eax
    mov     ebp, eax
loc_5187FE:
    or      dword ptr [rsp+101D8h+tracker.val.value], 1FFh
    cmp     ebp, 13h
    jz      short loc_518825
    jmp     short loc_518841
loc_518810:
    and     r13d, 0FFF7h
    mov     word ptr [rsp+101D8h+var_100D8+0Ah], r13w
    cmp     ebp, 13h
    jnz     short loc_518841
loc_518825:
    mov     edx, 13h; n
    mov     rdi, r14; s1
    lea     rsi, aPharSignatureB; ".phar/signature.bin"
    call    _strncmp
    test    eax, eax
    jz      loc_518A26
loc_518841:
    mov     edx, ebp; filename_len
    mov     r12, [rsp+101D8h+phar]
    mov     rdi, alias_len; phar
    mov     rsi, r14; filename
    call    phar_add_virtual_dirs
    cmp     [rsp+101D8h+var_1017A], 0
    mov     r14, [rsp+101D8h+var_100C8]
    mov     r13, [rsp+101D8h+var_101A0]
    jz      short loc_5188AB
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     rbp, rax
    movzx   edx, [rsp+101D8h+var_1017A]; len
    mov     rdi, fp; fp
    lea     rsi, [rsp+101D8h+src]; entry
    call    phar_zip_process_extra
    cmp     eax, 0FFFFFFFFh
    jz      loc_51955D
    movzx   eax, byte ptr [rsp+101D8h+var_1017A]
    movzx   esi, byte ptr [rsp+101D8h+var_1017A+1]
    shl     rsi, 8
    or      rsi, rax
    add     rsi, loc; offset
    mov     rdi, fp; stream
    xor     edx, edx; whence
    call    _php_stream_seek
loc_5188AB:
    movzx   eax, word ptr [rsp+101D8h+var_10198.u1+2]
    cmp     rax, 62h; switch 99 cases
    ja      def_5188C8; jumptable 00000000005188C8 default case, cases 11,13,15-17,20-96
    lea     rcx, jpt_5188C8
    movsxd  rax, ds:(jpt_5188C8 - 88F880h)[rcx+rax*4]
    add     rax, rcx
def_5188C8:
    jmp     rax; switch jump
    or      byte ptr [rsp+101D8h+tracker.val.value+1], 10h; jumptable 00000000005188C8 case 8
    lea     rax, phar_globals
    cmp     dword ptr [rax+0C8h], 0
    jnz     short loc_518903; jumptable 00000000005188C8 case 0
    jmp     loc_5195E5
    or      byte ptr [rsp+101D8h+tracker.val.value+1], 20h; jumptable 00000000005188C8 case 12
    lea     rax, phar_globals
    cmp     dword ptr [rax+0CCh], 0
    jz      loc_519605
loc_518903:
    movzx   ecx, [rsp+101D8h+var_10178]; jumptable 00000000005188C8 case 0
    movsx   eax, [rsp+101D8h+var_10177]
    shl     eax, 8
    or      rax, rcx
    test    ax, ax
    jz      short loc_51897F
    mov     r13, alias_len
    movzx   ebp, ax
    mov     rdi, fp; stream
    lea     r12, [rsp+101D8h+s]
    mov     rsi, r12; buf
    mov     rdx, rbp; size
    call    _php_stream_read
    cmp     rax, rbp
    jnz     loc_51957D
    movzx   eax, [rsp+101D8h+var_10178]
    movzx   ecx, [rsp+101D8h+var_10177]
    shl     ecx, 8
    movzx   edx, cx
    or      edx, eax; zip_metadata_len
    movzx   ecx, word ptr [rsp+101D8h+var_100D8+0Ah]
    shr     ecx, 8
    and     ecx, 1; persistent
    mov     rdi, r12; buffer
    lea     rsi, [rsp+101D8h+tracker.val.u1]; tracker
    call    phar_parse_metadata_lazy
    mov     rax, [rsp+101D8h+var_101A0]
    mov     r12, alias_len
    mov     r13, rax
    test    r13, r13
    jnz     short loc_5189BD
    jmp     short loc_51898F
loc_51897F:
    mov     dword ptr [rsp+101D8h+tracker.str], 0
    test    r13, r13
    jnz     short loc_5189BD
loc_51898F:
    cmp     dword ptr [rsp+101D8h+filename_len], 0Fh
    jnz     short loc_5189BA
    mov     rdi, [rsp+101D8h+filename_len+8]; s1
    mov     edx, 0Fh; n
    lea     rsi, aPharAliasTxt; ".phar/alias.txt"
    call    _strncmp
    test    eax, eax
    jz      loc_518BED
loc_5189BA:
    xor     r13d, r13d
loc_5189BD:
    lea     rdi, [rsp+101D8h+src]; entry
    call    phar_set_inode_0
    mov     rsi, [rsp+101D8h+filename_len+8]; str
    mov     edx, dword ptr [rsp+101D8h+filename_len]; len
    mov     qword ptr [rsp+101D8h+pData], 0
    mov     dword ptr [rsp+101D8h+pData+8], 0Dh
    mov     rdi, [rsp+101D8h+ht]; ht
    lea     rcx, [rsp+101D8h+pData]; pData
    call    zend_hash_str_add
    test    rax, rax
    jz      loc_518611
    mov     rbp, rax
    cmp     byte ptr [r12+4Ch], 0
    jns     loc_5185F6
    mov     edi, 0A0h; len
    call    __zend_malloc
    jmp     loc_5185FB
loc_518A26:
    mov     rdi, r14; ptr
    test    r13d, 100h
    jnz     short loc_518A46
    call    _efree
    cmp     dword ptr [rsp+101D8h+src], 10001h
    jb      short loc_518A59
    jmp     loc_51980E
loc_518A46:
    call    free
    cmp     dword ptr [rsp+101D8h+src], 10001h
    jnb     loc_51980E
loc_518A59:
    mov     rdi, fp; stream
    call    _php_stream_tell
    xor     edi, edi; dummy
    call    _php_stream_fopen_tmpfile
    test    rax, rax
    jz      loc_5198AE
    mov     r13, rax
    mov     rdi, fp; stream
    xor     esi, esi; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     rdx, [rsp+101D8h+maxlen+8]; maxlen
    mov     rdi, fp; src
    mov     rsi, sigfile; dest
    xor     ecx, ecx; len
    call    _php_stream_copy_to_stream_ex
    mov     rdi, fp; stream
    mov     rbp, [rsp+101D8h+offset]
    mov     rsi, rbp; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     rdx, [rsp+101D8h+var_100B8]
    sub     rdx, rbp; maxlen
    mov     rdi, fp; src
    mov     rsi, sigfile; dest
    xor     ecx, ecx; len
    call    _php_stream_copy_to_stream_ex
    test    metadata, metadata
    jz      short loc_518ADA
    mov     rdi, sigfile; stream
    mov     rsi, metadata; buf
    mov     rdx, [rsp+101D8h+count]; count
    call    _php_stream_write
loc_518ADA:
    mov     eax, dword ptr [rsp+101D8h+filename_len]
    add     rax, [rsp+101D8h+maxlen+8]
    movzx   ecx, byte ptr [rsp+101D8h+var_1017A]
    movzx   edx, byte ptr [rsp+101D8h+var_1017A+1]
    shl     rdx, 8
    or      rdx, rcx
    lea     rsi, [rax+rdx]
    add     rsi, 1Eh; offset
    mov     rdi, fp; stream
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     edi, dword ptr [rsp+101D8h+src]; size
    call    _emalloc
    mov     r14, rax
    mov     edx, dword ptr [rsp+101D8h+src]; size
    mov     rdi, fp; stream
    mov     rsi, rax; buf
    call    _php_stream_read
    mov     ecx, dword ptr [rsp+101D8h+src]
    cmp     read, rcx
    jnz     loc_51994E
    mov     eax, [sig]
    mov     rbp, [rsp+101D8h+phar]
    mov     [alias_len+114h], eax
    mov     rdi, sigfile; stream
    call    _php_stream_tell
    mov     edx, [alias_len+114h]; sig_type
    mov     rcx, sig
    add     rcx, 8; sig
    mov     r8d, dword ptr [rsp+101D8h+src]
    add     r8d, 0FFFFFFF8h; sig_len
    sub     rsp, 8
    mov     rdi, sigfile; fp
    mov     rsi, rax; end_of_phar
    mov     r9, [rsp+101E0h+var_101B0]; fname
    push    [rsp+101E0h+error_0]; error
    lea     rax, [rsp+101E8h+pData]
    push    rax; signature_len
    push    [rsp+101F0h+signature]; signature
    call    phar_verify_signature
    add     rsp, 20h
    cmp     eax, 0FFFFFFFFh
    jz      loc_519A03
    mov     rax, qword ptr [rsp+101D8h+nSize]
    mov     rcx, [rsp+101D8h+var_100C8]
    lea     r12d, [rax+rcx]
    mov     eax, dword ptr [rsp+101D8h+pData]
    mov     [alias_len+118h], eax
    mov     rdi, sigfile; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     rdi, sig; ptr
    call    _efree
    cmp     r12d, 0FFFFFFFFh
    jnz     loc_519B06
    mov     r12, [rsp+101D8h+phar]
    mov     sig, [rsp+101D8h+var_100C8]
    mov     sigfile, [rsp+101D8h+var_101A0]
    jmp     loc_518611
loc_518BED:
    mov     rdi, fp; stream
    call    _php_stream_tell
    mov     r13, rax
    movzx   eax, byte ptr [rsp+101D8h+var_1016E]
    movzx   ecx, byte ptr [rsp+101D8h+var_1016E+1]
    shl     rcx, 8
    or      rcx, rax
    movzx   eax, [rsp+101D8h+var_1016C]
    shl     rax, 10h
    or      rax, rcx
    movzx   esi, [rsp+101D8h+var_1016B]
    shl     rsi, 18h
    or      rsi, rax; offset
    mov     rdi, fp; stream
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     edx, 1Eh; size
    mov     rdi, fp; stream
    lea     rsi, [rsp+101D8h+pData]; buf
    call    _php_stream_read
    cmp     rax, 1Eh
    jnz     loc_51A17D
    mov     eax, dword ptr [rsp+101D8h+filename_len]
    movzx   ecx, [rsp+101D8h+var_10086]
    movzx   edx, [rsp+101D8h+var_10085]
    shl     edx, 8
    movzx   edx, dx
    or      edx, ecx
    cmp     eax, edx
    jnz     loc_5197EE
    mov     ecx, dword ptr [rsp+101D8h+src+0Ch]
    cmp     ecx, dword ptr [rsp+101D8h+pData+0Eh]
    jnz     loc_5197EE
    mov     ecx, dword ptr [rsp+101D8h+src]
    cmp     ecx, dword ptr [rsp+101D8h+var_1008E+4]
    jnz     loc_5197EE
    mov     ecx, dword ptr [rsp+101D8h+src+8]
    cmp     ecx, dword ptr [rsp+101D8h+var_1008E]
    jnz     loc_5197EE
    movzx   ecx, byte ptr [rsp+101D8h+var_10084]
    movzx   edx, byte ptr [rsp+101D8h+var_10084+1]
    shl     rdx, 8
    add     rax, [rsp+101D8h+maxlen+8]
    or      rdx, rcx
    lea     rsi, [rax+rdx]
    add     rsi, 1Eh; offset
    mov     qword ptr [rsp+101D8h+var_10128+8], rsi
    mov     [rsp+101D8h+maxlen], rsi
    mov     rdi, fp; stream
    xor     edx, edx; whence
    call    _php_stream_seek
    mov     rbp, [rsp+101D8h+var_10068]
    xorps   xmm0, xmm0
    movups  xmmword ptr [rbp+0], xmm0
    mov     rsi, [rsp+101D8h+maxlen]; offset
    mov     rdi, fp; stream
    xor     edx, edx; whence
    call    _php_stream_seek
    xorps   xmm0, xmm0
    movups  xmmword ptr [rbp+0], xmm0
    mov     esi, dword ptr [rsp+101D8h+src]; maxlen
    mov     [alias_len+28h], esi
    mov     eax, dword ptr [rsp+101D8h+tracker.val.value]
    test    eax, 1000h
    mov     [rsp+101D8h+var_101A0], saveloc
    jnz     short loc_518D8B
    test    eax, 2000h
    jnz     short loc_518DAB
    mov     rdi, fp; src
    xor     edx, edx; persistent
    call    _php_stream_copy_to_mem
    test    rax, rax
    jz      loc_51A19D
    mov     rbp, rax
    mov     rsi, [rax+10h]; length
    mov     dword ptr [rsp+101D8h+src], esi
    mov     rdi, rax
    add     rdi, 18h; s
    call    _estrndup
    mov     r13, rax
    mov     eax, [str+4]
    test    al, 40h
    jnz     short loc_518D72
    add     dword ptr [str+0], 0FFFFFFFFh
    jnz     short loc_518D72
    mov     rdi, str; ptr
    call    _efree
loc_518D72:
    test    actual_alias, actual_alias
    jz      loc_51A1A5
    cmp     dword ptr [rsp+101D8h+src], 0
    jnz     loc_518E55
    jmp     loc_51A1A5
loc_518D8B:
    movzx   edx, byte ptr [fp+60h]
    and     edx, 1; persistent
    lea     rdi, aZlibInflate; "zlib.inflate"
    xor     esi, esi; filterparams
    call    php_stream_filter_create
    test    rax, rax
    jnz     short loc_518DCA
    jmp     loc_51AA10
loc_518DAB:
    movzx   edx, byte ptr [fp+60h]
    and     edx, 1; persistent
    lea     rdi, aBzip2Decompres; "bzip2.decompress"
    xor     esi, esi; filterparams
    call    php_stream_filter_create
    test    rax, rax
    jz      loc_51AA29
loc_518DCA:
    mov     alias_len, rax
    mov     rdi, [rsp+101D8h+chain]; chain
    mov     rsi, rax; filter
    call    _php_stream_filter_append
    mov     esi, dword ptr [rsp+101D8h+src]; maxlen
    mov     rdi, fp; src
    xor     edx, edx; persistent
    call    _php_stream_copy_to_mem
    test    rax, rax
    jz      loc_51A19D
    mov     rbp, rax
    mov     rsi, [rax+10h]; length
    mov     dword ptr [rsp+101D8h+src], esi
    mov     rdi, rax
    add     rdi, 18h; s
    call    _estrndup
    mov     r13, rax
    mov     eax, [rbp+4]
    test    al, 40h
    jnz     short loc_518E23
    add     dword ptr [rbp+0], 0FFFFFFFFh
    jnz     short loc_518E23
    mov     rdi, rbp; ptr
    call    _efree
loc_518E23:
    test    actual_alias, actual_alias
    jz      loc_51A1A5
    cmp     dword ptr [rsp+101D8h+src], 0
    jz      loc_51A1A5
    mov     rdi, filter; filter
    mov     esi, 1; finish
    call    _php_stream_filter_flush
    mov     rdi, filter; filter
    mov     esi, 1; call_dtor
    call    php_stream_filter_remove
    mov     filter, [rsp+101D8h+phar]
loc_518E55:
    mov     rdi, fp; stream
    mov     rsi, [rsp+101D8h+var_101A0]; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    jmp     loc_5189BD
loc_518E69:
    test    rdi, rdi
    mov     rbp, [rsp+101D8h+phar]
    mov     rcx, [rsp+101D8h+var_101B0]
    jz      short loc_518E8A
    lea     rdx, aPharErrorCorru_0; "phar error: corrupt zip archive, zip fi"...
    mov     esi, 1000h; max_len
    xor     eax, eax
    call    zend_spprintf
loc_518E8A:
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     rax, [rsp+101D8h+var_101D0]
    test    byte ptr [rax+1], 1
    jnz     loc_519BF1
loc_518EA6:
    mov     rdi, rbp
    jmp     loc_519F13
loc_518EAE:
    lea     rsi, path; ".phar/stub.php"
    mov     edx, 0Eh; len
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_str_find
    mov     r14, [rsp+101D8h+var_101D0]
    mov     ecx, [r14]
    mov     edx, ecx
    or      edx, 80h
    and     ecx, 0FFFFFF7Fh
    test    rax, rax
    cmovz   ecx, edx
    mov     [r14], cx
    lea     rax, phar_globals
    cmp     dword ptr [rax+0D8h], 0
    jz      short loc_518F07
    test    cl, cl
    js      short loc_518F07
    cmp     qword ptr [r12+120h], 0
    jz      loc_5190A8
loc_518F07:
    mov     [r12+100h], fp
    mov     rsi, [r12]; str
    mov     qword ptr [rsp+101D8h+var_10198.value], r12
    mov     dword ptr [rsp+101D8h+var_10198.u1], 0Dh
    lea     metadata, phar_globals
    lea     fp, [rbx+38h]
    lea     rcx, [rsp+101D8h+var_10198]; pData
    mov     rdi, r15; ht
    mov     rdx, [rsp+101D8h+length]; len
    call    zend_hash_str_add
    test    rax, rax
    test    actual_alias, actual_alias
    mov     rbp, [rsp+101D8h+len]
    jz      short loc_518FCA
    mov     ebp, [r12+28h]
    mov     rdi, actual_alias; alias
    mov     rsi, rbp; alias_len
    call    phar_validate_alias_0
    test    eax, eax
    jz      loc_51905D
    and     byte ptr [r14], 0FEh
    add     rbx, 78h ; 'x'
    mov     rdi, rbx; ht
    mov     rsi, actual_alias; str
    mov     rdx, rbp; len
    call    zend_hash_str_find
    test    rax, rax
    jz      loc_51903A
    mov     rdi, [rax]; phar
    mov     edx, [r12+28h]; alias_len
    mov     rsi, actual_alias; alias
    call    phar_free_alias
    test    eax, eax
    jz      loc_51903A
    mov     rdi, [rsp+101D8h+error_0]; message
    test    rdi, rdi
    jz      loc_519085
    lea     rdx, aPharErrorUnabl_10; "phar error: Unable to add zip-based pha"...
    mov     esi, 1000h; max_len
    mov     rcx, [rsp+101D8h+var_101B0]
    xor     eax, eax
    call    zend_spprintf
    jmp     loc_519085
loc_518FCA:
    test    rbp, rbp
    jz      loc_519427
    mov     actual_alias, r12
    add     rbx, 78h ; 'x'
    mov     rdi, rbx; ht
    mov     r12, [rsp+101D8h+var_10078]
    mov     rsi, r12; str
    mov     rdx, rbp; len
    call    zend_hash_str_find
    test    rax, rax
    jz      loc_5193E1
    mov     rdi, [rax]; phar
    mov     rsi, r12; alias
    mov     rdx, rbp; alias_len
    call    phar_free_alias
    test    eax, eax
    jz      loc_5193E1
    mov     rdi, [rsp+101D8h+error_0]; message
    test    rdi, rdi
    jz      short loc_519034
    lea     rdx, aPharErrorUnabl_11; "phar error: Unable to add zip-based pha"...
    mov     esi, 1000h; max_len
    mov     rcx, [rsp+101D8h+var_101B0]
    xor     eax, eax
    call    zend_spprintf
loc_519034:
    mov     rsi, [r13+0]
    jmp     short loc_519091
loc_51903A:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    jnz     loc_51944C
    mov     [r12+20h], actual_alias
    mov     rsi, actual_alias
    mov     rbp, [rsp+101D8h+var_100A8]
    jmp     loc_519485
loc_51905D:
    mov     rdi, [rsp+101D8h+error_0]; message
    test    rdi, rdi
    jz      short loc_519085
    lea     rdx, aPharErrorInval_1; "phar error: invalid alias \"%s\" in zip"...
    mov     esi, 1000h; max_len
    mov     rcx, actual_alias
    mov     r8, [rsp+101D8h+var_101B0]
    xor     eax, eax
    call    zend_spprintf
loc_519085:
    mov     rdi, actual_alias; ptr
    call    _efree
    mov     rsi, [r12]; str
loc_519091:
    mov     rdi, r15; ht
    mov     rdx, [rsp+101D8h+length]; len
    call    zend_hash_str_del
    mov     ebx, 0FFFFFFFFh
    jmp     loc_518281
loc_5190A8:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [r12+128h]; tracker
    mov     esi, [r12+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [r12+120h]; ptr
    test    rdi, rdi
    jz      short loc_519121
    call    _efree
loc_519121:
    test    rbp, rbp
    jz      loc_519ED8
    mov     r8, [r12]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aSignatureIsMis; "signature is missing"
    jmp     loc_5193B4
loc_519141:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [r12+128h]; tracker
    mov     esi, [r12+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [r12+120h]; ptr
    test    rdi, rdi
    jz      short loc_5191BA
    call    _efree
loc_5191BA:
    test    rbp, rbp
    mov     i, [rsp+101D8h+var_101D0]
    jz      loc_519ED8
    mov     r8, [r12]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnableToReadCe; "unable to read central directory entry,"...
    jmp     loc_5193B4
loc_5191DF:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [r12+128h]; tracker
    mov     esi, [r12+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [r12+120h]; ptr
    test    rdi, rdi
    jz      short loc_519258
    call    _efree
loc_519258:
    test    rbp, rbp
    mov     i, [rsp+101D8h+var_101D0]
    jz      loc_519ED8
    mov     r8, [r12]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, end.name+1
    jmp     loc_5193B4
loc_51927D:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [r12+128h]; tracker
    mov     esi, [r12+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [r12+120h]; ptr
    test    rdi, rdi
    jz      short loc_5192F6
    call    _efree
loc_5192F6:
    test    rbp, rbp
    mov     i, [rsp+101D8h+var_101D0]
    jz      loc_519ED8
    mov     r8, [r12]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, end.bit64.leapcnt+7
    jmp     loc_5193B4
loc_51931B:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [r12+128h]; tracker
    mov     esi, [r12+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [r12+120h]; ptr
    test    rdi, rdi
    jz      short loc_519394
    call    _efree
loc_519394:
    test    rbp, rbp
    mov     i, [rsp+101D8h+var_101D0]
    jz      loc_519ED8
    mov     r8, [r12]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, end.trans_idx+2
loc_5193B4:
    mov     esi, 1000h
    mov     rdi, rbp
    jmp     loc_519ED1
loc_5193C1:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_5194AC
    call    _efree
    jmp     loc_5194B1
loc_5193E1:
    mov     r12, r13
    mov     edx, [r13+28h]; len
    mov     qword ptr [rsp+101D8h+var_10198.value], r13
    mov     dword ptr [rsp+101D8h+var_10198.u1], 0Dh
    lea     rcx, [rsp+101D8h+var_10198]; pData
    mov     rdi, rbx; ht
    xor     esi, esi; str
    call    zend_hash_str_add
    test    rax, rax
    test    byte ptr [r14+1], 1
    mov     rdi, [rsp+101D8h+var_10078]; s
    mov     rsi, rbp; length
    jnz     loc_51959D
    call    _estrndup
    jmp     loc_5195A2
loc_519427:
    test    byte ptr [r12+145h], 1
    mov     rdi, [r12]; s
    jnz     loc_5195AE
    mov     rbx, [rsp+101D8h+length]
    mov     rsi, rbx; length
    call    _estrndup
    jmp     loc_5195BB
loc_51944C:
    mov     esi, [r12+28h]; length
    mov     rdi, actual_alias; s
    call    zend_strndup
    mov     rsi, rax
    movzx   eax, word ptr [rsp+101D8h+var_100D8+0Ah]
    mov     [r12+20h], rsi
    test    eax, 100h
    mov     rbp, [rsp+101D8h+var_100A8]
    jz      short loc_519485
    mov     rdi, actual_alias; ptr
    call    _efree
    mov     rsi, [r12+20h]; str
loc_519485:
    mov     edx, [r12+28h]; len
    mov     qword ptr [rsp+101D8h+var_10198.value], r12
    mov     dword ptr [rsp+101D8h+var_10198.u1], 0Dh
    lea     rcx, [rsp+101D8h+var_10198]; pData
    mov     rdi, rbx; ht
    call    zend_hash_str_add
    test    rax, rax
    jmp     loc_5195D1
loc_5194AC:
    call    free
loc_5194B1:
    mov     i, [rsp+101D8h+var_101D0]
    mov     actual_alias, [rsp+101D8h+var_101C0]
    mov     rbp, [rsp+101D8h+var_101C8]
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+50h], 8
    mov     rdi, rbp; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+0C0h], 8
    mov     rdi, r13; ht
    call    zend_hash_destroy
    mov     dword ptr [r12+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [r12+128h]; tracker
    mov     esi, [r12+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [r12+120h]; ptr
    test    rdi, rdi
    jz      short loc_519535
    call    _efree
loc_519535:
    mov     rdi, [rsp+101D8h+error_0]
    test    rdi, rdi
    jz      loc_519ED8
    mov     r8, [r12]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, end.location.comments
    jmp     loc_519ECC
loc_51955D:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_519625
    call    _efree
    jmp     loc_51962A
loc_51957D:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_5196D6
    call    _efree
    jmp     loc_5196DB
loc_51959D:
    call    zend_strndup
loc_5195A2:
    mov     [r12+20h], rax
    mov     [r12+28h], ebp
    jmp     short loc_5195C5
loc_5195AE:
    mov     rbx, [rsp+101D8h+length]
    mov     rsi, rbx; length
    call    zend_strndup
loc_5195BB:
    mov     [r12+20h], rax
    mov     [r12+28h], ebx
loc_5195C5:
    or      byte ptr [r14], 1
    mov     rbp, [rsp+101D8h+var_100A8]
loc_5195D1:
    xor     ebx, ebx
    test    rbp, rbp
    jz      loc_518281
    mov     [rbp+0], r12
    jmp     loc_518281
loc_5195E5:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_519C11
    call    _efree
    jmp     loc_519C16
loc_519605:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_519CC2
    call    _efree
    jmp     loc_519CC7
loc_519625:
    call    free
loc_51962A:
    mov     r14, [rsp+101D8h+var_101D0]
    mov     metadata, [rsp+101D8h+var_101C0]
    mov     loc, [rsp+101D8h+var_101C8]
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+50h], 8
    mov     rdi, rbp; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+0C0h], 8
    mov     rdi, rbx; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias_len+128h]; tracker
    mov     esi, [alias_len+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias_len+120h]; ptr
    test    rdi, rdi
    jz      short loc_5196AE
    call    _efree
loc_5196AE:
    mov     rdi, [rsp+101D8h+error_0]
    test    rdi, rdi
    jz      loc_519ED8
    mov     r8, [alias_len]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnableToProces; "Unable to process extra field header fo"...
    jmp     loc_519ECC
loc_5196D6:
    call    free
loc_5196DB:
    mov     r14, [rsp+101D8h+var_101D0]
    mov     r12, [rsp+101D8h+var_101C0]
    mov     rbp, [rsp+101D8h+var_101C8]
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+50h], 8
    mov     rdi, rbp; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+0C0h], 8
    mov     rdi, r12; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias_len+128h]; tracker
    mov     esi, [alias_len+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias_len+120h]; ptr
    test    rdi, rdi
    jz      short loc_519759
    call    _efree
loc_519759:
    mov     rdi, [rsp+101D8h+error_0]; message
    test    rdi, rdi
    jz      short loc_519784
    mov     r8, [alias_len+0]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnableToReadIn_0; "unable to read in file comment, truncat"...
    mov     esi, 1000h; max_len
    xor     eax, eax
    call    zend_spprintf
loc_519784:
    test    byte ptr [alias_len+145h], 1
    mov     rdi, [alias_len+0]; ptr
    jnz     short loc_519799
    call    _efree
    jmp     short loc_51979E
loc_519799:
    call    free
loc_51979E:
    mov     rdi, [alias_len+20h]; ptr
    test    rdi, rdi
    jz      loc_519BFE
    test    byte ptr [r14+1], 1
    jnz     loc_519BF9
    call    _efree
    test    byte ptr [r14+1], 1
    jz      loc_519C09
loc_5197C6:
    mov     rdi, alias_len
    jmp     loc_519F31
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 cases 2-5
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_519D73
    call    _efree
    jmp     loc_519D78
loc_5197EE:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_519E24
    call    _efree
    jmp     loc_519E29
loc_51980E:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias_len+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias_len+128h]; tracker
    mov     esi, [alias_len+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias_len+120h]; ptr
    test    rdi, rdi
    jz      short loc_519881
    call    _efree
loc_519881:
    mov     rdi, [rsp+101D8h+error_0]
    test    rdi, rdi
    mov     metadata, [rsp+101D8h+var_101D0]
    jz      loc_519BA9
    mov     r8, [alias_len+0]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aSignaturesLarg; "signatures larger than 64 KiB are not s"...
    jmp     loc_519B9D
loc_5198AE:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias_len+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias_len+128h]; tracker
    mov     esi, [alias_len+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias_len+120h]; ptr
    test    rdi, rdi
    jz      short loc_519921
    call    _efree
loc_519921:
    mov     rdi, [rsp+101D8h+error_0]
    test    rdi, rdi
    mov     metadata, [rsp+101D8h+var_101D0]
    jz      loc_519BA9
    mov     r8, [alias_len+0]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aCouldnTOpenTem; "couldn't open temporary file"
    jmp     loc_519B9D
loc_51994E:
    mov     rdi, sigfile; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     rdi, sig; ptr
    call    _efree
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias_len+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias_len+128h]; tracker
    mov     esi, [alias_len+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias_len+120h]; ptr
    test    rdi, rdi
    jz      short loc_5199D6
    call    _efree
loc_5199D6:
    mov     rdi, [rsp+101D8h+error_0]
    test    rdi, rdi
    mov     metadata, [rsp+101D8h+var_101D0]
    jz      loc_519BA9
    mov     r8, [alias_len+0]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aPharErrorTarBa_0+20h; "signature cannot be read"
    jmp     loc_519B9D
loc_519A03:
    mov     rdi, sig; ptr
    call    _efree
    mov     alias_len, [rsp+101D8h+error_0]
    mov     rdi, sigfile; stream
    mov     esi, 3; close_options
    test    rbp, rbp
    jz      loc_519F40
    call    _php_stream_free
    mov     rcx, [rbp+0]
    lea     rdx, aPharErrorTarBa_2+20h; format
    lea     rdi, [rsp+101D8h+message]; message
    mov     esi, 1000h; max_len
    xor     eax, eax
    call    zend_spprintf
    mov     rdi, [rbp+0]; ptr
    call    _efree
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [save+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [save+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [save+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [save+128h]; tracker
    mov     esi, [save+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [save+120h]; ptr
    test    rdi, rdi
    jz      short loc_519AC4
    call    _efree
loc_519AC4:
    mov     rcx, [rsp+101D8h+message]
    mov     r8, [rbp+0]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    mov     esi, 1000h; max_len
    mov     rdi, [rsp+101D8h+error_0]; message
    xor     eax, eax
    call    zend_spprintf
    test    byte ptr [rbp+145h], 1
    mov     rdi, [rbp+0]; ptr
    jnz     loc_51A133
    call    _efree
    jmp     loc_51A138
loc_519B06:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     alias_len, [rsp+101D8h+phar]
    mov     dword ptr [rbp+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [rbp+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [rbp+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [rbp+128h]; tracker
    mov     esi, [rbp+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [rbp+120h]; ptr
    test    rdi, rdi
    jz      short loc_519B79
    call    _efree
loc_519B79:
    mov     rdi, [rsp+101D8h+error_0]; message
    test    rdi, rdi
    mov     metadata, [rsp+101D8h+var_101D0]
    jz      short loc_519BA9
    mov     r8, [rbp+0]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aEntriesExistAf; "entries exist after signature, invalid "...
loc_519B9D:
    mov     esi, 1000h; max_len
    xor     eax, eax
    call    zend_spprintf
loc_519BA9:
    test    byte ptr [rbp+145h], 1
    mov     rdi, [rbp+0]; ptr
    jnz     short loc_519BBD
    call    _efree
    jmp     short loc_519BC2
loc_519BBD:
    call    free
loc_519BC2:
    mov     rdi, [rbp+20h]; ptr
    test    rdi, rdi
    jz      short loc_519BE7
    test    byte ptr [rbx+1], 1
    jnz     short loc_519BE2
    call    _efree
    test    byte ptr [rbx+1], 1
    jz      loc_518EA6
    jmp     short loc_519BF1
loc_519BE2:
    call    free
loc_519BE7:
    test    byte ptr [rbx+1], 1
    jz      loc_518EA6
loc_519BF1:
    mov     rdi, rbp
    jmp     loc_519F31
loc_519BF9:
    call    free
loc_519BFE:
    test    byte ptr [r14+1], 1
    jnz     loc_5197C6
loc_519C09:
    mov     rdi, alias_len
    jmp     loc_519F13
loc_519C11:
    call    free
loc_519C16:
    mov     r14, [rsp+101D8h+var_101D0]
    mov     metadata, [rsp+101D8h+var_101C0]
    mov     rbp, [rsp+101D8h+var_101C8]
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+50h], 8
    mov     rdi, rbp; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+0C0h], 8
    mov     rdi, rbx; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias_len+128h]; tracker
    mov     esi, [alias_len+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias_len+120h]; ptr
    test    rdi, rdi
    jz      short loc_519C9A
    call    _efree
loc_519C9A:
    mov     rdi, [rsp+101D8h+error_0]
    test    rdi, rdi
    jz      loc_519ED8
    mov     r8, [alias_len]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aZlibExtensionI; "zlib extension is required"
    jmp     loc_519ECC
loc_519CC2:
    call    free
loc_519CC7:
    mov     r14, [rsp+101D8h+var_101D0]
    mov     metadata, [rsp+101D8h+var_101C0]
    mov     rbp, [rsp+101D8h+var_101C8]
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+50h], 8
    mov     rdi, rbp; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+0C0h], 8
    mov     rdi, rbx; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias_len+128h]; tracker
    mov     esi, [alias_len+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias_len+120h]; ptr
    test    rdi, rdi
    jz      short loc_519D4B
    call    _efree
loc_519D4B:
    mov     rdi, [rsp+101D8h+error_0]
    test    rdi, rdi
    jz      loc_519ED8
    mov     r8, [alias_len]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aBzip2Extension; "bzip2 extension is required"
    jmp     loc_519ECC
loc_519D73:
    call    free
loc_519D78:
    mov     r14, [rsp+101D8h+var_101D0]
    mov     metadata, [rsp+101D8h+var_101C0]
    mov     rbp, [rsp+101D8h+var_101C8]
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+50h], 8
    mov     rdi, rbp; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+0C0h], 8
    mov     rdi, rbx; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias_len+128h]; tracker
    mov     esi, [alias_len+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias_len+120h]; ptr
    test    rdi, rdi
    jz      short loc_519DFC
    call    _efree
loc_519DFC:
    mov     rdi, [rsp+101D8h+error_0]
    test    rdi, rdi
    jz      loc_519ED8
    mov     r8, [alias_len]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom; "unsupported compression method (Reduce)"...
    jmp     loc_519ECC
loc_519E24:
    call    free
loc_519E29:
    mov     r14, [rsp+101D8h+var_101D0]
    mov     metadata, [rsp+101D8h+var_101C0]
    mov     rbp, [rsp+101D8h+var_101C8]
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+50h], 8
    mov     rdi, rbp; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+0C0h], 8
    mov     rdi, rbx; ht
    call    zend_hash_destroy
    mov     dword ptr [alias_len+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias_len+128h]; tracker
    mov     esi, [alias_len+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias_len+120h]; ptr
    test    rdi, rdi
    jz      short loc_519EAD
    call    _efree
loc_519EAD:
    mov     rdi, [rsp+101D8h+error_0]; message
    test    rdi, rdi
    jz      short loc_519ED8
    mov     r8, [alias_len]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aPharErrorInter_0; "phar error: internal corruption of zip-"...
loc_519ECC:
    mov     esi, 1000h; max_len
loc_519ED1:
    xor     eax, eax
    call    zend_spprintf
loc_519ED8:
    test    byte ptr [r12+145h], 1
    mov     rdi, [r12]; ptr
    jnz     short loc_519EEE
    call    _efree
    jmp     short loc_519EF3
loc_519EEE:
    call    free
loc_519EF3:
    mov     rdi, [r12+20h]; ptr
    test    rdi, rdi
    jz      short loc_519F09
    test    byte ptr [r14+1], 1
    jnz     short loc_519F22
    call    _efree
loc_519F09:
    test    byte ptr [r14+1], 1
    jnz     short loc_519F2E
loc_519F10:
    mov     rdi, r12; ptr
loc_519F13:
    call    _efree
    mov     ebx, 0FFFFFFFFh
    jmp     loc_518281
loc_519F22:
    call    free
    test    byte ptr [r14+1], 1
    jz      short loc_519F10
loc_519F2E:
    mov     rdi, r12; ptr
loc_519F31:
    call    free
    mov     ebx, 0FFFFFFFFh
    jmp     loc_518281
loc_519F40:
    call    _php_stream_free
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [rbp+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [rbp+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [rbp+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [rbp+128h]; tracker
    mov     esi, [rbp+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [rbp+120h]; ptr
    test    rdi, rdi
    jz      short loc_519FB8
    call    _efree
loc_519FB8:
    test    byte ptr [rbp+145h], 1
    mov     rdi, [rbp+0]; ptr
    jz      loc_51ABAA
loc_519FC9:
    call    free
    jmp     loc_51ABAF
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A284
    call    _efree
    jmp     loc_51A289
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 6
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A325
    call    _efree
    jmp     loc_51A32A
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 7
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A3C6
    call    _efree
    jmp     loc_51A3CB
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 9
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A467
    call    _efree
    jmp     loc_51A46C
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 10
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A508
    call    _efree
    jmp     loc_51A50D
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 default case, cases 11,13,15-17,20-96
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A5A9
    call    _efree
    jmp     loc_51A5AE
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 14
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A64A
    call    _efree
    jmp     loc_51A64F
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 18
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A6EB
    call    _efree
    jmp     loc_51A6F0
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 19
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A78C
    call    _efree
    jmp     loc_51A791
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 97
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A82D
    call    _efree
    jmp     loc_51A832
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1; jumptable 00000000005188C8 case 98
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A8CE
    call    _efree
    jmp     loc_51A8D3
loc_51A133:
    call    free
loc_51A138:
    mov     rax, [rsp+101D8h+phar]
    mov     rdi, [rax+20h]; ptr
    test    rdi, rdi
    mov     metadata, [rsp+101D8h+var_101D0]
    jz      loc_51A264
    test    byte ptr [rbx+1], 1
    jnz     loc_51A25F
    call    _efree
    test    byte ptr [rbx+1], 1
    jz      loc_51A26E
loc_51A167:
    mov     rdi, [rsp+101D8h+phar]; ptr
    call    free
    mov     rdi, [rsp+101D8h+message]
    jmp     loc_519F13
loc_51A17D:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51A96F
    call    _efree
    jmp     loc_51A974
loc_51A19D:
    mov     dword ptr [rsp+101D8h+src], 0
loc_51A1A5:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     short loc_51A1BE
    call    _efree
    jmp     short loc_51A1C3
loc_51A1BE:
    call    free
loc_51A1C3:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A236
    call    _efree
loc_51A236:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnableToReadIn_1; "unable to read in alias, truncated"
    jmp     loc_51AB82
loc_51A25F:
    call    free
loc_51A264:
    test    byte ptr [rbx+1], 1
    jnz     loc_51A167
loc_51A26E:
    mov     rdi, [rsp+101D8h+phar]; ptr
    call    _efree
    mov     rdi, [rsp+101D8h+message]
    jmp     loc_519F13
loc_51A284:
    call    free
loc_51A289:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A2FC
    call    _efree
loc_51A2FC:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_0; "unsupported compression method (Shrunk)"...
    jmp     loc_51AB82
loc_51A325:
    call    free
loc_51A32A:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A39D
    call    _efree
loc_51A39D:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_1; "unsupported compression method (Implode"...
    jmp     loc_51AB82
loc_51A3C6:
    call    free
loc_51A3CB:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A43E
    call    _efree
loc_51A43E:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_2; "unsupported compression method (Tokeniz"...
    jmp     loc_51AB82
loc_51A467:
    call    free
loc_51A46C:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A4DF
    call    _efree
loc_51A4DF:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_3; "unsupported compression method (Deflate"...
    jmp     loc_51AB82
loc_51A508:
    call    free
loc_51A50D:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A580
    call    _efree
loc_51A580:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_4; "unsupported compression method (PKWare "...
    jmp     loc_51AB82
loc_51A5A9:
    call    free
loc_51A5AE:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A621
    call    _efree
loc_51A621:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_5; "unsupported compression method (unknown"...
    jmp     loc_51AB82
loc_51A64A:
    call    free
loc_51A64F:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A6C2
    call    _efree
loc_51A6C2:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_6; "unsupported compression method (LZMA) u"...
    jmp     loc_51AB82
loc_51A6EB:
    call    free
loc_51A6F0:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A763
    call    _efree
loc_51A763:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_7; "unsupported compression method (IBM TER"...
    jmp     loc_51AB82
loc_51A78C:
    call    free
loc_51A791:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A804
    call    _efree
loc_51A804:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_8; "unsupported compression method (IBM LZ7"...
    jmp     loc_51AB82
loc_51A82D:
    call    free
loc_51A832:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A8A5
    call    _efree
loc_51A8A5:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_9; "unsupported compression method (WavPack"...
    jmp     loc_51AB82
loc_51A8CE:
    call    free
loc_51A8D3:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A946
    call    _efree
loc_51A946:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnsupportedCom_10; "unsupported compression method (PPMd) u"...
    jmp     loc_51AB82
loc_51A96F:
    call    free
loc_51A974:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51A9E7
    call    _efree
loc_51A9E7:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aPharErrorInter_1; "phar error: internal corruption of zip-"...
    jmp     loc_51AB82
loc_51AA10:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     short loc_51AA49
    call    _efree
    jmp     short loc_51AA4E
loc_51AA29:
    test    byte ptr [rsp+101D8h+var_100D8+0Bh], 1
    mov     rdi, [rsp+101D8h+filename_len+8]; ptr
    jnz     loc_51AAEA
    call    _efree
    jmp     loc_51AAEF
loc_51AA49:
    call    free
loc_51AA4E:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51AAC1
    call    _efree
loc_51AAC1:
    cmp     [rsp+101D8h+error_0], 0
    jz      loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnableToDecomp; "unable to decompress alias, zlib filter"...
    jmp     loc_51AB82
loc_51AAEA:
    call    free
loc_51AAEF:
    mov     rdi, [rsp+101D8h+ht]; ht
    call    zend_hash_destroy
    mov     rbp, [rsp+101D8h+phar]
    mov     dword ptr [alias+50h], 8
    mov     rdi, [rsp+101D8h+var_101C8]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+0C0h], 8
    mov     rdi, [rsp+101D8h+var_101C0]; ht
    call    zend_hash_destroy
    mov     dword ptr [alias+88h], 8
    mov     rdi, fp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdi, [alias+128h]; tracker
    mov     esi, [alias+144h]
    shr     esi, 8
    and     esi, 1; persistent
    call    phar_metadata_tracker_free
    mov     rdi, [alias+120h]; ptr
    test    rdi, rdi
    jz      short loc_51AB62
    call    _efree
loc_51AB62:
    cmp     [rsp+101D8h+error_0], 0
    jz      short loc_51AB96
    mov     rax, [rsp+101D8h+phar]
    mov     r8, [mydata]
    lea     rdx, aPharErrorSInZi; "phar error: %s in zip-based phar \"%s\""
    lea     rcx, aUnableToReadIn_2; "unable to read in alias, bzip2 filter c"...
loc_51AB82:
    mov     esi, 1000h; max_len
    mov     rdi, [rsp+101D8h+error_0]; message
    xor     eax, eax
    call    zend_spprintf
loc_51AB96:
    mov     rax, [rsp+101D8h+phar]
    test    byte ptr [beforeus+145h], 1
    mov     rdi, [beforeus]; ptr
    jnz     loc_519FC9
loc_51ABAA:
    call    _efree
loc_51ABAF:
    mov     rax, [rsp+101D8h+phar]
    mov     rdi, [rax+20h]; ptr
    test    rdi, rdi
    jz      short loc_51ABD3
    mov     rax, [rsp+101D8h+var_101D0]
    test    byte ptr [rax+1], 1
    jnz     short loc_51ABCE
    call    _efree
    jmp     short loc_51ABD3
loc_51ABCE:
    call    free
loc_51ABD3:
    mov     rax, [rsp+101D8h+var_101D0]
    test    byte ptr [rax+1], 1
    jnz     short loc_51ABE7
    mov     rdi, [rsp+101D8h+phar]
    jmp     loc_519F13
loc_51ABE7:
    mov     rdi, [rsp+101D8h+phar]
    jmp     loc_519F31
phar_parse_zipfile endp



phar_verify_signature proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 538h
    mov     rbx, fname
    mov     r15, sig_len
    mov     ebp, edx
    mov     r14, end_of_phar
    mov     r12, fp
    mov     r13, [rsp+568h+message]
    mov     [rsp+568h+s2], sig
    mov     [rsp+568h+var_550], rcx
    xor     esi, esi; offset
    xor     edx, edx; whence
    call    _php_stream_seek
    add     ebp, 0FFFFFFFFh; switch 16 cases
    cmp     ebp, 0Fh
    ja      def_514094; jumptable 0000000000514094 default case, cases 5-15
    lea     rax, jpt_514094
    movsxd  rcx, ds:(jpt_514094 - 88E348h)[rax+rbp*4]
    add     rcx, rax
def_514094:
    jmp     rcx; switch jump
    lea     rdi, [rsp+568h+ctx]; jumptable 0000000000514094 case 1
    xor     esi, esi; args
    call    PHP_MD5InitArgs
    cmp     read_len, 400h
    mov     ebp, 400h
    cmovb   rbp, read_len
    lea     rsi, [rsp+568h+data]; buf
    mov     rdi, fp; stream
    mov     rdx, read_size; size
    call    _php_stream_read
    test    rax, rax
    jz      short loc_51410E
    mov     fname, rax
    lea     r13, [rsp+568h+ctx]
    lea     sig_len, [rsp+568h+data]
    nop     word ptr [rax+rax+00h]
loc_5140E0:
    mov     rdi, r13; ctx
    mov     rsi, r15; data
    mov     rdx, len; size
    call    PHP_MD5Update
    sub     read_len, len
    cmp     read_len, read_size
    cmovb   read_size, read_len
    mov     rdi, fp; stream
    mov     rsi, r15; buf
    mov     rdx, read_size; size
    call    _php_stream_read
    mov     len, rax
    test    rax, rax
    jnz     short loc_5140E0
loc_51410E:
    lea     rdi, [rsp+568h+result]; result
    lea     rsi, [rsp+568h+ctx]; ctx
    call    PHP_MD5Final
    mov     rax, [rsp+568h+s2]
    movdqu  xmm0, xmmword ptr [rax]
    pcmpeqb xmm0, xmmword ptr [rsp+568h+result]
    pmovmskb eax, xmm0
    cmp     eax, 0FFFFh
    jnz     loc_51437A
    lea     rdi, [rsp+568h+result]
    mov     esi, 10h
    jmp     loc_5144D4
    lea     rdi, [rsp+568h+ctx]; jumptable 0000000000514094 case 2
    xor     esi, esi; args
    call    PHP_SHA1InitArgs
    cmp     read_len, 400h
    mov     ebp, 400h
    cmovb   rbp, read_len
    lea     rsi, [rsp+568h+data]; buf
    mov     rdi, fp; stream
    mov     rdx, read_size; size
    call    _php_stream_read
    test    rax, rax
    jz      short loc_5141BE
    mov     fname, rax
    lea     r13, [rsp+568h+ctx]
    lea     sig_len, [rsp+568h+data]
    xchg    ax, ax
loc_514190:
    mov     rdi, r13; context
    mov     rsi, r15; input
    mov     rdx, len; inputLen
    call    PHP_SHA1Update
    sub     read_len, len
    cmp     read_len, read_size
    cmovb   read_size, read_len
    mov     rdi, fp; stream
    mov     rsi, r15; buf
    mov     rdx, read_size; size
    call    _php_stream_read
    mov     len, rax
    test    rax, rax
    jnz     short loc_514190
loc_5141BE:
    lea     rdi, [rsp+568h+result]; digest
    lea     rsi, [rsp+568h+ctx]; context
    call    PHP_SHA1Final
    mov     rax, [rsp+568h+s2]
    movdqu  xmm0, xmmword ptr [sig]
    movd    xmm1, dword ptr [rsp+568h+var_538]
    movd    xmm2, dword ptr [sig+10h]
    pcmpeqb xmm0, xmmword ptr [rsp+568h+result]
    pcmpeqb xmm2, xmm1
    pand    xmm0, xmm2
    pmovmskb eax, xmm0
    cmp     eax, 0FFFFh
    jnz     loc_51437A
    lea     rdi, [rsp+568h+result]
    mov     esi, 14h
    jmp     loc_5144D4
    lea     rdi, [rsp+568h+ctx]; jumptable 0000000000514094 case 3
    xor     esi, esi; args
    call    PHP_SHA256InitArgs
    cmp     read_len, 400h
    mov     ebp, 400h
    cmovb   rbp, read_len
    lea     rsi, [rsp+568h+data]; buf
    mov     rdi, fp; stream
    mov     rdx, read_size; size
    call    _php_stream_read
    test    rax, rax
    jz      short loc_51428E
    mov     fname, rax
    lea     r13, [rsp+568h+ctx]
    lea     sig_len, [rsp+568h+data]
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+rax+00h]
loc_514260:
    mov     rdi, r13; context
    mov     rsi, r15; input
    mov     rdx, len; inputLen
    call    PHP_SHA256Update
    sub     read_len, len
    cmp     read_len, read_size
    cmovb   read_size, read_len
    mov     rdi, fp; stream
    mov     rsi, r15; buf
    mov     rdx, read_size; size
    call    _php_stream_read
    mov     len, rax
    test    rax, rax
    jnz     short loc_514260
loc_51428E:
    lea     rdi, [rsp+568h+result]; digest
    lea     rsi, [rsp+568h+ctx]; context
    call    PHP_SHA256Final
    mov     rax, [rsp+568h+s2]
    movdqu  xmm0, xmmword ptr [sig]
    movdqu  xmm1, xmmword ptr [sig+10h]
    pcmpeqb xmm1, [rsp+568h+var_538]
    pcmpeqb xmm0, xmmword ptr [rsp+568h+result]
    pand    xmm0, xmm1
    pmovmskb eax, xmm0
    cmp     eax, 0FFFFh
    jnz     loc_51437A
    lea     rdi, [rsp+568h+result]
    mov     esi, 20h ; ' '
    jmp     loc_5144D4
    lea     rdi, [rsp+568h+ctx]; jumptable 0000000000514094 case 4
    xor     esi, esi; args
    call    PHP_SHA512InitArgs
    cmp     read_len, 400h
    mov     ebp, 400h
    cmovb   rbp, read_len
    lea     rsi, [rsp+568h+data]; buf
    mov     rdi, fp; stream
    mov     rdx, read_size; size
    call    _php_stream_read
    test    rax, rax
    jz      short loc_51434E
    mov     r13, rax
    lea     fname, [rsp+568h+ctx]
    lea     sig_len, [rsp+568h+data]
    nop     dword ptr [rax]
loc_514320:
    mov     rdi, rbx; context
    mov     rsi, r15; input
    mov     rdx, len; inputLen
    call    PHP_SHA512Update
    sub     read_len, len
    cmp     read_len, read_size
    cmovb   read_size, read_len
    mov     rdi, fp; stream
    mov     rsi, r15; buf
    mov     rdx, read_size; size
    call    _php_stream_read
    mov     len, rax
    test    rax, rax
    jnz     short loc_514320
loc_51434E:
    lea     rbx, [rsp+568h+result]
    lea     rsi, [rsp+568h+ctx]; context
    mov     rdi, rbx; digest
    call    PHP_SHA512Final
    mov     edx, 40h ; '@'; n
    mov     rdi, rbx; s1
    mov     rsi, [rsp+568h+s2]; s2
    call    _bcmp
    test    eax, eax
    jz      loc_5144CA
loc_51437A:
    mov     rdi, [rsp+568h+message]; message
    test    rdi, rdi
    jz      short loc_514397
    lea     rdx, aBrokenSignatur; "broken signature"
loc_51438E:
    xor     esi, esi; max_len
    xor     eax, eax
    call    zend_spprintf
loc_514397:
    mov     ebx, 0FFFFFFFFh
    jmp     loc_5144F0
    mov     ebx, 0FFFFFFFFh; jumptable 0000000000514094 default case, cases 5-15
    test    r13, r13
    jz      loc_5144F0
    lea     rdx, aBrokenOrUnsupp; "broken or unsupported signature"
    mov     rdi, r13; message
    xor     esi, esi; max_len
    xor     eax, eax
    call    zend_spprintf
    jmp     loc_5144F0
    lea     rdi, module_registry; jumptable 0000000000514094 case 16
    lea     rsi, aOpenssl; "openssl"
    mov     edx, 7; len
    call    zend_hash_str_find
    test    rax, rax
    jz      loc_514504
    lea     rdx, aSPubkey; "%s.pubkey"
    lea     rdi, [rsp+568h+ctx]; message
    xor     esi, esi; max_len
    mov     rcx, fname
    xor     eax, eax
    call    zend_spprintf
    mov     rdi, qword ptr [rsp+568h+ctx]; path
    lea     rsi, aLarrb+3; mode
    xor     edx, edx; options
    xor     ecx, ecx; opened_path
    xor     r8d, r8d; context
    call    _php_stream_open_wrapper_ex
    mov     r13, rax
    mov     rdi, qword ptr [rsp+568h+ctx]; ptr
    call    _efree
    test    pfp, pfp
    jz      loc_514529
    mov     rdi, pfp; src
    mov     rsi, 0FFFFFFFFFFFFFFFFh; maxlen
    xor     edx, edx; persistent
    call    _php_stream_copy_to_mem
    test    rax, rax
    jz      loc_51451C
    mov     fname, rax
    cmp     qword ptr [rax+10h], 0
    jz      loc_51451C
    mov     rdi, pfp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     [rsp+568h+data], tempsig
    mov     rcx, pubkey
    add     rcx, 18h; key
    mov     r8, [pubkey+10h]; key_len
    lea     rax, [rsp+568h+data]
    mov     [rsp+568h+var_568], rax; signature_len
    lea     r9, [rsp+568h+var_550]; signature
    xor     edi, edi; is_sign
    mov     rsi, fp; fp
    mov     rdx, end_of_phar; end
    call    phar_call_openssl_signverify
    mov     ebp, eax
    mov     eax, [pubkey+4]
    test    al, 40h
    jnz     short loc_5144AA
    add     dword ptr [pubkey], 0FFFFFFFFh
    jnz     short loc_5144AA
    mov     rdi, pubkey; ptr
    call    _efree
loc_5144AA:
    cmp     ebp, 0FFFFFFFFh
    mov     rdi, [rsp+568h+message]
    jz      loc_514546
    mov     rsi, [rsp+568h+data]
    mov     rdi, [rsp+568h+var_550]
    jmp     short loc_5144D4
loc_5144CA:
    lea     rdi, [rsp+568h+result]; digest
    mov     esi, 40h ; '@'; digest_len
loc_5144D4:
    mov     rdx, [rsp+568h+arg_0]; signature
    call    phar_hex_str
    cdqe
    mov     rcx, [rsp+568h+arg_8]
    mov     [rcx], rax
    xor     ebx, ebx
loc_5144F0:
    mov     eax, ebx
    add     rsp, 538h
    pop     rbx
    pop     fp
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_514504:
    test    r13, r13
    jz      loc_514397
    lea     rdx, aOpensslNotLoad; "openssl not loaded"
    mov     rdi, r13
    jmp     loc_51438E
loc_51451C:
    mov     rdi, pfp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_514529:
    mov     rdi, [rsp+568h+message]
    test    rdi, rdi
    jz      loc_514397
    lea     rdx, aOpensslPublicK; "openssl public key could not be read"
    jmp     loc_51438E
loc_514546:
    test    rdi, rdi
    jz      loc_514397
    lea     rdx, aOpensslSignatu; "openssl signature could not be verified"
    jmp     loc_51438E
phar_verify_signature endp

