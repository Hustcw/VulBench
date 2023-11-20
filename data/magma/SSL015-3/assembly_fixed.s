PKCS7_dataFinal proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 98h
    test    p7, p7
    jz      short loc_4CF8BD
    mov     r12, bio_0
    mov     r14, p7
    call    ossl_pkcs7_get0_ctx
    cmp     qword ptr [p7+20h], 0
    jz      short loc_4CF8E9
    mov     r13, rax
    call    EVP_MD_CTX_new
    test    rax, rax
    jz      loc_4CF915
    mov     rbx, rax
    mov     rdi, [p7+18h]; a
    call    OBJ_obj2nid
    mov     dword ptr [p7+10h], 0
    add     eax, 0FFFFFFEBh; switch 5 cases
    cmp     eax, 4
    ja      def_4CF8AA; jumptable 00000000004CF8AA default case
    lea     rcx, jpt_4CF8AA
    movsxd  rax, ds:(jpt_4CF8AA - 686A10h)[rcx+rax*4]
    add     rax, rcx
def_4CF8AA:
    jmp     rax; switch jump
    mov     [rbp+btmp], bio_0; jumptable 00000000004CF8AA case 21
    mov     rax, [p7+20h]
    mov     [rbp+os], rax
    jmp     loc_4CFCA9
loc_4CF8BD:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 2F2h; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     edi, 21h ; '!'
    mov     esi, 8Fh
    jmp     short loc_4CF93F
loc_4CF8E9:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 2F9h; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     edi, 21h ; '!'
    mov     esi, 7Ah ; 'z'
    jmp     short loc_4CF93F
loc_4CF915:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 304h; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     edi, 21h ; '!'; lib
    mov     esi, 0C0100h; reason
loc_4CF93F:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     loc_4CFE4E
    call    ERR_new; jumptable 00000000004CF8AA default case
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 33Eh; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     edi, 21h ; '!'; lib
    mov     esi, 70h ; 'p'; reason
loc_4CF977:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     err
    mov     r15, ctx_tmp; jumptable 00000000004CF8AA case 22
    mov     rax, [p7+20h]
    mov     rbx, [rax+20h]
    mov     rdi, [rax+28h]; p7
    call    PKCS7_get_octet_string
    mov     [rbp+os], rax
    mov     rax, [p7+20h]
    mov     rax, [rax+28h]
    mov     rdi, [rax+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 15h
    mov     [rbp+btmp], bio_0
    jnz     loc_4CFA5C
    cmp     dword ptr [p7+14h], 0
    jz      loc_4CFA5C
    mov     rdi, [rbp+os]; x
    call    ASN1_OCTET_STRING_free
    mov     rax, [p7+20h]
    mov     rax, [rax+28h]
    mov     qword ptr [rax+20h], 0
    xor     eax, eax
    mov     [rbp+os], rax
    test    si_sk, si_sk
    jnz     short loc_4CFA65
    jmp     loc_4CFCA6
    mov     [rbp+btmp], bio_0; jumptable 00000000004CF8AA case 23
    mov     rax, [p7+20h]
    mov     rax, [rax+10h]
    mov     rcx, [rax+10h]
    mov     rax, os_0
    mov     [rbp+os], rcx
    test    rcx, rcx
    jnz     loc_4CFCA9
    call    ASN1_OCTET_STRING_new
    test    os_0, os_0
    jz      loc_4CFD98
    mov     rcx, [p7+20h]
    mov     rdx, [rcx+10h]
    mov     rcx, os_0
    mov     [rbp+os], os_0
    mov     [rdx+10h], rax
    jmp     loc_4CFCA9
    mov     r15, ctx_tmp; jumptable 00000000004CF8AA case 24
    mov     rax, [p7+20h]
    mov     rbx, [rax+20h]
    mov     rax, [rax+28h]
    mov     rcx, [rax+10h]
    mov     rax, os_0
    mov     [rbp+os], rcx
    test    rcx, rcx
    jz      loc_4CFC78
    mov     [rbp+btmp], bio_0
loc_4CFA5C:
    test    si_sk, si_sk
    jz      loc_4CFCA6
loc_4CFA65:
    mov     rdi, si_sk; sk
    call    ossl_check_const_PKCS7_SIGNER_INFO_sk_type
    mov     [rbp+st], rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     loc_4CFCA6
    mov     [rbp+p7_ctx], p7_ctx_0
    xor     r12d, r12d
    mov     r13, ctx_tmp
    mov     si_sk, [rbp+st]
    mov     [rbp+ctx], ctx_tmp
    jmp     short loc_4CFAC4
loc_4CFA95:
    mov     rdi, si_0; si_0
    mov     rsi, rbx; mctx
    call    do_pkcs7_signed_attrib
    test    eax, eax
    jz      err
loc_4CFAA8:
    mov     r13, rbx
    add     r12d, 1
    mov     rbx, [rbp+st]
    mov     rdi, rbx; st
    call    OPENSSL_sk_num
    cmp     r12d, eax
    jge     loc_4CFD90
loc_4CFAC4:
    mov     rdi, rbx; st
    mov     esi, r12d; i
    call    OPENSSL_sk_value
    cmp     qword ptr [rax+38h], 0
    mov     rbx, r13
    jz      short loc_4CFAA8
    mov     ctx_tmp, rax
    mov     rax, [rax+10h]
    mov     rdi, [rax]; a
    call    OBJ_obj2nid
    lea     rdi, [rbp+mdc]; pmd
    mov     rsi, [rbp+btmp]; bio
    mov     edx, eax; nid
    call    PKCS7_find_digest
    xor     r13d, r13d
    test    btmp_0, btmp_0
    jz      err
    mov     rsi, [rbp+mdc]; in
    mov     rdi, rbx; out
    call    EVP_MD_CTX_copy_ex
    test    eax, eax
    jz      err
    mov     rdi, [si_0+18h]; sk
    call    ossl_check_const_X509_ATTRIBUTE_sk_type
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jg      loc_4CFA95
    mov     rdi, [si_0+38h]; pkey
    call    EVP_PKEY_get_size
    mov     dword ptr [rbp+md_data], eax
    mov     edi, eax; num
    lea     rsi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     edx, 364h; line
    call    CRYPTO_malloc
    test    abuf_0, abuf_0
    jz      loc_4CFE42
    mov     rcx, [si_0+38h]
    mov     [rbp+pkey], rcx
    mov     [rbp+abuf], abuf_0
    mov     rbx, [rbp+p7_ctx]
    mov     rdi, rbx; ctx
    call    ossl_pkcs7_ctx_get0_libctx
    mov     [rbp+libctx], rax
    mov     rdi, rbx; ctx
    mov     rbx, [rbp+abuf]
    call    ossl_pkcs7_ctx_get0_propq
    mov     rdi, [rbp+ctx]; ctx
    mov     rsi, abuf_0; sigret
    lea     rdx, [rbp+md_data]; siglen
    mov     rcx, [rbp+pkey]; pkey
    mov     r8, [rbp+libctx]; libctx
    mov     r9, rax; propq
    call    EVP_SignFinal_ex
    test    eax, eax
    jz      loc_4CFDFF
    mov     rdi, [si_0+28h]; str
    mov     edx, dword ptr [rbp+md_data]; len
    mov     rsi, abuf_0; data
    call    ASN1_STRING_set0
    mov     abuf_0, [rbp+ctx]
    jmp     loc_4CFAA8
    mov     rax, [p7+20h]; jumptable 00000000004CF8AA case 25
    mov     rdi, [rax+10h]; p7
    call    PKCS7_get_octet_string
    mov     r15, rax
    mov     rax, [p7+20h]
    mov     rax, [rax+10h]
    mov     rdi, [rax+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 15h
    jnz     short loc_4CFC0C
    cmp     dword ptr [p7+14h], 0
    jz      short loc_4CFC0C
    mov     rdi, os_0; x
    call    ASN1_OCTET_STRING_free
    mov     rax, [p7+20h]
    mov     rax, [rax+10h]
    mov     qword ptr [rax+20h], 0
    xor     r15d, r15d
loc_4CFC0C:
    mov     rax, [p7+20h]
    mov     rax, [rax+8]
    mov     rdi, [rax]; a
    call    OBJ_obj2nid
    lea     rdi, [rbp+mdc]; pmd
    mov     rsi, bio_0; bio
    mov     edx, eax; nid
    call    PKCS7_find_digest
    test    rax, rax
    jz      loc_4CFD5C
    mov     rdi, [rbp+mdc]; ctx
    lea     rsi, [rbp+md_data]; md
    lea     rdx, [rbp+md_len]; isize
    call    EVP_DigestFinal_ex
    test    eax, eax
    jz      loc_4CFD5C
    mov     rax, [p7+20h]
    mov     rdi, [rax+18h]; x
    mov     edx, [rbp+md_len]; len
    lea     rsi, [rbp+md_data]; d
    call    ASN1_OCTET_STRING_set
    test    eax, eax
    jz      loc_4CFD5C
    mov     [rbp+os], r15
    mov     [rbp+btmp], bio_0
    jmp     short loc_4CFCA9
loc_4CFC78:
    call    ASN1_OCTET_STRING_new
    test    os_0, os_0
    jz      loc_4CFDC7
    mov     [rbp+btmp], bio_0
    mov     rcx, [p7+20h]
    mov     rdx, [rcx+28h]
    mov     rcx, os_0
    mov     [rbp+os], os_0
    mov     [rdx+10h], rax
    test    si_sk, si_sk
    jnz     loc_4CFA65
loc_4CFCA6:
    mov     si_sk, ctx_tmp
loc_4CFCA9:
    mov     rdi, [p7+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 16h
    jnz     short loc_4CFCD7
    mov     rdi, p7; p7
    mov     esi, 2; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    PKCS7_ctrl
    mov     r13d, 1
    test    rax, rax
    jnz     err
loc_4CFCD7:
    mov     r12, [rbp+os]
    test    r12, r12
    jz      short loc_4CFD5C
    mov     r13d, 1
    test    byte ptr [r12+10h], 10h
    jnz     err
    mov     r15, rbx
    mov     rdi, [rbp+btmp]; bio
    mov     esi, 401h; type
    call    BIO_find_type
    test    rax, rax
    jz      short loc_4CFD64
    mov     rbx, rax
    lea     rcx, [rbp+md_data]; parg
    mov     rdi, rax; b
    mov     esi, 3; cmd
    xor     edx, edx; larg
    call    BIO_ctrl
    mov     p7, rax
    mov     rdi, btmp_0; b
    mov     esi, 200h; flags
    call    BIO_set_flags
    mov     rdi, btmp_0; b
    mov     esi, 82h; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    BIO_ctrl
    mov     rsi, qword ptr [rbp+md_data]; data
    mov     rdi, r12; str
    mov     edx, r14d; len
    mov     btmp_0, r15
    call    ASN1_STRING_set0
    jmp     err
loc_4CFD5C:
    xor     r13d, r13d
    jmp     err
loc_4CFD64:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 38Ah; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     edi, 21h ; '!'
    mov     esi, 6Bh ; 'k'
    jmp     short loc_4CFDF1
loc_4CFD90:
    mov     rbx, r13
    jmp     loc_4CFCA9
loc_4CFD98:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 322h; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     edi, 21h ; '!'
    mov     esi, 0C0100h
    jmp     loc_4CF977
loc_4CFDC7:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 316h; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     edi, 21h ; '!'; lib
    mov     esi, 0C0100h; reason
loc_4CFDF1:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    mov     rbx, r15
    jmp     short err
loc_4CFDFF:
    mov     rdi, abuf_0; str
    lea     abuf_0, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rsi, rbx; file
    mov     edx, 36Bh; line
    call    CRYPTO_free
    call    ERR_new
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     rdi, rbx; file
    mov     esi, 36Ch; line
    call    ERR_set_debug
    mov     edi, 21h ; '!'; lib
    mov     esi, 80006h; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
loc_4CFE42:
    mov     rbx, [rbp+ctx]
    mov     rdi, rbx; ctx
    call    EVP_MD_CTX_free
loc_4CFE4E:
    mov     eax, r13d
    add     rsp, 98h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
PKCS7_dataFinal endp

