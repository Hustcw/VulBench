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



PKCS7_dataDecode proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0B8h
    mov     [rbp+parg], 0
    mov     [rbp+ek], 0
    mov     [rbp+eklen], 0
    test    p7, p7
    jz      loc_4CED44
    mov     r15, in_bio_0
    mov     r14, pkey_0
    mov     rbx, p7
    mov     [rbp+tkey], pcert_0
    call    ossl_pkcs7_get0_ctx
    mov     r12, rax
    mov     rdi, rax; ctx
    call    ossl_pkcs7_ctx_get0_libctx
    mov     r13, rax
    mov     rdi, p7_ctx_0; ctx
    call    ossl_pkcs7_ctx_get0_propq
    mov     [rbp+propq], rax
    cmp     qword ptr [p7+20h], 0
    jz      loc_4CED70
    mov     rdi, [p7+18h]; a
    call    OBJ_obj2nid
    mov     dword ptr [p7+10h], 0
    cmp     eax, 18h
    jz      loc_4CEDA8
    cmp     eax, 17h
    jz      loc_4CEE80
    cmp     eax, 16h
    jnz     loc_4CEF12
    mov     [rbp+p7_ctx], p7_ctx_0
    mov     i, [p7+20h]
    mov     rdi, [rax+28h]; p7
    call    PKCS7_get_octet_string
    mov     r12, rax
    mov     rdi, [p7+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 16h
    jnz     loc_4CEF44
    mov     rdi, p7; p7
    mov     esi, 2; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    PKCS7_ctrl
    test    data_body_0, data_body_0
    jnz     loc_4CEF4D
    test    rax, rax
    jnz     loc_4CEF4D
loc_4CED12:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1C4h; line
    call    ERR_set_debug
    xor     eax, eax
    mov     [rbp+propq], rax
    mov     edi, 21h ; '!'
    mov     esi, 9Bh
    jmp     loc_4CF20E
loc_4CED44:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1A5h; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     edi, 21h ; '!'
    mov     esi, 8Fh
    jmp     short loc_4CED9A
loc_4CED70:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1AEh; line
    call    ERR_set_debug
    xor     r13d, r13d
    mov     edi, 21h ; '!'; lib
    mov     esi, 7Ah ; 'z'; reason
loc_4CED9A:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     loc_4CF27F
loc_4CEDA8:
    mov     [rbp+p7_ctx], p7_ctx_0
    mov     [rbp+pkey], pkey_0
    mov     i, [p7+20h]
    mov     rcx, [rax+30h]
    mov     [rbp+rsk], rcx
    mov     r14, [rax+8]
    mov     rax, [rax+28h]
    mov     rcx, [rax+8]
    mov     r12, [rax+10h]
    mov     [rbp+enc_alg], rcx
    mov     rdx, [rcx]; a
    lea     p7, [rbp+name]
    mov     rdi, rbx; buf
    mov     esi, 32h ; '2'; buf_len
    xor     ecx, ecx; no_name
    call    OBJ_obj2txt
    call    ERR_set_mark
    mov     rdi, libctx; ctx
    mov     rsi, rbx; algorithm
    mov     rdx, [rbp+propq]; properties
    call    EVP_CIPHER_fetch
    mov     rbx, rax
    mov     [rbp+cipher], rax
    test    rax, rax
    jnz     short loc_4CEE2B
    lea     rdi, [rbp+name]; name
    call    EVP_get_cipherbyname
    mov     rcx, cipher_0
    mov     [rbp+cipher], rax
    test    rax, rax
    jz      loc_4CF1BD
loc_4CEE2B:
    call    ERR_pop_to_mark
    test    in_bio_0, in_bio_0
    jnz     loc_4CEF79
loc_4CEE39:
    test    data_body_0, data_body_0
    jnz     loc_4CEF79
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1FDh; line
    call    ERR_set_debug
    xor     eax, eax
    mov     [rbp+propq], rax
    mov     edi, 21h ; '!'; lib
    mov     esi, 7Ah ; 'z'; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    xor     r12d, r12d
    jmp     loc_4CF21C
loc_4CEE80:
    mov     [rbp+p7_ctx], p7_ctx_0
    mov     i, [p7+20h]
    mov     rcx, [rax+8]
    mov     [rbp+rsk], rcx
    mov     rax, [rax+10h]
    mov     rcx, [rax+8]
    mov     r12, [rax+10h]
    mov     [rbp+enc_alg], rcx
    mov     rdx, [rcx]; a
    lea     p7, [rbp+name]
    mov     rdi, rbx; buf
    mov     esi, 32h ; '2'; buf_len
    xor     ecx, ecx; no_name
    call    OBJ_obj2txt
    call    ERR_set_mark
    mov     rdi, libctx; ctx
    mov     rsi, rbx; algorithm
    mov     rdx, [rbp+propq]; properties
    call    EVP_CIPHER_fetch
    mov     rbx, rax
    mov     [rbp+cipher], rax
    test    rax, rax
    jnz     short loc_4CEEFB
    lea     rdi, [rbp+name]; name
    call    EVP_get_cipherbyname
    mov     rcx, cipher_0
    mov     [rbp+cipher], rax
    test    rax, rax
    jz      loc_4CF1DC
loc_4CEEFB:
    mov     [rbp+pkey], pkey_0
    call    ERR_pop_to_mark
    xor     r14d, r14d
    test    in_bio_0, in_bio_0
    jz      loc_4CEE39
    jmp     short loc_4CEF79
loc_4CEF12:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1F6h; line
    call    ERR_set_debug
    xor     eax, eax
    mov     [rbp+propq], rax
    mov     edi, 21h ; '!'
    mov     esi, 70h ; 'p'
    jmp     loc_4CF20E
loc_4CEF44:
    test    data_body_0, data_body_0
    jz      loc_4CED12
loc_4CEF4D:
    mov     [rbp+pkey], pkey_0
    mov     rax, [p7+20h]
    mov     r14, [rax+8]
    xor     ebx, ebx
    xor     eax, eax
    mov     [rbp+cipher], rax
    xor     eax, eax
    mov     [rbp+enc_alg], rax
    xor     eax, eax
    mov     [rbp+rsk], rax
    test    in_bio_0, in_bio_0
    jz      loc_4CEE39
loc_4CEF79:
    xor     eax, eax
    mov     [rbp+tkeylen], rax
    test    md_sk, md_sk
    mov     [rbp+evp_cipher], evp_cipher_0
    mov     [rbp+in_bio], in_bio_0
    mov     [rbp+data_body], data_body_0
    jz      loc_4CF0AA
    mov     rdi, md_sk; sk
    call    ossl_check_const_X509_ALGOR_sk_type
    mov     rbx, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    xor     r14d, r14d
    test    eax, eax
    jle     loc_4CF0AA
    xor     eax, eax
    mov     [rbp+out], rax
    mov     [rbp+var_A0], libctx
    jmp     short loc_4CEFFB
loc_4CEFD0:
    mov     [rbp+out], rdi
    mov     rsi, btmp_0; bio
    call    BIO_push
loc_4CEFDC:
    mov     r13, [rbp+var_A0]
    add     r14d, 1
    mov     evp_md, r15
    mov     rdi, r15; st
    call    OPENSSL_sk_num
    cmp     r14d, eax
    jge     loc_4CF0B0
loc_4CEFFB:
    mov     r15, rbx
    mov     rdi, rbx; st
    mov     esi, r14d; i
    call    OPENSSL_sk_value
    mov     rbx, rax
    call    BIO_f_md
    mov     rdi, rax; method
    call    BIO_new
    test    btmp_0, btmp_0
    jz      loc_4CF17F
    mov     r12, btmp_0
    mov     rdx, [xa]; a
    lea     xa, [rbp+name]
    mov     rdi, rbx; buf
    mov     esi, 32h ; '2'; buf_len
    xor     ecx, ecx; no_name
    call    OBJ_obj2txt
    call    ERR_set_mark
    mov     rdi, libctx; ctx
    mov     rsi, rbx; algorithm
    mov     rdx, [rbp+propq]; properties
    call    EVP_MD_fetch
    mov     rbx, rax
    mov     libctx, rax
    test    rax, rax
    jnz     short loc_4CF075
    lea     rdi, [rbp+name]; name
    call    EVP_get_digestbyname
    mov     r13, rax
    test    rax, rax
    jz      loc_4CF294
loc_4CF075:
    call    ERR_pop_to_mark
    mov     rdi, btmp_0; b
    mov     esi, 6Fh ; 'o'; cmd
    xor     edx, edx; larg
    mov     rcx, r13; parg
    call    BIO_ctrl
    mov     rdi, evp_md; md
    call    EVP_MD_free
    mov     rdi, [rbp+out]; b
    test    rdi, rdi
    jnz     loc_4CEFD0
    mov     [rbp+out], btmp_0
    jmp     loc_4CEFDC
loc_4CF0AA:
    xor     eax, eax
    mov     [rbp+out], rax
loc_4CF0B0:
    cmp     [rbp+cipher], 0
    jz      short loc_4CF135
    call    BIO_f_cipher
    mov     rdi, rax; method
    call    BIO_new
    test    rax, rax
    jz      loc_4CF165
    mov     r13, rax
    cmp     [rbp+tkey], 0
    mov     [rbp+propq], rax
    jz      loc_4CF351
    mov     rdi, [rbp+rsk]; sk
    call    ossl_check_const_PKCS7_RECIP_INFO_sk_type
    mov     r14, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     loc_4CF30B
    xor     ebx, ebx
    nop     dword ptr [rax]
loc_4CF100:
    mov     rdi, r14; st
    mov     esi, ebx; i
    call    OPENSSL_sk_value
    mov     r15, rax
    mov     rdi, rax; ri
    mov     rsi, [rbp+tkey]; pcert
    call    pkcs7_cmp_ri
    test    eax, eax
    jz      loc_4CF2C8
    add     ebx, 1
    mov     rdi, r14; st
    call    OPENSSL_sk_num
    cmp     ebx, eax
    jl      short loc_4CF100
    jmp     loc_4CF30B
loc_4CF135:
    mov     rbx, [rbp+evp_cipher]
    mov     r14, [rbp+in_bio]
    mov     r13, [rbp+out]
    test    r14, r14
    jz      loc_4CF5B9
loc_4CF14D:
    mov     rdi, out_0; b
    mov     rsi, bio; bio
    call    BIO_push
    mov     rdi, rbx; cipher
    call    EVP_CIPHER_free
    jmp     loc_4CF27F
loc_4CF165:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 22Ah
    jmp     short loc_4CF197
loc_4CF17F:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 20Ah; line
loc_4CF197:
    call    ERR_set_debug
    xor     eax, eax
    mov     [rbp+propq], rax
    mov     edi, 21h ; '!'; lib
    mov     esi, 80020h; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
loc_4CF1B5:
    xor     r12d, r12d
    jmp     loc_4CF33E
loc_4CF1BD:
    call    ERR_clear_last_mark
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1DBh
    jmp     short loc_4CF1F9
loc_4CF1DC:
    call    ERR_clear_last_mark
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1F0h; line
loc_4CF1F9:
    call    ERR_set_debug
    xor     eax, eax
    mov     [rbp+propq], rax
    mov     edi, 21h ; '!'; lib
    mov     esi, 6Fh ; 'o'; reason
loc_4CF20E:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    xor     r12d, r12d
    xor     ebx, ebx
loc_4CF21C:
    xor     r14d, r14d
    xor     r15d, r15d
    xor     r13d, r13d
    mov     rdi, evp_cipher_0; cipher
    call    EVP_CIPHER_free
    mov     rdi, [rbp+ek]; str
    movsxd  rsi, [rbp+eklen]; num
    lea     evp_cipher_0, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rdx, rbx; file
    mov     ecx, 2A9h; line
    call    CRYPTO_clear_free
    movsxd  rsi, r15d; num
    mov     rdi, tkey_0; str
    mov     rdx, rbx; file
    mov     ecx, 2AAh; line
    call    CRYPTO_clear_free
    mov     rdi, out_0; bio
    call    BIO_free_all
    mov     rdi, btmp_0; bio
    call    BIO_free_all
    mov     rdi, [rbp+propq]; bio
    call    BIO_free_all
    xor     r13d, r13d
    xor     edi, edi; bio
    call    BIO_free_all
loc_4CF27F:
    mov     rax, r13
    add     rsp, 0B8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_4CF294:
    call    ERR_clear_last_mark
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 219h; line
    call    ERR_set_debug
    xor     eax, eax
    mov     [rbp+propq], rax
    mov     edi, 21h ; '!'
    mov     esi, 6Dh ; 'm'
    jmp     short loc_4CF335
loc_4CF2C8:
    test    r15, r15
    jz      short loc_4CF30B
    cmp     [rbp+tkey], 0
    jz      short loc_4CF351
    mov     rax, [rbp+p7_ctx]
    mov     [r15+28h], rax
    xor     r14d, r14d
    lea     rdi, [rbp+ek]; pek
    lea     rsi, [rbp+eklen]; peklen
    mov     rdx, r15; ri
    mov     rcx, [rbp+pkey]; pkey
    xor     r8d, r8d; fixlen
    call    pkcs7_decrypt_rinfo
    test    eax, eax
    js      loc_4CF4A4
    call    ERR_clear_error
    jmp     loc_4CF3C5
loc_4CF30B:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 241h; line
    call    ERR_set_debug
    xor     r12d, r12d
    mov     edi, 21h ; '!'; lib
    mov     esi, 73h ; 's'; reason
loc_4CF335:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
loc_4CF33E:
    xor     r14d, r14d
loc_4CF341:
    xor     r15d, r15d
    mov     rbx, [rbp+evp_cipher]
    mov     r13, [rbp+out]
    jmp     err
loc_4CF351:
    mov     rdi, [rbp+rsk]; sk
    call    ossl_check_const_PKCS7_RECIP_INFO_sk_type
    mov     r12, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     short loc_4CF3C5
    lea     r14, [rbp+ek]
    lea     r15, [rbp+eklen]
    xor     ebx, ebx
loc_4CF373:
    mov     rdi, r12; st
    mov     esi, ebx; i
    call    OPENSSL_sk_value
    mov     etmp_0, rax
    mov     rax, [rbp+p7_ctx]
    mov     [ri+28h], rax
    mov     rdi, [rbp+cipher]; cipher
    call    EVP_CIPHER_get_key_length
    movsxd  r8, eax; fixlen
    mov     rdi, r14; pek
    mov     rsi, r15; peklen
    mov     rdx, ri; ri
    mov     rcx, [rbp+pkey]; pkey
    call    pkcs7_decrypt_rinfo
    test    eax, eax
    js      loc_4CF46D
    call    ERR_clear_error
    add     ebx, 1
    mov     rdi, r12; st
    call    OPENSSL_sk_num
    cmp     ebx, eax
    jl      short loc_4CF373
loc_4CF3C5:
    mov     [rbp+parg], 0
    lea     rcx, [rbp+parg]; parg
    mov     r13, [rbp+propq]
    mov     rdi, r13; b
    mov     esi, 81h; cmd
    xor     edx, edx; larg
    call    BIO_ctrl
    mov     rdi, [rbp+parg]; ctx
    mov     rsi, [rbp+cipher]; cipher
    xor     edx, edx; impl
    xor     ecx, ecx; key
    xor     r8d, r8d; iv
    xor     r9d, r9d; enc
    call    EVP_CipherInit_ex
    test    eax, eax
    jle     loc_4CF1B5
    mov     rdi, [rbp+parg]; c
    mov     rax, [rbp+enc_alg]
    mov     rsi, [rax+8]; type
    call    EVP_CIPHER_asn1_to_param
    test    eax, eax
    mov     rbx, [rbp+evp_cipher]
    js      short loc_4CF483
    mov     rdi, [rbp+parg]; ctx
    call    EVP_CIPHER_CTX_get_key_length
    test    eax, eax
    jle     short loc_4CF483
    mov     r15d, eax
    movsxd  r14, eax
    lea     rsi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rdi, r14; num
    mov     edx, 267h; line
    call    CRYPTO_malloc
    test    tkey_0, tkey_0
    jz      short loc_4CF495
    mov     rdi, [rbp+parg]; ctx
    mov     [rbp+tkey], tkey_0
    mov     rsi, ek_0; key
    call    EVP_CIPHER_CTX_rand_key
    test    eax, eax
    jle     short loc_4CF4AC
    mov     r13, [rbp+ek]
    test    ek_0, ek_0
    jz      short loc_4CF4BC
    mov     ebx, [rbp+eklen]
    jmp     short loc_4CF4D1
loc_4CF46D:
    xor     r12d, r12d
    xor     r14d, r14d
    mov     i, [rbp+evp_cipher]
    mov     ri, [rbp+out]
    xor     r15d, r15d
    jmp     err
loc_4CF483:
    xor     r12d, r12d
    xor     r14d, r14d
    xor     r15d, r15d
    mov     r13, [rbp+out]
    jmp     err
loc_4CF495:
    xor     r12d, r12d
    xor     r14d, r14d
    mov     r13, [rbp+out]
    jmp     err
loc_4CF4A4:
    xor     r12d, r12d
    jmp     loc_4CF341
loc_4CF4AC:
    xor     r12d, r12d
    mov     r14, [rbp+tkey]
    mov     r13, [rbp+out]
    jmp     err
loc_4CF4BC:
    mov     ek_0, [rbp+tkey]
    mov     [rbp+ek], r13
    mov     [rbp+eklen], r15d
    mov     ebx, r15d
    xor     eax, eax
    mov     [rbp+tkey], rax
loc_4CF4D1:
    mov     rdi, [rbp+parg]; ctx
    call    EVP_CIPHER_CTX_get_key_length
    cmp     ebx, eax
    mov     [rbp+tkeylen], len
    jz      short loc_4CF51D
    mov     rdi, [rbp+parg]; c
    mov     esi, ebx; keylen
    call    EVP_CIPHER_CTX_set_key_length
    test    eax, eax
    jnz     short loc_4CF51D
    movsxd  rsi, ebx; num
    lea     rdx, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rdi, ek_0; str
    mov     ecx, 27Ah; line
    call    CRYPTO_clear_free
    mov     ek_0, [rbp+tkey]
    mov     [rbp+ek], r13
    mov     [rbp+eklen], r15d
    mov     ebx, r15d
    xor     eax, eax
    mov     [rbp+tkey], rax
loc_4CF51D:
    call    ERR_clear_error
    mov     rdi, [rbp+parg]; ctx
    xor     r12d, r12d
    xor     esi, esi; cipher
    xor     edx, edx; impl
    mov     rcx, ek_0; key
    xor     r8d, r8d; iv
    xor     r9d, r9d; enc
    call    EVP_CipherInit_ex
    test    eax, eax
    jle     short loc_4CF58C
    movsxd  rsi, ebx; num
    lea     eklen_0, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rdi, ek_0; str
    mov     rdx, rbx; file
    mov     ecx, 285h; line
    call    CRYPTO_clear_free
    mov     [rbp+ek], 0
    mov     rdi, [rbp+tkey]; str
    mov     rsi, r14; num
    mov     rdx, rbx; file
    mov     ecx, 287h; line
    call    CRYPTO_clear_free
    mov     r13, [rbp+out]
    test    r13, r13
    jz      short loc_4CF5A1
    mov     rdi, r13; b
    mov     rsi, [rbp+propq]; bio
    call    BIO_push
    jmp     short loc_4CF5A5
loc_4CF58C:
    mov     eklen_0, [rbp+evp_cipher]
    mov     ek_0, [rbp+out]
    mov     len, [rbp+tkeylen]
    mov     r14, [rbp+tkey]
    jmp     err
loc_4CF5A1:
    mov     r13, [rbp+propq]
loc_4CF5A5:
    mov     rbx, [rbp+evp_cipher]
    mov     r14, [rbp+in_bio]
    test    r14, r14
    jnz     loc_4CF14D
loc_4CF5B9:
    mov     rax, [rbp+data_body]
    mov     esi, [rax]; len
    test    esi, esi
    jle     short loc_4CF5DD
    mov     rdi, [rax+8]; buf
    call    BIO_new_mem_buf
    mov     r14, rax
    test    rax, rax
    jnz     loc_4CF14D
    jmp     short loc_4CF608
loc_4CF5DD:
    call    BIO_s_mem
    mov     rdi, rax; method
    call    BIO_new
    test    rax, rax
    jz      short loc_4CF608
    mov     r14, rax
    mov     rdi, rax; b
    mov     esi, 82h; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    BIO_ctrl
    jmp     loc_4CF14D
loc_4CF608:
    xor     eax, eax
    mov     [rbp+propq], rax
    xor     r12d, r12d
    xor     r14d, r14d
    mov     r15, [rbp+tkeylen]
    jmp     err
PKCS7_dataDecode endp



PKCS7_dataInit proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0A8h
    mov     [rbp+out], 0
    test    p7_0, p7_0
    jz      loc_4CE459
    mov     r14, bio_0
    mov     rbx, p7_0
    call    ossl_pkcs7_get0_ctx
    mov     r15, rax
    mov     rdi, rax; ctx
    call    ossl_pkcs7_ctx_get0_libctx
    mov     r12, rax
    mov     rdi, p7_ctx; ctx
    call    ossl_pkcs7_ctx_get0_propq
    cmp     qword ptr [p7_0+20h], 0
    jz      loc_4CE484
    mov     r13, rax
    mov     rdi, [p7_0+18h]; a
    call    OBJ_obj2nid
    mov     dword ptr [p7_0+10h], 0
    add     eax, 0FFFFFFEBh; switch 5 cases
    cmp     eax, 4
    ja      def_4CE437; jumptable 00000000004CE437 default case
    mov     [rbp+p7], p7_0
    mov     [rbp+propq], propq_0
    mov     [rbp+libctx], libctx_0
    xor     edi, edi
    lea     rcx, jpt_4CE437
    movsxd  rdx, ds:(jpt_4CE437 - 6869FCh)[rcx+rax*4]
    add     rdx, rcx
    xor     r13d, r13d
    xor     esi, esi
    xor     ecx, ecx
    xor     eax, eax
    xor     ebx, ebx
def_4CE437:
    jmp     rdx; switch jump
    mov     rax, [rbp+p7]; jumptable 00000000004CE437 case 22
    mov     rax, [rax+20h]
    mov     r13, [rax+8]
    mov     rdi, [rax+28h]; p7
    call    PKCS7_get_octet_string
    xor     edi, edi
    xor     esi, esi
    xor     ecx, ecx
    jmp     loc_4CE537
loc_4CE459:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 0DEh; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     edi, 21h ; '!'
    mov     esi, 8Fh
    jmp     short loc_4CE4AD
loc_4CE484:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 0F0h; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     edi, 21h ; '!'; lib
    mov     esi, 7Ah ; 'z'; reason
loc_4CE4AD:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     loc_4CE932
    call    ERR_new; jumptable 00000000004CE437 default case
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 11Bh; line
    call    ERR_set_debug
    xor     r15d, r15d
    mov     edi, 21h ; '!'
    mov     esi, 70h ; 'p'
    jmp     loc_4CE850
    mov     rax, [rbp+p7]; jumptable 00000000004CE437 case 23
    mov     rax, [rax+20h]
    mov     rcx, [rax+10h]
    mov     rdi, [rcx+18h]
    test    evp_cipher_0, evp_cipher_0
    jz      loc_4CE80C
    mov     rsi, [rax+8]
    mov     rcx, [rcx+8]
    xor     r13d, r13d
    jmp     short loc_4CE535
    mov     rax, [rbp+p7]; jumptable 00000000004CE437 case 24
    mov     rax, [rax+20h]
    mov     rcx, [rax+28h]
    mov     rdi, [rcx+18h]
    test    evp_cipher_0, evp_cipher_0
    jz      loc_4CE826
    mov     rsi, [rax+30h]
    mov     r13, [rax+8]
    mov     rcx, [rcx+8]
loc_4CE535:
    xor     eax, eax
loc_4CE537:
    xor     ebx, ebx
    jmp     short loc_4CE559; jumptable 00000000004CE437 case 21
    mov     rax, [rbp+p7]; jumptable 00000000004CE437 case 25
    mov     rax, [rax+20h]
    mov     rbx, [rax+8]
    mov     rdi, [rax+10h]; p7
    call    PKCS7_get_octet_string
    xor     edi, edi
    xor     r13d, r13d
    xor     esi, esi
    xor     ecx, ecx
loc_4CE559:
    mov     [rbp+evp_cipher], evp_cipher_0; jumptable 00000000004CE437 case 21
    mov     [rbp+keylen], xa_0
    mov     [rbp+xalg], xalg_0
    mov     [rbp+rsk], rsk_0
    mov     [rbp+os], os_0
    mov     [rbp+bio], bio_0
    mov     rdi, md_sk; sk
    call    ossl_check_const_X509_ALGOR_sk_type
    mov     md_sk, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     short loc_4CE5C2
    lea     r14, [rbp+out]
    xor     r12d, r12d
    nop
loc_4CE590:
    mov     rdi, r13; st
    mov     esi, r12d; i
    call    OPENSSL_sk_value
    mov     rdi, r14; pbio
    mov     rsi, rax; alg
    mov     rdx, p7_ctx; ctx
    call    pkcs7_bio_add_digest
    test    eax, eax
    jz      loc_4CE7C9
    add     r12d, 1
    mov     rdi, r13; st
    call    OPENSSL_sk_num
    cmp     r12d, eax
    jl      short loc_4CE590
loc_4CE5C2:
    mov     rsi, [rbp+keylen]; alg
    test    rsi, rsi
    jz      short loc_4CE5DF
    lea     rdi, [rbp+out]; pbio
    mov     rdx, p7_ctx; ctx
    call    pkcs7_bio_add_digest
    test    eax, eax
    jz      loc_4CE911
loc_4CE5DF:
    mov     rax, [rbp+evp_cipher]
    test    rax, rax
    mov     rbx, [rbp+p7]
    jz      loc_4CE866
    mov     r13, rax
    call    BIO_f_cipher
    mov     rdi, rax; method
    call    BIO_new
    mov     r12, rax
    test    rax, rax
    jz      loc_4CE7D4
    lea     rcx, [rbp+parg]; parg
    mov     rdi, btmp; b
    mov     esi, 81h; cmd
    xor     edx, edx; larg
    call    BIO_ctrl
    mov     rbx, r13
    mov     rdi, r13; cipher
    call    EVP_CIPHER_get_key_length
    mov     dword ptr [rbp+keylen], eax
    mov     rdi, r13; cipher
    call    EVP_CIPHER_get_iv_length
    mov     r14d, eax
    mov     rdi, r13; cipher
    call    EVP_CIPHER_get_type
    mov     edi, eax; n
    call    OBJ_nid2obj
    mov     rcx, [rbp+xalg]
    mov     [rcx], rax
    test    r14d, r14d
    mov     p7_ctx, [rbp+libctx]
    jle     short loc_4CE673
    movsxd  rdx, r14d; num
    lea     rsi, [rbp+iv]; buf
    mov     rdi, r15; ctx
    xor     ecx, ecx; strength
    call    RAND_bytes_ex
    test    eax, eax
    jle     loc_4CE7CC
loc_4CE673:
    call    ERR_set_mark
    mov     rbx, r13
    mov     rdi, r13; cipher
    call    EVP_CIPHER_get0_name
    mov     rdi, r15; ctx
    mov     rsi, rax; algorithm
    mov     rdx, [rbp+propq]; properties
    call    EVP_CIPHER_fetch
    mov     r15, rax
    call    ERR_pop_to_mark
    test    fetched_cipher, fetched_cipher
    cmovnz  rbx, fetched_cipher
    mov     rdi, [rbp+parg]; ctx
    mov     rsi, cipher; cipher
    xor     edx, edx; impl
    xor     ecx, ecx; key
    xor     r8d, r8d; iv
    mov     r9d, 1; enc
    call    EVP_CipherInit_ex
    test    eax, eax
    jle     err
    mov     rdi, fetched_cipher; cipher
    call    EVP_CIPHER_free
    mov     rdi, [rbp+parg]; ctx
    lea     rsi, [rbp+key]; key
    call    EVP_CIPHER_CTX_rand_key
    test    eax, eax
    jle     loc_4CE7CC
    mov     rdi, [rbp+parg]; ctx
    xor     r15d, r15d
    lea     rcx, [rbp+key]; key
    lea     r8, [rbp+iv]; iv
    mov     esi, 0; cipher
    xor     edx, edx; impl
    mov     r9d, 1; enc
    call    EVP_CipherInit_ex
    test    eax, eax
    jle     err
    test    r14d, r14d
    jle     short loc_4CE74C
    mov     rax, [rbp+xalg]
    mov     rsi, [rax+8]
    test    rsi, rsi
    jnz     short loc_4CE73B
    mov     cipher, rax
    call    ASN1_TYPE_new
    mov     rsi, rax; type
    mov     [rbx+8], rax
    test    rax, rax
    jz      loc_4CE7CC
loc_4CE73B:
    mov     rdi, [rbp+parg]; c
    call    EVP_CIPHER_param_to_asn1
    test    eax, eax
    js      loc_4CE7CC
loc_4CE74C:
    mov     rdi, [rbp+rsk]; sk
    call    ossl_check_const_PKCS7_RECIP_INFO_sk_type
    mov     r13, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     short loc_4CE79F
    xor     r15d, r15d
    lea     ivlen, [rbp+key]
    xor     ebx, ebx
loc_4CE770:
    mov     rdi, r13; st
    mov     esi, ebx; i
    call    OPENSSL_sk_value
    mov     rdi, ri; ri
    mov     rsi, r14; key
    mov     edx, dword ptr [rbp+keylen]; keylen
    call    pkcs7_encode_rinfo
    test    eax, eax
    jle     err
    add     ebx, 1
    mov     rdi, r13; st
    call    OPENSSL_sk_num
    cmp     ebx, eax
    jl      short loc_4CE770
loc_4CE79F:
    movsxd  rsi, dword ptr [rbp+keylen]
    lea     rdi, [rbp+key]
    call    OPENSSL_cleanse
    mov     rdi, [rbp+out]; b
    test    out_0, out_0
    jz      loc_4CE85E
    mov     rsi, btmp; bio
    call    BIO_push
    jmp     loc_4CE862
loc_4CE7C9:
    xor     r12d, r12d
loc_4CE7CC:
    xor     r15d, r15d
    jmp     err
loc_4CE7D4:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 12Dh; line
    call    ERR_set_debug
    xor     r15d, r15d
    mov     edi, 21h ; '!'; lib
    mov     esi, 80020h; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     err
loc_4CE80C:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 110h
    jmp     short loc_4CE83E
loc_4CE826:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 107h; line
loc_4CE83E:
    call    ERR_set_debug
    xor     r15d, r15d
    mov     edi, 21h ; '!'; lib
    mov     esi, 74h ; 't'; reason
loc_4CE850:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     loc_4CE914
loc_4CE85E:
    mov     [rbp+out], btmp
loc_4CE862:
    mov     rbx, [rbp+p7]
loc_4CE866:
    mov     r14, [rbp+bio]
    test    r14, r14
    jz      short loc_4CE888
loc_4CE86F:
    mov     rbx, [rbp+out]
    test    out_0, out_0
    jz      short loc_4CE8BB
    mov     rdi, out_0; b
    mov     rsi, bio_0; bio
    call    BIO_push
    jmp     loc_4CE932
loc_4CE888:
    mov     rdi, [rbx+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 16h
    jnz     short loc_4CE8C4
    mov     rdi, rbx; p7
    mov     esi, 2; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    PKCS7_ctrl
    test    rax, rax
    jz      short loc_4CE8C4
    call    BIO_s_null
    mov     rdi, rax; method
    call    BIO_new
    jmp     short loc_4CE8DC
loc_4CE8BB:
    mov     [rbp+out], bio_0
    mov     out_0, bio_0
    jmp     short loc_4CE932
loc_4CE8C4:
    mov     rax, [rbp+os]
    test    rax, rax
    jz      short loc_4CE8E6
    mov     esi, [rax]; len
    test    esi, esi
    jle     short loc_4CE8E6
    mov     rdi, [rax+8]; buf
    call    BIO_new_mem_buf
loc_4CE8DC:
    mov     r14, rax
    test    rax, rax
    jnz     short loc_4CE86F
    jmp     short loc_4CE911
loc_4CE8E6:
    call    BIO_s_mem
    mov     rdi, rax; method
    call    BIO_new
    test    rax, rax
    jz      short loc_4CE911
    mov     r14, rax
    mov     rdi, rax; b
    mov     esi, 82h; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    BIO_ctrl
    jmp     loc_4CE86F
loc_4CE911:
    xor     r15d, r15d
loc_4CE914:
    xor     r12d, r12d
    mov     rdi, fetched_cipher; cipher
    call    EVP_CIPHER_free
    mov     rdi, [rbp+out]; bio
    call    BIO_free_all
    mov     rdi, btmp; bio
    call    BIO_free_all
    xor     ebx, ebx
loc_4CE932:
    mov     rax, rbx
    add     rsp, 0A8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
PKCS7_dataInit endp



PKCS7_dataVerify proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    test    p7, p7
    jz      loc_4D031D
    mov     rbx, p7
    cmp     qword ptr [rcx+20h], 0
    jz      loc_4D0349
    mov     r15, si_0_0
    mov     r14, bio_0
    mov     r12, ctx
    mov     r13, cert_store
    mov     rdi, [p7+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 16h
    jz      short loc_4D0294
    mov     rdi, [p7+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 18h
    jnz     loc_4D039E
loc_4D0294:
    mov     [rbp+bio], bio_0
    mov     rax, [p7+20h]
    add     rax, 10h
    mov     r14, [rax]
    mov     [rbp+si_0], si_0_0
    mov     rax, [r15+8]
    mov     rsi, [ias]; name
    mov     rdx, [ias+8]; serial
    mov     rdi, cert; sk
    call    X509_find_by_issuer_and_serial
    test    rax, rax
    jz      loc_4D0375
    mov     r15, rax
    mov     rdi, ctx; ctx
    mov     rsi, cert_store; store
    mov     rdx, rax; x509
    mov     rcx, cert; chain
    call    X509_STORE_CTX_init
    test    eax, eax
    jz      loc_4D03C7
    mov     rdi, ctx; ctx
    mov     esi, 4; purpose
    call    X509_STORE_CTX_set_purpose
    mov     rdi, ctx; ctx
    call    X509_verify_cert
    test    eax, eax
    jle     loc_4D03E1
    mov     rdi, [rbp+bio]; bio
    mov     rsi, p7; p7
    mov     rdx, [rbp+si_0]; si_0
    mov     rcx, x509; x509
    add     rsp, 18h
    pop     p7
    pop     ctx
    pop     cert_store
    pop     cert
    pop     x509
    pop     rbp
    jmp     PKCS7_signatureVerify
loc_4D031D:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 3DDh; line
    call    ERR_set_debug
    mov     edi, 21h ; '!'
    mov     esi, 8Fh
    jmp     loc_4D0408
loc_4D0349:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 3E2h; line
    call    ERR_set_debug
    mov     edi, 21h ; '!'
    mov     esi, 7Ah ; 'z'
    jmp     loc_4D0408
loc_4D0375:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 3FAh; line
    call    ERR_set_debug
    mov     edi, 21h ; '!'
    mov     esi, 6Ah ; 'j'
    jmp     short loc_4D0408
loc_4D039E:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 3F0h; line
    call    ERR_set_debug
    mov     edi, 21h ; '!'
    mov     esi, 72h ; 'r'
    jmp     short loc_4D0408
loc_4D03C7:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 400h
    jmp     short loc_4D03F9
loc_4D03E1:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Dataverif; "PKCS7_dataVerify"
    mov     esi, 406h; line
loc_4D03F9:
    call    ERR_set_debug
    mov     edi, 21h ; '!'; lib
    mov     esi, 8000Bh; reason
loc_4D0408:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    xor     eax, eax
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
PKCS7_dataVerify endp

