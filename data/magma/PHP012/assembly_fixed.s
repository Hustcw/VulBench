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
    movapd  xmmword ptr [rsp+0D98h+var_D78.s], xmm0
    mov     [rsp+0D98h+s1], 0
    test    r9d, r9d
    jle     loc_5C4CF6
    mov     r12d, r9d
    mov     r15, context
    mov     r13, mode
    mov     rbx, path
    mov     [rsp+0D98h+var_D64], ecx
    mov     rdi, rsi; str
    call    php_url_parse
    test    rax, rax
    jz      loc_5C7392
    mov     rbp, rax
    mov     [rsp+0D98h+var_D60], path
    mov     rdi, [rax]
    mov     rax, [rdi+10h]
    cmp     rax, 4
    jnz     short loc_5C4C6B
    add     rdi, 18h; s1
    lea     rdx, aHttp; "http"
    mov     esi, 4; len1
    mov     ecx, 4; len2
    call    zend_binary_strcasecmp
    test    eax, eax
    jz      loc_5C4D39
    mov     rdi, [resource+0]
    mov     rax, [rdi+10h]
loc_5C4C6B:
    cmp     rax, 5
    jnz     short loc_5C4C93
    add     rdi, 18h; s1
    lea     rdx, aHttps; "https"
    mov     esi, 5; len1
    mov     ecx, 5; len2
    call    zend_binary_strcasecmp
    test    eax, eax
    jz      loc_5C4D39
loc_5C4C93:
    mov     [rsp+0D98h+theurl], resource
    test    context, context
    jz      short loc_5C4D10
    mov     rax, [wrapper]
    mov     rsi, [rax+28h]; wrappername
    lea     rdx, optionname; "proxy"
    mov     rdi, context; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C4D10
    cmp     byte ptr [tmpzval+8], 6
    jnz     short loc_5C4D10
    mov     rbx, [tmpzval]
    cmp     qword ptr [rbx+10h], 0
    jz      short loc_5C4D10
    mov     al, 1
    mov     [rsp+0D98h+ptr], rax
    mov     eax, 1
    mov     [rsp+0D98h+bytes_max], rax
    mov     [rsp+0D98h+var_D34], 0
    test    byte ptr [rbx+4], 40h
    jnz     short loc_5C4CED
    add     dword ptr [rbx], 1
loc_5C4CED:
    mov     ebp, [rsp+0D98h+var_D64]
    jmp     loc_5C4E95
loc_5C4CF6:
    lea     mode, aRedirectionLim; "Redirection limit reached, aborting"
    xor     ebx, ebx
    mov     rdi, wrapper; wrapper
    mov     esi, ecx; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    jmp     loc_5C7394
loc_5C4D10:
    mov     rdi, [rsp+0D98h+theurl]; theurl
    call    php_url_free
    mov     rdi, [rsp+0D98h+var_D60]; path
    mov     rsi, mode; mode
    mov     edx, 8; options
    xor     ecx, ecx; opened_path
    mov     r8, context; context
    call    _php_stream_open_wrapper_ex
    mov     rbx, rax
    jmp     loc_5C7394
loc_5C4D39:
    lea     rsi, aAwx; "awx+"
    mov     rdi, mode; s
    call    _strpbrk
    test    rax, rax
    jz      short loc_5C4D71
    lea     rdx, aHttpWrapperDoe; "HTTP wrapper does not support writeable"...
    xor     ebx, ebx
    mov     rdi, wrapper; wrapper
    mov     esi, [rsp+0D98h+var_D64]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    mov     rdi, resource; theurl
    call    php_url_free
    jmp     loc_5C7394
loc_5C4D71:
    mov     [rsp+0D98h+src], mode
    mov     rax, [resource+0]
    test    rax, rax
    mov     [rsp+0D98h+theurl], resource
    jz      short loc_5C4DCC
    mov     [rsp+0D98h+var_D34], 0
    cmp     qword ptr [rax+10h], 5
    mov     r13d, 0
    jb      short loc_5C4DD7
    mov     [rsp+0D98h+var_D34], 0
    cmp     byte ptr [rax+1Ch], 73h ; 's'
    mov     r13d, 0
    jnz     short loc_5C4DD7
    cmp     word ptr [resource+20h], 0
    jz      loc_5C697C
    mov     r13b, 1
    mov     [rsp+0D98h+var_D34], 1
    cmp     word ptr [resource+20h], 0
    jnz     short loc_5C4DE4
    jmp     short loc_5C4DDE
loc_5C4DCC:
    mov     [rsp+0D98h+var_D34], 0
    xor     r13d, r13d
loc_5C4DD7:
    cmp     word ptr [resource+20h], 0
    jnz     short loc_5C4DE4
loc_5C4DDE:
    mov     word ptr [resource+20h], 50h ; 'P'
loc_5C4DE4:
    test    context, context
    mov     ebp, [rsp+0D98h+var_D64]
    jz      short loc_5C4E3C
    mov     rax, [wrapper]
    mov     rsi, [rax+28h]; wrappername
    lea     rdx, optionname; "proxy"
    mov     rdi, context; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C4E3C
    cmp     byte ptr [tmpzval+8], 6
    jnz     short loc_5C4E3C
    mov     rbx, [tmpzval]
    cmp     qword ptr [rbx+10h], 0
    jz      short loc_5C4E3C
    mov     eax, 1
    mov     [rsp+0D98h+bytes_max], rax
    test    byte ptr [rbx+4], 40h
    mov     r13, [rsp+0D98h+src]
    jnz     short loc_5C4E30
    add     dword ptr [rbx], 1
loc_5C4E30:
    xor     eax, eax
    mov     [rsp+0D98h+ptr], rax
    jmp     short loc_5C4E95
loc_5C4E3C:
    lea     rax, aOpenssl+4; "ssl"
    lea     rdx, aTcp; "tcp"
    test    r13b, r13b
    cmovnz  rdx, rax
    mov     rax, [rsp+0D98h+theurl]
    mov     rcx, [rax+18h]
    add     rcx, 18h
    movzx   r8d, word ptr [rax+20h]
    lea     rsi, aSSD; "%s://%s:%d"
    xor     eax, eax
    mov     [rsp+0D98h+bytes_max], rax
    xor     edi, edi; max_len
    xor     eax, eax
    call    zend_strpprintf
    mov     rbx, rax
    xor     eax, eax
    test    context, context
    jz      loc_5C4F22
    mov     [rsp+0D98h+ptr], rax
    mov     r13, [rsp+0D98h+src]
loc_5C4E95:
    mov     rax, [wrapper]
    mov     rsi, [rax+28h]; wrappername
    lea     rdx, aTimeout; "timeout"
    mov     rdi, context; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C4F19
    cmp     byte ptr [tmpzval+8], 5
    jnz     loc_5C7B77
    movsd   xmm0, qword ptr [tmpzval]
loc_5C4EBE:
    mov     [rsp+0D98h+src], r13
    cvttsd2si rcx, xmm0
    cvtsi2sd d, rcx
    subsd   xmm0, d
    mulsd   xmm0, cs:qword_73B250
    movsd   xmm1, cs:qword_73CA88
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
    mov     [rsp+0D98h+var_D28], rcx
    jmp     short loc_5C4F50
loc_5C4F19:
    mov     al, 1
    mov     [rsp+0D98h+var_D28], rax
    jmp     short loc_5C4F36
loc_5C4F22:
    mov     [rsp+0D98h+var_D28], rax
    xor     eax, eax
    mov     [rsp+0D98h+ptr], rax
    mov     r13, [rsp+0D98h+src]
loc_5C4F36:
    mov     [rsp+0D98h+src], r13
    lea     rax, file_globals
    mov     rax, [rax+18h]
    mov     [rsp+0D98h+timeout.tv_sec], rax
    xor     eax, eax
loc_5C4F50:
    mov     [rsp+0D98h+timeout.tv_usec], rax
    lea     rdi, [rbx+18h]; name
    mov     rsi, [rbx+10h]; namelen
    lea     rax, [rsp+0D98h+var_CE8]
    mov     [rsp+0D98h+error_string+8], rax; error_string
    mov     [rsp+0D98h+error_string], context; context
    mov     [rsp+0D98h+error_code], 0; error_code
    lea     r9, [rsp+0D98h+timeout]; timeout
    mov     edx, ebp; options
    mov     ecx, 2; flags
    xor     r8d, r8d; persistent_id
    call    _php_stream_xport_create
    mov     rbp, rax
    test    rax, rax
    jz      short loc_5C4FB0
    lea     rcx, [rsp+0D98h+timeout]; ptrparam
    mov     rdi, stream; stream
    mov     esi, 4; option
    xor     edx, edx; value
    call    _php_stream_set_option
loc_5C4FB0:
    mov     [rsp+0D98h+var_D20], stream
    mov     rcx, [rsp+0D98h+var_CE8]
    test    errstr, errstr
    mov     rbp, [rsp+0D98h+src]
    jz      short loc_5C5005
    add     errstr, 18h
    lea     rdx, aXPhpOriginatin+22h; fmt
    mov     rdi, wrapper; wrapper
    mov     esi, [rsp+0D98h+var_D64]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    mov     rdi, [rsp+0D98h+var_CE8]; ptr
    mov     eax, [errstr+4]
    test    al, 40h
    jnz     short loc_5C4FF9
    add     dword ptr [errstr], 0FFFFFFFFh
    jnz     short loc_5C4FF9
    call    _efree
loc_5C4FF9:
    mov     [rsp+0D98h+var_CE8], 0
loc_5C5005:
    mov     eax, [rbx+4]
    test    al, 40h
    jnz     short loc_5C5024
    add     dword ptr [rbx], 0FFFFFFFFh
    jnz     short loc_5C5024
    mov     rdi, rbx; ptr
    test    al, al
    js      short loc_5C501F
    call    _efree
    jmp     short loc_5C5024
loc_5C501F:
    call    free
loc_5C5024:
    cmp     [rsp+0D98h+var_D34], 0
    mov     [rsp+0D98h+opened_path], context
    mov     [rsp+0D98h+var_CF8], wrapper
    jz      loc_5C50C5
    cmp     dword ptr [rsp+0D98h+bytes_max], 0
    mov     r13, [rsp+0D98h+var_D20]
    jz      loc_5C5631
    test    r13, r13
    jz      loc_5C5631
    xorpd   xmm0, xmm0
    movapd  xmmword ptr [rsp+0D98h+str.s], xmm0
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C5088
    lea     rsi, aOpenssl+4; wrappername
    lea     rdx, aPeerName; "peer_name"
    mov     rdi, context; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jnz     loc_5C511B
loc_5C5088:
    mov     rax, [rsp+0D98h+theurl]
    mov     rcx, [rax+18h]
    mov     qword ptr [rsp+0D98h+optionvalue.value], __s
    mov     eax, 6
    test    byte ptr [__s+4], 40h
    jnz     short loc_5C50AC
    add     dword ptr [__s], 1
    mov     eax, 106h
loc_5C50AC:
    mov     dword ptr [rsp+0D98h+optionvalue.u1], eax
    mov     rax, [r13+90h]
    test    rax, rax
    jz      short loc_5C50F3
    mov     rdi, [rax+10h]
    jmp     short loc_5C50F5
loc_5C50C5:
    mov     r13, [rsp+0D98h+var_D20]
    test    stream, stream
    jnz     loc_5C563A
loc_5C50D3:
    mov     r14, rbp
    xor     r15d, r15d
    mov     [rsp+0D98h+var_D04], 0
    xor     ebp, ebp
    xor     r13d, r13d
    xor     r12d, r12d
    xor     ebx, ebx
    jmp     out
loc_5C50F3:
    xor     edi, edi; context
loc_5C50F5:
    lea     rsi, aOpenssl+4; wrappername
    lea     rdx, aPeerName; "peer_name"
    lea     rbp, [rsp+0D98h+optionvalue]
    mov     rcx, rbp; optionvalue
    call    php_stream_context_set_option
    mov     rdi, rbp; zval_ptr
    call    zval_ptr_dtor
loc_5C511B:
    mov     rax, [rsp+0D98h+str.s]
    test    rax, rax
    mov     [rsp+0D98h+var_D00], redirect_max
    jz      loc_5C7AF9
    mov     rcx, [rax+10h]
    lea     redirect_max, [rcx+8]
    cmp     r12, [rsp+0D98h+str.a]
    jnb     loc_5C7AFF
loc_5C514A:
    mov     rdx, 205443454E4E4F43h
    mov     [rax+rcx+18h], rdx
    mov     r14, [rsp+0D98h+str.s]
    mov     [r14+10h], r12
    mov     rax, [rsp+0D98h+theurl]
    mov     rbp, [rax+18h]
    add     rbp, 18h
    mov     rdi, rbp; s
    call    _strlen
    mov     r13, rax
    mov     rbx, rax
    test    r14, r14
    jz      loc_5C761D
    mov     rbx, r13
    add     rbx, r12
    cmp     rbx, [rsp+0D98h+str.a]
    jnb     loc_5C761D
loc_5C519D:
    lea     rdi, [r14+r12]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r13; n
    call    _memcpy
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    test    rax, rax
    jz      loc_5C7B20
    add     rbx, 1
    cmp     rbx, [rsp+0D98h+str.a]
    mov     context, [rsp+0D98h+opened_path]
    mov     rbp, [rsp+0D98h+theurl]
    mov     r13, [rsp+0D98h+var_D20]
    jnb     loc_5C7B34
loc_5C51E6:
    mov     byte ptr [rbx+rax+17h], 3Ah ; ':'
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    movzx   ecx, word ptr [rbp+20h]
    lea     r12, [rsp+0D98h+var_819]
    mov     [rsp+0D98h+var_819], 0
    mov     rsi, 0CCCCCCCCCCCCCCCDh
    mov     rbp, r12
    nop     dword ptr [rax+rax+00000000h]
loc_5C5220:
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
    ja      short loc_5C5220
    sub     r12, rbp
    mov     rax, [rsp+0D98h+str.s]
    mov     rbx, r12
    test    rax, rax
    jz      loc_5C763E
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+r12]
    cmp     rbx, [rsp+0D98h+str.a]
    jnb     loc_5C763E
loc_5C5276:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r12; n
    call    _memcpy
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    test    rax, rax
    jz      loc_5C7B51
    lea     rbp, [rbx+0Bh]
    cmp     rbp, [rsp+0D98h+str.a]
    jnb     loc_5C7B56
loc_5C52B0:
    mov     rcx, 2E312F5054544820h
    mov     [rax+rbx+18h], rcx
    mov     dword ptr [rax+rbx+1Fh], 0A0D302Eh
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbp
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      loc_5C54D4
    lea     rsi, aHttp; "http"
    lea     rdx, aTheAdditionalH+2Fh; optionname
    mov     rdi, r15; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      loc_5C54C2
    mov     cl, [tmpzval+8]
    cmp     cl, 6
    jz      loc_5C540D
    cmp     cl, 7
    jnz     loc_5C54C2
    mov     tmpzval, [tmpzval]
    mov     r14d, [__ht+18h]
    test    r14, r14
    jz      loc_5C54C2
    mov     r13, [__ht+10h]
    shl     r14, 5
    add     r14, _p
    lea     r15, aProxyAuthoriza; "Proxy-Authorization:"
    mov     r12d, 2401h
    cmp     byte ptr [_z+8], 6
    jz      short loc_5C5355
loc_5C5341:
    add     _p, 20h ; ' '
    cmp     _p, _end
    jz      loc_5C54C2
    cmp     byte ptr [_z+8], 6
    jnz     short loc_5C5341
loc_5C5355:
    mov     rbp, [_z+0]
    add     rbp, 18h
    jmp     short loc_5C5363
loc_5C535F:
    add     s, 1
loc_5C5363:
    mov     al, [s+0]
    cmp     al, 9
    jz      short loc_5C535F
    cmp     al, 20h ; ' '
    jz      short loc_5C535F
    lea     rbx, [s+1]
    cmp     al, 0Ch
    jle     short loc_5C5392
    nop     word ptr [rax+rax+00000000h]
loc_5C5380:
    cmp     al, 0Dh
    jz      short loc_5C539A
    cmp     al, 3Ah ; ':'
    jz      short loc_5C53A0
loc_5C5388:
    mov     al, [rbx]
    add     rbx, 1
    cmp     al, 0Ch
    jg      short loc_5C5380
loc_5C5392:
    test    al, al
    jz      short loc_5C539A
    cmp     al, 0Ah
    jnz     short loc_5C5388
loc_5C539A:
    add     rbx, 0FFFFFFFFFFFFFFFFh
    jmp     short loc_5C53E3
loc_5C53A0:
    mov     rax, rbx
    sub     rax, s
    cmp     rax, 14h
    jnz     short loc_5C53D4
    mov     esi, 14h; len1
    mov     ecx, 14h; len2
    mov     rdi, s; s1
    mov     rdx, r15; s2
    call    zend_binary_strcasecmp
    test    eax, eax
    jnz     short loc_5C53D4
    jmp     loc_5C7505
loc_5C53D0:
    add     p, 1
loc_5C53D4:
    movzx   eax, byte ptr [p]
    cmp     rax, 0Dh
    ja      short loc_5C53D0
    bt      r12, rax
    jnb     short loc_5C53D0
loc_5C53E3:
    mov     s, rbx
    cmp     al, 0Ah
    jnz     short loc_5C53FC
    nop     word ptr [rax+rax+00h]
loc_5C53F0:
    movzx   eax, byte ptr [s+1]
    add     s, 1
    cmp     al, 0Ah
    jz      short loc_5C53F0
loc_5C53FC:
    cmp     al, 0Dh
    jz      short loc_5C53F0
    test    al, al
    jnz     loc_5C5363
    jmp     loc_5C5341
loc_5C540D:
    mov     rbx, [tmpzval]
    cmp     qword ptr [rbx+10h], 0
    jz      loc_5C54C2
    add     rbx, 18h
    lea     r14, aProxyAuthoriza; "Proxy-Authorization:"
    mov     r12d, 2401h
    jmp     short loc_5C5432
loc_5C542E:
    add     s, 1
loc_5C5432:
    mov     al, [s]
    cmp     al, 9
    jz      short loc_5C542E
    cmp     al, 20h ; ' '
    jz      short loc_5C542E
    lea     rbp, [s+1]
    cmp     al, 0Ch
    jle     short loc_5C5457
loc_5C5444:
    cmp     al, 0Dh
    jz      short loc_5C545F
    cmp     al, 3Ah ; ':'
    jz      short loc_5C5465
loc_5C544C:
    mov     al, [rbp+0]
    add     rbp, 1
    cmp     al, 0Ch
    jg      short loc_5C5444
loc_5C5457:
    test    al, al
    jz      short loc_5C545F
    cmp     al, 0Ah
    jnz     short loc_5C544C
loc_5C545F:
    add     rbp, 0FFFFFFFFFFFFFFFFh
    jmp     short loc_5C54A3
loc_5C5465:
    mov     rax, rbp
    sub     rax, s
    cmp     rax, 14h
    jnz     short loc_5C5493
    mov     esi, 14h; len1
    mov     ecx, 14h; len2
    mov     rdi, s; s1
    mov     rdx, r14; s2
    call    zend_binary_strcasecmp
    test    eax, eax
    jnz     short loc_5C5493
    jmp     loc_5C7A5D
loc_5C548F:
    add     p, 1
loc_5C5493:
    movzx   eax, byte ptr [p+0]
    cmp     rax, 0Dh
    ja      short loc_5C548F
    bt      r12, rax
    jnb     short loc_5C548F
loc_5C54A3:
    mov     s, rbp
    cmp     al, 0Ah
    jnz     short loc_5C54B6
loc_5C54AA:
    movzx   eax, byte ptr [s+1]
    add     s, 1
    cmp     al, 0Ah
    jz      short loc_5C54AA
loc_5C54B6:
    cmp     al, 0Dh
    jz      short loc_5C54AA
    test    al, al
    jnz     loc_5C5432
loc_5C54C2:
    mov     rax, [rsp+0D98h+str.s]
loc_5C54CA:
    mov     r15, [rsp+0D98h+opened_path]
    mov     r13, [rsp+0D98h+var_D20]
loc_5C54D4:
    test    rax, rax
    jz      loc_5C75AE
loc_5C54DD:
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+2]
    cmp     rbx, [rsp+0D98h+str.a]
    mov     r14, [rsp+0D98h+var_CF8]
    mov     rbp, [rsp+0D98h+src]
    jnb     loc_5C75C0
loc_5C5500:
    mov     word ptr [rax+rcx+18h], 0A0Dh
    mov     rsi, [rsp+0D98h+str.s]
    mov     [rsi+10h], rbx
    add     rsi, 18h; buf
    mov     rdi, r13; stream
    mov     rdx, rbx; count
    call    _php_stream_write
    mov     rdi, [rsp+0D98h+str.s]
    cmp     rax, [rdi+10h]
    jz      short loc_5C555D
    lea     rdx, aCannotConnectT; "Cannot connect to HTTPS server through "
    mov     rdi, r14; wrapper
    mov     esi, [rsp+0D98h+var_D64]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    mov     rdi, r13; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    mov     rdi, [rsp+0D98h+str.s]; ptr
    xor     r13d, r13d
loc_5C555D:
    test    rdi, rdi
    jz      short loc_5C557F
    mov     eax, [rdi+4]
    test    al, 40h
    jnz     short loc_5C5573
    add     dword ptr [rdi], 0FFFFFFFFh
    jnz     short loc_5C5573
    call    _efree
loc_5C5573:
    mov     [rsp+0D98h+str.s], 0
loc_5C557F:
    mov     [rsp+0D98h+str.a], 0
    test    stream, stream
    jz      loc_5C5626
    lea     rbx, [rsp+0D98h+buf]
    mov     ebp, 2401h
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+rax+00h]
loc_5C55B0:
    mov     edx, 3FFh; maxlen
    mov     rdi, stream; stream
    mov     rsi, rbx; buf
    xor     ecx, ecx; returned_len
    call    _php_stream_get_line
    test    rax, rax
    jz      short loc_5C55DB
    movzx   eax, [rsp+0D98h+buf]
    cmp     rax, 0Dh
    ja      short loc_5C55B0
    bt      rbp, rax
    jnb     short loc_5C55B0
loc_5C55DB:
    mov     rdi, stream; stream
    mov     esi, 39h ; '9'; crypto_method
    xor     edx, edx; session_stream
    call    php_stream_xport_crypto_setup
    test    eax, eax
    mov     rbp, [rsp+0D98h+src]
    js      short loc_5C5604
    mov     rdi, stream; stream
    mov     esi, 1; activate
    call    php_stream_xport_crypto_enable
    test    eax, eax
    jns     short loc_5C5629
loc_5C5604:
    lea     rdx, aCannotConnectT; "Cannot connect to HTTPS server through "
    mov     rdi, r14; wrapper
    mov     esi, [rsp+0D98h+var_D64]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    mov     rdi, stream; stream
    mov     esi, 3; close_options
    call    _php_stream_free
loc_5C5626:
    xor     r13d, r13d
loc_5C5629:
    mov     r12, [rsp+0D98h+var_D00]
loc_5C5631:
    test    stream, stream
    jz      loc_5C50D3
loc_5C563A:
    test    byte ptr [rsp+0D98h+var_D64], 20h
    jnz     short loc_5C5645
    xor     eax, eax
    jmp     short loc_5C565B
loc_5C5645:
    mov     rdi, stream; stream
    mov     esi, 5; option
    mov     edx, 1; value
    xor     ecx, ecx; ptrparam
    call    _php_stream_set_option
    cdqe
loc_5C565B:
    mov     [rsp+0D98h+var_CF0], rax
    mov     eax, [stream+74h]
    mov     [rsp+0D98h+var_D04], eax
    and     eax, 0FFFFFFF3h
    mov     [stream+74h], eax
    mov     rdi, stream; stream
    mov     rsi, r15; context
    call    php_stream_context_set
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    mov     [rsp+0D98h+src], rbp
    jz      loc_5C579E
    cmp     qword ptr [r15], 0
    jz      short loc_5C56B6
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0; bytes_max
    mov     rdi, r15; context
    mov     esi, 2; notifycode
    xor     edx, edx; severity
    xor     ecx, ecx; xmsg
    xor     r8d, r8d; xcode
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C56B6:
    mov     eax, [rsp+0D98h+redirect_max_0]
    mov     ebx, eax
    test    al, 1
    jz      short loc_5C56EB
    lea     rsi, aHttp; "http"
    lea     rdx, aMaxRedirects; "max_redirects"
    mov     rdi, r15; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C56EB
    cmp     byte ptr [tmpzval+8], 4
    jnz     loc_5C7E0E
    mov     r12, [tmpzval]
loc_5C56EB:
    and     bl, 1
    lea     rsi, aHttp; "http"
    lea     rdx, aIntlcalIsWeeke+26h; optionname
    mov     rdi, r15; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      loc_5C57A0
    cmp     byte ptr [tmpzval+8], 6
    jnz     loc_5C57A0
    mov     [rsp+0D98h+var_D44], ebx
    mov     header_init, [tmpzval]
    mov     rbp, [rbx+10h]
    test    rbp, rbp
    jz      loc_5C7452
    mov     eax, [rsp+0D98h+redirect_max_0]
    test    al, 2
    jnz     loc_5C699D
loc_5C573A:
    add     rbx, 18h
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     r15, rbp
    test    rax, rax
    jz      loc_5C7E20
    mov     rcx, [rax+10h]
    lea     r15, [rcx+rbp]
    cmp     r15, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7E20
loc_5C5762:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbx; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], r15
    test    rax, rax
    jz      loc_5C7E92
    add     r15, 1
    cmp     r15, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7E98
loc_5C5796:
    mov     byte ptr [r15+rax+17h], 20h ; ' '
    jmp     short loc_5C57CD
loc_5C579E:
    xor     ebx, ebx
loc_5C57A0:
    mov     rax, [rsp+0D98h+var_D78.s]
    test    rax, rax
    mov     [rsp+0D98h+var_D44], ebx
    jz      loc_5C7A01
    mov     rcx, [rax+10h]
    lea     r15, [rcx+4]
    cmp     r15, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7A07
loc_5C57C5:
    mov     dword ptr [rax+rcx+18h], 20544547h
loc_5C57CD:
    mov     [rsp+0D98h+var_D00], r12
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], r15
    mov     rdx, [rsp+0D98h+ptr]
    test    dl, dl
    setnz   al
    mov     rcx, [rsp+0D98h+var_D28]
    mov     ebx, ecx
    xor     bl, 1
    or      al, bl
    mov     [rsp+0D98h+var_D20], stream
    mov     rdi, [rsp+0D98h+opened_path]; context
    mov     r13, [rsp+0D98h+var_D60]
    mov     [rsp+0D98h+var_D11], bl
    jnz     short loc_5C5834
    lea     rsi, aHttp; "http"
    lea     rdx, aRequestFulluri; "request_fulluri"
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C5838
    mov     rdi, tmpzval; op
    call    zend_is_true
    test    eax, eax
    setnz   dl
loc_5C5834:
    test    dl, dl
    jnz     short loc_5C58A9
loc_5C5838:
    mov     rax, [rsp+0D98h+theurl]
    mov     rbp, [rax+28h]
    test    rbp, rbp
    jz      loc_5C58F7
    cmp     qword ptr [rbp+10h], 0
    jz      loc_5C58F7
    add     rbp, 18h
    mov     rdi, rbp; s
    call    _strlen
    mov     r12, rax
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rbx, r12
    test    rax, rax
    jz      loc_5C7CF1
    mov     rcx, [rax+10h]
    mov     rbx, r12
    add     rbx, rcx
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7CF1
loc_5C588A:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r12; n
    call    _memcpy
    mov     rcx, [rsp+0D98h+theurl]
    mov     r15, [rsp+0D98h+opened_path]
    jmp     short loc_5C5927
loc_5C58A9:
    mov     rdi, r13; s
    call    _strlen
    mov     rbx, rax
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rbp, rbx
    test    rax, rax
    jz      loc_5C7A42
    mov     rcx, [rax+10h]
    mov     rbp, rbx
    add     rbp, rcx
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7A42
loc_5C58DA:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, r13; src
    mov     rdx, rbx; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    jmp     loc_5C59B9
loc_5C58F7:
    mov     rax, [rsp+0D98h+var_D78.s]
    test    rax, rax
    jz      loc_5C7D2D
    mov     rbx, [rax+10h]
    add     rbx, 1
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7D32
loc_5C5918:
    mov     byte ptr [rbx+rax+17h], 2Fh ; '/'
    mov     r15, [rsp+0D98h+opened_path]
    mov     rcx, [rsp+0D98h+theurl]
loc_5C5927:
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    mov     [rsp+0D98h+theurl], rcx
    cmp     qword ptr [rcx+30h], 0
    jz      loc_5C59C2
    test    rax, rax
    jz      loc_5C7D0C
    add     rbx, 1
    cmp     rbx, [rsp+0D98h+var_D78.a]
    mov     r12, [rsp+0D98h+theurl]
    jnb     loc_5C7D16
loc_5C595D:
    mov     byte ptr [rbx+rax+17h], 3Fh ; '?'
    mov     r14, [rsp+0D98h+var_D78.s]
    mov     [r14+10h], rbx
    mov     r12, [r12+30h]
    add     r12, 18h
    mov     rdi, r12; s
    call    _strlen
    mov     r13, rax
    mov     rbp, rax
    test    r14, r14
    jz      loc_5C7B84
    mov     rbp, r13
    add     rbp, rbx
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7B84
loc_5C599C:
    lea     rdi, [r14+rbx]
    add     rdi, 18h; dest
    mov     rsi, r12; src
    mov     rdx, r13; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     r13, [rsp+0D98h+var_D60]
loc_5C59B9:
    mov     [rax+10h], rbp
    mov     r15, [rsp+0D98h+opened_path]
loc_5C59C2:
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      loc_5C5ADD
    lea     rsi, aHttp; "http"
    lea     rdx, aProtocolVersio; "protocol_version"
    mov     rdi, r15; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      loc_5C5AD8
    cmp     byte ptr [tmpzval+8], 5
    jnz     loc_5C7D64
    movsd   xmm0, qword ptr [tmpzval]
loc_5C59FA:
    lea     rdx, aF1f+2; format
    lea     rdi, [rsp+0D98h+buf]; message
    xor     esi, esi; max_len
    mov     al, 1
    call    zend_spprintf
    mov     rax, [rsp+0D98h+var_D78.s]
    test    rax, rax
    jz      loc_5C7D71
    mov     rcx, [rax+10h]
    lea     r13, [rcx+6]
    cmp     r13, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7D77
loc_5C5A33:
    mov     word ptr [rax+rcx+1Ch], 2F50h
    mov     dword ptr [rax+rcx+18h], 54544820h
    mov     rbx, [rsp+0D98h+var_D78.s]
    mov     [rbx+10h], r13
    mov     r12, qword ptr [rsp+0D98h+buf]
    mov     rdi, protocol_version; s
    call    _strlen
    mov     r14, rax
    mov     rbp, rax
    test    rbx, rbx
    jz      loc_5C7BDF
    mov     rbp, r14
    add     rbp, r13
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7BDF
loc_5C5A7B:
    lea     rdi, [rbx+r13]
    add     rdi, 18h; dest
    mov     rsi, protocol_version; src
    mov     rdx, r14; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbp
    test    rax, rax
    jz      loc_5C7D92
    lea     rbx, [rbp+2]
    cmp     rbx, [rsp+0D98h+var_D78.a]
    mov     r15, [rsp+0D98h+opened_path]
    mov     r13, [rsp+0D98h+var_D60]
    jnb     loc_5C7DA1
loc_5C5AB9:
    mov     word ptr [rax+rbp+18h], 0A0Dh
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    mov     rdi, qword ptr [rsp+0D98h+buf]; ptr
    call    _efree
    jmp     short loc_5C5B24
loc_5C5AD8:
    mov     tmpzval, [rsp+0D98h+var_D78.s]
loc_5C5ADD:
    test    rax, rax
    jz      loc_5C7B9F
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+0Bh]
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7BA4
loc_5C5AF9:
    mov     rdx, 2E312F5054544820h
    mov     [rax+rcx+18h], rdx
    mov     dword ptr [rax+rcx+1Fh], 0A0D312Eh
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      loc_5C5C7E
loc_5C5B24:
    lea     rsi, aHttp; "http"
    lea     rdx, aTheAdditionalH+2Fh; optionname
    mov     rdi, r15; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      loc_5C5C7E
    mov     cl, [tmpzval+8]
    cmp     cl, 6
    jz      loc_5C5C5A
    cmp     cl, 7
    jnz     loc_5C5C7E
    xorpd   xmm0, xmm0
    movapd  xmmword ptr [rsp+0D98h+buf], xmm0
    mov     tmpzval, [tmpzval]
    mov     r12d, [__ht+18h]
    test    r12, r12
    jz      loc_5C68ED
    mov     r15, [__ht+10h]
    shl     r12, 5
    xor     r14d, r14d
    xor     eax, eax
    cmp     byte ptr [r15+r14+8], 6
    jz      short loc_5C5B9F
loc_5C5B8A:
    add     r14, 20h ; ' '
    cmp     r12, r14
    jz      loc_5C6881
    cmp     byte ptr [r15+r14+8], 6
    jnz     short loc_5C5B8A
loc_5C5B9F:
    mov     rbx, [r15+r14]
    mov     r13, [rbx+10h]
    add     rbx, 18h
    mov     rbp, r13
    test    rax, rax
    jz      short loc_5C5C14
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+r13]
    cmp     rbp, qword ptr [rsp+0D98h+buf+8]
    jnb     short loc_5C5C14
loc_5C5BC5:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbx; src
    mov     rdx, r13; n
    call    _memcpy
    mov     rax, qword ptr [rsp+0D98h+buf]
    mov     [rax+10h], rbp
    test    rax, rax
    jz      short loc_5C5C32
    lea     rbx, [rbp+2]
    cmp     rbx, qword ptr [rsp+0D98h+buf+8]
    mov     r13, [rsp+0D98h+var_D60]
    jnb     short loc_5C5C3C
loc_5C5BFC:
    mov     word ptr [rax+rbp+18h], 0A0Dh
    mov     rax, qword ptr [rsp+0D98h+buf]
    mov     [rax+10h], rbx
    jmp     loc_5C5B8A
loc_5C5C14:
    lea     rdi, [rsp+0D98h+buf]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, qword ptr [rsp+0D98h+buf]
    mov     rcx, [rax+10h]
    jmp     short loc_5C5BC5
loc_5C5C32:
    mov     ebx, 2
    mov     r13, [rsp+0D98h+var_D60]
loc_5C5C3C:
    lea     rdi, [rsp+0D98h+buf]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, qword ptr [rsp+0D98h+buf]
    mov     rbp, [rax+10h]
    jmp     short loc_5C5BFC
loc_5C5C5A:
    mov     rdi, [tmpzval]; str
    cmp     qword ptr [rdi+10h], 0
    jz      short loc_5C5C7E
    xor     esi, esi; what
    xor     edx, edx; what_len
    mov     ecx, 3; mode
    call    php_trim
    mov     rbp, rax
    test    tmp, tmp
    jnz     loc_5C68F8
loc_5C5C7E:
    xor     r12d, r12d
    xor     r15d, r15d
loc_5C5C84:
    mov     rbx, [rsp+0D98h+theurl]
    cmp     qword ptr [rbx+8], 0
    jz      loc_5C5E3B
    mov     [rsp+0D98h+bytes_max], r12
    mov     rdi, r13; s
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
    jz      short loc_5C5D03
    mov     rsi, [rdi+10h]; len
    add     rdi, 18h; str
    call    php_url_decode
    mov     rsi, [rbx+10h]
    add     rsi, 18h; src
    mov     rdi, scratch; dest
    call    _strcat
loc_5C5D03:
    mov     rdi, scratch; s
    call    _strlen
    mov     rdi, scratch
    mov     rsi, rax
    call    j_resolve_base64_encode
    mov     rbx, rax
    mov     rbp, [rsp+0D98h+var_D78.s]
    test    rbp, rbp
    mov     [rsp+0D98h+var_D60], r15
    jz      loc_5C7BFA
    mov     rax, [rbp+10h]
    lea     r14, [rax+15h]
    cmp     r14, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7C00
loc_5C5D3F:
    movupd  xmm0, cs:xmmword_8B24F6
    movupd  xmmword ptr [rbp+rax+18h], xmm0
    mov     rcx, 206369736142203Ah
    mov     [rbp+rax+25h], rcx
    mov     [rbp+10h], r14
    mov     [rsp+0D98h+ptr], stmp
    lea     r13, [rbx+18h]
    mov     rdi, r13; s
    call    _strlen
    mov     r15, rax
    mov     rbx, rax
    test    rbp, rbp
    jz      loc_5C767A
    mov     rbx, r15
    add     rbx, r14
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C767A
loc_5C5D94:
    lea     rdi, [r14+rbp]
    add     rdi, 18h; dest
    mov     rsi, r13; src
    mov     rdx, r15; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    test    rax, rax
    jz      loc_5C7C1B
    lea     rbp, [rbx+2]
    cmp     rbp, [rsp+0D98h+var_D78.a]
    mov     r15, [rsp+0D98h+opened_path]
    jnb     loc_5C7C25
loc_5C5DCD:
    mov     word ptr [rax+rbx+18h], 0A0Dh
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbp
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C5E0A
    cmp     qword ptr [r15], 0
    jz      short loc_5C5E0A
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0; bytes_max
    mov     rdi, r15; context
    mov     esi, 3; notifycode
    xor     edx, edx; severity
    xor     ecx, ecx; xmsg
    xor     r8d, r8d; xcode
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C5E0A:
    mov     rdi, [rsp+0D98h+ptr]; ptr
    mov     eax, [rdi+4]
    test    al, 40h
    mov     r15, [rsp+0D98h+var_D60]
    jnz     short loc_5C5E2E
    test    al, al
    js      short loc_5C5E29
    call    _efree
    jmp     short loc_5C5E2E
loc_5C5E29:
    call    free
loc_5C5E2E:
    mov     rdi, scratch; ptr
    call    _efree
    mov     scratch, [rsp+0D98h+bytes_max]
loc_5C5E3B:
    lea     rbp, file_globals
    test    r12b, 8
    mov     [rsp+0D98h+var_D60], r15
    jnz     loc_5C5F17
    cmp     qword ptr [rbp+28h], 0
    jz      loc_5C5F17
    mov     r13, r12
    mov     rax, [rsp+0D98h+var_D78.s]
    test    rax, rax
    jz      loc_5C7C40
    mov     rcx, [rax+10h]
    lea     r12, [rcx+6]
    cmp     r12, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7C46
loc_5C5E80:
    mov     word ptr [rax+rcx+1Ch], 203Ah
    mov     dword ptr [rax+rcx+18h], 6D6F7246h
    mov     rbx, [rsp+0D98h+var_D78.s]
    mov     [rbx+10h], r12
    mov     r15, [rbp+28h]
    mov     rdi, r15; s
    call    _strlen
    mov     r14, rax
    mov     rbp, rax
    test    rbx, rbx
    jz      loc_5C79BB
    mov     rbp, r14
    add     rbp, r12
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C79BB
loc_5C5EC4:
    lea     rdi, [rbx+r12]
    add     rdi, 18h; dest
    mov     rsi, r15; src
    mov     rdx, r14; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbp
    test    rax, rax
    jz      loc_5C7C61
    lea     rbx, [rbp+2]
    cmp     rbx, [rsp+0D98h+var_D78.a]
    mov     r12, r13
    mov     r15, [rsp+0D98h+var_D60]
    jnb     loc_5C7C6E
loc_5C5F00:
    mov     word ptr [rax+rbp+18h], 0A0Dh
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    lea     rbp, file_globals
loc_5C5F17:
    test    r12b, 2
    jnz     loc_5C5FE0
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     r13, r12
    test    rax, rax
    jz      loc_5C7C89
    mov     rcx, [rax+10h]
    lea     r15, [rcx+6]
    cmp     r15, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7C8F
loc_5C5F45:
    mov     word ptr [rax+rcx+1Ch], 203Ah
    mov     dword ptr [rax+rcx+18h], 74736F48h
    mov     r14, [rsp+0D98h+var_D78.s]
    mov     [r14+10h], r15
    mov     rax, [rsp+0D98h+theurl]
    mov     rbp, [rax+18h]
    add     rbp, 18h
    mov     rdi, rbp; s
    call    _strlen
    mov     r12, rax
    mov     rbx, rax
    test    r14, r14
    jz      loc_5C79D6
    mov     rbx, r12
    add     rbx, r15
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C79D6
loc_5C5F92:
    lea     rdi, [r14+r15]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r12; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    mov     rbp, [rsp+0D98h+theurl]
    movzx   ecx, word ptr [rbp+20h]
    cmp     [rsp+0D98h+var_D34], 0
    jz      short loc_5C6035
    test    cx, cx
    mov     r12, r13
    mov     r15, [rsp+0D98h+var_D60]
    jz      loc_5C6111
    movzx   ecx, cx
    cmp     ecx, 1BBh
    jz      loc_5C6111
    jmp     short loc_5C6050
loc_5C5FE0:
    test    r12b, 40h
    jnz     loc_5C614E
loc_5C5FEA:
    mov     rax, [rsp+0D98h+var_D78.s]
    test    rax, rax
    jz      loc_5C7CAA
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+13h]
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7CAF
loc_5C600B:
    movupd  xmm0, cs:xmmword_8B251A
    movupd  xmmword ptr [rax+rcx+18h], xmm0
    mov     dword ptr [rax+rcx+27h], 0A0D6573h
    mov     [rax+10h], rbx
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      loc_5C6181
    jmp     loc_5C6155
loc_5C6035:
    test    cx, cx
    mov     r12, r13
    mov     r15, [rsp+0D98h+var_D60]
    jz      loc_5C6111
    cmp     cx, 50h ; 'P'
    jz      loc_5C6111
loc_5C6050:
    test    rax, rax
    jz      loc_5C7DF2
    add     rbx, 1
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7DF7
loc_5C6068:
    mov     byte ptr [rbx+rax+17h], 3Ah ; ':'
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    movzx   ecx, word ptr [rbp+20h]
    lea     rbp, [rsp+0D98h+var_819]
    mov     [rsp+0D98h+var_819], 0
    mov     rsi, 0CCCCCCCCCCCCCCCDh
    mov     rbx, rbp
    nop     word ptr [rax+rax+00000000h]
loc_5C60A0:
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
    ja      short loc_5C60A0
    sub     rbp, rbx
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     r15, rbp
    test    rax, rax
    jz      loc_5C7D49
    mov     rcx, [rax+10h]
    lea     r15, [rcx+rbp]
    cmp     r15, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7D49
loc_5C60F0:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbx; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], r15
    mov     r15, [rsp+0D98h+var_D60]
loc_5C6111:
    test    rax, rax
    jz      loc_5C7CCA
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+2]
    cmp     rbx, [rsp+0D98h+var_D78.a]
    lea     rbp, file_globals
    jnb     loc_5C7CD6
loc_5C6134:
    mov     word ptr [rax+rcx+18h], 0A0Dh
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    test    r12b, 40h
    jz      loc_5C5FEA
loc_5C614E:
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C6181
loc_5C6155:
    lea     rsi, aHttp; "http"
    lea     rdx, aUserAgent; "user_agent"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    ua_zval, ua_zval
    jz      short loc_5C6181
    cmp     byte ptr [ua_zval+8], 6
    jnz     short loc_5C6181
    mov     rbp, [ua_zval]
    add     rbp, 18h
    jmp     short loc_5C6185
loc_5C6181:
    mov     rbp, [rbp+20h]
loc_5C6185:
    mov     r13, [rsp+0D98h+var_D20]
    test    r12b, 1
    mov     r14, [rsp+0D98h+opened_path]
    jnz     loc_5C625D
    test    ua_str, ua_str
    jz      loc_5C625D
    mov     rdi, ua_str; s
    call    _strlen
    lea     rbx, [rax+11h]
    cmp     ua_len, 12h
    jb      loc_5C625D
    mov     [rsp+0D98h+bytes_max], r12
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
    jz      short loc_5C623B
    movsxd  ua_str, eax
    mov     byte ptr [ua+ua_len], 0
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     r15, ua_len
    test    rax, rax
    jz      loc_5C7DBC
    mov     rcx, [rax+10h]
    lea     r15, [rcx+ua_len]
    cmp     r15, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7DBC
loc_5C6213:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, ua; src
    mov     rdx, ua_len; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], r15
    mov     r14, [rsp+0D98h+opened_path]
    mov     r15, [rsp+0D98h+var_D60]
    jmp     short loc_5C6250
loc_5C623B:
    lea     rdx, aCannotConstruc; "Cannot construct User-agent header"
    xor     edi, edi; docref
    mov     esi, 2; type
    xor     eax, eax
    call    php_error_docref
loc_5C6250:
    mov     rdi, ua; ptr
    call    _efree
    mov     ua, [rsp+0D98h+bytes_max]
loc_5C625D:
    test    r15, r15
    jz      loc_5C6433
    mov     eax, r12d
    and     eax, 10h
    shr     eax, 4
    mov     ecx, [rsp+0D98h+var_D44]
    xor     cl, 1
    or      cl, al
    jnz     loc_5C63B6
    lea     rsi, aHttp; "http"
    lea     rdx, aContent; "content"
    mov     rdi, r14; context
    call    php_stream_context_get_option
    test    rax, rax
    jz      loc_5C63B6
    mov     rbx, rax
    cmp     byte ptr [rax+8], 6
    jnz     loc_5C63B6
    mov     rax, [tmpzval]
    cmp     qword ptr [rax+10h], 0
    jz      loc_5C63B6
    mov     rax, [rsp+0D98h+var_D78.s]
    test    rax, rax
    jz      loc_5C7EAF
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+10h]
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7EB4
loc_5C62D9:
    movupd  xmm0, cs:xmmword_8B2562
    movupd  xmmword ptr [rax+rcx+18h], xmm0
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbp
    mov     rax, [tmpzval]
    mov     rcx, [rax+10h]
    lea     r15, [rsp+0D98h+var_819]
    mov     [rsp+0D98h+var_819], 0
    mov     rsi, 0CCCCCCCCCCCCCCCDh
    mov     tmpzval, r15
loc_5C6314:
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
    ja      short loc_5C6314
    sub     r15, rbx
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rbp, r15
    test    rax, rax
    jz      loc_5C7E3B
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+r15]
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7E3B
loc_5C6364:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbx; src
    mov     rdx, r15; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbp
    test    rax, rax
    jz      loc_5C7ECF
    lea     rbx, [rbp+2]
    cmp     rbx, [rsp+0D98h+var_D78.a]
    mov     r14, [rsp+0D98h+opened_path]
    mov     r15, [rsp+0D98h+var_D60]
    jnb     loc_5C7EDE
loc_5C63A2:
    mov     word ptr [rax+rbp+18h], 0A0Dh
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    or      r12d, 10h
loc_5C63B6:
    mov     rdi, r15; s
    call    _strlen
    mov     rbp, rax
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rbx, rbp
    test    rax, rax
    jz      loc_5C765F
    mov     rcx, [rax+10h]
    mov     rbx, rbp
    add     rbx, rcx
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C765F
loc_5C63E7:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, r15; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbx
    test    rax, rax
    jz      loc_5C7BBF
    lea     rbp, [rbx+2]
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7BC4
loc_5C641B:
    mov     word ptr [rax+rbx+18h], 0A0Dh
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbp
    mov     rdi, r15; ptr
    call    _efree
loc_5C6433:
    mov     rbp, [rsp+0D98h+var_CF8]
    mov     eax, [rsp+0D98h+var_D44]
    test    al, al
    jz      loc_5C666E
    lea     rsi, aHttp; "http"
    lea     rdx, aContent; "content"
    mov     rdi, r14; context
    call    php_stream_context_get_option
    test    rax, rax
    jz      loc_5C666E
    mov     rbx, rax
    cmp     byte ptr [rax+8], 6
    jnz     loc_5C666E
    mov     rax, [tmpzval]
    cmp     qword ptr [rax+10h], 0
    jz      loc_5C666E
    test    r12b, 10h
    jnz     loc_5C658B
    mov     rax, [rsp+0D98h+var_D78.s]
    test    rax, rax
    jz      loc_5C7EF9
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+10h]
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7EFE
loc_5C64AC:
    mov     r14, have_header
    movupd  xmm0, cs:xmmword_8B2562
    movupd  xmmword ptr [rax+rcx+18h], xmm0
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbp
    mov     rax, [tmpzval]
    mov     rcx, [rax+10h]
    lea     r15, [rsp+0D98h+var_819]
    mov     [rsp+0D98h+var_819], 0
    mov     rsi, 0CCCCCCCCCCCCCCCDh
    mov     rbp, r15
loc_5C64EA:
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
    ja      short loc_5C64EA
    sub     r15, rbp
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     have_header, r15
    test    rax, rax
    jz      loc_5C7E56
    mov     rcx, [rax+10h]
    lea     r12, [rcx+r15]
    cmp     r12, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7E56
loc_5C653A:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r15; n
    call    _memcpy
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], r12
    test    rax, rax
    jz      loc_5C7F19
    lea     rbp, [r12+2]
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7F1E
loc_5C656F:
    mov     word ptr [rax+r12+18h], 0A0Dh
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], rbp
    mov     rbp, [rsp+0D98h+var_CF8]
    mov     r12, r14
loc_5C658B:
    test    r12b, 20h
    jnz     short loc_5C65FC
    mov     r14, rbp
    mov     rax, [rsp+0D98h+var_D78.s]
    test    rax, rax
    jz      loc_5C7F39
    mov     rcx, [rax+10h]
    lea     rbp, [rcx+31h]
    cmp     rbp, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7F3E
loc_5C65B5:
    movups  xmm0, cs:xmmword_8B2593
    movups  xmmword ptr [rax+rcx+38h], xmm0
    movups  xmm0, cs:xmmword_8B2583
    movups  xmmword ptr [rax+rcx+28h], xmm0
    movupd  xmm0, cs:xmmword_8B2573
    movupd  xmmword ptr [rax+rcx+18h], xmm0
    mov     byte ptr [rax+rcx+48h], 0Ah
    mov     [rax+10h], rbp
    lea     rdx, aContentTypeNot; "Content-type not specified assuming app"...
    xor     edi, edi; docref
    mov     esi, 8; type
    xor     eax, eax
    call    php_error_docref
    mov     rbp, r14
loc_5C65FC:
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     r14, rbp
    test    rax, rax
    jz      loc_5C7E71
    mov     rcx, [rax+10h]
    lea     r15, [rcx+2]
    cmp     r15, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7E77
loc_5C6620:
    mov     word ptr [rax+rcx+18h], 0A0Dh
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     [rax+10h], r15
    mov     rbp, [tmpzval]
    mov     r12, [rbp+10h]
    add     rbp, 18h
    mov     tmpzval, r12
    test    rax, rax
    jz      loc_5C7DD7
    lea     rbx, [r12+r15]
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7DD7
loc_5C6656:
    lea     rdi, [rax+r15]
    add     rdi, 18h; dest
    mov     rsi, rbp; src
    mov     rdx, r12; n
    call    _memcpy
    mov     rbp, r14
    jmp     short loc_5C6696
loc_5C666E:
    mov     rax, [rsp+0D98h+var_D78.s]
    test    rax, rax
    jz      loc_5C7A22
    mov     rcx, [rax+10h]
    lea     rbx, [rcx+2]
    cmp     rbx, [rsp+0D98h+var_D78.a]
    jnb     loc_5C7A27
loc_5C668F:
    mov     word ptr [rax+rcx+18h], 0A0Dh
loc_5C6696:
    mov     rsi, [rsp+0D98h+var_D78.s]
    mov     [rsi+10h], rbx
    add     rsi, 18h; buf
    mov     rdi, r13; stream
    mov     rdx, rbx; count
    call    _php_stream_write
    mov     [rsp+0D98h+buf], 0
    mov     rax, [rsp+0D98h+arg_8]
    cmp     byte ptr [rax+8], 0
    jnz     short loc_5C66DB
    call    _zend_new_array_0
    mov     rcx, [rsp+0D98h+arg_8]
    mov     [rcx], __arr
    mov     dword ptr [rcx+8], 307h
loc_5C66DB:
    and     [rsp+0D98h+var_D04], 0Ch
    mov     rdi, r13; stream
    call    _php_stream_eof
    test    eax, eax
    jz      short loc_5C672D
loc_5C66EF:
    mov     rdi, r13; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    lea     rdx, aHttpRequestFai; "HTTP request failed!"
    xor     r15d, r15d
    mov     rdi, rbp; wrapper
    mov     esi, [rsp+0D98h+var_D64]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    xor     ebp, ebp
    xor     r12d, r12d
    xor     ebx, ebx
    mov     r14, [rsp+0D98h+src]
    mov     r13, [rsp+0D98h+var_CF0]
    jmp     out
loc_5C672D:
    lea     rsi, [rsp+0D98h+s1]; buf
    lea     rcx, [rsp+0D98h+returned_len]; returned_len
    mov     edx, 7Fh; maxlen
    mov     rdi, r13; stream
    call    _php_stream_get_line
    test    rax, rax
    jz      short loc_5C66EF
    xor     r15d, r15d
    cmp     [rsp+0D98h+returned_len], 0Ah
    jb      short loc_5C676D
    lea     rdi, [rsp+0D98h+nptr]; nptr
    call    _atoi
    mov     r15d, eax
loc_5C676D:
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C67A0
    lea     rsi, aHttp; "http"
    lea     rdx, aIgnoreErrors; "ignore_errors"
    mov     rdi, [rsp+0D98h+opened_path]; context
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C67A0
    mov     rdi, tmpzval; op
    call    zend_is_true
    test    eax, eax
    setnz   al
    jmp     short loc_5C67A2
loc_5C67A0:
    xor     eax, eax
loc_5C67A2:
    mov     dword ptr [rsp+0D98h+ptr], eax
    movzx   ecx, al
    mov     eax, [rsp+0D98h+var_D64]
    shr     eax, 9
    and     eax, 1
    mov     [rsp+0D98h+var_CDC], eax
    or      ecx, eax
    mov     [rsp+0D98h+var_D44], ecx
    cmp     r15d, 65h ; 'e'
    jz      short loc_5C680D
    lea     eax, [response_code-64h]
    cmp     eax, 63h ; 'c'
    ja      short loc_5C680D
    mov     r12, rbp
    mov     rdi, r13; stream
    call    _php_stream_eof
    test    eax, eax
    jz      loc_5C69CF
loc_5C67E5:
    mov     rbp, [rsp+0D98h+returned_len]
loc_5C67ED:
    xor     r15d, r15d
    cmp     tmp_line_len, 0Ah
    jb      loc_5C6A46
    lea     rdi, [rsp+0D98h+nptr]; nptr
    call    _atoi
    mov     r15d, eax
    mov     tmp_line_len, r12
loc_5C680D:
    lea     eax, [response_code-0C8h]
    cmp     eax, 0C8h
    jnb     short loc_5C6828
    mov     [rsp+0D98h+var_D44], 1
    jmp     loc_5C6A93
loc_5C6828:
    cmp     r15d, 193h
    jnz     loc_5C6A3B
    mov     r15d, 193h
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      loc_5C6A93
    mov     rdi, [rsp+0D98h+opened_path]
    cmp     qword ptr [rdi], 0
    jz      loc_5C6A93
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0
    lea     rcx, [rsp+0D98h+s1]
    mov     r15d, 193h
    mov     esi, 0Ah
    mov     edx, 2
    mov     r8d, 193h
    jmp     loc_5C6A86
loc_5C6881:
    test    rax, rax
    jz      short loc_5C68ED
    mov     rcx, [rax+10h]
    mov     byte ptr [rax+rcx+18h], 0
    mov     rdi, qword ptr [rsp+0D98h+buf]; str
    test    rdi, rdi
    jz      short loc_5C68ED
    xor     esi, esi; what
    xor     edx, edx; what_len
    mov     ecx, 3; mode
    call    php_trim
    mov     rbp, rax
    mov     rdi, qword ptr [rsp+0D98h+buf]; ptr
    test    rdi, rdi
    jz      short loc_5C68D7
    mov     eax, [rdi+4]
    test    al, 40h
    jnz     short loc_5C68CB
    add     dword ptr [rdi], 0FFFFFFFFh
    jnz     short loc_5C68CB
    call    _efree
loc_5C68CB:
    mov     qword ptr [rsp+0D98h+buf], 0
loc_5C68D7:
    mov     qword ptr [rsp+0D98h+buf+8], 0
    test    tmp, tmp
    jnz     short loc_5C68F8
    jmp     loc_5C5C7E
loc_5C68ED:
    xor     ebp, ebp
    test    tmp, tmp
    jz      loc_5C5C7E
loc_5C68F8:
    mov     rsi, [tmp+10h]; length
    test    rsi, rsi
    jz      loc_5C6992
    lea     r14, [tmp+18h]
    mov     rdi, r14; s
    call    _estrndup
    mov     r15, rax
    test    byte ptr [tmp+4], 40h
    jnz     loc_5C7047
    mov     eax, [tmp+0]
    cmp     eax, 2
    jb      loc_5C708F
    add     eax, 0FFFFFFFFh
    mov     [tmp+0], eax
    mov     tmp, [tmp+10h]
    lea     rdi, [rbp+20h]
    and     rdi, 0FFFFFFFFFFFFFFF8h; size
    call    _emalloc
    mov     rbx, rax
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
    mov     rbp, tmp
    jmp     loc_5C708C
loc_5C697C:
    mov     word ptr [resource+20h], 1BBh
    mov     r13b, 1
    mov     [rsp+0D98h+var_D34], 1
    jmp     loc_5C4DE4
loc_5C6992:
    xor     r12d, r12d
    xor     r15d, r15d
    jmp     loc_5C75F9
loc_5C699D:
    cmp     rbp, 4
    jz      loc_5C7445
    cmp     rbp, 3
    jnz     loc_5C7452
    movzx   eax, word ptr [rbx+18h]
    xor     eax, 4547h
    movzx   ecx, byte ptr [rbx+1Ah]
    xor     ecx, 54h
    or      cx, ax
    jnz     loc_5C7452
    jmp     loc_5C573A
loc_5C69CF:
    lea     rbx, [rsp+0D98h+s1]
    lea     r14, [rsp+0D98h+returned_len]
    lea     response_code, aHttp1; "HTTP/1"
    jmp     short loc_5C69F8
loc_5C69E8:
    mov     rdi, r13; stream
    call    _php_stream_eof
    test    eax, eax
    jnz     loc_5C67E5
loc_5C69F8:
    mov     edx, 7Fh; maxlen
    mov     rdi, r13; stream
    mov     rsi, rbx; buf
    mov     rcx, r14; returned_len
    call    _php_stream_get_line
    test    rax, rax
    jz      loc_5C67E5
    mov     rbp, [rsp+0D98h+returned_len]
    cmp     tmp_line_len, 6
    jb      short loc_5C69E8
    mov     edx, 6; n
    mov     rdi, rbx; s1
    mov     rsi, r15; s2
    call    _strncasecmp
    test    eax, eax
    jnz     short loc_5C69E8
    jmp     loc_5C67ED
loc_5C6A3B:
    mov     r12, rbp
    mov     rbp, [rsp+0D98h+returned_len]
loc_5C6A46:
    test    tmp_line_len, tmp_line_len
    jnz     short loc_5C6A53
    mov     [rsp+0D98h+s1], 0
loc_5C6A53:
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C6A90
    mov     rdi, [rsp+0D98h+opened_path]; context
    cmp     qword ptr [rdi], 0
    mov     tmp_line_len, r12
    jz      short loc_5C6A93
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0; bytes_max
    lea     rcx, [rsp+0D98h+s1]; xmsg
    mov     esi, 9; notifycode
    mov     edx, 2; severity
    mov     r8d, r15d; xcode
loc_5C6A86:
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
    jmp     short loc_5C6A93
loc_5C6A90:
    mov     tmp_line_len, r12
loc_5C6A93:
    mov     rax, [rsp+0D98h+returned_len]
    mov     r14, rbp
    test    tmp_line_len, tmp_line_len
    jz      short loc_5C6AD9
    cmp     byte ptr [rsp+tmp_line_len+0D98h+optionvalue.u2+3], 0Ah
    jnz     short loc_5C6AD4
    mov     rbp, tmp_line_len
    add     rbp, 0FFFFFFFFFFFFFFFFh
    mov     [rsp+0D98h+returned_len], tmp_line_len
    jz      short loc_5C6AD9
    cmp     byte ptr [rsp+rax+0D98h+optionvalue.u2+2], 0Dh
    jnz     short loc_5C6ADB
    add     rax, 0FFFFFFFFFFFFFFFEh
    mov     [rsp+0D98h+returned_len], tmp_line_len
loc_5C6AD4:
    mov     rbp, tmp_line_len
    jmp     short loc_5C6ADB
loc_5C6AD9:
    xor     ebp, ebp
loc_5C6ADB:
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
    mov     rdi, r13; stream
    call    _php_stream_eof
    test    eax, eax
    jz      short loc_5C6B77
    mov     al, 1
    mov     dword ptr [rsp+0D98h+var_D60], eax
    xor     r15d, r15d
    xor     eax, eax
    mov     [rsp+0D98h+bytes_max], rax
    xor     r12d, r12d
    mov     tmp_line_len, r14
    mov     r14, [rsp+0D98h+var_D00]
    jmp     loc_5C6F21
loc_5C6B77:
    mov     eax, [rsp+0D98h+var_D64]
    and     eax, 200h
    mov     [rsp+0D98h+var_CE0], eax
    mov     eax, r15d
    and     eax, 0FFFFFFFCh
    cmp     eax, 12Ch
    setz    al
    add     r15d, 0FFFFFECDh
    cmp     r15d, 2
    setb    cl
    or      cl, al
    mov     [rsp+0D98h+var_D12], cl
    mov     al, 1
    mov     dword ptr [rsp+0D98h+var_D60], eax
    xor     r12d, r12d
    xor     eax, eax
    mov     [rsp+0D98h+bytes_max], rax
    xor     r13d, r13d
    mov     tmp_line_len, r14
    mov     r14, [rsp+0D98h+var_D00]
loc_5C6BCA:
    test    http_header_line, http_header_line
    jz      short loc_5C6BD7
    mov     rdi, http_header_line; ptr
    call    _efree
loc_5C6BD7:
    mov     rdi, [rsp+0D98h+var_D20]; stream
    xor     esi, esi; buf
    xor     edx, edx; maxlen
    lea     rcx, [rsp+0D98h+returned_len]; returned_len
    call    _php_stream_get_line
    mov     http_header_line, rax
    test    rax, rax
    jz      loc_5C6F1E
    mov     al, [http_header_line]
    cmp     al, 0Ah
    jz      loc_5C6F1E
    cmp     al, 0Dh
    jz      loc_5C6F1E
    mov     rax, [rsp+0D98h+returned_len]
    lea     rbx, [http_header_line+http_header_line_length]
    add     rbx, 0FFFFFFFFFFFFFFFFh
    cmp     e, http_header_line
    jnb     short loc_5C6C39
    jmp     short loc_5C6C54
loc_5C6C30:
    add     e, 0FFFFFFFFFFFFFFFFh
    cmp     e, http_header_line
    jb      short loc_5C6C54
loc_5C6C39:
    movzx   eax, byte ptr [e]
    cmp     al, 0Dh
    jz      short loc_5C6C30
    cmp     al, 0Ah
    jz      short loc_5C6C30
    jmp     short loc_5C6C54
loc_5C6C50:
    add     e, 0FFFFFFFFFFFFFFFFh
loc_5C6C54:
    cmp     e, http_header_line
    jb      short loc_5C6C64
    movzx   eax, byte ptr [e]
    cmp     al, 20h ; ' '
    jz      short loc_5C6C50
    cmp     al, 9
    jz      short loc_5C6C50
loc_5C6C64:
    lea     rbp, [e+1]
    mov     byte ptr [rbx+1], 0
    mov     rdx, e
    sub     rdx, http_header_line; n
    mov     [rsp+0D98h+returned_len], http_header_line_length
    mov     rdi, http_header_line; s
    mov     esi, 3Ah ; ':'; c
    call    _memchr
    test    http_header_value, http_header_value
    jz      short loc_5C6CBE
    cmp     http_header_value, rbx
    jb      short loc_5C6CA9
    jmp     short loc_5C6CB7
loc_5C6CA0:
    add     rax, 1
    cmp     rbx, rax
    jz      short loc_5C6CB7
loc_5C6CA9:
    movzx   ecx, byte ptr [http_header_value+1]
    cmp     cl, 20h ; ' '
    jz      short loc_5C6CA0
    cmp     cl, 9
    jz      short loc_5C6CA0
loc_5C6CB7:
    add     rax, 1
    mov     e, rax
loc_5C6CBE:
    mov     edx, 9; n
    mov     rdi, http_header_line; s1
    lea     rsi, aLocation; "Location:"
    call    _strncasecmp
    test    eax, eax
    jz      loc_5C6DB4
    mov     edx, 0Dh; n
    mov     rdi, http_header_line; s1
    lea     rsi, aContentType_0; "Content-Type:"
    call    _strncasecmp
    test    eax, eax
    jz      loc_5C6E1D
    mov     edx, 0Fh; n
    mov     rdi, http_header_line; s1
    lea     rsi, aContentLength; "Content-Length:"
    call    _strncasecmp
    test    eax, eax
    jz      loc_5C6E44
    mov     edx, 12h; n
    mov     rdi, http_header_line; s1
    lea     rsi, aTransferEncodi; "Transfer-Encoding:"
    call    _strncasecmp
    test    eax, eax
    jnz     loc_5C6E8C
    mov     edx, 7; n
    mov     rdi, http_header_value; s1
    lea     rsi, aChunked; "Chunked"
    call    _strncasecmp
    or      eax, [rsp+0D98h+var_CE0]
    jnz     loc_5C6E8C
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C6D83
    mov     rdi, [rsp+0D98h+opened_path]; context
    lea     rsi, aHttp; "http"
    lea     rdx, aAutoDecode; "auto_decode"
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C6D83
    mov     rdi, tmpzval; op
    call    zend_is_true
    test    eax, eax
    jz      loc_5C6E8C
loc_5C6D83:
    mov     rax, [rsp+0D98h+var_D20]
    movzx   edx, byte ptr [rax+60h]
    and     edx, 1; persistent
    lea     rdi, aDechunk; "dechunk"
    xor     esi, esi; filterparams
    call    php_stream_filter_create
    mov     r15, rax
    mov     r13d, 0
    test    rax, rax
    jnz     loc_5C6EFF
    jmp     loc_5C6E8C
loc_5C6DB4:
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C6DEB
    mov     rdi, [rsp+0D98h+opened_path]; context
    lea     rsi, aHttp; "http"
    lea     rdx, aFollowLocation; "follow_location"
    call    php_stream_context_get_option
    test    tmpzval, tmpzval
    jz      short loc_5C6DEB
    mov     rdi, tmpzval; op
    call    zend_is_true
    test    eax, eax
    setnz   al
    mov     dword ptr [rsp+0D98h+var_D60], eax
    jmp     short loc_5C6E06
loc_5C6DEB:
    mov     ecx, dword ptr [rsp+0D98h+var_D60]
    movzx   ecx, cl
    cmp     [rsp+0D98h+var_D12], 0
    mov     eax, 0
    cmovz   ecx, eax
    mov     dword ptr [rsp+0D98h+var_D60], ecx
loc_5C6E06:
    mov     edx, 400h; siz
    lea     rdi, [rsp+0D98h+buf]; dst
    mov     rsi, http_header_value; src
    call    php_strlcpy
    jmp     short loc_5C6E8C
loc_5C6E1D:
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C6E8C
    mov     rdi, [rsp+0D98h+opened_path]
    cmp     qword ptr [rdi], 0
    jz      short loc_5C6E8C
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0
    mov     esi, 4
    xor     edx, edx
    mov     rcx, http_header_value
    jmp     short loc_5C6E81
loc_5C6E44:
    mov     rdi, http_header_value; nptr
    call    _atoi
    cdqe
    mov     [rsp+0D98h+bytes_max], rax
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C6E8C
    mov     rdi, [rsp+0D98h+opened_path]; context
    cmp     qword ptr [rdi], 0
    jz      short loc_5C6E8C
    mov     rax, [rsp+0D98h+bytes_max]
    mov     [rsp+0D98h+error_string], rax; bytes_max
    mov     [rsp+0D98h+error_string+8], 0; ptr
    mov     esi, 5; notifycode
    xor     edx, edx; severity
    mov     rcx, http_header_line; xmsg
loc_5C6E81:
    xor     r8d, r8d; xcode
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C6E8C:
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
    mov     dword ptr [rsp+0D98h+str.a], 106h
    mov     rax, [rsp+0D98h+arg_8]
    mov     rdi, [rax]; ht
    lea     rsi, [rsp+0D98h+str]; pData
    call    zend_hash_next_index_insert
    mov     r15, transfer_encoding
loc_5C6EFF:
    mov     rdi, [rsp+0D98h+var_D20]; stream
    call    _php_stream_eof
    mov     r13, transfer_encoding
    test    eax, eax
    mov     rbp, [rsp+0D98h+var_CF8]
    jz      loc_5C6BCA
    jmp     short loc_5C6F21
loc_5C6F1E:
    mov     r15, transfer_encoding
loc_5C6F21:
    cmp     [rsp+0D98h+var_D44], 0
    mov     eax, dword ptr [rsp+0D98h+ptr]
    jz      short loc_5C6F56
    test    byte ptr [rsp+0D98h+var_D60], 1
    mov     rbx, [rsp+0D98h+var_D20]
    mov     r13, [rsp+0D98h+var_CF0]
    jz      loc_5C726C
    cmp     [rsp+0D98h+buf], 0
    jnz     short loc_5C6F6E
    jmp     loc_5C726C
loc_5C6F56:
    test    byte ptr [rsp+0D98h+var_D60], 1
    mov     rbx, [rsp+0D98h+var_D20]
    mov     r13, [rsp+0D98h+var_CF0]
    jz      loc_5C726C
loc_5C6F6E:
    test    al, al
    setnz   al
    cmp     r14d, 1
    jg      short loc_5C6F88
    mov     ecx, [rsp+0D98h+var_CDC]
    or      cl, al
    jnz     loc_5C726C
loc_5C6F88:
    cmp     [rsp+0D98h+buf], 0
    setz    al
    or      [rsp+0D98h+var_D11], al
    jnz     short loc_5C6FCF
    mov     rax, [rsp+0D98h+opened_path]
    cmp     qword ptr [rax], 0
    jz      short loc_5C6FCF
    xorpd   xmm0, xmm0
    movupd  xmmword ptr [rsp+0D98h+error_string], xmm0; bytes_max
    lea     rcx, [rsp+0D98h+buf]; xmsg
    mov     rdi, [rsp+0D98h+opened_path]; context
    mov     esi, 6; notifycode
    xor     edx, edx; severity
    xor     r8d, r8d; xcode
    xor     r9d, r9d; bytes_sofar
    call    php_stream_notification_notify
loc_5C6FCF:
    mov     rdi, rbx; stream
    mov     esi, 3; close_options
    call    _php_stream_free
    test    transfer_encoding, transfer_encoding
    jz      short loc_5C6FE9
    mov     rdi, transfer_encoding; filter
    call    php_stream_filter_free
loc_5C6FE9:
    mov     bl, [rsp+0D98h+buf]
    test    bl, bl
    jz      loc_5C724A
    mov     byte ptr [rsp+0D98h+str.s], 0
    lea     rdi, [rsp+0D98h+buf]; s
    call    _strlen
    cmp     rax, 8
    jnb     loc_5C73A9
loc_5C7017:
    cmp     bl, 2Fh ; '/'
    jnz     loc_5C745B
    lea     rdi, [rsp+0D98h+returned_len]; dst
    lea     rsi, [rsp+0D98h+buf]; src
    mov     edx, 400h; siz
    call    php_strlcpy
    lea     r15, [rsp+0D98h+returned_len]
    jmp     loc_5C7740
loc_5C7047:
    mov     rbx, [tmp+10h]
    lea     rdi, [rbx+20h]
    and     rdi, 0FFFFFFFFFFFFFFF8h; size
    call    _emalloc
    mov     tmp, rax
    mov     rax, 1600000001h
    mov     [tmp+0], rax
    mov     qword ptr [tmp+8], 0
    mov     [tmp+10h], rbx
    lea     rdi, [tmp+18h]; dest
    mov     rsi, r14; src
    mov     rdx, rbx; n
    call    _memcpy
    lea     rax, [rbx+tmp]
    add     rax, 18h
loc_5C708C:
    mov     byte ptr [rax], 0
loc_5C708F:
    lea     r14, [tmp+18h]
    mov     [rsp+0D98h+var_D60], tmp
    mov     rsi, [rbp+10h]; len
    mov     rdi, t; s
    call    php_strtolower
    mov     eax, [rsp+0D98h+redirect_max_0]
    test    al, 1
    jnz     short loc_5C70D3
    lea     rdx, lc_header_name; "content-length:"
    mov     rdi, user_headers; header_bag
    mov     rsi, t; lc_header_bag
    call    strip_header
    lea     rdx, aContentType_1; "content-type:"
    mov     rdi, user_headers; header_bag
    mov     rsi, t; lc_header_bag
    call    strip_header
loc_5C70D3:
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
    lea     rsi, aContentType_1; "content-type:"
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
    jz      loc_5C75EF
    cmp     dword ptr [rsp+0D98h+bytes_max], 0
    mov     rbp, [rsp+0D98h+var_D60]
    jz      loc_5C75F4
    lea     rsi, aProxy; "proxy-"
    mov     rdi, t; haystack
    call    _strstr
    test    s, s
    jz      loc_5C75F4
    cmp     s, t
    jz      short loc_5C71BA
    cmp     byte ptr [s-1], 0Ah
    jnz     loc_5C75F4
loc_5C71BA:
    mov     rbp, s
    cmp     s, t
    ja      short loc_5C71CD
    jmp     short loc_5C71DB
loc_5C71C4:
    add     s, 0FFFFFFFFFFFFFFFFh
    cmp     s, t
    jbe     short loc_5C71DB
loc_5C71CD:
    movzx   ecx, byte ptr [s-1]
    cmp     cl, 20h ; ' '
    jz      short loc_5C71C4
    cmp     cl, 9
    jz      short loc_5C71C4
loc_5C71DB:
    add     rax, 14h
    mov     edx, 2401h
    jmp     short loc_5C71EA
loc_5C71E6:
    add     p, 1
loc_5C71EA:
    movzx   ecx, byte ptr [p]
    cmp     rcx, 0Dh
    ja      short loc_5C71E6
    bt      rdx, rcx
    jnb     short loc_5C71E6
    jmp     short loc_5C7203
loc_5C71FB:
    movzx   ecx, byte ptr [p+1]
    add     p, 1
loc_5C7203:
    cmp     cl, 0Ah
    jz      short loc_5C71FB
    cmp     cl, 0Dh
    jz      short loc_5C71FB
    mov     rbx, have_header
    test    cl, cl
    jnz     loc_5C74AF
    cmp     s, t
    jz      loc_5C75E1
    mov     have_header, rbx
    ja      short loc_5C7231
    jmp     short loc_5C723D
loc_5C7228:
    add     s, 0FFFFFFFFFFFFFFFFh
    cmp     s, t
    jbe     short loc_5C723D
loc_5C7231:
    movzx   eax, byte ptr [s-1]
    cmp     al, 0Dh
    jz      short loc_5C7228
    cmp     al, 0Ah
    jz      short loc_5C7228
loc_5C723D:
    sub     s, t
    mov     byte ptr [user_headers+rbp], 0
    jmp     loc_5C75EF
loc_5C724A:
    lea     rdx, aHttpRequestFai_0; "HTTP request failed! %s"
    xor     r15d, r15d
    lea     rcx, [rsp+0D98h+s1]
    mov     rdi, rbp; wrapper
    mov     esi, [rsp+0D98h+var_D64]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    xor     ebx, ebx
loc_5C726C:
    mov     r14, [rsp+0D98h+src]
loc_5C7271:
    mov     rbp, [rsp+0D98h+bytes_max]
    mov     rdi, [rsp+0D98h+var_D78.s]; ptr
    test    rdi, rdi
    jz      short loc_5C729A
    mov     eax, [rdi+4]
    test    al, 40h
    jnz     short loc_5C7291
    add     dword ptr [rdi], 0FFFFFFFFh
    jnz     short loc_5C7291
    call    _efree
loc_5C7291:
    mov     [rsp+0D98h+var_D78.s], 0
loc_5C729A:
    mov     [rsp+0D98h+var_D78.a], 0
    test    http_header_line, http_header_line
    jz      short loc_5C72B0
    mov     rdi, http_header_line; ptr
    call    _efree
loc_5C72B0:
    mov     rdi, [rsp+0D98h+theurl]; theurl
    test    rdi, rdi
    jz      short loc_5C72BF
    call    php_url_free
loc_5C72BF:
    test    stream, stream
    jz      loc_5C7392
    mov     eax, [rsp+0D98h+redirect_max_0]
    test    al, 1
    jz      short loc_5C72F6
    mov     rax, [rsp+0D98h+arg_8]
    mov     rcx, rax
    mov     rax, [rax]
    mov     ecx, [_z2+8]
    mov     [stream+50h], _gc
    mov     [stream+58h], ecx
    test    ecx, 0FF00h
    jz      short loc_5C72F6
    add     dword ptr [_gc], 1
loc_5C72F6:
    cmp     byte ptr [rsp+0D98h+var_D28], 0
    jz      short loc_5C7340
    mov     rax, [rsp+0D98h+opened_path]
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_5C7340
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
loc_5C7340:
    test    byte ptr [rsp+0D98h+var_D64], 20h
    jz      short loc_5C7359
    mov     rdi, stream; stream
    mov     esi, 5; option
    mov     edx, r13d; value
    xor     ecx, ecx; ptrparam
    call    _php_stream_set_option
loc_5C7359:
    mov     eax, [rsp+0D98h+var_D04]
    or      [stream+74h], eax
    mov     qword ptr [stream+98h], 0
    lea     rdi, [stream+61h]; dst
    mov     edx, 10h; siz
    mov     rsi, r14; src
    call    php_strlcpy
    test    transfer_encoding, transfer_encoding
    jz      short loc_5C7394
    lea     rdi, [stream+10h]; chain
    mov     rsi, transfer_encoding; filter
    call    _php_stream_filter_append
    jmp     short loc_5C7394
loc_5C7392:
    xor     ebx, ebx
loc_5C7394:
    mov     rax, rbx
    add     rsp, 0D68h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_5C73A9:
    lea     rsi, aHttp_0; "http://"
    lea     rdi, [rsp+0D98h+buf]; s1
    mov     edx, 7; n
    call    _strncasecmp
    test    eax, eax
    jz      short loc_5C7421
    lea     rsi, aHttps_0; "https://"
    lea     rdi, [rsp+0D98h+buf]; s1
    mov     edx, 8; n
    call    _strncasecmp
    test    eax, eax
    jz      short loc_5C7421
    lea     rsi, aFtp_0; "ftp://"
    lea     rdi, [rsp+0D98h+buf]; s1
    mov     edx, 6; n
    call    _strncasecmp
    test    eax, eax
    jz      short loc_5C7421
    lea     rsi, aFtps; "ftps://"
    lea     rdi, [rsp+0D98h+buf]; s1
    mov     edx, 7; n
    call    _strncasecmp
    test    eax, eax
    jnz     loc_5C7017
loc_5C7421:
    lea     rdi, [rsp+0D98h+str]; dst
    lea     rsi, [rsp+0D98h+buf]; src
    mov     edx, 400h; siz
    call    php_strlcpy
    mov     rbx, [rsp+0D98h+theurl]
    jmp     loc_5C77CD
loc_5C7445:
    cmp     dword ptr [rbx+18h], 44414548h
    jz      loc_5C573A
loc_5C7452:
    mov     ebx, [rsp+0D98h+var_D44]
    jmp     loc_5C57A0
loc_5C745B:
    mov     rbx, rbp
    cmp     [rsp+0D98h+buf+1], 0
    lea     r15, [rsp+0D98h+returned_len]
    jz      short loc_5C74DA
    mov     rax, [rsp+0D98h+theurl]
    mov     rbp, [rax+28h]
    test    rbp, rbp
    jz      short loc_5C74DA
    lea     r14, [rbp+18h]
    mov     rdi, s; s
    mov     esi, 2Fh ; '/'; c
    call    _strrchr
    test    s, s
    jnz     loc_5C76EC
    cmp     qword ptr [rbp+10h], 0
    jz      loc_5C7695
    mov     byte ptr [r14], 2Fh ; '/'
    mov     s, r14
    jmp     loc_5C76EC
loc_5C74AF:
    sub     s, t
    add     rbp, user_headers
    mov     have_header, p
    sub     r12, t
    add     r12, user_headers
    mov     rdi, p; s
    call    _strlen
    lea     rdx, [rax+1]; n
    mov     rdi, rbp; dest
    mov     rsi, r12; src
    call    _memmove
    jmp     loc_5C75EC
loc_5C74DA:
    lea     rdx, aGlobS+6; format
    lea     rdi, [rsp+0D98h+returned_len]; buf
    lea     rcx, [rsp+0D98h+buf]
    mov     esi, 3FFh; len
    xor     eax, eax
    call    ap_php_snprintf
    mov     rbp, rbx
    jmp     loc_5C7740
loc_5C7505:
    mov     eax, 2401h
    mov     r15, [rsp+0D98h+opened_path]
    mov     _z, [rsp+0D98h+var_D20]
    jmp     short loc_5C751A
loc_5C7516:
    add     p, 1
loc_5C751A:
    movzx   ecx, byte ptr [p]
    cmp     rcx, 0Dh
    ja      short loc_5C7516
    bt      rax, rcx
    jnb     short loc_5C7516
    sub     p, s
    mov     rax, [rsp+0D98h+str.s]
    mov     r12, rbx
    test    rax, rax
    jz      loc_5C7F59
    mov     rcx, [rax+10h]
    lea     r12, [rcx+rbx]
    cmp     r12, [rsp+0D98h+str.a]
    jnb     loc_5C7F59
loc_5C7556:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, s; src
    mov     rdx, rbx; n
    call    _memcpy
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], r12
    test    rax, rax
    jz      loc_5C7F7A
    lea     rbx, [r12+2]
    cmp     rbx, [rsp+0D98h+str.a]
    jnb     loc_5C7F7F
loc_5C7591:
    mov     word ptr [rax+r12+18h], 0A0Dh
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    test    rax, rax
    jnz     loc_5C54DD
loc_5C75AE:
    mov     ebx, 2
    mov     r14, [rsp+0D98h+var_CF8]
    mov     rbp, [rsp+0D98h+src]
loc_5C75C0:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C5500
loc_5C75E1:
    mov     rdi, user_headers; ptr
    call    _efree
    xor     r15d, r15d
loc_5C75EC:
    mov     r12, rbx
loc_5C75EF:
    mov     rbp, [rsp+0D98h+var_D60]
loc_5C75F4:
    test    rbp, rbp
    jz      short loc_5C760E
loc_5C75F9:
    mov     eax, [rbp+4]
    test    al, 40h
    jnz     short loc_5C760E
    add     dword ptr [rbp+0], 0FFFFFFFFh
    jnz     short loc_5C760E
    mov     rdi, rbp; ptr
    call    _efree
loc_5C760E:
    test    r12b, 4
    jz      loc_5C5C84
    jmp     loc_5C5E3B
loc_5C761D:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     r14, [rsp+0D98h+str.s]
    mov     r12, [r14+10h]
    jmp     loc_5C519D
loc_5C763E:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C5276
loc_5C765F:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C63E7
loc_5C767A:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rbp, [rsp+0D98h+var_D78.s]
    mov     r14, [rbp+10h]
    jmp     loc_5C5D94
loc_5C7695:
    mov     eax, [rbp+4]
    test    al, 40h
    jnz     short loc_5C76AA
    add     dword ptr [rbp+0], 0FFFFFFFFh
    jnz     short loc_5C76AA
    mov     rdi, rbp; ptr
    call    _efree
loc_5C76AA:
    call    _emalloc_32
    mov     rcx, 1600000001h
    mov     [rax], rcx
    movapd  xmm0, cs:xmmword_7CACC0
    movupd  xmmword ptr [rax+8], xmm0
    mov     word ptr [rax+18h], 2Fh ; '/'
    mov     rcx, [rsp+0D98h+theurl]
    mov     [rcx+28h], rax
    add     rax, 18h
    mov     r13, [rsp+0D98h+var_CF0]
    lea     r15, [rsp+0D98h+returned_len]
loc_5C76EC:
    mov     byte ptr [s+1], 0
    mov     s, [rsp+0D98h+theurl]
    mov     rcx, [rax+28h]
    test    rcx, rcx
    jz      short loc_5C770E
    cmp     byte ptr [rcx+18h], 2Fh ; '/'
    jnz     short loc_5C770E
    cmp     byte ptr [rcx+19h], 0
    jz      loc_5C79F1
loc_5C770E:
    add     rcx, 18h
    lea     rdx, aSS_4; "%s/%s"
loc_5C7719:
    lea     rdi, [rsp+0D98h+returned_len]; buf
    lea     r8, [rsp+0D98h+buf]
    mov     esi, 3FFh; len
    xor     eax, eax
    call    ap_php_snprintf
    mov     rbp, rbx
    mov     r14, [rsp+0D98h+var_D00]
loc_5C7740:
    mov     rax, [rsp+0D98h+theurl]
    movzx   r9d, word ptr [rax+20h]
    cmp     [rsp+0D98h+var_D34], 0
    jz      short loc_5C7793
    cmp     r9d, 1BBh
    jnz     short loc_5C779A
loc_5C775A:
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
    jmp     short loc_5C77CD
loc_5C7793:
    cmp     r9w, 50h ; 'P'
    jz      short loc_5C775A
loc_5C779A:
    mov     rbx, [rsp+0D98h+theurl]
    mov     rcx, [rbx]
    mov     r8, [rbx+18h]
    add     rcx, 18h
    add     r8, 18h
    mov     [rsp+0D98h+error_string], r15
    lea     rdx, aSSDS; "%s://%s:%d%s"
    lea     rdi, [rsp+0D98h+str]; buf
    mov     esi, 3FFh; len
    xor     eax, eax
    call    ap_php_snprintf
loc_5C77CD:
    mov     rdi, rbx; theurl
    call    php_url_free
    lea     rdi, [rsp+0D98h+str]; str
    call    php_url_parse
    mov     [rsp+0D98h+theurl], resource
    test    rax, rax
    jz      loc_5C7979
    mov     r15, rbp
    lea     rsi, aHttp_0; "http://"
    lea     rdi, [rsp+0D98h+str]; s1
    mov     edx, 7; n
    call    _strncasecmp
    test    eax, eax
    jnz     short loc_5C7831
    lea     rsi, aHttps_0; "https://"
    lea     rdi, [rsp+0D98h+str]; s1
    mov     edx, 8; n
    call    _strncasecmp
    test    eax, eax
    jz      loc_5C7932
loc_5C7831:
    mov     rax, [rsp+0D98h+theurl]
    mov     rdi, [rax+8]
    test    rdi, rdi
    jz      short loc_5C7888
    mov     rsi, [rdi+10h]; len
    add     rdi, 18h; str
    call    php_url_decode
    mov     rcx, [rsp+0D98h+theurl]
    mov     rbx, [rcx+8]
    mov     [rbx+10h], rax
    test    rax, rax
    jle     short loc_5C7888
    lea     rbp, [rbx+rax]
    add     rbp, 18h
    add     rbx, 18h
    call    ___ctype_b_loc
    mov     rax, [rax]
loc_5C7872:
    movzx   ecx, byte ptr [s]
    test    byte ptr [rax+rcx*2], 2
    jnz     loc_5C798F
    add     rbx, 1
    cmp     s, e
    jb      short loc_5C7872
loc_5C7888:
    mov     rax, [rsp+0D98h+theurl]
    mov     rdi, [rax+10h]
    test    rdi, rdi
    jz      short loc_5C78DF
    mov     rsi, [rdi+10h]; len
    add     rdi, 18h; str
    call    php_url_decode
    mov     rcx, [rsp+0D98h+theurl]
    mov     rbx, [rcx+10h]
    mov     [rbx+10h], rax
    test    rax, rax
    jle     short loc_5C78DF
    lea     rbp, [rbx+rax]
    add     rbp, 18h
    add     rbx, 18h
    call    ___ctype_b_loc
    mov     rax, [rax]
loc_5C78C9:
    movzx   ecx, byte ptr [s]
    test    byte ptr [rax+rcx*2], 2
    jnz     loc_5C798F
    add     rbx, 1
    cmp     s, e
    jb      short loc_5C78C9
loc_5C78DF:
    mov     rax, [rsp+0D98h+theurl]
    mov     rdi, [rax+28h]
    test    rdi, rdi
    jz      short loc_5C7932
    mov     rsi, [rdi+10h]; len
    add     rdi, 18h; str
    call    php_url_decode
    mov     rcx, [rsp+0D98h+theurl]
    mov     rbx, [rcx+28h]
    mov     [rbx+10h], rax
    test    rax, rax
    jle     short loc_5C7932
    lea     rbp, [rbx+rax]
    add     rbp, 18h
    add     rbx, 18h
    call    ___ctype_b_loc
    mov     rax, [rax]
loc_5C7920:
    movzx   ecx, byte ptr [s]
    test    byte ptr [rax+rcx*2], 2
    jnz     short loc_5C798F
    add     rbx, 1
    cmp     s, e
    jb      short loc_5C7920
loc_5C7932:
    add     r14d, 0FFFFFFFFh
    mov     rax, [rsp+0D98h+arg_8]
    mov     [rsp+0D98h+error_string+8], rax; flags
    mov     dword ptr [rsp+0D98h+error_string], 2; redirect_max
    lea     rsi, [rsp+0D98h+str]; path
    mov     rdi, r15; wrapper
    mov     rdx, [rsp+0D98h+src]; mode
    mov     r9, redirect_max; context
    mov     r14, rdx
    mov     ecx, [rsp+0D98h+var_D64]; options
    mov     r8, [rsp+0D98h+opened_path]; opened_path
    call    php_stream_url_wrap_http_ex
    mov     rbx, rax
    xor     r15d, r15d
    jmp     loc_5C7271
loc_5C7979:
    lea     rdx, aInvalidRedirec; "Invalid redirect URL! %s"
    xor     ebx, ebx
    lea     rcx, [rsp+0D98h+str]
    mov     rdi, rbp
    jmp     short loc_5C79A3
loc_5C798F:
    lea     rdx, aInvalidRedirec; "Invalid redirect URL! %s"
    xor     ebx, ebx
    lea     rcx, [rsp+0D98h+str]
    mov     rdi, r15; wrapper
loc_5C79A3:
    mov     esi, [rsp+0D98h+var_D64]; options
    xor     eax, eax
    call    php_stream_wrapper_log_error
    mov     r14, [rsp+0D98h+src]
    xor     r15d, r15d
    jmp     loc_5C7271
loc_5C79BB:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rbx, [rsp+0D98h+var_D78.s]
    mov     r12, [rbx+10h]
    jmp     loc_5C5EC4
loc_5C79D6:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     r14, [rsp+0D98h+var_D78.s]
    mov     r15, [r14+10h]
    jmp     loc_5C5F92
loc_5C79F1:
    add     rcx, 18h
    lea     rdx, aSS_5; "%s%s"
    jmp     loc_5C7719
loc_5C7A01:
    mov     r15d, 4
loc_5C7A07:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C57C5
loc_5C7A22:
    mov     ebx, 2
loc_5C7A27:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C668F
loc_5C7A42:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C58DA
loc_5C7A5D:
    mov     eax, 2401h
    jmp     short loc_5C7A68
loc_5C7A64:
    add     p, 1
loc_5C7A68:
    movzx   ecx, byte ptr [p+0]
    cmp     rcx, 0Dh
    ja      short loc_5C7A64
    bt      rax, rcx
    jnb     short loc_5C7A64
    sub     p, s
    mov     rax, [rsp+0D98h+str.s]
    mov     r12, rbp
    test    rax, rax
    jz      loc_5C7FA0
    mov     rcx, [rax+10h]
    lea     r12, [rcx+rbp]
    cmp     r12, [rsp+0D98h+str.a]
    jnb     loc_5C7FA0
loc_5C7AA5:
    lea     rdi, [rax+rcx]
    add     rdi, 18h; dest
    mov     rsi, s; src
    mov     rdx, rbp; n
    call    _memcpy
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], r12
    test    rax, rax
    jz      loc_5C7FC1
    lea     s, [r12+2]
    cmp     rbx, [rsp+0D98h+str.a]
    jnb     loc_5C7FC6
loc_5C7AE0:
    mov     word ptr [rax+r12+18h], 0A0Dh
    mov     rax, [rsp+0D98h+str.s]
    mov     [rax+10h], rbx
    jmp     loc_5C54CA
loc_5C7AF9:
    mov     r12d, 8
loc_5C7AFF:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C514A
loc_5C7B20:
    mov     ebx, 1
    mov     context, [rsp+0D98h+opened_path]
    mov     rbp, [rsp+0D98h+theurl]
    mov     r13, [rsp+0D98h+var_D20]
loc_5C7B34:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    jmp     loc_5C51E6
loc_5C7B51:
    mov     ebp, 0Bh
loc_5C7B56:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rbx, [rax+10h]
    jmp     loc_5C52B0
loc_5C7B77:
    mov     rdi, tmpzval; op
    call    zval_get_double_func
    jmp     loc_5C4EBE
loc_5C7B84:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     r14, [rsp+0D98h+var_D78.s]
    mov     rbx, [r14+10h]
    jmp     loc_5C599C
loc_5C7B9F:
    mov     ebx, 0Bh
loc_5C7BA4:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C5AF9
loc_5C7BBF:
    mov     ebp, 2
loc_5C7BC4:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rbx, [rax+10h]
    jmp     loc_5C641B
loc_5C7BDF:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rbx, [rsp+0D98h+var_D78.s]
    mov     r13, [rbx+10h]
    jmp     loc_5C5A7B
loc_5C7BFA:
    mov     r14d, 15h
loc_5C7C00:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r14; len
    call    smart_str_erealloc
    mov     rbp, [rsp+0D98h+var_D78.s]
    mov     rax, [rbp+10h]
    jmp     loc_5C5D3F
loc_5C7C1B:
    mov     ebp, 2
    mov     r15, [rsp+0D98h+opened_path]
loc_5C7C25:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rbx, [rax+10h]
    jmp     loc_5C5DCD
loc_5C7C40:
    mov     r12d, 6
loc_5C7C46:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C5E80
loc_5C7C61:
    mov     ebx, 2
    mov     r12, r13
    mov     r15, [rsp+0D98h+var_D60]
loc_5C7C6E:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rbp, [rax+10h]
    jmp     loc_5C5F00
loc_5C7C89:
    mov     r15d, 6
loc_5C7C8F:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C5F45
loc_5C7CAA:
    mov     ebx, 13h
loc_5C7CAF:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C600B
loc_5C7CCA:
    mov     ebx, 2
    lea     rbp, file_globals
loc_5C7CD6:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C6134
loc_5C7CF1:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C588A
loc_5C7D0C:
    mov     ebx, 1
    mov     r12, [rsp+0D98h+theurl]
loc_5C7D16:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    jmp     loc_5C595D
loc_5C7D2D:
    mov     ebx, 1
loc_5C7D32:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    jmp     loc_5C5918
loc_5C7D49:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C60F0
loc_5C7D64:
    mov     rdi, tmpzval; op
    call    zval_get_double_func
    jmp     loc_5C59FA
loc_5C7D71:
    mov     r13d, 6
loc_5C7D77:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r13; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C5A33
loc_5C7D92:
    mov     ebx, 2
    mov     r15, [rsp+0D98h+opened_path]
    mov     r13, [rsp+0D98h+var_D60]
loc_5C7DA1:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rbp, [rax+10h]
    jmp     loc_5C5AB9
loc_5C7DBC:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C6213
loc_5C7DD7:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     r15, [rax+10h]
    jmp     loc_5C6656
loc_5C7DF2:
    mov     ebx, 1
loc_5C7DF7:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    jmp     loc_5C6068
loc_5C7E0E:
    mov     rdi, tmpzval; op
    xor     esi, esi; is_strict
    call    zval_get_long_func
    mov     r12, rax
    jmp     loc_5C56EB
loc_5C7E20:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C5762
loc_5C7E3B:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C6364
loc_5C7E56:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C653A
loc_5C7E71:
    mov     r15d, 2
loc_5C7E77:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C6620
loc_5C7E92:
    mov     r15d, 1
loc_5C7E98:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, r15; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    jmp     loc_5C5796
loc_5C7EAF:
    mov     ebp, 10h
loc_5C7EB4:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C62D9
loc_5C7ECF:
    mov     ebx, 2
    mov     r14, [rsp+0D98h+opened_path]
    mov     r15, [rsp+0D98h+var_D60]
loc_5C7EDE:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rbp, [rax+10h]
    jmp     loc_5C63A2
loc_5C7EF9:
    mov     ebp, 10h
loc_5C7EFE:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C64AC
loc_5C7F19:
    mov     ebp, 2
loc_5C7F1E:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     r12, [rax+10h]
    jmp     loc_5C656F
loc_5C7F39:
    mov     ebp, 31h ; '1'
loc_5C7F3E:
    lea     rdi, [rsp+0D98h+var_D78]; str
    mov     rsi, rbp; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+var_D78.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C65B5
loc_5C7F59:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C7556
loc_5C7F7A:
    mov     ebx, 2
loc_5C7F7F:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     r12, [rax+10h]
    jmp     loc_5C7591
loc_5C7FA0:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, r12; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     rcx, [rax+10h]
    jmp     loc_5C7AA5
loc_5C7FC1:
    mov     ebx, 2
loc_5C7FC6:
    lea     rdi, [rsp+0D98h+str]; str
    mov     rsi, rbx; len
    call    smart_str_erealloc
    mov     rax, [rsp+0D98h+str.s]
    mov     r12, [rax+10h]
    jmp     loc_5C7AE0
php_stream_url_wrap_http_ex endp

