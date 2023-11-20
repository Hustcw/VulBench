dtls1_preprocess_fragment proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    rbx
    push    rax
    mov     r14, s
    mov     r15, [msg_hdr+8]
    mov     rax, [msg_hdr+20h]
    add     frag_len, [msg_hdr+18h]
    cmp     rax, msg_len
    jbe     short loc_440BA8
    call    ERR_new
    lea     rdi, aSslStatemState_1; "ssl/statem/statem_dtls.c"
    lea     rdx, aDtls1Preproces; "dtls1_preprocess_fragment"
    mov     esi, 1C6h
    jmp     short loc_440BDF
loc_440BA8:
    mov     rax, [s+4B8h]
    cmp     qword ptr [rax+1A8h], 0
    jz      short loc_440C09
    mov     ebx, 1
    cmp     msg_len, [rax+198h]
    jz      short loc_440BFC
    call    ERR_new
    lea     rdi, aSslStatemState_1; "ssl/statem/statem_dtls.c"
    lea     rdx, aDtls1Preproces; "dtls1_preprocess_fragment"
    mov     esi, 1E1h; line
loc_440BDF:
    call    ERR_set_debug
    xor     ebx, ebx
    mov     rdi, s; s
    mov     esi, 2Fh ; '/'; al_0
    mov     edx, 98h; reason
loc_440BF3:
    xor     ecx, ecx; fmt
    xor     eax, eax
    call    ossl_statem_fatal
loc_440BFC:
    mov     eax, ebx
    add     rsp, 8
    pop     rbx
    pop     s
    pop     msg_len
    pop     rbp
    retn
loc_440C09:
    mov     rbx, msg_hdr
    mov     rdi, [s+88h]; str
    lea     rsi, [msg_len+0Ch]; len
    call    BUF_MEM_grow_clean
    test    rax, rax
    jz      short loc_440C58
    mov     [s+2D0h], msg_len
    mov     rax, [s+4B8h]
    mov     [rax+198h], msg_len
    movzx   ecx, byte ptr [msg_hdr]
    mov     [s+2D8h], ecx
    mov     [rax+190h], cl
    movzx   ecx, word ptr [msg_hdr+10h]
    mov     [rax+1A0h], cx
    mov     ebx, 1
    jmp     short loc_440BFC
loc_440C58:
    call    ERR_new
    lea     rdi, aSslStatemState_1; "ssl/statem/statem_dtls.c"
    lea     rdx, aDtls1Preproces; "dtls1_preprocess_fragment"
    mov     esi, 1D3h; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     rdi, s
    mov     esi, 50h ; 'P'
    mov     edx, 80007h
    jmp     loc_440BF3
dtls1_preprocess_fragment endp



dtls1_max_handshake_message_len proc
    mov     rcx, [s+0A00h]
    cmp     rcx, 454Ch
    mov     eax, 454Ch
    cmova   rax, rcx
    retn
dtls1_max_handshake_message_len endp

