tls_parse_ctos_status_request proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 38h
    mov     ebx, 1
    test    x, x
    jnz     loc_4334BC
    mov     r15, s_0
    cmp     dword ptr [rdi+4D0h], 0
    jnz     loc_4334BC
    mov     r14, pkt
    lea     rbx, [s_0+0A60h]
    mov     rdi, rsi; pkt
    mov     rsi, rbx; data
    call    PACKET_get_1_4
    test    eax, eax
    jz      loc_433460
    cmp     dword ptr [rbx], 1
    jnz     loc_43347A
    lea     rsi, [rbp+responder_id_list]; subpkt
    mov     rdi, pkt; pkt
    call    PACKET_get_length_prefixed_2_1
    test    eax, eax
    jz      loc_433487
    lea     rdi, [rbp+responder_id_list]; pkt
    call    PACKET_remaining_7
    test    rax, rax
    jz      short loc_4332E6
    cmp     qword ptr [s_0+0A78h], 0
    jnz     short loc_4332E6
    call    OPENSSL_sk_new_null
    mov     [s_0+0A78h], rax
    test    rax, rax
    jz      loc_433504
loc_4332E6:
    mov     [rbp+s], s_0
    lea     rdi, [rbp+responder_id_list]; pkt
    call    PACKET_remaining_7
    test    rax, rax
    jz      loc_4333B6
    lea     rbx, [rbp+responder_id_list]
    lea     r13, [rbp+responder_id]
    nop     word ptr [rax+rax+00000000h]
    xchg    ax, ax
loc_433310:
    mov     rdi, rbx; pkt
    mov     rsi, r13; subpkt
    call    PACKET_get_length_prefixed_2_1
    test    eax, eax
    jz      loc_4334CD
    mov     rdi, r13; pkt
    call    PACKET_remaining_7
    test    rax, rax
    jz      loc_4334CD
    mov     rdi, r13; pkt
    call    PACKET_data_4
    mov     [rbp+ext_data], id_data_0
    mov     rdi, r13; pkt
    call    PACKET_remaining_7
    movsxd  rdx, eax; len
    xor     edi, edi; a
    lea     rsi, [rbp+ext_data]; in
    call    d2i_OCSP_RESPID
    test    rax, rax
    jz      loc_433532
    mov     r12, rax
    mov     r15, [rbp+ext_data]
    mov     rdi, r13; pkt
    call    PACKET_end
    cmp     id_data_0, rax
    jnz     loc_43354C
    mov     rax, [rbp+s]
    mov     rdi, [rax+0A78h]; sk
    call    ossl_check_OCSP_RESPID_sk_type_0
    mov     id_data_0, rax
    mov     rdi, id; ptr
    call    ossl_check_OCSP_RESPID_type
    mov     rdi, r15; st
    mov     rsi, rax; data
    call    OPENSSL_sk_push
    test    eax, eax
    jz      loc_43357C
    mov     rdi, rbx; pkt
    call    PACKET_remaining_7
    test    rax, rax
    jnz     loc_433310
loc_4333B6:
    lea     rsi, [rbp+responder_id]; subpkt
    mov     rdi, pkt; pkt
    call    PACKET_as_length_prefixed_2_0
    test    eax, eax
    jz      loc_4334EA
    lea     rdi, [rbp+responder_id]; pkt
    call    PACKET_remaining_7
    test    rax, rax
    jz      loc_433480
    lea     rbx, [rbp+responder_id]
    mov     rdi, rbx; pkt
    call    PACKET_data_4
    mov     [rbp+ext_data], ext_data_0
    mov     r15, [rbp+s]
    mov     rdi, [r15+0A80h]; sk
    call    ossl_check_X509_EXTENSION_sk_type_0
    lea     rsi, X509_EXTENSION_free; func
    mov     rdi, rax; st
    call    OPENSSL_sk_pop_free
    mov     rdi, rbx; pkt
    call    PACKET_remaining_7
    movsxd  rdx, eax; len
    xor     ebx, ebx
    lea     rsi, [rbp+ext_data]; in
    xor     edi, edi; a
    call    d2i_X509_EXTENSIONS
    mov     [r15+0A80h], rax
    test    rax, rax
    jz      short loc_433441
    mov     pkt, [rbp+ext_data]
    lea     rdi, [rbp+responder_id]; pkt
    call    PACKET_end
    cmp     ext_data_0, rax
    jz      short loc_433480
loc_433441:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 19Dh; line
    call    ERR_set_debug
    jmp     short loc_4334A6
loc_433460:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 13Bh
    jmp     short loc_43349F
loc_43347A:
    mov     dword ptr [rbx], 0FFFFFFFFh
loc_433480:
    mov     ebx, 1
    jmp     short loc_4334BC
loc_433487:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 148h; line
loc_43349F:
    call    ERR_set_debug
    xor     ebx, ebx
loc_4334A6:
    mov     rdi, r15; s
loc_4334A9:
    mov     esi, 32h ; '2'; al_0
    mov     edx, 6Eh ; 'n'; reason
loc_4334B3:
    xor     ecx, ecx; fmt
    xor     eax, eax
    call    ossl_statem_fatal
loc_4334BC:
    mov     eax, ebx
    add     rsp, 38h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_4334CD:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 174h
    jmp     loc_43356C
loc_4334EA:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 191h
    jmp     short loc_43356C
loc_433504:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 15Fh; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     rdi, s_0
    mov     esi, 50h ; 'P'
    mov     edx, 0C0100h
    jmp     short loc_4334B3
loc_433532:
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 17Ch
    jmp     short loc_43356C
loc_43354C:
    mov     rdi, id; a
    call    OCSP_RESPID_free
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 182h; line
loc_43356C:
    call    ERR_set_debug
    xor     ebx, ebx
    mov     rdi, [rbp+s]
    jmp     loc_4334A9
loc_43357C:
    mov     rdi, id; a
    call    OCSP_RESPID_free
    call    ERR_new
    lea     rdi, aSslStatemExten_2; "ssl/statem/extensions_srvr.c"
    lea     rdx, aTlsParseCtosSt; "tls_parse_ctos_status_request"
    mov     esi, 189h; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     rdi, [rbp+s]
    mov     esi, 50h ; 'P'
    mov     edx, 0C0103h
    jmp     loc_4334B3
tls_parse_ctos_status_request endp

