PKCS7_dataVerify proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     rbx, si_0_0
    mov     r13, p7
    mov     r14, bio_0
    mov     [rbp+ctx], ctx_0
    mov     r12, cert_store
    mov     rdi, [rcx+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 16h
    jz      short loc_4C4D51
    mov     rdi, [p7+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 18h
    jnz     loc_4C4E03
loc_4C4D51:
    mov     [rbp+bio], bio_0
    mov     rax, [p7+20h]
    add     rax, 10h
    mov     r14, [rax]
    mov     [rbp+si_0], si_0_0
    mov     rax, [rbx+8]
    mov     rsi, [ias]; name
    mov     rdx, [ias+8]; serial
    mov     rdi, cert; sk
    call    X509_find_by_issuer_and_serial
    test    rax, rax
    jz      short loc_4C4DDA
    mov     r15, rax
    mov     rbx, [rbp+ctx]
    mov     rdi, rbx; ctx
    mov     rsi, cert_store; store
    mov     rdx, rax; x509
    mov     rcx, cert; chain
    call    X509_STORE_CTX_init
    test    eax, eax
    jz      loc_4C4E2C
    mov     rdi, rbx; ctx
    mov     esi, 4; purpose
    call    X509_STORE_CTX_set_purpose
    mov     rdi, rbx; ctx
    call    X509_verify_cert
    test    eax, eax
    jle     loc_4C4E46
    mov     rdi, [rbp+bio]; bio
    mov     rsi, p7; p7
    mov     rdx, [rbp+si_0]; si_0
    mov     rcx, x509; x509
    add     rsp, 18h
    pop     rbx
    pop     cert_store
    pop     p7
    pop     cert
    pop     x509
    pop     rbp
    jmp     PKCS7_signatureVerify
loc_4C4DDA:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 3FAh; line
    call    ERR_set_debug
    mov     edi, 21h ; '!'
    mov     esi, 6Ah ; 'j'
    jmp     short loc_4C4E6D
loc_4C4E03:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 3F0h; line
    call    ERR_set_debug
    mov     edi, 21h ; '!'
    mov     esi, 72h ; 'r'
    jmp     short loc_4C4E6D
loc_4C4E2C:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 400h
    jmp     short loc_4C4E5E
loc_4C4E46:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 406h; line
loc_4C4E5E:
    call    ERR_set_debug
    mov     edi, 21h ; '!'; lib
    mov     esi, 8000Bh; reason
loc_4C4E6D:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    xor     eax, eax
    add     rsp, 18h
    pop     rbx
    pop     cert_store
    pop     p7
    pop     r14
    pop     r15
    pop     rbp
    retn
PKCS7_dataVerify endp

