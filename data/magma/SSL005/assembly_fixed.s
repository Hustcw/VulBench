tls_parse_ctos_status_request proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 38h
    mov     r14d, 1
    test    x, x
    jnz     loc_433389
    mov     r15, s_0
    cmp     dword ptr [rdi+4D0h], 0
    jnz     loc_433389
    mov     r13, pkt_0
    lea     rbx, [s_0+0A60h]
    mov     rdi, rsi; pkt
    mov     rsi, rbx; data
    call    PACKET_get_1_4
    test    eax, eax
    jz      loc_43332B
    cmp     dword ptr [rbx], 1
    jnz     loc_433345
    lea     rsi, [rbp+responder_id_list]; subpkt
    mov     rdi, pkt_0; pkt
    call    PACKET_get_length_prefixed_2_1
    test    eax, eax
    jz      loc_433353
    mov     rdi, [s_0+0A78h]; sk
    call    ossl_check_OCSP_RESPID_sk_type_0
    lea     rsi, OCSP_RESPID_free; func
    mov     rdi, rax; st
    call    OPENSSL_sk_pop_free
    lea     rdi, [rbp+responder_id_list]; pkt
    call    PACKET_remaining_7
    test    rax, rax
    jz      loc_43339B
    call    OPENSSL_sk_new_null
    mov     [s_0+0A78h], rax
    test    rax, rax
    jnz     loc_4333A6
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 155h; line
    call    ERR_set_debug
    xor     r14d, r14d
    mov     rdi, s_0
    mov     esi, 50h ; 'P'
    mov     edx, 0C0100h
    jmp     short loc_433380
loc_43332B:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 13Bh
    jmp     short loc_43336B
loc_433345:
    mov     dword ptr [rbx], 0FFFFFFFFh
loc_43334B:
    mov     r14d, 1
    jmp     short loc_433389
loc_433353:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 148h; line
loc_43336B:
    call    ERR_set_debug
    xor     r14d, r14d
    mov     rdi, s_0; s
loc_433376:
    mov     esi, 32h ; '2'; al_0
    mov     edx, 6Eh ; 'n'; reason
loc_433380:
    xor     ecx, ecx; fmt
    xor     eax, eax
    call    ossl_statem_fatal
loc_433389:
    mov     eax, r14d
    add     rsp, 38h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_43339B:
    mov     qword ptr [s_0+0A78h], 0
loc_4333A6:
    mov     [rbp+s], s_0
    lea     rdi, [rbp+responder_id_list]; pkt
    call    PACKET_remaining_7
    test    rax, rax
    jz      loc_43348C
    lea     r15, [rbp+responder_id_list]
    lea     rbx, [rbp+responder_id]
    mov     [rbp+pkt], pkt_0
    nop     dword ptr [rax+rax+00000000h]
loc_4333D0:
    mov     rdi, r15; pkt
    mov     rsi, rbx; subpkt
    call    PACKET_get_length_prefixed_2_1
    test    eax, eax
    jz      loc_433541
    mov     rdi, rbx; pkt
    call    PACKET_remaining_7
    test    rax, rax
    jz      loc_433541
    mov     rdi, rbx; pkt
    call    PACKET_data_4
    mov     [rbp+ext_data], id_data_0
    mov     rdi, rbx; pkt
    call    PACKET_remaining_7
    movsxd  rdx, eax; len
    xor     edi, edi; a
    lea     rsi, [rbp+ext_data]; in
    call    d2i_OCSP_RESPID
    test    rax, rax
    jz      loc_433575
    mov     rdi, rbx; pkt
    mov     r12, rax
    mov     rbx, r15
    mov     r14, [rbp+ext_data]
    mov     r13, rdi
    call    PACKET_end
    cmp     id_data_0, rax
    jnz     loc_43358F
    mov     r15, [rbp+s]
    mov     rdi, [r15+0A78h]; sk
    call    ossl_check_OCSP_RESPID_sk_type_0
    mov     id_data_0, rax
    mov     rdi, id; ptr
    call    ossl_check_OCSP_RESPID_type
    mov     rdi, r14; st
    mov     rsi, rax; data
    call    OPENSSL_sk_push
    test    eax, eax
    jz      loc_4335C0
    mov     r15, rbx
    mov     rdi, rbx; pkt
    call    PACKET_remaining_7
    test    rax, rax
    mov     r14d, 1
    mov     rbx, r13
    mov     r13, [rbp+pkt]
    jnz     loc_4333D0
loc_43348C:
    lea     rsi, [rbp+responder_id]; subpkt
    mov     rdi, r13; pkt
    call    PACKET_as_length_prefixed_2_0
    test    eax, eax
    jz      loc_43355B
    lea     rdi, [rbp+responder_id]; pkt
    call    PACKET_remaining_7
    test    rax, rax
    jz      loc_433389
    lea     r14, [rbp+responder_id]
    mov     rdi, r14; pkt
    call    PACKET_data_4
    mov     [rbp+ext_data], ext_data_0
    mov     rbx, [rbp+s]
    mov     rdi, [rbx+0A80h]; sk
    call    ossl_check_X509_EXTENSION_sk_type_0
    lea     rsi, X509_EXTENSION_free; func
    mov     rdi, rax; st
    call    OPENSSL_sk_pop_free
    mov     rdi, r14; pkt
    call    PACKET_remaining_7
    movsxd  rdx, eax; len
    xor     r14d, r14d
    lea     rsi, [rbp+ext_data]; in
    xor     edi, edi; a
    call    d2i_X509_EXTENSIONS
    mov     [rbx+0A80h], rax
    test    rax, rax
    jz      short loc_43351C
    mov     r15, [rbp+ext_data]
    lea     rdi, [rbp+responder_id]; pkt
    call    PACKET_end
    cmp     ext_data_0, rax
    jz      loc_43334B
loc_43351C:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 19Dh; line
    call    ERR_set_debug
    mov     rdi, rbx
    jmp     loc_433376
loc_433541:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 174h
    jmp     short loc_4335AF
loc_43355B:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 191h
    jmp     short loc_4335AF
loc_433575:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 17Ch
    jmp     short loc_4335AF
loc_43358F:
    mov     rdi, id; a
    call    OCSP_RESPID_free
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 182h; line
loc_4335AF:
    call    ERR_set_debug
    xor     r14d, r14d
    mov     rdi, [rbp+s]
    jmp     loc_433376
loc_4335C0:
    mov     rdi, id; a
    call    OCSP_RESPID_free
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 189h; line
    call    ERR_set_debug
    xor     r14d, r14d
    mov     rdi, r15
    mov     esi, 50h ; 'P'
    mov     edx, 0C0103h
    jmp     loc_433380
tls_parse_ctos_status_request endp

