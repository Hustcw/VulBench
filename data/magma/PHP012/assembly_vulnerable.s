php_stream_url_wrap_http_ex proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0D68h
    mov     r14, wrapper
    mov     [rsp+0D98h+var_CE8], 0
    xorpd   xmm0, xmm0
    movapd  xmmword ptr [rsp+0D98h+ptr], xmm0
    mov     [rsp+0D98h+s1], 0
    test    r9d, r9d
    jle     loc_5C37DF
    mov     ebx, r9d
    mov     r12, context
    mov     r13, mode
    mov     rbp, path
    mov     [rsp+0D98h+var_D5C], ecx
    mov     rdi, rsi; str
    call    php_url_parse
    test    rax, rax
    jz      loc_5C55B7
    mov     r15, rax
    mov     [rsp+0D98h+bytes_max], path
    mov     rdi, [rax]
    mov     rax, [rdi+10h]
    cmp     rax, 4
    mov     [rsp+0D98h+theurl], resource
    jnz     short loc_5C374F
    add     rdi, 18h; s1
    lea     rdx, aHttp; "http"
    mov     esi, 4; len1
    mov     ecx, 4; len2
    call    zend_binary_strcasecmp
    test    eax, eax
    jz      loc_5C3822
    mov     rdi, [resource]
    mov     rax, [rdi+10h]
loc_5C374F:
    cmp     rax, 5
    jnz     short loc_5C3777
    add     rdi, 18h; s1
    lea     rdx, aHttps; "https"
    mov     esi, 5; len1
    mov     ecx, 5; len2
    call    zend_binary_strcasecmp
    test    eax, eax
    jz      loc_5C3822
loc_5C3777:
    mov     [rsp+0D98h+var_D10], redirect_max
    test    context, context
    jz      short loc_5C37F9
    mov     rax, [wrapper]
    mov     rsi, [rax+28h]; wrappername
    lea     rdx, optionname; "proxy"
    mov     rdi, context; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C37F9
    cmp     byte ptr [tmpzval+8], 6
    jnz     short loc_5C37F9
    mov     resource, [tmpzval]
    cmp     qword ptr [r15+10h], 0
    jz      short loc_5C37F9
    mov     eax, 1
    mov     [rsp+0D98h+var_D18], rax
    mov     [rsp+0D98h+var_D34], 0
    test    byte ptr [r15+4], 40h
    jnz     loc_5C398C
    mov     al, 1
    mov     [rsp+0D98h+header_bag], rax
    add     dword ptr [r15], 1
    jmp     loc_5C3993
loc_5C37DF:
    lea     mode, aRedirectionLim; "Redirection limit reached, aborting"
    xor     ebx, ebx
    mov     rdi, wrapper; wrapper
    mov     esi, ecx; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    jmp     loc_5C55B9
loc_5C37F9:
    mov     rdi, [rsp+0D98h+theurl]; theurl
    call    php_url_free
    mov     rdi, [rsp+0D98h+bytes_max]; path
    mov     rsi, mode; mode
    mov     edx, 8; options
    xor     ecx, ecx; opened_path
    mov     r8, context; context
    call    _php_stream_open_wrapper_ex
    mov     redirect_max, rax
    jmp     loc_5C55B9
loc_5C3822:
    lea     rsi, aAwx; "awx+"
    mov     rdi, mode; s
    call    _strpbrk
    test    rax, rax
    jz      short loc_5C385A
    lea     rdx, aHttpWrapperDoe; "HTTP wrapper does not support writeable"...
    xor     ebx, ebx
    mov     rdi, wrapper; wrapper
    mov     esi, [rsp+0D98h+var_D5C]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    mov     rdi, resource; theurl
    call    php_url_free
    jmp     loc_5C55B9
loc_5C385A:
    mov     [rsp+0D98h+opened_path], context
    mov     [rsp+0D98h+var_D10], redirect_max
    mov     rax, [resource]
    test    rax, rax
    jz      short loc_5C38B6
    mov     [rsp+0D98h+var_D34], 0
    cmp     qword ptr [rax+10h], 5
    mov     ebx, 0
    jb      short loc_5C38C0
    mov     [rsp+0D98h+var_D34], 0
    cmp     byte ptr [rax+1Ch], 73h ; 's'
    mov     ebx, 0
    jnz     short loc_5C38C0
    cmp     word ptr [resource+20h], 0
    jz      loc_5C571D
    mov     bl, 1
    mov     [rsp+0D98h+var_D34], 1
    cmp     word ptr [resource+20h], 0
    jnz     short loc_5C38CF
    jmp     short loc_5C38C8
loc_5C38B6:
    mov     [rsp+0D98h+var_D34], 0
    xor     ebx, ebx
loc_5C38C0:
    cmp     word ptr [resource+20h], 0
    jnz     short loc_5C38CF
loc_5C38C8:
    mov     word ptr [resource+20h], 50h ; 'P'
loc_5C38CF:
    mov     rbp, [rsp+0D98h+opened_path]
    test    rbp, rbp
    jz      short loc_5C391E
    mov     rax, [wrapper]
    mov     rsi, [rax+28h]; wrappername
    lea     rdx, optionname; "proxy"
    mov     rdi, rbp; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C391E
    cmp     byte ptr [tmpzval+8], 6
    jnz     short loc_5C391E
    mov     resource, [tmpzval]
    cmp     qword ptr [r15+10h], 0
    jz      short loc_5C391E
    mov     eax, 1
    mov     [rsp+0D98h+var_D18], rax
    test    byte ptr [r15+4], 40h
    jnz     short loc_5C3966
    add     dword ptr [r15], 1
    jmp     short loc_5C3966
loc_5C391E:
    lea     rax, aOpenssl+4; "ssl"
    lea     rdx, aTcp; "tcp"
    test    bl, bl
    cmovnz  rdx, rax
    mov     rax, [rsp+0D98h+theurl]
    mov     rcx, [rax+18h]
    add     rcx, 18h
    movzx   r8d, word ptr [rax+20h]
    lea     rsi, aSSD; "%s://%s:%d"
    xor     eax, eax
    mov     [rsp+0D98h+var_D18], rax
    xor     edi, edi; max_len
    xor     eax, eax
    call    zend_strpprintf
    mov     r15, rax
    test    rbp, rbp
    jz      short loc_5C3974
loc_5C3966:
    xor     eax, eax
    mov     [rsp+0D98h+header_bag], rax
    mov     r12, [rsp+0D98h+opened_path]
    jmp     short loc_5C3993
loc_5C3974:
    xor     eax, eax
    mov     [rsp+0D98h+var_D30], rax
    xor     eax, eax
    mov     [rsp+0D98h+header_bag], rax
    mov     r12, [rsp+0D98h+opened_path]
    jmp     loc_5C3A1C
loc_5C398C:
    mov     al, 1
    mov     [rsp+0D98h+header_bag], rax
loc_5C3993:
    mov     rax, [wrapper]
    mov     rsi, [rax+28h]; wrappername
    lea     rdx, aTimeout; "timeout"
    mov     rdi, r12; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C3A15
    cmp     byte ptr [tmpzval+8], 5
    jnz     loc_5C65F3
    movsd   xmm0, qword ptr [tmpzval]
loc_5C39BC:
    mov     rbx, mode
    cvttsd2si rcx, xmm0
    cvtsi2sd d, rcx
    subsd   xmm0, d
    mulsd   xmm0, cs:qword_739C90
    movsd   xmm1, cs:qword_73B4C8
    movapd  xmm2, xmm0
    subsd   xmm2, xmm1
    cvttsd2si rax, xmm2
    mov     rdx, 8000000000000000h
    xor     rdx, rax
    cvttsd2si rax, xmm0
    ucomisd xmm0, xmm1
    mov     [rsp+0D98h+timeout.tv_sec], rcx
    cmovnb  rax, rdx
    mov     cl, 1
    mov     [rsp+0D98h+var_D30], rcx
    jmp     short loc_5C3A34
loc_5C3A15:
    mov     al, 1
    mov     [rsp+0D98h+var_D30], rax
loc_5C3A1C:
    mov     rbx, mode
    lea     rax, file_globals
    mov     rax, [rax+18h]
    mov     [rsp+0D98h+timeout.tv_sec], rax
    xor     eax, eax
loc_5C3A34:
    mov     [rsp+0D98h+timeout.tv_usec], rax
    lea     rdi, [r15+18h]; name
    mov     rsi, [r15+10h]; namelen
    lea     rax, [rsp+0D98h+var_CE8]
    mov     [rsp+0D98h+error_string+8], rax; error_string
    mov     [rsp+0D98h+opened_path], r12
    mov     [rsp+0D98h+error_string], r12; context
    mov     [rsp+0D98h+error_code], 0; error_code
    lea     r9, [rsp+0D98h+timeout]; timeout
    mov     edx, [rsp+0D98h+var_D5C]; options
    mov     ecx, 2; flags
    xor     r8d, r8d; persistent_id
    call    _php_stream_xport_create
    mov     r13, rax
    test    rax, rax
    jz      short loc_5C3A9B
    lea     rcx, [rsp+0D98h+timeout]; ptrparam
    mov     rdi, stream; stream
    mov     esi, 4; option
    xor     edx, edx; value
    call    _php_stream_set_option
loc_5C3A9B:
    mov     [rsp+0D98h+var_D00], stream
    mov     rcx, [rsp+0D98h+var_CE8]
    test    errstr, errstr
    mov     r13, mode
    jz      short loc_5C3AF1
    add     errstr, 18h
    lea     rdx, aXPhpOriginatin+22h; fmt
    mov     rdi, wrapper; wrapper
    mov     esi, [rsp+0D98h+var_D5C]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    mov     rdi, [rsp+0D98h+var_CE8]; ptr
    mov     eax, [errstr+4]
    test    al, 40h
    jnz     short loc_5C3AE5
    add     dword ptr [errstr], 0FFFFFFFFh
    jnz     short loc_5C3AE5
    call    _efree
loc_5C3AE5:
    mov     [rsp+0D98h+var_CE8], 0
loc_5C3AF1:
    mov     eax, [r15+4]
    test    al, 40h
    jnz     short loc_5C3B12
    add     dword ptr [r15], 0FFFFFFFFh
    jnz     short loc_5C3B12
    mov     rdi, r15; ptr
    test    al, al
    js      short loc_5C3B0D
    call    _efree
    jmp     short loc_5C3B12
loc_5C3B0D:
    call    free
loc_5C3B12:
    cmp     [rsp+0D98h+var_D34], 0
    mov     [rsp+0D98h+src], mode
    mov     [rsp+0D98h+var_D08], wrapper
    jz      loc_5C3BBF
    cmp     dword ptr [rsp+0D98h+var_D18], 0
    mov     rbx, [rsp+0D98h+var_D00]
    mov     r15, [rsp+0D98h+var_D10]
    jz      loc_5C4103
    test    rbx, rbx
    jz      loc_5C4103
    xorpd   xmm0, xmm0
    movapd  xmmword ptr [rsp+0D98h+str.s], xmm0
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C3B82
    lea     rsi, aOpenssl+4; wrappername
    lea     rdx, aPeerName; "peer_name"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jnz     short loc_5C3BF4
loc_5C3B82:
    mov     rax, [rsp+0D98h+theurl]
    mov     rcx, [rax+18h]
    mov     qword ptr [rsp+0D98h+optionvalue.value], __s
    mov     eax, 6
    test    byte ptr [__s+4], 40h
    jnz     short loc_5C3BA6
    add     dword ptr [__s], 1
    mov     eax, 106h
loc_5C3BA6:
    mov     dword ptr [rsp+0D98h+optionvalue.u1], eax
    mov     rax, [rbx+90h]
    test    rax, rax
    jz      short loc_5C3BCC
    mov     rdi, [rax+10h]
    jmp     short loc_5C3BCE
loc_5C3BBF:
    mov     rbx, [rsp+0D98h+var_D00]
    jmp     loc_5C40FB
loc_5C3BCC:
    xor     edi, edi; context
loc_5C3BCE:
    lea     rsi, aOpenssl+4; wrappername
    lea     rdx, aPeerName; "peer_name"
    lea     rbx, [rsp+0D98h+optionvalue]
    mov     rcx, rbx; optionvalue
    call    php_stream_context_set_option
    mov     rdi, rbx; zval_ptr
    call    zval_ptr_dtor
loc_5C3BF4:
    mov     rax, [rsp+0D98h+str.s]
    test    rax, rax
    jz      loc_5C657A
    mov     rcx, [rax+10h]
    lea     r12, [rcx+8]
    cmp     r12, [rsp+0D98h+str.a]
    jnb     loc_5C6580
loc_5C3C1B:
    mov     rdx, 205443454E4E4F43h
    mov     [rax+rcx+18h], rdx
    mov     r14, [rsp+0D98h+str.s]
    mov     [r14+10h], r12
    mov     rax, [rsp+0D98h+theurl]
    mov     rbp, [rax+18h]
    add     rbp, 18h
    mov     rdi, rbp; s
    call    _strlen
    mov     mode, rax
    mov     rbx, rax
    test    r14, r14
    jz      loc_5C6089
    mov     rbx, r13
    add     rbx, r12
    cmp     rbx, [rsp+0D98h+str.a]
    jnb     loc_5C6089
loc_5C3C6E:
    lea     rdi, [r14+r12]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r13; n
    call    _memcpy
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    test    rax, rax
    jz      loc_5C65A1
    add     rbx, 1
    cmp     rbx, [rsp+0D98h+str.a]
    mov     r13, [rsp+0D98h+src]
    mov     rbp, [rsp+0D98h+theurl]
    jnb     loc_5C65B0
loc_5C3CB2:
    mov     byte ptr [rbx+rax+17h], 3Ah ; ':'
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    movzx   ecx, word ptr [rbp+20h]
    lea     r12, [rsp+0D98h+var_819]
    mov     [rsp+0D98h+var_819], 0
    mov     rsi, 0CCCCCCCCCCCCCCCDh
    mov     rbp, r12
    nop     word ptr [rax+rax+00000000h]
    xchg    ax, ax
loc_5C3CF0:
    mov     rax, rcx
    mul     rsi
    shr     rdx, 3
    lea     eax, [rdx+rdx]
    lea     eax, [rax+rax*4]
    mov     edi, ecx
    sub     edi, eax
    or      dil, 30h
    mov     [rbp-1], dil
    add     rbp, 0FFFFFFFFFFFFFFFFh
    cmp     rcx, 9
    mov     rcx, rdx
    ja      short loc_5C3CF0
    sub     r12, rbp
    mov     rax, [rsp+0D98h+str.s]
    mov     rbx, r12
    test    rax, rax
    jz      loc_5C60AA
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+r12]
    cmp     rbx, [rsp+0D98h+str.a]
    jnb     loc_5C60AA
loc_5C3D46:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r12; n
    call    _memcpy
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    test    rax, rax
    jz      loc_5C65CD
    lea     rbp, [rbx+0Bh]
    cmp     rbp, [rsp+0D98h+str.a]
    jnb     loc_5C65D2
loc_5C3D80:
    mov     rcx, 2E312F5054544820h
    mov     [rax+rbx+18h], rcx
    mov     dword ptr [rax+rbx+1Fh], 0A0D302Eh
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbp
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      loc_5C3F9D
    mov     r14, r13
    lea     rsi, aHttp; "http"
    lea     rdx, aTheAdditionalH+2Fh; optionname
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      loc_5C3F92
    mov     cl, [tmpzval+8]
    cmp     cl, 6
    jz      loc_5C3EDD
    cmp     cl, 7
    jnz     loc_5C3F92
    mov     tmpzval, [tmpzval]
    mov     r15d, [__ht+18h]
    test    r15, r15
    jz      loc_5C3F92
    mov     r13, [__ht+10h]
    shl     r15, 5
    add     r15, _p
    mov     r12d, 2401h
    cmp     byte ptr [_z+8], 6
    jz      short loc_5C3E23
loc_5C3E0F:
    add     _p, 20h ; ' '
    cmp     _p, _end
    jz      loc_5C3F92
    cmp     byte ptr [_z+8], 6
    jnz     short loc_5C3E0F
loc_5C3E23:
    mov     rbp, [_z+0]
    add     rbp, 18h
    jmp     short loc_5C3E31
loc_5C3E2D:
    add     s, 1
loc_5C3E31:
    mov     al, [s+0]
    cmp     al, 9
    jz      short loc_5C3E2D
    cmp     al, 20h ; ' '
    jz      short loc_5C3E2D
    lea     rbx, [s+1]
    cmp     al, 0Ch
    jle     short loc_5C3E62
    nop     word ptr [rax+rax+00000000h]
    xchg    ax, ax
loc_5C3E50:
    cmp     al, 0Dh
    jz      short loc_5C3E6A
    cmp     al, 3Ah ; ':'
    jz      short loc_5C3E70
loc_5C3E58:
    mov     al, [rbx]
    add     rbx, 1
    cmp     al, 0Ch
    jg      short loc_5C3E50
loc_5C3E62:
    test    al, al
    jz      short loc_5C3E6A
    cmp     al, 0Ah
    jnz     short loc_5C3E58
loc_5C3E6A:
    add     rbx, 0FFFFFFFFFFFFFFFFh
    jmp     short loc_5C3EB3
loc_5C3E70:
    mov     rax, rbx
    sub     rax, s
    cmp     rax, 14h
    jnz     short loc_5C3EA4
    mov     esi, 14h; len1
    mov     ecx, 14h; len2
    mov     rdi, s; s1
    lea     rdx, aProxyAuthoriza; "Proxy-Authorization:"
    call    zend_binary_strcasecmp
    test    eax, eax
    jnz     short loc_5C3EA4
    jmp     loc_5C5F75
loc_5C3EA0:
    add     p, 1
loc_5C3EA4:
    movzx   eax, byte ptr [p]
    cmp     rax, 0Dh
    ja      short loc_5C3EA0
    bt      r12, rax
    jnb     short loc_5C3EA0
loc_5C3EB3:
    mov     s, rbx
    cmp     al, 0Ah
    jnz     short loc_5C3ECC
    nop     word ptr [rax+rax+00h]
loc_5C3EC0:
    movzx   eax, byte ptr [s+1]
    add     s, 1
    cmp     al, 0Ah
    jz      short loc_5C3EC0
loc_5C3ECC:
    cmp     al, 0Dh
    jz      short loc_5C3EC0
    test    al, al
    jnz     loc_5C3E31
    jmp     loc_5C3E0F
loc_5C3EDD:
    mov     rbx, [tmpzval]
    cmp     qword ptr [rbx+10h], 0
    jz      loc_5C3F92
    add     rbx, 18h
    lea     r15, aProxyAuthoriza; "Proxy-Authorization:"
    mov     r12d, 2401h
    jmp     short loc_5C3F02
loc_5C3EFE:
    add     s, 1
loc_5C3F02:
    mov     al, [s]
    cmp     al, 9
    jz      short loc_5C3EFE
    cmp     al, 20h ; ' '
    jz      short loc_5C3EFE
    lea     rbp, [s+1]
    cmp     al, 0Ch
    jle     short loc_5C3F27
loc_5C3F14:
    cmp     al, 0Dh
    jz      short loc_5C3F2F
    cmp     al, 3Ah ; ':'
    jz      short loc_5C3F35
loc_5C3F1C:
    mov     al, [rbp+0]
    add     rbp, 1
    cmp     al, 0Ch
    jg      short loc_5C3F14
loc_5C3F27:
    test    al, al
    jz      short loc_5C3F2F
    cmp     al, 0Ah
    jnz     short loc_5C3F1C
loc_5C3F2F:
    add     rbp, 0FFFFFFFFFFFFFFFFh
    jmp     short loc_5C3F73
loc_5C3F35:
    mov     rax, rbp
    sub     rax, s
    cmp     rax, 14h
    jnz     short loc_5C3F63
    mov     esi, 14h; len1
    mov     ecx, 14h; len2
    mov     rdi, s; s1
    mov     rdx, r15; s2
    call    zend_binary_strcasecmp
    test    eax, eax
    jnz     short loc_5C3F63
    jmp     loc_5C64D0
loc_5C3F5F:
    add     p, 1
loc_5C3F63:
    movzx   eax, byte ptr [p+0]
    cmp     rax, 0Dh
    ja      short loc_5C3F5F
    bt      r12, rax
    jnb     short loc_5C3F5F
loc_5C3F73:
    mov     s, rbp
    cmp     al, 0Ah
    jnz     short loc_5C3F86
loc_5C3F7A:
    movzx   eax, byte ptr [s+1]
    add     s, 1
    cmp     al, 0Ah
    jz      short loc_5C3F7A
loc_5C3F86:
    cmp     al, 0Dh
    jz      short loc_5C3F7A
    test    al, al
    jnz     loc_5C3F02
loc_5C3F92:
    mov     rax, [rsp+0D98h+str.s]
    mov     r13, r14
loc_5C3F9D:
    test    rax, rax
    jz      loc_5C6017
loc_5C3FA6:
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+2]
    cmp     rbx, [rsp+0D98h+str.a]
    mov     r14, [rsp+0D98h+var_D08]
    jnb     loc_5C6024
loc_5C3FC4:
    mov     word ptr [rax+rcx+18h], 0A0Dh
    mov     rsi, [rsp+0D98h+str.s]
    mov     [rsi+10h], rbx
    add     rsi, 18h; buf
    mov     rbp, [rsp+0D98h+var_D00]
    mov     rdi, rbp; stream
    mov     rdx, rbx; count
    call    _php_stream_write
    mov     rdi, [rsp+0D98h+str.s]
    cmp     rax, [rdi+10h]
    jnz     short loc_5C4006
    mov     rbx, rbp
    test    rdi, rdi
    jnz     short loc_5C4037
    jmp     short loc_5C4054
loc_5C4006:
    lea     rdx, aCannotConnectT; "Cannot connect to HTTPS server through "
    mov     rdi, r14; wrapper
    mov     esi, [rsp+0D98h+var_D5C]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    mov     rdi, rbp; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     rdi, [rsp+0D98h+str.s]; ptr
    xor     ebx, ebx
    test    rdi, rdi
    jz      short loc_5C4054
loc_5C4037:
    mov     eax, [rdi+4]
    test    al, 40h
    jnz     short loc_5C4048
    add     dword ptr [rdi], 0FFFFFFFFh
    jnz     short loc_5C4048
    call    _efree
loc_5C4048:
    mov     [rsp+0D98h+str.s], 0
loc_5C4054:
    mov     [rsp+0D98h+str.a], 0
    test    stream, stream
    jz      loc_5C40F9
    lea     r14, [rsp+0D98h+buf]
    mov     ebp, 2401h
    nop     word ptr [rax+rax+00000000h]
loc_5C4080:
    mov     edx, 3FFh; maxlen
    mov     rdi, stream; stream
    mov     rsi, r14; buf
    xor     ecx, ecx; returned_len
    call    _php_stream_get_line
    test    rax, rax
    jz      short loc_5C40AB
    movzx   eax, [rsp+0D98h+buf]
    cmp     rax, 0Dh
    ja      short loc_5C4080
    bt      rbp, rax
    jnb     short loc_5C4080
loc_5C40AB:
    mov     rdi, stream; stream
    mov     esi, 39h ; '9'; crypto_method
    xor     edx, edx; session_stream
    call    php_stream_xport_crypto_setup
    test    eax, eax
    js      short loc_5C40CF
    mov     rdi, stream; stream
    mov     esi, 1; activate
    call    php_stream_xport_crypto_enable
    test    eax, eax
    jns     short loc_5C40FB
loc_5C40CF:
    lea     rdx, aCannotConnectT; "Cannot connect to HTTPS server through "
    mov     r14, [rsp+0D98h+var_D08]
    mov     rdi, r14; wrapper
    mov     esi, [rsp+0D98h+var_D5C]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    mov     rdi, stream; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_5C40F9:
    xor     ebx, ebx
loc_5C40FB:
    mov     r15, [rsp+0D98h+var_D10]
loc_5C4103:
    test    stream, stream
    jz      short loc_5C4113
    test    byte ptr [rsp+0D98h+var_D5C], 20h
    jnz     short loc_5C4130
    xor     eax, eax
    jmp     short loc_5C4146
loc_5C4113:
    xor     r15d, r15d
    mov     [rsp+0D98h+var_CEC], 0
    xor     r14d, r14d
    xor     ebp, ebp
    xor     r12d, r12d
    xor     ebx, ebx
    jmp     out
loc_5C4130:
    mov     rdi, stream; stream
    mov     esi, 5; option
    mov     edx, 1; value
    xor     ecx, ecx; ptrparam
    call    _php_stream_set_option
    cdqe
loc_5C4146:
    mov     [rsp+0D98h+var_CF8], rax
    mov     eax, [stream+74h]
    mov     [rsp+0D98h+var_CEC], eax
    and     eax, 0FFFFFFF3h
    mov     [stream+74h], eax
    mov     rdi, stream; stream
    mov     rbp, [rsp+0D98h+opened_path]
    mov     rsi, rbp; context
    call    php_stream_context_set
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    mov     [rsp+0D98h+var_D00], stream
    jz      loc_5C42A3
    cmp     qword ptr [rbp+0], 0
    jz      short loc_5C41A8
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0; bytes_max
    mov     rdi, rbp; context
    mov     esi, 2; notifycode
    xor     edx, edx; severity
    xor     ecx, ecx; xmsg
    xor     r8d, r8d; xcode
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C41A8:
    mov     eax, [rsp+0D98h+redirect_max_0]
    mov     [rsp+0D98h+var_D28], eax
    test    al, 1
    jz      short loc_5C41E1
    lea     rsi, aHttp; "http"
    lea     rdx, aMaxRedirects; "max_redirects"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C41E1
    cmp     byte ptr [tmpzval+8], 4
    jnz     loc_5C6883
    mov     r15, [tmpzval]
loc_5C41E1:
    mov     eax, [rsp+0D98h+var_D28]
    and     al, 1
    mov     [rsp+0D98h+var_D28], eax
    lea     rsi, aHttp; "http"
    lea     rdx, aIntlcalIsWeeke+26h; optionname
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      loc_5C42AB
    cmp     byte ptr [tmpzval+8], 6
    mov     rdx, [rsp+0D98h+header_bag]
    jnz     loc_5C42B0
    mov     r12, [tmpzval]
    mov     rbp, [r12+10h]
    test    rbp, rbp
    jz      loc_5C42B0
    mov     eax, [rsp+0D98h+redirect_max_0]
    test    al, 2
    jnz     loc_5C5742
loc_5C423B:
    add     r12, 18h
    mov     rax, [rsp+0D98h+ptr]
    mov     rbx, rbp
    test    rax, rax
    jz      loc_5C6895
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+rbp]
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C6895
loc_5C4263:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, r12; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    test    rax, rax
    jz      loc_5C6907
    add     rbx, 1
    cmp     rbx, [rsp+0D98h+ptr+8]
    mov     rdx, [rsp+0D98h+header_bag]
    jnb     loc_5C690C
loc_5C429C:
    mov     byte ptr [rbx+rax+17h], 20h ; ' '
    jmp     short loc_5C42D9
loc_5C42A3:
    mov     [rsp+0D98h+var_D28], 0
loc_5C42AB:
    mov     rdx, [rsp+0D98h+header_bag]
loc_5C42B0:
    mov     rax, [rsp+0D98h+ptr]
    test    rax, rax
    jz      loc_5C646F
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+4]
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C6474
loc_5C42D1:
    mov     dword ptr [rax+rcx+18h], 20544547h
loc_5C42D9:
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    test    dl, dl
    setnz   al
    mov     rcx, [rsp+0D98h+var_D30]
    mov     ebx, ecx
    xor     bl, 1
    or      al, bl
    mov     [rsp+0D98h+var_D10], r15
    mov     [rsp+0D98h+var_D21], bl
    jnz     short loc_5C432B
    lea     rsi, aHttp; "http"
    lea     rdx, aRequestFulluri; "request_fulluri"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C432F
    mov     rdi, tmpzval; op
    call    zend_is_true
    test    eax, eax
    setnz   dl
loc_5C432B:
    test    dl, dl
    jnz     short loc_5C4396
loc_5C432F:
    mov     rax, [rsp+0D98h+theurl]
    mov     rbp, [rax+28h]
    test    rbp, rbp
    jz      loc_5C43E8
    cmp     qword ptr [rbp+10h], 0
    jz      loc_5C43E8
    add     rbp, 18h
    mov     rdi, rbp; s
    call    _strlen
    mov     r12, rax
    mov     rax, [rsp+0D98h+ptr]
    mov     rbx, r12
    test    rax, rax
    jz      loc_5C676B
    mov     rcx, [rax+10h]
    mov     rbx, r12
    add     rbx, rcx
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C676B
loc_5C4381:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r12; n
    call    _memcpy
    jmp     short loc_5C440E
loc_5C4396:
    mov     rdi, [rsp+0D98h+bytes_max]; s
    call    _strlen
    mov     rbx, rax
    mov     rax, [rsp+0D98h+ptr]
    mov     rbp, rbx
    test    rax, rax
    jz      loc_5C64B5
    mov     rcx, [rax+10h]
    mov     rbp, rbx
    add     rbp, rcx
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C64B5
loc_5C43C9:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, [rsp+0D98h+bytes_max]; src
    mov     rdx, rbx; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    jmp     loc_5C449C
loc_5C43E8:
    mov     rax, [rsp+0D98h+ptr]
    test    rax, rax
    jz      loc_5C67A7
    mov     rbx, [rax+10h]
    add     rbx, 1
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C67AC
loc_5C4409:
    mov     byte ptr [rbx+rax+17h], 2Fh ; '/'
loc_5C440E:
    mov     rcx, [rsp+0D98h+theurl]
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    cmp     qword ptr [rcx+30h], 0
    jz      short loc_5C44A0
    test    rax, rax
    jz      loc_5C6786
    add     rbx, 1
    cmp     rbx, [rsp+0D98h+ptr+8]
    mov     r12, [rsp+0D98h+theurl]
    jnb     loc_5C6790
loc_5C4440:
    mov     byte ptr [rbx+rax+17h], 3Fh ; '?'
    mov     r14, [rsp+0D98h+ptr]
    mov     [r14+10h], rbx
    mov     r12, [r12+30h]
    add     r12, 18h
    mov     rdi, r12; s
    call    _strlen
    mov     r13, rax
    mov     rbp, rax
    test    r14, r14
    jz      loc_5C6600
    mov     rbp, r13
    add     rbp, rbx
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C6600
loc_5C447F:
    lea     rdi, [r14+rbx]
    add     rdi, 18h; dest
    mov     rsi, r12; src
    mov     rdx, r13; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     r13, [rsp+0D98h+src]
loc_5C449C:
    mov     [rax+10h], rbp
loc_5C44A0:
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      loc_5C45B8
    lea     rsi, aHttp; "http"
    lea     rdx, aProtocolVersio; "protocol_version"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      loc_5C45B3
    cmp     byte ptr [tmpzval+8], 5
    jnz     loc_5C67DE
    movsd   xmm0, qword ptr [tmpzval]
loc_5C44DA:
    lea     rdx, aF1f+2; format
    lea     rdi, [rsp+0D98h+buf]; message
    xor     esi, esi; max_len
    mov     al, 1
    call    zend_spprintf
    mov     rax, [rsp+0D98h+ptr]
    test    rax, rax
    jz      loc_5C67EB
    mov     rcx, [rax+10h]
    lea     r13, [rcx+6]
    cmp     r13, [rsp+0D98h+ptr+8]
    jnb     loc_5C67F1
loc_5C4513:
    mov     word ptr [rax+rcx+1Ch], 2F50h
    mov     dword ptr [rax+rcx+18h], 54544820h
    mov     rbx, [rsp+0D98h+ptr]
    mov     [rbx+10h], r13
    mov     r12, qword ptr [rsp+0D98h+buf]
    mov     rdi, protocol_version; s
    call    _strlen
    mov     r14, rax
    mov     rbp, rax
    test    rbx, rbx
    jz      loc_5C665B
    mov     rbp, r14
    add     rbp, r13
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C665B
loc_5C455B:
    lea     rdi, [rbx+r13]
    add     rdi, 18h; dest
    mov     rsi, protocol_version; src
    mov     rdx, r14; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbp
    test    rax, rax
    jz      loc_5C680C
    lea     rbx, [rbp+2]
    cmp     rbx, [rsp+0D98h+ptr+8]
    mov     r13, [rsp+0D98h+src]
    jnb     loc_5C6816
loc_5C4594:
    mov     word ptr [rax+rbp+18h], 0A0Dh
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    mov     rdi, qword ptr [rsp+0D98h+buf]; ptr
    call    _efree
    jmp     short loc_5C45FF
loc_5C45B3:
    mov     tmpzval, [rsp+0D98h+ptr]
loc_5C45B8:
    test    rax, rax
    jz      loc_5C661B
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+0Bh]
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C6620
loc_5C45D4:
    mov     rdx, 2E312F5054544820h
    mov     [rax+rcx+18h], rdx
    mov     dword ptr [rax+rcx+1Fh], 0A0D312Eh
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      loc_5C49EE
loc_5C45FF:
    lea     rsi, aHttp; "http"
    lea     rdx, aTheAdditionalH+2Fh; optionname
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      loc_5C49EE
    mov     cl, [tmpzval+8]
    cmp     cl, 6
    jz      loc_5C472D
    cmp     cl, 7
    jnz     loc_5C49EE
    xorpd   xmm0, xmm0
    movapd  xmmword ptr [rsp+0D98h+buf], xmm0
    mov     tmpzval, [tmpzval]
    mov     r12d, [__ht+18h]
    test    r12, r12
    jz      loc_5C49E3
    mov     r15, [__ht+10h]
    shl     r12, 5
    xor     r14d, r14d
    xor     eax, eax
    cmp     byte ptr [r15+r14+8], 6
    jz      short loc_5C467C
loc_5C4667:
    add     r14, 20h ; ' '
    cmp     r12, r14
    jz      loc_5C496D
    cmp     byte ptr [r15+r14+8], 6
    jnz     short loc_5C4667
loc_5C467C:
    mov     rbx, [r15+r14]
    mov     r13, [rbx+10h]
    add     rbx, 18h
    mov     rbp, r13
    test    rax, rax
    jz      short loc_5C46EC
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+r13]
    cmp     rbp, qword ptr [rsp+0D98h+buf+8]
    jnb     short loc_5C46EC
loc_5C46A2:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbx; src
    mov     rdx, r13; n
    call    _memcpy
    mov     rax, qword ptr [rsp+0D98h+buf]
    mov     [rax+10h], rbp
    test    rax, rax
    jz      short loc_5C470A
    lea     rbx, [rbp+2]
    cmp     rbx, qword ptr [rsp+0D98h+buf+8]
    jnb     short loc_5C470F
loc_5C46D4:
    mov     word ptr [rax+rbp+18h], 0A0Dh
    mov     rax, qword ptr [rsp+0D98h+buf]
    mov     [rax+10h], rbx
    jmp     loc_5C4667
loc_5C46EC:
    lea     rdi, [rsp+0D98h+buf]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, qword ptr [rsp+0D98h+buf]
    mov     rcx, [rax+10h]
    jmp     short loc_5C46A2
loc_5C470A:
    mov     ebx, 2
loc_5C470F:
    lea     rdi, [rsp+0D98h+buf]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, qword ptr [rsp+0D98h+buf]
    mov     rbp, [rax+10h]
    jmp     short loc_5C46D4
loc_5C472D:
    mov     rdi, [tmpzval]; str
    cmp     qword ptr [rdi+10h], 0
    jz      loc_5C49EE
    xor     esi, esi; what
    xor     edx, edx; what_len
    mov     ecx, 3; mode
    call    php_trim
    mov     rbx, rax
    test    tmp, tmp
    jz      loc_5C49EE
loc_5C4755:
    mov     rsi, [tmp+10h]; length
    test    rsi, rsi
    jz      loc_5C5733
    lea     r14, [tmp+18h]
    mov     rdi, r14; s
    call    _estrndup
    mov     [rsp+0D98h+header_bag], rax
    test    byte ptr [tmp+4], 40h
    jnz     short loc_5C4785
    mov     eax, [tmp]
    cmp     eax, 2
    jb      short loc_5C47CC
    add     eax, 0FFFFFFFFh
    mov     [tmp], eax
loc_5C4785:
    mov     rbp, [tmp+10h]
    lea     rdi, [rbp+20h]
    and     rdi, 0FFFFFFFFFFFFFFF8h; size
    call    _emalloc
    mov     tmp, rax
    mov     rax, 1600000001h
    mov     [tmp], rax
    mov     qword ptr [tmp+8], 0
    mov     [tmp+10h], rbp
    lea     rdi, [tmp+18h]; dest
    mov     rsi, r14; src
    mov     rdx, rbp; n
    call    _memcpy
    lea     rax, [tmp+rbp]
    add     rax, 18h
    mov     byte ptr [rax], 0
loc_5C47CC:
    lea     r14, [tmp+18h]
    mov     r15, tmp
    mov     rsi, [rbx+10h]; len
    mov     rdi, t; s
    call    php_strtolower
    mov     eax, [rsp+0D98h+redirect_max_0]
    test    al, 1
    jnz     short loc_5C4813
    lea     rdx, lc_header_name; "content-length:"
    mov     rbx, [rsp+0D98h+header_bag]
    mov     rdi, rbx; header_bag
    mov     rsi, t; lc_header_bag
    call    strip_header
    lea     rdx, aContentType_0; "content-type:"
    mov     rdi, rbx; header_bag
    mov     rsi, t; lc_header_bag
    call    strip_header
loc_5C4813:
    lea     rsi, header; "user-agent:"
    mov     rdi, t; headers
    call    check_has_header
    movzx   ebp, al
    lea     rsi, aHost; "host:"
    mov     rdi, t; headers
    call    check_has_header
    lea     ebx, [have_header+2]
    test    al, al
    cmovz   ebx, ebp
    lea     rsi, aFrom_0; "from:"
    mov     rdi, t; headers
    call    check_has_header
    lea     ebp, [have_header+8]
    test    al, al
    cmovz   ebp, ebx
    lea     rsi, aAuthorization; "authorization:"
    mov     rdi, t; headers
    call    check_has_header
    lea     ebx, [have_header+4]
    test    al, al
    cmovz   ebx, ebp
    lea     rsi, lc_header_name; "content-length:"
    mov     rdi, t; headers
    call    check_has_header
    mov     ebp, ebx
    or      ebp, 10h
    test    al, al
    cmovz   ebp, ebx
    lea     rsi, aContentType_0; "content-type:"
    mov     rdi, t; headers
    call    check_has_header
    mov     ebx, ebp
    or      ebx, 20h
    test    al, al
    cmovz   ebx, ebp
    lea     rsi, aConnection; "connection:"
    mov     rdi, t; headers
    call    check_has_header
    mov     r12d, ebx
    or      r12d, 40h
    test    al, al
    cmovz   r12d, ebx
    cmp     [rsp+0D98h+var_D34], 0
    jz      loc_5C6059
    cmp     dword ptr [rsp+0D98h+var_D18], 0
    jz      loc_5C6059
    lea     rsi, aProxy; "proxy-"
    mov     rdi, t; haystack
    call    _strstr
    test    s, s
    jz      loc_5C6059
    cmp     s, t
    jz      short loc_5C48F8
    cmp     byte ptr [s-1], 0Ah
    jnz     loc_5C6059
loc_5C48F8:
    mov     rbp, s
    cmp     s, t
    ja      short loc_5C490B
    jmp     short loc_5C4919
loc_5C4902:
    add     s, 0FFFFFFFFFFFFFFFFh
    cmp     s, t
    jbe     short loc_5C4919
loc_5C490B:
    movzx   ecx, byte ptr [s-1]
    cmp     cl, 20h ; ' '
    jz      short loc_5C4902
    cmp     cl, 9
    jz      short loc_5C4902
loc_5C4919:
    add     rax, 14h
    mov     edx, 2401h
    jmp     short loc_5C4928
loc_5C4924:
    add     p, 1
loc_5C4928:
    movzx   ecx, byte ptr [p]
    cmp     rcx, 0Dh
    ja      short loc_5C4924
    bt      rdx, rcx
    jnb     short loc_5C4924
    jmp     short loc_5C4941
loc_5C4939:
    movzx   ecx, byte ptr [p+1]
    add     p, 1
loc_5C4941:
    cmp     cl, 0Ah
    jz      short loc_5C4939
    cmp     cl, 0Dh
    jz      short loc_5C4939
    mov     rbx, have_header
    test    cl, cl
    jnz     loc_5C5F1A
    cmp     s, t
    jz      loc_5C6045
    mov     have_header, rbx
    ja      loc_5C5781
    jmp     loc_5C578D
loc_5C496D:
    test    rax, rax
    jz      loc_5C5DD7
    mov     rcx, [rax+10h]
    mov     byte ptr [rax+rcx+18h], 0
    mov     rdi, qword ptr [rsp+0D98h+buf]; str
    test    rdi, rdi
    mov     r13, [rsp+0D98h+src]
    jz      short loc_5C49E3
    xor     esi, esi; what
    xor     edx, edx; what_len
    mov     ecx, 3; mode
    call    php_trim
    mov     rbx, rax
    mov     rdi, qword ptr [rsp+0D98h+buf]; ptr
    test    rdi, rdi
    jz      short loc_5C49CC
    mov     eax, [rdi+4]
    test    al, 40h
    jnz     short loc_5C49C0
    add     dword ptr [rdi], 0FFFFFFFFh
    jnz     short loc_5C49C0
    call    _efree
loc_5C49C0:
    mov     qword ptr [rsp+0D98h+buf], 0
loc_5C49CC:
    mov     qword ptr [rsp+0D98h+buf+8], 0
    test    tmp, tmp
    jnz     loc_5C4755
    jmp     short loc_5C49EE
loc_5C49E3:
    xor     ebx, ebx
    test    tmp, tmp
    jnz     loc_5C4755
loc_5C49EE:
    xor     r12d, r12d
    xor     eax, eax
    mov     [rsp+0D98h+header_bag], rax
loc_5C49F8:
    mov     rbx, [rsp+0D98h+theurl]
    cmp     qword ptr [rbx+8], 0
    jz      loc_5C4BAC
    mov     [rsp+0D98h+var_D18], r12
    mov     rdi, [rsp+0D98h+bytes_max]; s
    call    _strlen
    lea     rdi, [rax+1]; size
    call    _emalloc
    mov     r12, rax
    mov     rdi, [rbx+8]
    mov     rsi, [rdi+10h]; len
    add     rdi, 18h; str
    call    php_url_decode
    mov     rsi, [rbx+8]
    add     rsi, 18h; src
    mov     rdi, scratch; dest
    call    _strcpy
    mov     rdi, scratch; s
    call    _strlen
    mov     word ptr [scratch+rax], 3Ah ; ':'
    mov     rdi, [rbx+10h]
    test    rdi, rdi
    jz      short loc_5C4A7C
    mov     rsi, [rdi+10h]; len
    add     rdi, 18h; str
    call    php_url_decode
    mov     rsi, [rbx+10h]
    add     rsi, 18h; src
    mov     rdi, scratch; dest
    call    _strcat
loc_5C4A7C:
    mov     rdi, scratch; s
    call    _strlen
    mov     rdi, scratch
    mov     rsi, rax
    call    j_resolve_base64_encode
    mov     rbx, rax
    mov     rbp, [rsp+0D98h+ptr]
    test    rbp, rbp
    jz      loc_5C6676
    mov     rax, [rbp+10h]
    lea     r14, [rax+15h]
    cmp     r14, [rsp+0D98h+ptr+8]
    jnb     loc_5C667C
loc_5C4AB3:
    movupd  xmm0, cs:xmmword_8B0C76
    movupd  xmmword ptr [rbp+rax+18h], xmm0
    mov     rcx, 206369736142203Ah
    mov     [rbp+rax+25h], rcx
    mov     [rbp+10h], r14
    mov     [rsp+0D98h+bytes_max], stmp
    lea     r13, [rbx+18h]
    mov     rdi, r13; s
    call    _strlen
    mov     r15, rax
    mov     rbx, rax
    test    rbp, rbp
    jz      loc_5C60E6
    mov     rbx, r15
    add     rbx, r14
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C60E6
loc_5C4B05:
    lea     rdi, [r14+rbp]
    add     rdi, 18h; dest
    mov     rsi, r13; src
    mov     rdx, r15; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    test    rax, rax
    jz      loc_5C6697
    lea     rbp, [rbx+2]
    cmp     rbp, [rsp+0D98h+ptr+8]
    mov     r13, [rsp+0D98h+src]
    mov     r15, [rsp+0D98h+opened_path]
    jnb     loc_5C66A6
loc_5C4B43:
    mov     word ptr [rax+rbx+18h], 0A0Dh
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbp
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C4B80
    cmp     qword ptr [r15], 0
    jz      short loc_5C4B80
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0; bytes_max
    mov     rdi, r15; context
    mov     esi, 3; notifycode
    xor     edx, edx; severity
    xor     ecx, ecx; xmsg
    xor     r8d, r8d; xcode
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C4B80:
    mov     rdi, [rsp+0D98h+bytes_max]; ptr
    mov     eax, [rdi+4]
    test    al, 40h
    jnz     short loc_5C4B9C
    test    al, al
    js      short loc_5C4B97
    call    _efree
    jmp     short loc_5C4B9C
loc_5C4B97:
    call    free
loc_5C4B9C:
    mov     rdi, scratch; ptr
    call    _efree
    mov     scratch, [rsp+0D98h+var_D18]
loc_5C4BAC:
    mov     r14, r13
    lea     rbp, file_globals
    test    r12b, 8
    jnz     loc_5C4C86
    cmp     qword ptr [rbp+28h], 0
    jz      loc_5C4C86
    mov     r13, r12
    mov     rax, [rsp+0D98h+ptr]
    test    rax, rax
    jz      loc_5C66C1
    mov     rcx, [rax+10h]
    lea     r12, [rcx+6]
    cmp     r12, [rsp+0D98h+ptr+8]
    jnb     loc_5C66C7
loc_5C4BEF:
    mov     word ptr [rax+rcx+1Ch], 203Ah
    mov     dword ptr [rax+rcx+18h], 6D6F7246h
    mov     rbx, [rsp+0D98h+ptr]
    mov     [rbx+10h], r12
    mov     r15, [rbp+28h]
    mov     rdi, r15; s
    call    _strlen
    mov     r14, rax
    mov     rbp, rax
    test    rbx, rbx
    jz      loc_5C6429
    mov     rbp, r14
    add     rbp, r12
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C6429
loc_5C4C33:
    lea     rdi, [rbx+r12]
    add     rdi, 18h; dest
    mov     rsi, r15; src
    mov     rdx, r14; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbp
    test    rax, rax
    jz      loc_5C66E2
    lea     rbx, [rbp+2]
    cmp     rbx, [rsp+0D98h+ptr+8]
    mov     r14, [rsp+0D98h+src]
    mov     r12, r13
    jnb     loc_5C66EF
loc_5C4C6F:
    mov     word ptr [rax+rbp+18h], 0A0Dh
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    lea     rbp, file_globals
loc_5C4C86:
    test    r12b, 2
    jnz     loc_5C4D4F
    mov     rax, [rsp+0D98h+ptr]
    mov     r13, r12
    test    rax, rax
    jz      loc_5C670A
    mov     rcx, [rax+10h]
    lea     r15, [rcx+6]
    cmp     r15, [rsp+0D98h+ptr+8]
    jnb     loc_5C6710
loc_5C4CB4:
    mov     word ptr [rax+rcx+1Ch], 203Ah
    mov     dword ptr [rax+rcx+18h], 74736F48h
    mov     r14, [rsp+0D98h+ptr]
    mov     [r14+10h], r15
    mov     rax, [rsp+0D98h+theurl]
    mov     rbp, [rax+18h]
    add     rbp, 18h
    mov     rdi, rbp; s
    call    _strlen
    mov     r12, rax
    mov     rbx, rax
    test    r14, r14
    jz      loc_5C6444
    mov     rbx, r12
    add     rbx, r15
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C6444
loc_5C4D01:
    lea     rdi, [r14+r15]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r12; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    mov     rbp, [rsp+0D98h+theurl]
    movzx   ecx, word ptr [rbp+20h]
    cmp     [rsp+0D98h+var_D34], 0
    jz      short loc_5C4DA4
    test    cx, cx
    mov     r14, [rsp+0D98h+src]
    mov     r12, r13
    jz      loc_5C4E84
    movzx   ecx, cx
    cmp     ecx, 1BBh
    jz      loc_5C4E84
    jmp     short loc_5C4DBF
loc_5C4D4F:
    test    r12b, 40h
    jnz     loc_5C4EC1
loc_5C4D59:
    mov     rax, [rsp+0D98h+ptr]
    test    rax, rax
    jz      loc_5C672B
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+13h]
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C6730
loc_5C4D7A:
    movupd  xmm0, cs:xmmword_8B0C9A
    movupd  xmmword ptr [rax+rcx+18h], xmm0
    mov     dword ptr [rax+rcx+27h], 0A0D6573h
    mov     [rax+10h], rbx
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      loc_5C4EF4
    jmp     loc_5C4EC8
loc_5C4DA4:
    test    cx, cx
    mov     r14, [rsp+0D98h+src]
    mov     r12, r13
    jz      loc_5C4E84
    cmp     cx, 50h ; 'P'
    jz      loc_5C4E84
loc_5C4DBF:
    test    rax, rax
    mov     [rsp+0D98h+var_D18], r12
    jz      loc_5C6867
    add     rbx, 1
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C686C
loc_5C4DDF:
    mov     byte ptr [rbx+rax+17h], 3Ah ; ':'
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    movzx   ecx, word ptr [rbp+20h]
    lea     rbp, [rsp+0D98h+var_819]
    mov     [rsp+0D98h+var_819], 0
    mov     rsi, 0CCCCCCCCCCCCCCCDh
    mov     rbx, rbp
    xchg    ax, ax
loc_5C4E10:
    mov     rax, rcx
    mul     rsi
    shr     rdx, 3
    lea     eax, [rdx+rdx]
    lea     eax, [rax+rax*4]
    mov     edi, ecx
    sub     edi, eax
    or      dil, 30h
    mov     [rbx-1], dil
    add     rbx, 0FFFFFFFFFFFFFFFFh
    cmp     rcx, 9
    mov     rcx, rdx
    ja      short loc_5C4E10
    sub     rbp, rbx
    mov     rax, [rsp+0D98h+ptr]
    mov     r15, rbp
    test    rax, rax
    jz      loc_5C67C3
    mov     rcx, [rax+10h]
    lea     r15, [rcx+rbp]
    cmp     r15, [rsp+0D98h+ptr+8]
    jnb     loc_5C67C3
loc_5C4E60:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbx; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], r15
    mov     r12, [rsp+0D98h+var_D18]
loc_5C4E84:
    test    rax, rax
    lea     rbp, file_globals
    jz      loc_5C674B
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+2]
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C6750
loc_5C4EA7:
    mov     word ptr [rax+rcx+18h], 0A0Dh
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    test    r12b, 40h
    jz      loc_5C4D59
loc_5C4EC1:
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C4EF4
loc_5C4EC8:
    lea     rsi, aHttp; "http"
    lea     rdx, aUserAgent_0; "user_agent"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    ua_zval, ua_zval
    jz      short loc_5C4EF4
    cmp     byte ptr [ua_zval+8], 6
    jnz     short loc_5C4EF4
    mov     rbp, [ua_zval]
    add     rbp, 18h
    jmp     short loc_5C4EF8
loc_5C4EF4:
    mov     rbp, [rbp+20h]
loc_5C4EF8:
    mov     r13, r14
    test    r12b, 1
    mov     r14d, [rsp+0D98h+var_D28]
    jnz     loc_5C4FC5
    test    ua_str, ua_str
    jz      loc_5C4FC5
    mov     rdi, ua_str; s
    call    _strlen
    lea     rbx, [rax+11h]
    cmp     ua_len, 12h
    jb      loc_5C4FC5
    mov     r13, r12
    add     rax, 12h
    mov     rdi, rax; size
    call    _emalloc
    mov     r12, rax
    lea     rdx, aUserAgentS; "User-Agent: %s\r\n"
    mov     rdi, rax; buf
    mov     rsi, ua_len; len
    mov     rcx, ua_str
    xor     eax, eax
    call    ap_php_slprintf
    test    eax, eax
    jz      short loc_5C4FA0
    movsxd  ua_str, eax
    mov     byte ptr [ua+ua_len], 0
    mov     rax, [rsp+0D98h+ptr]
    mov     r15, ua_len
    test    rax, rax
    jz      loc_5C6831
    mov     rcx, [rax+10h]
    lea     r15, [rcx+ua_len]
    cmp     r15, [rsp+0D98h+ptr+8]
    jnb     loc_5C6831
loc_5C4F82:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, ua; src
    mov     rdx, ua_len; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], r15
    jmp     short loc_5C4FB5
loc_5C4FA0:
    lea     rdx, aCannotConstruc; "Cannot construct User-agent header"
    xor     edi, edi; docref
    mov     esi, 2; type
    xor     eax, eax
    call    php_error_docref
loc_5C4FB5:
    mov     rdi, ua; ptr
    call    _efree
    mov     ua, r13
    mov     r13, [rsp+0D98h+src]
loc_5C4FC5:
    cmp     [rsp+0D98h+header_bag], 0
    jz      loc_5C51A0
    mov     eax, r12d
    and     eax, 10h
    shr     eax, 4
    mov     ecx, r14d
    xor     cl, 1
    or      cl, al
    jnz     loc_5C511D
    lea     rsi, aHttp; "http"
    lea     rdx, aContent; "content"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    rax, rax
    jz      loc_5C511D
    mov     rbx, rax
    cmp     byte ptr [rax+8], 6
    jnz     loc_5C511D
    mov     rax, [tmpzval]
    cmp     qword ptr [rax+10h], 0
    jz      loc_5C511D
    mov     rax, [rsp+0D98h+ptr]
    test    rax, rax
    jz      loc_5C6928
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+10h]
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C692D
loc_5C5045:
    movupd  xmm0, cs:xmmword_8B0CE2
    movupd  xmmword ptr [rax+rcx+18h], xmm0
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbp
    mov     rax, [tmpzval]
    mov     rcx, [rax+10h]
    lea     r15, [rsp+0D98h+var_819]
    mov     [rsp+0D98h+var_819], 0
    mov     rsi, 0CCCCCCCCCCCCCCCDh
    mov     tmpzval, r15
loc_5C5080:
    mov     rax, rcx
    mul     rsi
    shr     rdx, 3
    lea     eax, [rdx+rdx]
    lea     eax, [rax+rax*4]
    mov     edi, ecx
    sub     edi, eax
    or      dil, 30h
    mov     [rbx-1], dil
    add     rbx, 0FFFFFFFFFFFFFFFFh
    cmp     rcx, 9
    mov     rcx, rdx
    ja      short loc_5C5080
    sub     r15, rbx
    mov     rax, [rsp+0D98h+ptr]
    mov     rbp, r15
    test    rax, rax
    jz      loc_5C68B0
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+r15]
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C68B0
loc_5C50D0:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbx; src
    mov     rdx, r15; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbp
    test    rax, rax
    jz      loc_5C6948
    lea     rbx, [rbp+2]
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C694D
loc_5C5104:
    mov     word ptr [rax+rbp+18h], 0A0Dh
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    or      r12d, 10h
    mov     r14d, [rsp+0D98h+var_D28]
loc_5C511D:
    mov     rdi, [rsp+0D98h+header_bag]; s
    call    _strlen
    mov     rbp, rax
    mov     rax, [rsp+0D98h+ptr]
    mov     rbx, rbp
    test    rax, rax
    jz      loc_5C60CB
    mov     rcx, [rax+10h]
    mov     rbx, rbp
    add     rbx, rcx
    cmp     rbx, [rsp+0D98h+ptr+8]
    jnb     loc_5C60CB
loc_5C5150:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, [rsp+0D98h+header_bag]; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbx
    test    rax, rax
    jz      loc_5C663B
    lea     rbp, [rbx+2]
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C6640
loc_5C5186:
    mov     word ptr [rax+rbx+18h], 0A0Dh
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbp
    mov     rdi, [rsp+0D98h+header_bag]; ptr
    call    _efree
loc_5C51A0:
    mov     rbp, [rsp+0D98h+var_D08]
    test    r14b, r14b
    jz      loc_5C53DA
    lea     rsi, aHttp; "http"
    lea     rdx, aContent; "content"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    rax, rax
    jz      loc_5C53DA
    mov     rbx, rax
    cmp     byte ptr [rax+8], 6
    jnz     loc_5C53DA
    mov     rax, [tmpzval]
    cmp     qword ptr [rax+10h], 0
    jz      loc_5C53DA
    test    r12b, 10h
    jnz     loc_5C52F7
    mov     rax, [rsp+0D98h+ptr]
    test    rax, rax
    jz      loc_5C6968
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+10h]
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C696D
loc_5C5218:
    mov     r14, have_header
    movupd  xmm0, cs:xmmword_8B0CE2
    movupd  xmmword ptr [rax+rcx+18h], xmm0
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbp
    mov     rax, [tmpzval]
    mov     rcx, [rax+10h]
    lea     r15, [rsp+0D98h+var_819]
    mov     [rsp+0D98h+var_819], 0
    mov     rsi, 0CCCCCCCCCCCCCCCDh
    mov     rbp, r15
loc_5C5256:
    mov     rax, rcx
    mul     rsi
    shr     rdx, 3
    lea     eax, [rdx+rdx]
    lea     eax, [rax+rax*4]
    mov     edi, ecx
    sub     edi, eax
    or      dil, 30h
    mov     [rbp-1], dil
    add     rbp, 0FFFFFFFFFFFFFFFFh
    cmp     rcx, 9
    mov     rcx, rdx
    ja      short loc_5C5256
    sub     r15, rbp
    mov     rax, [rsp+0D98h+ptr]
    mov     have_header, r15
    test    rax, rax
    jz      loc_5C68CB
    mov     rcx, [rax+10h]
    lea     r12, [rcx+r15]
    cmp     r12, [rsp+0D98h+ptr+8]
    jnb     loc_5C68CB
loc_5C52A6:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r15; n
    call    _memcpy
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], r12
    test    rax, rax
    jz      loc_5C6988
    lea     rbp, [r12+2]
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C698D
loc_5C52DB:
    mov     word ptr [rax+r12+18h], 0A0Dh
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], rbp
    mov     rbp, [rsp+0D98h+var_D08]
    mov     r12, r14
loc_5C52F7:
    test    r12b, 20h
    jnz     short loc_5C5368
    mov     r14, rbp
    mov     rax, [rsp+0D98h+ptr]
    test    rax, rax
    jz      loc_5C69A8
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+31h]
    cmp     rbp, [rsp+0D98h+ptr+8]
    jnb     loc_5C69AD
loc_5C5321:
    movups  xmm0, cs:xmmword_8B0D13
    movups  xmmword ptr [rax+rcx+38h], xmm0
    movups  xmm0, cs:xmmword_8B0D03
    movups  xmmword ptr [rax+rcx+28h], xmm0
    movupd  xmm0, cs:xmmword_8B0CF3
    movupd  xmmword ptr [rax+rcx+18h], xmm0
    mov     byte ptr [rax+rcx+48h], 0Ah
    mov     [rax+10h], rbp
    lea     rdx, aContentTypeNot; "Content-type not specified assuming app"...
    xor     edi, edi; docref
    mov     esi, 8; type
    xor     eax, eax
    call    php_error_docref
    mov     rbp, r14
loc_5C5368:
    mov     rax, [rsp+0D98h+ptr]
    mov     r14, rbp
    test    rax, rax
    jz      loc_5C68E6
    mov     rcx, [rax+10h]
    lea     r15, [rcx+2]
    cmp     r15, [rsp+0D98h+ptr+8]
    jnb     loc_5C68EC
loc_5C538C:
    mov     word ptr [rax+rcx+18h], 0A0Dh
    mov     rax, [rsp+0D98h+ptr]
    mov     [rax+10h], r15
    mov     rbp, [tmpzval]
    mov     tmpzval, [rbp+10h]
    add     rbp, 18h
    mov     r12, rbx
    test    rax, rax
    jz      loc_5C684C
    lea     r12, [rbx+r15]
    cmp     r12, [rsp+0D98h+ptr+8]
    jnb     loc_5C684C
loc_5C53C2:
    lea     rdi, [rax+r15]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, rbx; n
    call    _memcpy
    mov     rbp, r14
    jmp     short loc_5C5402
loc_5C53DA:
    mov     rax, [rsp+0D98h+ptr]
    test    rax, rax
    jz      loc_5C6494
    mov     rcx, [rax+10h]
    lea     have_header, [rcx+2]
    cmp     r12, [rsp+0D98h+ptr+8]
    jnb     loc_5C649A
loc_5C53FB:
    mov     word ptr [rax+rcx+18h], 0A0Dh
loc_5C5402:
    mov     rsi, [rsp+0D98h+ptr]
    mov     [rsi+10h], r12
    add     rsi, 18h; buf
    mov     rbx, [rsp+0D98h+var_D00]
    mov     rdi, rbx; stream
    mov     rdx, r12; count
    call    _php_stream_write
    mov     [rsp+0D98h+buf], 0
    mov     rax, [rsp+0D98h+arg_8]
    cmp     byte ptr [rax+8], 0
    jnz     short loc_5C544F
    call    _zend_new_array_0
    mov     rcx, [rsp+0D98h+arg_8]
    mov     [rcx], __arr
    mov     dword ptr [rcx+8], 307h
loc_5C544F:
    and     [rsp+0D98h+var_CEC], 0Ch
    mov     rdi, rbx; stream
    call    _php_stream_eof
    test    eax, eax
    jz      loc_5C55CE
loc_5C5467:
    mov     rdi, rbx; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdx, aHttpRequestFai; "HTTP request failed!"
    xor     r15d, r15d
    mov     rdi, rbp; wrapper
    mov     esi, [rsp+0D98h+var_D5C]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    xor     r14d, r14d
    xor     r12d, r12d
loc_5C5492:
    xor     ebx, ebx
loc_5C5494:
    mov     rbp, [rsp+0D98h+var_CF8]
    mov     rdi, [rsp+0D98h+ptr]; ptr
    test    rdi, rdi
    jz      short loc_5C54C0
    mov     eax, [rdi+4]
    test    al, 40h
    jnz     short loc_5C54B7
    add     dword ptr [rdi], 0FFFFFFFFh
    jnz     short loc_5C54B7
    call    _efree
loc_5C54B7:
    mov     [rsp+0D98h+ptr], 0
loc_5C54C0:
    mov     [rsp+0D98h+ptr+8], 0
    test    http_header_line, http_header_line
    jz      short loc_5C54D6
    mov     rdi, http_header_line; ptr
    call    _efree
loc_5C54D6:
    mov     rdi, [rsp+0D98h+theurl]; theurl
    test    rdi, rdi
    jz      short loc_5C54E5
    call    php_url_free
loc_5C54E5:
    test    stream, stream
    jz      loc_5C55B7
    mov     eax, [rsp+0D98h+redirect_max_0]
    test    al, 1
    jz      short loc_5C551C
    mov     rax, [rsp+0D98h+arg_8]
    mov     rcx, rax
    mov     rax, [rax]
    mov     ecx, [_z2+8]
    mov     [stream+50h], _gc
    mov     [stream+58h], ecx
    test    ecx, 0FF00h
    jz      short loc_5C551C
    add     dword ptr [_gc], 1
loc_5C551C:
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C5566
    mov     rax, [rsp+0D98h+opened_path]
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_5C5566
    mov     qword ptr [rax+28h], 0
    mov     [rax+30h], file_size
    or      byte ptr [rax+20h], 1
    mov     [rsp+0D98h+error_string], file_size; bytes_max
    mov     [rsp+0D98h+error_string+8], 0; ptr
    mov     rdi, [rsp+0D98h+opened_path]; context
    mov     esi, 7; notifycode
    xor     edx, edx; severity
    xor     ecx, ecx; xmsg
    xor     r8d, r8d; xcode
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C5566:
    test    byte ptr [rsp+0D98h+var_D5C], 20h
    jz      short loc_5C557E
    mov     rdi, stream; stream
    mov     esi, 5; option
    mov     edx, ebp; value
    xor     ecx, ecx; ptrparam
    call    _php_stream_set_option
loc_5C557E:
    mov     eax, [rsp+0D98h+var_CEC]
    or      [stream+74h], eax
    mov     qword ptr [stream+98h], 0
    lea     rdi, [stream+61h]; dst
    mov     edx, 10h; siz
    mov     rsi, r13; src
    call    php_strlcpy
    test    transfer_encoding, transfer_encoding
    jz      short loc_5C55B9
    lea     rdi, [stream+10h]; chain
    mov     rsi, transfer_encoding; filter
    call    _php_stream_filter_append
    jmp     short loc_5C55B9
loc_5C55B7:
    xor     ebx, ebx
loc_5C55B9:
    mov     rax, rbx
    add     rsp, 0D68h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_5C55CE:
    lea     rsi, [rsp+0D98h+s1]; buf
    lea     rcx, [rsp+0D98h+returned_len]; returned_len
    mov     edx, 7Fh; maxlen
    mov     rdi, rbx; stream
    call    _php_stream_get_line
    test    rax, rax
    jz      loc_5C5467
    xor     r15d, r15d
    cmp     [rsp+0D98h+returned_len], 0Ah
    jb      short loc_5C5612
    lea     rdi, [rsp+0D98h+nptr]; nptr
    call    _atoi
    mov     r15d, eax
loc_5C5612:
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C5645
    lea     rsi, aHttp; "http"
    lea     rdx, aIgnoreErrors; "ignore_errors"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C5645
    mov     rdi, tmpzval; op
    call    zend_is_true
    test    eax, eax
    setnz   al
    jmp     short loc_5C5647
loc_5C5645:
    xor     eax, eax
loc_5C5647:
    mov     [rsp+0D98h+var_D28], eax
    movzx   ecx, al
    mov     eax, [rsp+0D98h+var_D5C]
    shr     eax, 9
    and     eax, 1
    mov     dword ptr [rsp+0D98h+var_D18], eax
    or      ecx, eax
    mov     dword ptr [rsp+0D98h+header_bag], ecx
    cmp     r15d, 65h ; 'e'
    jz      short loc_5C56A9
    lea     eax, [response_code-64h]
    cmp     eax, 63h ; 'c'
    ja      short loc_5C56A9
    mov     rdi, rbx; stream
    call    _php_stream_eof
    test    eax, eax
    jz      loc_5C579E
loc_5C5684:
    mov     rbp, [rsp+0D98h+returned_len]
loc_5C568C:
    xor     r15d, r15d
    cmp     tmp_line_len, 0Ah
    jb      loc_5C581A
    lea     rdi, [rsp+0D98h+nptr]; nptr
    call    _atoi
    mov     r15d, eax
loc_5C56A9:
    lea     eax, [response_code-0C8h]
    cmp     eax, 0C8h
    jnb     short loc_5C56C4
    mov     dword ptr [rsp+0D98h+header_bag], 1
    jmp     loc_5C585F
loc_5C56C4:
    cmp     r15d, 193h
    jnz     loc_5C5812
    mov     r15d, 193h
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      loc_5C585F
    mov     rdi, [rsp+0D98h+opened_path]
    cmp     qword ptr [rdi], 0
    jz      loc_5C585F
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0
    lea     rcx, [rsp+0D98h+s1]
    mov     r15d, 193h
    mov     esi, 0Ah
    mov     edx, 2
    mov     r8d, 193h
    jmp     loc_5C5857
loc_5C571D:
    mov     word ptr [resource+20h], 1BBh
    mov     bl, 1
    mov     [rsp+0D98h+var_D34], 1
    jmp     loc_5C38CF
loc_5C5733:
    xor     r12d, r12d
    xor     eax, eax
    mov     [rsp+0D98h+header_bag], rax
    jmp     loc_5C6066
loc_5C5742:
    cmp     rbp, 4
    jz      loc_5C5EBA
    cmp     rbp, 3
    jnz     loc_5C42B0
    movzx   eax, word ptr [r12+18h]
    xor     eax, 4547h
    movzx   ecx, byte ptr [r12+1Ah]
    xor     ecx, 54h
    or      cx, ax
    jnz     loc_5C42B0
    jmp     loc_5C423B
loc_5C5778:
    add     s, 0FFFFFFFFFFFFFFFFh
    cmp     s, t
    jbe     short loc_5C578D
loc_5C5781:
    movzx   eax, byte ptr [s-1]
    cmp     al, 0Dh
    jz      short loc_5C5778
    cmp     al, 0Ah
    jz      short loc_5C5778
loc_5C578D:
    sub     s, t
    mov     rax, [rsp+0D98h+header_bag]
    mov     byte ptr [rax+rbp], 0
    jmp     loc_5C6059
loc_5C579E:
    lea     r12, [rsp+0D98h+s1]
    lea     r14, [rsp+0D98h+returned_len]
    lea     response_code, aHttp1; "HTTP/1"
    jmp     short loc_5C57CF
loc_5C57B7:
    mov     rbx, [rsp+0D98h+var_D00]
    mov     rdi, rbx; stream
    call    _php_stream_eof
    test    eax, eax
    jnz     loc_5C5684
loc_5C57CF:
    mov     edx, 7Fh; maxlen
    mov     rdi, rbx; stream
    mov     rsi, r12; buf
    mov     rcx, r14; returned_len
    call    _php_stream_get_line
    test    rax, rax
    jz      loc_5C5684
    mov     rbp, [rsp+0D98h+returned_len]
    cmp     tmp_line_len, 6
    jb      short loc_5C57B7
    mov     edx, 6; n
    mov     rdi, r12; s1
    mov     rsi, r15; s2
    call    _strncasecmp
    test    eax, eax
    jnz     short loc_5C57B7
    jmp     loc_5C568C
loc_5C5812:
    mov     rbp, [rsp+0D98h+returned_len]
loc_5C581A:
    test    tmp_line_len, tmp_line_len
    jnz     short loc_5C5827
    mov     [rsp+0D98h+s1], 0
loc_5C5827:
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C585F
    mov     rdi, [rsp+0D98h+opened_path]; context
    cmp     qword ptr [rdi], 0
    jz      short loc_5C585F
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0; bytes_max
    lea     rcx, [rsp+0D98h+s1]; xmsg
    mov     esi, 9; notifycode
    mov     edx, 2; severity
    mov     r8d, r15d; xcode
loc_5C5857:
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C585F:
    mov     rbp, [rsp+0D98h+returned_len]
    cmp     byte ptr [rsp+tmp_line_len+0D98h+optionvalue.u2+3], 0Ah
    jnz     short loc_5C588D
    lea     rax, [tmp_line_len-2]
    cmp     byte ptr [rsp+tmp_line_len+0D98h+optionvalue.u2+2], 0Dh
    lea     tmp_line_len, [tmp_line_len-1]
    cmovz   rbp, rax
    mov     [rsp+0D98h+returned_len], rbp
loc_5C588D:
    lea     rdi, [tmp_line_len+20h]
    and     rdi, 0FFFFFFFFFFFFFFF8h; size
    call    _emalloc
    mov     rbx, rax
    mov     rax, 1600000001h
    mov     [__s], rax
    mov     qword ptr [__s+8], 0
    mov     [__s+10h], tmp_line_len
    lea     rdi, [__s+18h]; dest
    lea     rsi, [rsp+0D98h+s1]; src
    mov     rdx, tmp_line_len; n
    call    _memcpy
    mov     byte ptr [__s+tmp_line_len+18h], 0
    mov     [rsp+0D98h+str.s], __s
    mov     dword ptr [rsp+0D98h+str.a], 106h
    mov     rax, [rsp+0D98h+arg_8]
    mov     rdi, [rax]; ht
    lea     rsi, [rsp+0D98h+str]; pData
    call    zend_hash_next_index_insert
    mov     __s, [rsp+0D98h+var_D00]
    mov     rdi, rbx; stream
    call    _php_stream_eof
    test    eax, eax
    jz      short loc_5C592B
    mov     r14b, 1
    xor     r15d, r15d
    xor     eax, eax
    mov     [rsp+0D98h+bytes_max], rax
    xor     r12d, r12d
    mov     tmp_line_len, [rsp+0D98h+var_D08]
    jmp     loc_5C5CBE
loc_5C592B:
    mov     eax, [rsp+0D98h+var_D5C]
    and     eax, 200h
    mov     [rsp+0D98h+var_CDC], eax
    mov     eax, r15d
    and     eax, 0FFFFFFFCh
    cmp     eax, 12Ch
    setz    al
    add     r15d, 0FFFFFECDh
    cmp     r15d, 2
    setb    cl
    or      cl, al
    mov     [rsp+0D98h+var_D22], cl
    mov     r14b, 1
    xor     r12d, r12d
    xor     eax, eax
    mov     [rsp+0D98h+bytes_max], rax
    xor     r13d, r13d
    mov     tmp_line_len, [rsp+0D98h+var_D08]
loc_5C5975:
    test    http_header_line, http_header_line
    jz      short loc_5C5982
    mov     rdi, http_header_line; ptr
    call    _efree
loc_5C5982:
    mov     rdi, rbx; stream
    xor     esi, esi; buf
    xor     edx, edx; maxlen
    lea     rcx, [rsp+0D98h+returned_len]; returned_len
    call    _php_stream_get_line
    mov     http_header_line, rax
    test    rax, rax
    jz      loc_5C5CBB
    mov     al, [http_header_line]
    cmp     al, 0Ah
    jz      loc_5C5CBB
    cmp     al, 0Dh
    jz      loc_5C5CBB
    mov     rax, [rsp+0D98h+returned_len]
    lea     rbx, [http_header_line+http_header_line_length]
    add     rbx, 0FFFFFFFFFFFFFFFFh
    cmp     e, http_header_line
    jnb     short loc_5C59D9
    jmp     short loc_5C59F4
loc_5C59D0:
    add     e, 0FFFFFFFFFFFFFFFFh
    cmp     e, http_header_line
    jb      short loc_5C59F4
loc_5C59D9:
    movzx   eax, byte ptr [e]
    cmp     al, 0Dh
    jz      short loc_5C59D0
    cmp     al, 0Ah
    jz      short loc_5C59D0
    jmp     short loc_5C59F4
loc_5C59F0:
    add     e, 0FFFFFFFFFFFFFFFFh
loc_5C59F4:
    cmp     e, http_header_line
    jb      short loc_5C5A04
    movzx   eax, byte ptr [e]
    cmp     al, 20h ; ' '
    jz      short loc_5C59F0
    cmp     al, 9
    jz      short loc_5C59F0
loc_5C5A04:
    lea     rbp, [e+1]
    mov     byte ptr [rbx+1], 0
    mov     rdx, e
    sub     rdx, http_header_line; n
    mov     [rsp+0D98h+returned_len], http_header_line_length
    mov     rdi, http_header_line; s
    mov     esi, 3Ah ; ':'; c
    call    _memchr
    test    http_header_value, http_header_value
    jz      short loc_5C5A5E
    cmp     http_header_value, rbx
    jb      short loc_5C5A49
    jmp     short loc_5C5A57
loc_5C5A40:
    add     rax, 1
    cmp     rbx, rax
    jz      short loc_5C5A57
loc_5C5A49:
    movzx   ecx, byte ptr [http_header_value+1]
    cmp     cl, 20h ; ' '
    jz      short loc_5C5A40
    cmp     cl, 9
    jz      short loc_5C5A40
loc_5C5A57:
    add     rax, 1
    mov     e, rax
loc_5C5A5E:
    mov     edx, 9; n
    mov     rdi, http_header_line; s1
    lea     rsi, aLocation; "Location:"
    call    _strncasecmp
    test    eax, eax
    jz      loc_5C5B57
    mov     edx, 0Dh; n
    mov     rdi, http_header_line; s1
    lea     rsi, aContentType_1; "Content-Type:"
    call    _strncasecmp
    test    eax, eax
    mov     rbx, [rsp+0D98h+var_D00]
    jz      loc_5C5BB4
    mov     edx, 0Fh; n
    mov     rdi, http_header_line; s1
    lea     rsi, aContentLength_0; "Content-Length:"
    call    _strncasecmp
    test    eax, eax
    jz      loc_5C5BDB
    mov     edx, 12h; n
    mov     rdi, http_header_line; s1
    lea     rsi, aTransferEncodi; "Transfer-Encoding:"
    call    _strncasecmp
    test    eax, eax
    jnz     loc_5C5C23
    mov     edx, 7; n
    mov     rdi, http_header_value; s1
    lea     rsi, aChunked; "Chunked"
    call    _strncasecmp
    or      eax, [rsp+0D98h+var_CDC]
    jnz     loc_5C5C23
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C5B2B
    mov     rdi, [rsp+0D98h+opened_path]; context
    lea     rsi, aHttp; "http"
    lea     rdx, aAutoDecode; "auto_decode"
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C5B2B
    mov     rdi, tmpzval; op
    call    zend_is_true
    test    eax, eax
    jz      loc_5C5C23
loc_5C5B2B:
    movzx   edx, byte ptr [rbx+60h]
    and     edx, 1; persistent
    lea     rdi, aDechunk; "dechunk"
    xor     esi, esi; filterparams
    call    php_stream_filter_create
    mov     r15, rax
    mov     r13d, 0
    test    rax, rax
    jnz     loc_5C5C9E
    jmp     loc_5C5C23
loc_5C5B57:
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C5B8B
    mov     rdi, [rsp+0D98h+opened_path]; context
    lea     rsi, aHttp; "http"
    lea     rdx, aFollowLocation; "follow_location"
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C5B8B
    mov     rdi, tmpzval; op
    call    zend_is_true
    test    eax, eax
    setnz   r14b
    jmp     short loc_5C5B9D
loc_5C5B8B:
    movzx   r14d, r14b
    cmp     [rsp+0D98h+var_D22], 0
    mov     eax, 0
    cmovz   r14d, eax
loc_5C5B9D:
    mov     edx, 400h; siz
    lea     rdi, [rsp+0D98h+buf]; dst
    mov     rsi, http_header_value; src
    call    php_strlcpy
    jmp     short loc_5C5C23
loc_5C5BB4:
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C5C23
    mov     rdi, [rsp+0D98h+opened_path]
    cmp     qword ptr [rdi], 0
    jz      short loc_5C5C23
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0
    mov     esi, 4
    xor     edx, edx
    mov     rcx, http_header_value
    jmp     short loc_5C5C18
loc_5C5BDB:
    mov     rdi, http_header_value; nptr
    call    _atoi
    cdqe
    mov     [rsp+0D98h+bytes_max], rax
    cmp     byte ptr [rsp+0D98h+var_D30], 0
    jz      short loc_5C5C23
    mov     rdi, [rsp+0D98h+opened_path]; context
    cmp     qword ptr [rdi], 0
    jz      short loc_5C5C23
    mov     rax, [rsp+0D98h+bytes_max]
    mov     [rsp+0D98h+error_string], rax; bytes_max
    mov     [rsp+0D98h+error_string+8], 0; ptr
    mov     esi, 5; notifycode
    xor     edx, edx; severity
    mov     rcx, http_header_line; xmsg
loc_5C5C18:
    xor     r8d, r8d; xcode
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C5C23:
    mov     http_header_value, [rsp+0D98h+returned_len]
    lea     rdi, [http_header_line_length+20h]
    and     rdi, 0FFFFFFFFFFFFFFF8h; size
    call    _emalloc
    mov     rbx, rax
    mov     rax, 1600000001h
    mov     [__s], rax
    mov     qword ptr [__s+8], 0
    mov     [__s+10h], http_header_line_length
    lea     rdi, [__s+18h]; dest
    mov     rsi, http_header_line; src
    mov     rdx, http_header_line_length; n
    call    _memcpy
    mov     byte ptr [__s+http_header_line_length+18h], 0
    mov     [rsp+0D98h+str.s], __s
    mov     __s, [rsp+0D98h+var_D00]
    mov     dword ptr [rsp+0D98h+str.a], 106h
    mov     rax, [rsp+0D98h+arg_8]
    mov     rdi, [rax]; ht
    lea     rsi, [rsp+0D98h+str]; pData
    call    zend_hash_next_index_insert
    mov     r15, transfer_encoding
loc_5C5C9E:
    mov     rdi, rbx; stream
    call    _php_stream_eof
    mov     r13, transfer_encoding
    test    eax, eax
    mov     rbp, [rsp+0D98h+var_D08]
    jz      loc_5C5975
    jmp     short loc_5C5CBE
loc_5C5CBB:
    mov     r15, transfer_encoding
loc_5C5CBE:
    cmp     dword ptr [rsp+0D98h+header_bag], 0
    mov     eax, [rsp+0D98h+var_D28]
    jz      short loc_5C5CEC
    test    r14b, 1
    mov     r13, [rsp+0D98h+src]
    jz      loc_5C6417
    cmp     [rsp+0D98h+buf], 0
    mov     follow_location, [rsp+0D98h+bytes_max]
    jnz     short loc_5C5D00
    jmp     loc_5C5494
loc_5C5CEC:
    test    r14b, 1
    mov     r13, [rsp+0D98h+src]
    mov     follow_location, [rsp+0D98h+bytes_max]
    jz      loc_5C5494
loc_5C5D00:
    test    al, al
    setnz   al
    cmp     dword ptr [rsp+0D98h+var_D10], 1
    jg      short loc_5C5D1E
    mov     ecx, dword ptr [rsp+0D98h+var_D18]
    or      cl, al
    jnz     loc_5C5494
loc_5C5D1E:
    cmp     [rsp+0D98h+buf], 0
    setz    al
    or      [rsp+0D98h+var_D21], al
    jnz     short loc_5C5D62
    mov     rax, [rsp+0D98h+opened_path]
    cmp     qword ptr [rax], 0
    jz      short loc_5C5D62
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0; bytes_max
    lea     rcx, [rsp+0D98h+buf]; xmsg
    mov     rdi, [rsp+0D98h+opened_path]; context
    mov     esi, 6; notifycode
    xor     edx, edx; severity
    xor     r8d, r8d; xcode
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C5D62:
    mov     rdi, rbx; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    transfer_encoding, transfer_encoding
    jz      short loc_5C5D7C
    mov     rdi, transfer_encoding; filter
    call    php_stream_filter_free
loc_5C5D7C:
    mov     bl, [rsp+0D98h+buf]
    test    bl, bl
    jz      short loc_5C5DEC
    mov     byte ptr [rsp+0D98h+str.s], 0
    lea     rdi, [rsp+0D98h+buf]; s
    call    _strlen
    cmp     rax, 8
    jnb     short loc_5C5E11
loc_5C5DA2:
    cmp     bl, 2Fh ; '/'
    mov     r15d, [rsp+0D98h+var_D5C]
    mov     r14, [rsp+0D98h+var_D10]
    jnz     loc_5C5ECE
    lea     rdi, [rsp+0D98h+returned_len]; dst
    lea     rsi, [rsp+0D98h+buf]; src
    mov     edx, 400h; siz
    call    php_strlcpy
    jmp     loc_5C61A6
loc_5C5DD7:
    xor     ebx, ebx
    mov     r13, [rsp+0D98h+src]
    test    tmp, tmp
    jnz     loc_5C4755
    jmp     loc_5C49EE
loc_5C5DEC:
    lea     rdx, aHttpRequestFai_0; "HTTP request failed! %s"
    xor     r15d, r15d
    lea     rcx, [rsp+0D98h+s1]
    mov     rdi, rbp; wrapper
    mov     esi, [rsp+0D98h+var_D5C]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    jmp     loc_5C5492
loc_5C5E11:
    lea     rsi, aHttp_0; "http://"
    lea     rdi, [rsp+0D98h+buf]; s1
    mov     edx, 7; n
    call    _strncasecmp
    test    eax, eax
    jz      short loc_5C5E89
    lea     rsi, aHttps_0; "https://"
    lea     rdi, [rsp+0D98h+buf]; s1
    mov     edx, 8; n
    call    _strncasecmp
    test    eax, eax
    jz      short loc_5C5E89
    lea     rsi, aFtp_0; "ftp://"
    lea     rdi, [rsp+0D98h+buf]; s1
    mov     edx, 6; n
    call    _strncasecmp
    test    eax, eax
    jz      short loc_5C5E89
    lea     rsi, aFtps; "ftps://"
    lea     rdi, [rsp+0D98h+buf]; s1
    mov     edx, 7; n
    call    _strncasecmp
    test    eax, eax
    jnz     loc_5C5DA2
loc_5C5E89:
    lea     rdi, [rsp+0D98h+str]; dst
    lea     rsi, [rsp+0D98h+buf]; src
    mov     edx, 400h; siz
    call    php_strlcpy
    mov     r15d, [rsp+0D98h+var_D5C]
    mov     rbx, [rsp+0D98h+theurl]
    mov     r14, [rsp+0D98h+var_D10]
    jmp     loc_5C623B
loc_5C5EBA:
    cmp     dword ptr [r12+18h], 44414548h
    jnz     loc_5C42B0
    jmp     loc_5C423B
loc_5C5ECE:
    mov     rbx, rbp
    cmp     [rsp+0D98h+buf+1], 0
    jz      short loc_5C5F4A
    mov     rax, [rsp+0D98h+theurl]
    mov     rbp, [rax+28h]
    test    rbp, rbp
    jz      short loc_5C5F4A
    lea     r14, [rbp+18h]
    mov     rdi, s; s
    mov     esi, 2Fh ; '/'; c
    call    _strrchr
    test    s, s
    jnz     loc_5C614D
    cmp     qword ptr [rbp+10h], 0
    jz      loc_5C6101
    mov     byte ptr [r14], 2Fh ; '/'
    mov     s, r14
    jmp     loc_5C614D
loc_5C5F1A:
    sub     s, t
    mov     rcx, [rsp+0D98h+header_bag]
    add     rbp, rcx
    mov     have_header, p
    sub     r12, t
    add     r12, rcx
    mov     rdi, p; s
    call    _strlen
    lea     rdx, [rax+1]; n
    mov     rdi, rbp; dest
    mov     rsi, r12; src
    call    _memmove
    jmp     loc_5C6056
loc_5C5F4A:
    lea     rdx, aGlobS+6; format
    lea     rdi, [rsp+0D98h+returned_len]; buf
    lea     rcx, [rsp+0D98h+buf]
    mov     esi, 3FFh; len
    xor     eax, eax
    call    ap_php_snprintf
    mov     rbp, rbx
    jmp     loc_5C61A6
loc_5C5F75:
    mov     eax, 2401h
    mov     _z, r14
    jmp     short loc_5C5F83
loc_5C5F7F:
    add     p, 1
loc_5C5F83:
    movzx   ecx, byte ptr [p]
    cmp     rcx, 0Dh
    ja      short loc_5C5F7F
    bt      rax, rcx
    jnb     short loc_5C5F7F
    sub     p, s
    mov     rax, [rsp+0D98h+str.s]
    mov     r12, rbx
    test    rax, rax
    jz      loc_5C69C8
    mov     rcx, [rax+10h]
    lea     r12, [rcx+rbx]
    cmp     r12, [rsp+0D98h+str.a]
    jnb     loc_5C69C8
loc_5C5FBF:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, s; src
    mov     rdx, rbx; n
    call    _memcpy
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], r12
    test    rax, rax
    jz      loc_5C69E9
    lea     rbx, [r12+2]
    cmp     rbx, [rsp+0D98h+str.a]
    jnb     loc_5C69EE
loc_5C5FFA:
    mov     word ptr [rax+r12+18h], 0A0Dh
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    test    rax, rax
    jnz     loc_5C3FA6
loc_5C6017:
    mov     ebx, 2
    mov     r14, [rsp+0D98h+var_D08]
loc_5C6024:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C3FC4
loc_5C6045:
    mov     rdi, [rsp+0D98h+header_bag]; ptr
    call    _efree
    xor     eax, eax
    mov     [rsp+0D98h+header_bag], rax
loc_5C6056:
    mov     r12, rbx
loc_5C6059:
    mov     rbx, tmp
    test    tmp, tmp
    mov     r13, [rsp+0D98h+src]
    jz      short loc_5C607A
loc_5C6066:
    mov     eax, [rbx+4]
    test    al, 40h
    jnz     short loc_5C607A
    add     dword ptr [rbx], 0FFFFFFFFh
    jnz     short loc_5C607A
    mov     rdi, rbx; ptr
    call    _efree
loc_5C607A:
    test    r12b, 4
    jz      loc_5C49F8
    jmp     loc_5C4BAC
loc_5C6089:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     r14, [rsp+0D98h+str.s]
    mov     r12, [r14+10h]
    jmp     loc_5C3C6E
loc_5C60AA:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C3D46
loc_5C60CB:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C5150
loc_5C60E6:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rbp, [rsp+0D98h+ptr]
    mov     r14, [rbp+10h]
    jmp     loc_5C4B05
loc_5C6101:
    mov     eax, [rbp+4]
    test    al, 40h
    jnz     short loc_5C6116
    add     dword ptr [rbp+0], 0FFFFFFFFh
    jnz     short loc_5C6116
    mov     rdi, rbp; ptr
    call    _efree
loc_5C6116:
    call    _emalloc_32
    mov     rcx, 1600000001h
    mov     [rax], rcx
    movapd  xmm0, cs:xmmword_7C96C0
    movupd  xmmword ptr [rax+8], xmm0
    mov     word ptr [rax+18h], 2Fh ; '/'
    mov     rcx, [rsp+0D98h+theurl]
    mov     [rcx+28h], rax
    add     rax, 18h
    mov     r15d, [rsp+0D98h+var_D5C]
loc_5C614D:
    mov     byte ptr [s+1], 0
    mov     s, [rsp+0D98h+theurl]
    mov     rcx, [rax+28h]
    test    rcx, rcx
    jz      short loc_5C616F
    cmp     byte ptr [rcx+18h], 2Fh ; '/'
    jnz     short loc_5C616F
    cmp     byte ptr [rcx+19h], 0
    jz      loc_5C645F
loc_5C616F:
    add     rcx, 18h
    lea     rdx, aSS_4; "%s/%s"
loc_5C617A:
    lea     rdi, [rsp+0D98h+returned_len]; buf
    lea     r8, [rsp+0D98h+buf]
    mov     esi, 3FFh; len
    xor     eax, eax
    call    ap_php_snprintf
    mov     r13, [rsp+0D98h+src]
    mov     rbp, rbx
    mov     r14, [rsp+0D98h+var_D10]
loc_5C61A6:
    mov     rax, [rsp+0D98h+theurl]
    movzx   r9d, word ptr [rax+20h]
    cmp     [rsp+0D98h+var_D34], 0
    jz      short loc_5C61F9
    cmp     r9d, 1BBh
    jnz     short loc_5C6200
loc_5C61C0:
    mov     rbx, [rsp+0D98h+theurl]
    mov     rcx, [rbx]
    mov     r8, [rbx+18h]
    add     rcx, 18h
    add     r8, 18h
    lea     rdx, aSSS_1; "%s://%s%s"
    lea     rdi, [rsp+0D98h+str]; buf
    lea     r9, [rsp+0D98h+returned_len]
    mov     esi, 3FFh; len
    xor     eax, eax
    call    ap_php_snprintf
    jmp     short loc_5C623B
loc_5C61F9:
    cmp     r9w, 50h ; 'P'
    jz      short loc_5C61C0
loc_5C6200:
    mov     rbx, [rsp+0D98h+theurl]
    mov     rcx, [rbx]
    mov     r8, [rbx+18h]
    add     rcx, 18h
    add     r8, 18h
    lea     rax, [rsp+0D98h+returned_len]
    mov     [rsp+0D98h+error_string], rax
    lea     rdx, aSSDS; "%s://%s:%d%s"
    lea     rdi, [rsp+0D98h+str]; buf
    mov     esi, 3FFh; len
    xor     eax, eax
    call    ap_php_snprintf
loc_5C623B:
    mov     rdi, rbx; theurl
    call    php_url_free
    lea     rdi, [rsp+0D98h+str]; str
    call    php_url_parse
    mov     [rsp+0D98h+theurl], resource
    test    rax, rax
    jz      loc_5C63DC
    mov     r15, rbp
    lea     rsi, aHttp_0; "http://"
    lea     rdi, [rsp+0D98h+str]; s1
    mov     edx, 7; n
    call    _strncasecmp
    test    eax, eax
    jnz     short loc_5C629F
    lea     rsi, aHttps_0; "https://"
    lea     rdi, [rsp+0D98h+str]; s1
    mov     edx, 8; n
    call    _strncasecmp
    test    eax, eax
    jz      loc_5C63A0
loc_5C629F:
    mov     rax, [rsp+0D98h+theurl]
    mov     rdi, [rax+8]
    test    rdi, rdi
    jz      short loc_5C62F6
    mov     rsi, [rdi+10h]; len
    add     rdi, 18h; str
    call    php_url_decode
    mov     rcx, [rsp+0D98h+theurl]
    mov     rbx, [rcx+8]
    mov     [rbx+10h], rax
    test    rax, rax
    jle     short loc_5C62F6
    lea     rbp, [rbx+rax]
    add     rbp, 18h
    add     rbx, 18h
    call    ___ctype_b_loc
    mov     rax, [rax]
loc_5C62E0:
    movzx   ecx, byte ptr [s]
    test    byte ptr [rax+rcx*2], 2
    jnz     loc_5C63F5
    add     rbx, 1
    cmp     s, e
    jb      short loc_5C62E0
loc_5C62F6:
    mov     rax, [rsp+0D98h+theurl]
    mov     rdi, [rax+10h]
    test    rdi, rdi
    jz      short loc_5C634D
    mov     rsi, [rdi+10h]; len
    add     rdi, 18h; str
    call    php_url_decode
    mov     rcx, [rsp+0D98h+theurl]
    mov     rbx, [rcx+10h]
    mov     [rbx+10h], rax
    test    rax, rax
    jle     short loc_5C634D
    lea     rbp, [rbx+rax]
    add     rbp, 18h
    add     rbx, 18h
    call    ___ctype_b_loc
    mov     rax, [rax]
loc_5C6337:
    movzx   ecx, byte ptr [s]
    test    byte ptr [rax+rcx*2], 2
    jnz     loc_5C63F5
    add     rbx, 1
    cmp     s, e
    jb      short loc_5C6337
loc_5C634D:
    mov     rax, [rsp+0D98h+theurl]
    mov     rdi, [rax+28h]
    test    rdi, rdi
    jz      short loc_5C63A0
    mov     rsi, [rdi+10h]; len
    add     rdi, 18h; str
    call    php_url_decode
    mov     rcx, [rsp+0D98h+theurl]
    mov     rbx, [rcx+28h]
    mov     [rbx+10h], rax
    test    rax, rax
    jle     short loc_5C63A0
    lea     rbp, [rbx+rax]
    add     rbp, 18h
    add     rbx, 18h
    call    ___ctype_b_loc
    mov     rax, [rax]
loc_5C638E:
    movzx   ecx, byte ptr [s]
    test    byte ptr [rax+rcx*2], 2
    jnz     short loc_5C63F5
    add     rbx, 1
    cmp     s, e
    jb      short loc_5C638E
loc_5C63A0:
    mov     r9, r14
    add     r9d, 0FFFFFFFFh; context
    mov     rax, [rsp+0D98h+arg_8]
    mov     [rsp+0D98h+error_string+8], rax; flags
    mov     dword ptr [rsp+0D98h+error_string], 2; redirect_max
    lea     rsi, [rsp+0D98h+str]; path
    mov     rdi, r15; wrapper
    mov     rdx, r13; mode
    mov     ecx, [rsp+0D98h+var_D5C]; options
    mov     r8, [rsp+0D98h+opened_path]; opened_path
    call    php_stream_url_wrap_http_ex
    mov     rbx, rax
    jmp     short loc_5C6414
loc_5C63DC:
    lea     rdx, aInvalidRedirec; "Invalid redirect URL! %s"
    xor     ebx, ebx
    lea     rcx, [rsp+0D98h+str]
    mov     rdi, rbp
    mov     esi, r15d
    jmp     short loc_5C640D
loc_5C63F5:
    lea     rdx, aInvalidRedirec; "Invalid redirect URL! %s"
    xor     ebx, ebx
    lea     rcx, [rsp+0D98h+str]
    mov     rdi, r15; wrapper
    mov     esi, [rsp+0D98h+var_D5C]; options
loc_5C640D:
    xor     eax, eax
    call    php_stream_wrapper_log_error
loc_5C6414:
    xor     r15d, r15d
loc_5C6417:
    mov     rbp, [rsp+0D98h+var_CF8]
    mov     r14, [rsp+0D98h+bytes_max]
    jmp     out
loc_5C6429:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rbx, [rsp+0D98h+ptr]
    mov     r12, [rbx+10h]
    jmp     loc_5C4C33
loc_5C6444:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     r14, [rsp+0D98h+ptr]
    mov     r15, [r14+10h]
    jmp     loc_5C4D01
loc_5C645F:
    add     rcx, 18h
    lea     rdx, aSS_5; "%s%s"
    jmp     loc_5C617A
loc_5C646F:
    mov     ebx, 4
loc_5C6474:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rdx, [rsp+0D98h+header_bag]
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C42D1
loc_5C6494:
    mov     r12d, 2
loc_5C649A:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C53FB
loc_5C64B5:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C43C9
loc_5C64D0:
    mov     eax, 2401h
    jmp     short loc_5C64DB
loc_5C64D7:
    add     p, 1
loc_5C64DB:
    movzx   ecx, byte ptr [p+0]
    cmp     rcx, 0Dh
    ja      short loc_5C64D7
    bt      rax, rcx
    jnb     short loc_5C64D7
    sub     p, s
    mov     rax, [rsp+0D98h+str.s]
    mov     r12, rbp
    test    rax, rax
    jz      loc_5C6A0F
    mov     rcx, [rax+10h]
    lea     r12, [rcx+rbp]
    cmp     r12, [rsp+0D98h+str.a]
    jnb     loc_5C6A0F
loc_5C6518:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, s; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], r12
    test    rax, rax
    jz      loc_5C6A30
    lea     s, [r12+2]
    cmp     rbx, [rsp+0D98h+str.a]
    jnb     loc_5C6A35
loc_5C6553:
    mov     word ptr [rax+r12+18h], 0A0Dh
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    mov     r13, [rsp+0D98h+src]
    test    rax, rax
    jnz     loc_5C3FA6
    jmp     loc_5C6017
loc_5C657A:
    mov     r12d, 8
loc_5C6580:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C3C1B
loc_5C65A1:
    mov     ebx, 1
    mov     r13, [rsp+0D98h+src]
    mov     rbp, [rsp+0D98h+theurl]
loc_5C65B0:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    jmp     loc_5C3CB2
loc_5C65CD:
    mov     ebp, 0Bh
loc_5C65D2:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rbx, [rax+10h]
    jmp     loc_5C3D80
loc_5C65F3:
    mov     rdi, tmpzval; op
    call    zval_get_double_func
    jmp     loc_5C39BC
loc_5C6600:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     r14, [rsp+0D98h+ptr]
    mov     rbx, [r14+10h]
    jmp     loc_5C447F
loc_5C661B:
    mov     ebx, 0Bh
loc_5C6620:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C45D4
loc_5C663B:
    mov     ebp, 2
loc_5C6640:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rbx, [rax+10h]
    jmp     loc_5C5186
loc_5C665B:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rbx, [rsp+0D98h+ptr]
    mov     r13, [rbx+10h]
    jmp     loc_5C455B
loc_5C6676:
    mov     r14d, 15h
loc_5C667C:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r14; len
    call    smart_str_erealloc
    mov     rbp, [rsp+0D98h+ptr]
    mov     rax, [rbp+10h]
    jmp     loc_5C4AB3
loc_5C6697:
    mov     ebp, 2
    mov     r13, [rsp+0D98h+src]
    mov     r15, [rsp+0D98h+opened_path]
loc_5C66A6:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rbx, [rax+10h]
    jmp     loc_5C4B43
loc_5C66C1:
    mov     r12d, 6
loc_5C66C7:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C4BEF
loc_5C66E2:
    mov     ebx, 2
    mov     r14, [rsp+0D98h+src]
    mov     r12, r13
loc_5C66EF:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rbp, [rax+10h]
    jmp     loc_5C4C6F
loc_5C670A:
    mov     r15d, 6
loc_5C6710:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C4CB4
loc_5C672B:
    mov     ebx, 13h
loc_5C6730:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C4D7A
loc_5C674B:
    mov     ebx, 2
loc_5C6750:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C4EA7
loc_5C676B:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C4381
loc_5C6786:
    mov     ebx, 1
    mov     r12, [rsp+0D98h+theurl]
loc_5C6790:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    jmp     loc_5C4440
loc_5C67A7:
    mov     ebx, 1
loc_5C67AC:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    jmp     loc_5C4409
loc_5C67C3:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C4E60
loc_5C67DE:
    mov     rdi, tmpzval; op
    call    zval_get_double_func
    jmp     loc_5C44DA
loc_5C67EB:
    mov     r13d, 6
loc_5C67F1:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r13; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C4513
loc_5C680C:
    mov     ebx, 2
    mov     r13, [rsp+0D98h+src]
loc_5C6816:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rbp, [rax+10h]
    jmp     loc_5C4594
loc_5C6831:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C4F82
loc_5C684C:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     r15, [rax+10h]
    jmp     loc_5C53C2
loc_5C6867:
    mov     ebx, 1
loc_5C686C:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    jmp     loc_5C4DDF
loc_5C6883:
    mov     rdi, tmpzval; op
    xor     esi, esi; is_strict
    call    zval_get_long_func
    mov     r15, rax
    jmp     loc_5C41E1
loc_5C6895:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C4263
loc_5C68B0:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C50D0
loc_5C68CB:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C52A6
loc_5C68E6:
    mov     r15d, 2
loc_5C68EC:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C538C
loc_5C6907:
    mov     ebx, 1
loc_5C690C:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rdx, [rsp+0D98h+header_bag]
    mov     rax, [rsp+0D98h+ptr]
    jmp     loc_5C429C
loc_5C6928:
    mov     ebp, 10h
loc_5C692D:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C5045
loc_5C6948:
    mov     ebx, 2
loc_5C694D:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rbp, [rax+10h]
    jmp     loc_5C5104
loc_5C6968:
    mov     ebp, 10h
loc_5C696D:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C5218
loc_5C6988:
    mov     ebp, 2
loc_5C698D:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     r12, [rax+10h]
    jmp     loc_5C52DB
loc_5C69A8:
    mov     ebp, 31h ; '1'
loc_5C69AD:
    lea     rdi, [rsp+0D98h+ptr]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+ptr]
    mov     rcx, [rax+10h]
    jmp     loc_5C5321
loc_5C69C8:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C5FBF
loc_5C69E9:
    mov     ebx, 2
loc_5C69EE:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     r12, [rax+10h]
    jmp     loc_5C5FFA
loc_5C6A0F:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C6518
loc_5C6A30:
    mov     ebx, 2
loc_5C6A35:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     r12, [rax+10h]
    jmp     loc_5C6553
php_stream_url_wrap_http_ex endp

