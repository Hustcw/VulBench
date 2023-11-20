PKCS7_dataFinal proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 88h
    mov     r15, bio_0
    mov     rbx, p7_0
    call    EVP_MD_CTX_new
    test    rax, rax
    jz      short loc_4C4460
    mov     r13, rax
    mov     rdi, [p7_0+18h]; a
    call    OBJ_obj2nid
    mov     dword ptr [p7_0+10h], 0
    add     eax, 0FFFFFFEBh; switch 5 cases
    cmp     eax, 4
    ja      short def_4C444D; jumptable 00000000004C444D default case
    lea     rcx, jpt_4C444D
    movsxd  rax, ds:(jpt_4C444D - 6238D8h)[rcx+rax*4]
    add     rax, rcx
def_4C444D:
    jmp     rax; switch jump
    mov     [rbp+btmp], bio_0; jumptable 00000000004C444D case 21
    mov     rax, [p7_0+20h]
    mov     [rbp+os], rax
    jmp     loc_4C47A9
loc_4C4460:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 304h; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     edi, 21h ; '!'; lib
    mov     esi, 0C0100h; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     loc_4C48D7
    call    ERR_new; jumptable 00000000004C444D default case
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 33Eh; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     edi, 21h ; '!'
    mov     esi, 70h ; 'p'
    jmp     loc_4C48C6
    mov     rax, [p7_0+20h]; jumptable 00000000004C444D case 22
    mov     r14, [rax+20h]
    mov     rdi, [rax+28h]; p7
    call    PKCS7_get_octet_string
    mov     r12, rax
    mov     rax, [p7_0+20h]
    mov     rax, [rax+28h]
    mov     rdi, [rax+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 15h
    mov     [rbp+btmp], bio_0
    jnz     loc_4C465A
    cmp     dword ptr [p7_0+14h], 0
    jz      loc_4C465A
    mov     rdi, os_0; x
    call    ASN1_OCTET_STRING_free
    mov     rax, [p7_0+20h]
    mov     rax, [rax+28h]
    mov     qword ptr [rax+20h], 0
    xor     r12d, r12d
    jmp     loc_4C465A
    mov     [rbp+btmp], bio_0; jumptable 00000000004C444D case 23
    mov     rax, [p7_0+20h]
    mov     rax, [rax+10h]
    mov     rax, [rax+10h]
    mov     [rbp+os], os_0
    test    rax, rax
    jnz     loc_4C47A9
    call    ASN1_OCTET_STRING_new
    test    os_0, os_0
    jz      loc_4C4883
    mov     rcx, [p7_0+20h]
    mov     rcx, [rcx+10h]
    mov     [rbp+os], os_0
    mov     [rcx+10h], rax
    jmp     loc_4C47A9
    mov     rax, [p7_0+20h]; jumptable 00000000004C444D case 24
    mov     r14, [rax+20h]
    mov     rax, [rax+28h]
    mov     r12, [rax+10h]
    test    os_0, os_0
    jz      loc_4C4639
    mov     [rbp+btmp], bio_0
    jmp     loc_4C465A
    mov     rax, [p7_0+20h]; jumptable 00000000004C444D case 25
    mov     rdi, [rax+10h]; p7
    call    PKCS7_get_octet_string
    mov     r14, rax
    mov     rax, [p7_0+20h]
    mov     rax, [rax+10h]
    mov     rdi, [rax+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 15h
    jnz     short loc_4C45CA
    cmp     dword ptr [p7_0+14h], 0
    jz      short loc_4C45CA
    mov     rdi, os_0; x
    call    ASN1_OCTET_STRING_free
    mov     rax, [p7_0+20h]
    mov     rax, [rax+10h]
    mov     qword ptr [rax+20h], 0
    xor     r14d, r14d
loc_4C45CA:
    mov     rax, [p7_0+20h]
    mov     rax, [rax+8]
    mov     rdi, [rax]; a
    call    OBJ_obj2nid
    lea     rdi, [rbp+mdc]; pmd
    mov     rsi, bio_0; bio
    mov     edx, eax; nid
    call    PKCS7_find_digest
    test    rax, rax
    jz      loc_4C4854
    mov     rdi, [rbp+mdc]; ctx
    lea     rsi, [rbp+abuflen]; md
    lea     rdx, [rbp+md_len]; isize
    call    EVP_DigestFinal_ex
    test    eax, eax
    jz      loc_4C4854
    mov     rax, [p7_0+20h]
    mov     rdi, [rax+18h]; x
    mov     edx, [rbp+md_len]; len
    lea     rsi, [rbp+abuflen]; d
    call    ASN1_OCTET_STRING_set
    test    eax, eax
    jz      loc_4C4854
    mov     [rbp+os], r14
    mov     [rbp+btmp], bio_0
    jmp     loc_4C47A9
loc_4C4639:
    call    ASN1_OCTET_STRING_new
    test    rax, rax
    jz      loc_4C489D
    mov     os_0, rax
    mov     [rbp+btmp], bio_0
    mov     rax, [p7_0+20h]
    mov     rax, [rax+28h]
    mov     [rax+10h], os_0
loc_4C465A:
    test    si_sk, si_sk
    mov     [rbp+os], os_0
    jz      loc_4C47A9
    mov     rdi, si_sk; sk
    call    ossl_check_const_PKCS7_SIGNER_INFO_sk_type
    mov     r12, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     loc_4C47A9
    mov     [rbp+p7], p7_0
    xor     r14d, r14d
    mov     [rbp+ctx], ctx_tmp
    jmp     short loc_4C46B8
loc_4C4690:
    mov     rdi, si_0; si_0
    mov     rsi, ctx_tmp; mctx
    call    do_pkcs7_signed_attrib
    test    eax, eax
    jz      err
loc_4C46A3:
    add     r14d, 1
    mov     rdi, r12; st
    call    OPENSSL_sk_num
    cmp     r14d, eax
    jge     loc_4C47A5
loc_4C46B8:
    mov     rdi, r12; st
    mov     esi, r14d; i
    call    OPENSSL_sk_value
    cmp     qword ptr [rax+38h], 0
    jz      short loc_4C46A3
    mov     r15, rax
    mov     rax, [rax+10h]
    mov     rdi, [rax]; a
    call    OBJ_obj2nid
    lea     rdi, [rbp+mdc]; pmd
    mov     rsi, [rbp+btmp]; bio
    mov     edx, eax; nid
    call    PKCS7_find_digest
    xor     ebx, ebx
    test    btmp_0, btmp_0
    jz      err
    mov     rsi, [rbp+mdc]; in
    mov     rdi, ctx_tmp; out
    call    EVP_MD_CTX_copy_ex
    test    eax, eax
    jz      err
    mov     rdi, [si_0+18h]; sk
    call    ossl_check_const_X509_ATTRIBUTE_sk_type
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jg      loc_4C4690
    mov     rdi, [si_0+38h]; pkey
    call    EVP_PKEY_get_size
    mov     dword ptr [rbp+abuflen], eax
    mov     edi, eax; ctx
    lea     rsi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     edx, 364h; line
    call    CRYPTO_malloc
    test    rax, rax
    jz      loc_4C492E
    mov     ctx_tmp, rax
    mov     rax, [si_0+38h]
    mov     [rbp+pkey], rax
    call    ossl_pkcs7_ctx_get0_libctx
    mov     [rbp+libctx], rax
    call    ossl_pkcs7_ctx_get0_propq
    mov     rdi, [rbp+ctx]; ctx
    mov     rsi, abuf; sigret
    lea     rdx, [rbp+abuflen]; siglen
    mov     rcx, [rbp+pkey]; pkey
    mov     r8, [rbp+libctx]; libctx
    mov     r9, rax; propq
    call    EVP_SignFinal_ex
    test    eax, eax
    jz      loc_4C48EB
    mov     rdi, [si_0+28h]; str
    mov     edx, dword ptr [rbp+abuflen]; len
    mov     rsi, abuf; data
    call    ASN1_STRING_set0
    mov     abuf, [rbp+ctx]
    jmp     loc_4C46A3
loc_4C47A5:
    mov     rbx, [rbp+p7]
loc_4C47A9:
    mov     r14, rbx
    mov     rdi, [rbx+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 16h
    jnz     short loc_4C47D9
    mov     rdi, r14; p7
    mov     esi, 2; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    PKCS7_ctrl
    mov     ebx, 1
    test    rax, rax
    jnz     err
loc_4C47D9:
    mov     r12, [rbp+os]
    test    r12, r12
    jz      short loc_4C4854
    mov     ebx, 1
    test    byte ptr [r12+10h], 10h
    jnz     err
    mov     rdi, [rbp+btmp]; bio
    mov     esi, 401h; type
    call    BIO_find_type
    test    rax, rax
    jz      short loc_4C4858
    mov     r14, rax
    lea     rcx, [rbp+abuflen]; parg
    mov     rdi, rax; b
    mov     esi, 3; cmd
    xor     edx, edx; larg
    call    BIO_ctrl
    mov     r15, rax
    mov     rdi, btmp_0; b
    mov     esi, 200h; flags
    call    BIO_set_flags
    mov     rdi, btmp_0; b
    mov     esi, 82h; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    BIO_ctrl
    mov     rsi, [rbp+abuflen]; data
    mov     rdi, r12; str
    mov     edx, r15d; len
    call    ASN1_STRING_set0
    jmp     short err
loc_4C4854:
    xor     ebx, ebx
    jmp     short err
loc_4C4858:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 38Ah; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     edi, 21h ; '!'
    mov     esi, 6Bh ; 'k'
    jmp     short loc_4C48C6
loc_4C4883:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 322h
    jmp     short loc_4C48B5
loc_4C489D:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     esi, 316h; line
loc_4C48B5:
    call    ERR_set_debug
    xor     ebx, ebx
    mov     edi, 21h ; '!'; lib
    mov     esi, 0C0100h; reason
loc_4C48C6:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    mov     rdi, r13; ctx
    call    EVP_MD_CTX_free
loc_4C48D7:
    mov     eax, ebx
    add     rsp, 88h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_4C48EB:
    lea     i, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rdi, abuf; str
    mov     rsi, r14; file
    mov     edx, 36Bh; line
    call    CRYPTO_free
    call    ERR_new
    lea     rdx, aPkcs7Datafinal; "PKCS7_dataFinal"
    mov     rdi, r14; file
    mov     esi, 36Ch; line
    call    ERR_set_debug
    mov     edi, 21h ; '!'; lib
    mov     esi, 80006h; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
loc_4C492E:
    mov     r13, [rbp+ctx]
    jmp     short err
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
    mov     [rbp+pcert], pcert_0
    mov     r15, in_bio_0
    mov     [rbp+pkey], pkey_0
    mov     rbx, p7_0
    mov     [rbp+parg], 0
    mov     [rbp+ek], 0
    mov     [rbp+eklen], 0
    mov     rdi, [rdi+18h]; a
    call    OBJ_obj2nid
    mov     dword ptr [p7_0+10h], 0
    cmp     eax, 18h
    jz      loc_4C396E
    cmp     eax, 17h
    jz      loc_4C39F7
    cmp     eax, 16h
    jnz     loc_4C3A83
    mov     i, [p7_0+20h]
    mov     rdi, [rax+28h]; p7
    call    PKCS7_get_octet_string
    mov     r14, rax
    mov     rdi, [p7_0+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 16h
    jnz     loc_4C3AB2
    mov     rdi, p7_0; p7
    mov     esi, 2; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    PKCS7_ctrl
    test    data_body_0, data_body_0
    jnz     loc_4C3ABB
    test    rax, rax
    jnz     loc_4C3ABB
loc_4C393F:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1C4h; line
    call    ERR_set_debug
    xor     r15d, r15d
    mov     edi, 21h ; '!'
    mov     esi, 9Bh
    jmp     loc_4C3F15
loc_4C396E:
    mov     [rbp+p7], p7_0
    mov     i, [rbx+20h]
    mov     rcx, [rax+30h]
    mov     [rbp+rsk], rcx
    mov     r14, [rax+8]
    mov     rax, [rax+28h]
    mov     rcx, [rax+8]
    mov     rax, [rax+10h]
    mov     [rbp+data_body], rax
    mov     [rbp+enc_alg], rcx
    mov     rdx, [rcx]; a
    lea     rbx, [rbp+name]
    mov     rdi, rbx; buf
    mov     esi, 32h ; '2'; buf_len
    xor     ecx, ecx; no_name
    call    OBJ_obj2txt
    call    ERR_set_mark
    mov     rsi, rbx; algorithm
    call    EVP_CIPHER_fetch
    mov     rbx, rax
    mov     [rbp+cipher], rax
    test    rax, rax
    jnz     short loc_4C39ED
    lea     rdi, [rbp+name]; name
    call    EVP_get_cipherbyname
    mov     rcx, cipher_0
    mov     [rbp+cipher], rax
    test    rax, rax
    jz      loc_4C3EC7
loc_4C39ED:
    call    ERR_pop_to_mark
    jmp     loc_4C3AE8
loc_4C39F7:
    mov     [rbp+p7], p7_0
    mov     i, [rbx+20h]
    mov     rcx, [rax+8]
    mov     [rbp+rsk], rcx
    mov     rax, [rax+10h]
    mov     rcx, [rax+8]
    mov     rax, [rax+10h]
    mov     [rbp+data_body], rax
    mov     [rbp+enc_alg], rcx
    mov     rdx, [rcx]; a
    lea     rbx, [rbp+name]
    mov     rdi, rbx; buf
    mov     esi, 32h ; '2'; buf_len
    xor     ecx, ecx; no_name
    call    OBJ_obj2txt
    call    ERR_set_mark
    mov     rsi, rbx; algorithm
    call    EVP_CIPHER_fetch
    mov     rbx, rax
    mov     [rbp+cipher], rax
    test    rax, rax
    jnz     short loc_4C3A72
    lea     rdi, [rbp+name]; name
    call    EVP_get_cipherbyname
    mov     rcx, cipher_0
    mov     [rbp+cipher], rax
    test    rax, rax
    jz      loc_4C3EE6
loc_4C3A72:
    mov     [rbp+evp_cipher], evp_cipher_0
    call    ERR_pop_to_mark
    xor     r12d, r12d
    jmp     loc_4C3C0B
loc_4C3A83:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1F6h; line
    call    ERR_set_debug
    xor     r15d, r15d
    mov     edi, 21h ; '!'
    mov     esi, 70h ; 'p'
    jmp     loc_4C3F15
loc_4C3AB2:
    test    data_body_0, data_body_0
    jz      loc_4C393F
loc_4C3ABB:
    mov     [rbp+data_body], data_body_0
    mov     [rbp+p7], p7_0
    mov     rax, [rbx+20h]
    mov     r14, [rax+8]
    xor     ebx, ebx
    xor     eax, eax
    mov     [rbp+cipher], rax
    xor     eax, eax
    mov     [rbp+enc_alg], rax
    xor     eax, eax
    mov     [rbp+rsk], rax
loc_4C3AE8:
    mov     [rbp+in_bio], in_bio_0
    xor     eax, eax
    mov     [rbp+tkeylen], rax
    test    md_sk, md_sk
    mov     [rbp+evp_cipher], evp_cipher_0
    jz      loc_4C3BF9
    mov     rdi, md_sk; sk
    call    ossl_check_const_X509_ALGOR_sk_type
    mov     md_sk, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    xor     r15d, r15d
    xor     r12d, r12d
    test    eax, eax
    jle     loc_4C3BFC
    mov     [rbp+st], r14
    jmp     short loc_4C3B54
loc_4C3B30:
    mov     rdi, out; b
    mov     rsi, rbx; bio
    call    BIO_push
loc_4C3B3B:
    mov     evp_md, [rbp+st]
    add     r15d, 1
    mov     rdi, r14; st
    call    OPENSSL_sk_num
    cmp     r15d, eax
    jge     loc_4C3BFC
loc_4C3B54:
    mov     rdi, r14; st
    mov     esi, r15d; i
    call    OPENSSL_sk_value
    mov     rbx, rax
    call    BIO_f_md
    mov     rdi, rax; method
    call    BIO_new
    test    btmp_0, btmp_0
    jz      loc_4C3CDF
    mov     [rbp+btmp], btmp_0
    mov     rdx, [xa]; a
    lea     xa, [rbp+name]
    mov     rdi, rbx; buf
    mov     esi, 32h ; '2'; buf_len
    xor     ecx, ecx; no_name
    call    OBJ_obj2txt
    call    ERR_set_mark
    mov     rsi, rbx; algorithm
    call    EVP_MD_fetch
    mov     r14, rax
    mov     r13, rax
    test    rax, rax
    jnz     short loc_4C3BC5
    lea     rdi, [rbp+name]; name
    call    EVP_get_digestbyname
    mov     r13, rax
    test    rax, rax
    jz      loc_4C3FD9
loc_4C3BC5:
    call    ERR_pop_to_mark
    mov     rbx, [rbp+btmp]
    mov     rdi, rbx; b
    mov     esi, 6Fh ; 'o'; cmd
    xor     edx, edx; larg
    mov     rcx, r13; parg
    call    BIO_ctrl
    mov     rdi, evp_md; md
    call    EVP_MD_free
    test    out, out
    jnz     loc_4C3B30
    mov     out, rbx
    jmp     loc_4C3B3B
loc_4C3BF9:
    xor     r12d, r12d
loc_4C3BFC:
    cmp     [rbp+cipher], 0
    mov     r15, [rbp+in_bio]
    jz      loc_4C412F
loc_4C3C0B:
    call    BIO_f_cipher
    mov     rdi, rax; method
    call    BIO_new
    test    etmp, etmp
    jz      short loc_4C3C98
    mov     rcx, etmp
    mov     [rbp+in_bio], r15
    mov     [rbp+st], r12
    cmp     [rbp+pcert], 0
    mov     r12, rax
    jz      loc_4C3D99
    mov     rdi, [rbp+rsk]; sk
    call    ossl_check_const_PKCS7_RECIP_INFO_sk_type
    mov     r14, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     loc_4C3D50
    xor     ebx, ebx
    nop     word ptr [rax+rax+00000000h]
loc_4C3C60:
    mov     rdi, r14; st
    mov     esi, ebx; i
    call    OPENSSL_sk_value
    mov     r15, rax
    mov     rdi, rax; ri
    mov     rsi, [rbp+pcert]; pcert
    call    pkcs7_cmp_ri
    test    eax, eax
    jz      loc_4C3D11
    add     ebx, 1
    mov     rdi, r14; st
    call    OPENSSL_sk_num
    cmp     ebx, eax
    jl      short loc_4C3C60
    jmp     loc_4C3D50
loc_4C3C98:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 22Ah; line
    call    ERR_set_debug
    xor     eax, eax
    mov     [rbp+btmp], rax
    mov     edi, 21h ; '!'; lib
    mov     esi, 80020h; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    xor     r14d, r14d
    xor     r13d, r13d
    mov     r15, r12
    xor     r12d, r12d
    jmp     loc_4C3D90
loc_4C3CDF:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 20Ah; line
    call    ERR_set_debug
    xor     eax, eax
    mov     [rbp+btmp], rax
    mov     edi, 21h ; '!'
    mov     esi, 80020h
    jmp     loc_4C4005
loc_4C3D11:
    test    r15, r15
    jz      short loc_4C3D50
    cmp     [rbp+pcert], 0
    jz      short loc_4C3D99
    lea     rdi, [rbp+ek]; pek
    lea     rsi, [rbp+eklen]; peklen
    mov     rdx, r15; ri
    mov     rcx, [rbp+pkey]; pkey
    xor     r8d, r8d; fixlen
    call    pkcs7_decrypt_rinfo
    test    eax, eax
    js      loc_4C402E
    mov     [rbp+b], r12
    call    ERR_clear_error
    jmp     loc_4C3E0A
loc_4C3D50:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 241h; line
    call    ERR_set_debug
    xor     eax, eax
    mov     [rbp+btmp], rax
    mov     edi, 21h ; '!'; lib
    mov     esi, 73h ; 's'; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    xor     r14d, r14d
loc_4C3D89:
    xor     r13d, r13d
loc_4C3D8C:
    mov     r15, [rbp+st]
loc_4C3D90:
    mov     rdi, [rbp+evp_cipher]
    jmp     err
loc_4C3D99:
    mov     [rbp+b], r12
    mov     rdi, [rbp+rsk]; sk
    call    ossl_check_const_PKCS7_RECIP_INFO_sk_type
    mov     r12, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     short loc_4C3E0A
    lea     r14, [rbp+ek]
    lea     r15, [rbp+eklen]
    xor     ebx, ebx
    nop
loc_4C3DC0:
    mov     rdi, r12; st
    mov     esi, ebx; i
    call    OPENSSL_sk_value
    mov     r13, rax
    mov     rdi, [rbp+cipher]; cipher
    call    EVP_CIPHER_get_key_length
    movsxd  r8, eax; fixlen
    mov     rdi, r14; pek
    mov     rsi, r15; peklen
    mov     rdx, ri; ri
    mov     rcx, [rbp+pkey]; pkey
    call    pkcs7_decrypt_rinfo
    test    eax, eax
    js      loc_4C3F9B
    call    ERR_clear_error
    add     ebx, 1
    mov     rdi, r12; st
    call    OPENSSL_sk_num
    cmp     ebx, eax
    jl      short loc_4C3DC0
loc_4C3E0A:
    mov     [rbp+parg], 0
    lea     rcx, [rbp+parg]; parg
    mov     r12, [rbp+b]
    mov     rdi, r12; b
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
    jle     loc_4C3FC0
    mov     rdi, [rbp+parg]; c
    mov     rax, [rbp+enc_alg]
    mov     rsi, [rax+8]; type
    call    EVP_CIPHER_asn1_to_param
    test    eax, eax
    js      loc_4C3FB5
    mov     rdi, [rbp+parg]; ctx
    call    EVP_CIPHER_CTX_get_key_length
    test    eax, eax
    jle     loc_4C3FB5
    mov     ebx, eax
    movsxd  r13, eax
    lea     rsi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rdi, r13; num
    mov     edx, 267h; line
    call    CRYPTO_malloc
    test    rax, rax
    jz      loc_4C4023
    mov     r14, rax
    mov     rdi, [rbp+parg]; ctx
    mov     rsi, rax; key
    call    EVP_CIPHER_CTX_rand_key
    test    eax, eax
    jle     loc_4C403C
    mov     r15, [rbp+ek]
    test    ek_0, ek_0
    mov     [rbp+tkeylen], len
    jz      loc_4C404A
    mov     ebx, [rbp+eklen]
    jmp     loc_4C4057
loc_4C3EC7:
    call    ERR_clear_last_mark
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1DBh
    jmp     short loc_4C3F03
loc_4C3EE6:
    call    ERR_clear_last_mark
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 1F0h; line
loc_4C3F03:
    call    ERR_set_debug
    xor     r15d, r15d
    mov     edi, 21h ; '!'; lib
    mov     esi, 6Fh ; 'o'; reason
loc_4C3F15:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    xor     eax, eax
    mov     [rbp+btmp], rax
    xor     r12d, r12d
    xor     edi, edi; cipher
    xor     r14d, r14d
loc_4C3F2C:
    xor     r13d, r13d
    call    EVP_CIPHER_free
    mov     rdi, [rbp+ek]; str
    movsxd  rsi, [rbp+eklen]; num
    lea     rbx, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rdx, rbx; file
    mov     ecx, 2A9h; line
    call    CRYPTO_clear_free
    movsxd  rsi, r13d; num
    mov     rdi, tkey; str
    mov     rdx, rbx; file
    mov     ecx, 2AAh; line
    call    CRYPTO_clear_free
    mov     rdi, out; bio
    call    BIO_free_all
    mov     rdi, [rbp+btmp]; bio
    call    BIO_free_all
    mov     rdi, etmp; bio
    call    BIO_free_all
    xor     r12d, r12d
    xor     edi, edi; bio
    call    BIO_free_all
loc_4C3F86:
    mov     rax, r12
    add     rsp, 0B8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_4C3F9B:
    xor     eax, eax
    mov     [rbp+btmp], rax
    xor     r14d, r14d
    mov     rdi, [rbp+evp_cipher]
    mov     r15, [rbp+st]
    mov     r12, [rbp+b]
    jmp     loc_4C3F2C
loc_4C3FB5:
    xor     eax, eax
    mov     [rbp+btmp], rax
    xor     r14d, r14d
    jmp     short loc_4C3FC9
loc_4C3FC0:
    xor     r14d, r14d
    xor     eax, eax
    mov     [rbp+btmp], rax
loc_4C3FC9:
    xor     r13d, r13d
    mov     rdi, [rbp+evp_cipher]
    mov     r15, [rbp+st]
    jmp     err
loc_4C3FD9:
    call    ERR_clear_last_mark
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datadecod; "PKCS7_dataDecode"
    mov     esi, 219h; line
    call    ERR_set_debug
    mov     edi, 21h ; '!'; lib
    mov     esi, 6Dh ; 'm'; reason
loc_4C4005:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    xor     r14d, r14d
    xor     r13d, r13d
    mov     rdi, [rbp+evp_cipher]
    mov     i, out
    xor     r12d, r12d
    jmp     err
loc_4C4023:
    xor     eax, eax
    mov     [rbp+btmp], rax
    xor     r14d, r14d
    jmp     short loc_4C4042
loc_4C402E:
    xor     r14d, r14d
    xor     eax, eax
    mov     [rbp+btmp], rax
    jmp     loc_4C3D89
loc_4C403C:
    xor     eax, eax
    mov     [rbp+btmp], rax
loc_4C4042:
    mov     r13, len
    jmp     loc_4C3D8C
loc_4C404A:
    mov     [rbp+ek], tkey
    mov     [rbp+eklen], ebx
    mov     ek_0, r14
    xor     r14d, r14d
loc_4C4057:
    mov     rdi, [rbp+parg]; ctx
    call    EVP_CIPHER_CTX_get_key_length
    cmp     ebx, eax
    mov     [rbp+b], r12
    jz      short loc_4C40A1
    mov     rdi, [rbp+parg]; c
    mov     esi, ebx; keylen
    call    EVP_CIPHER_CTX_set_key_length
    test    eax, eax
    jnz     short loc_4C40A1
    movsxd  rsi, ebx; num
    lea     rdx, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rdi, ek_0; str
    mov     ecx, 27Ah; line
    call    CRYPTO_clear_free
    mov     [rbp+ek], tkey
    mov     rax, [rbp+tkeylen]
    mov     [rbp+eklen], eax
    mov     ebx, eax
    mov     ek_0, r14
    xor     r14d, r14d
loc_4C40A1:
    call    ERR_clear_error
    mov     rdi, [rbp+parg]; ctx
    xor     esi, esi; cipher
    xor     edx, edx; impl
    mov     rcx, ek_0; key
    xor     r8d, r8d; iv
    xor     r9d, r9d; enc
    call    EVP_CipherInit_ex
    test    eax, eax
    jle     short loc_4C410C
    movsxd  rsi, ebx; num
    lea     eklen_0, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    mov     rdi, ek_0; str
    mov     rdx, rbx; file
    mov     ecx, 285h; line
    call    CRYPTO_clear_free
    mov     [rbp+ek], 0
    mov     rdi, tkey; str
    mov     rsi, r13; num
    mov     rdx, rbx; file
    mov     ecx, 287h; line
    call    CRYPTO_clear_free
    mov     r12, [rbp+st]
    test    r12, r12
    jz      short loc_4C4127
    mov     rdi, r12; b
    mov     rsi, [rbp+b]; bio
    call    BIO_push
    jmp     short loc_4C412B
loc_4C410C:
    mov     ek_0, [rbp+st]
    xor     eax, eax
    mov     [rbp+btmp], rax
    mov     r13, [rbp+tkeylen]
    mov     rdi, [rbp+evp_cipher]
    mov     r12, [rbp+b]
    jmp     err
loc_4C4127:
    mov     r12, [rbp+b]
loc_4C412B:
    mov     r15, [rbp+in_bio]
loc_4C412F:
    mov     r14, [rbp+p7]
    mov     rdi, [r14+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 16h
    jnz     short loc_4C4161
    mov     rdi, r14; p7
    mov     esi, 2; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    PKCS7_ctrl
    test    r15, r15
    jnz     short loc_4C41AC
    test    rax, rax
    jz      short loc_4C4166
    jmp     short loc_4C41AC
loc_4C4161:
    test    r15, r15
    jnz     short loc_4C41AC
loc_4C4166:
    mov     rax, [rbp+data_body]
    mov     esi, [rax]; len
    test    esi, esi
    jle     short loc_4C4186
    mov     rdi, [rax+8]; buf
    call    BIO_new_mem_buf
    mov     r15, rax
    test    rax, rax
    jnz     short loc_4C41AC
    jmp     short loc_4C41C5
loc_4C4186:
    call    BIO_s_mem
    mov     rdi, rax; method
    call    BIO_new
    test    rax, rax
    jz      short loc_4C41C5
    mov     r15, rax
    mov     rdi, rax; b
    mov     esi, 82h; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    BIO_ctrl
loc_4C41AC:
    mov     rdi, out; b
    mov     rsi, bio; bio
    call    BIO_push
    mov     rdi, [rbp+evp_cipher]; cipher
    call    EVP_CIPHER_free
    jmp     loc_4C3F86
loc_4C41C5:
    xor     eax, eax
    mov     [rbp+btmp], rax
    xor     r14d, r14d
    mov     r15, out
    xor     r12d, r12d
    mov     r13, [rbp+tkeylen]
    jmp     loc_4C3D90
PKCS7_dataDecode endp



PKCS7_dataInit proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 98h
    mov     rbx, bio_0
    mov     r15, p7_0
    mov     [rbp+out], 0
    mov     rdi, [rdi+18h]; a
    call    OBJ_obj2nid
    mov     dword ptr [p7_0+10h], 0
    add     eax, 0FFFFFFEBh; switch 5 cases
    cmp     eax, 4
    ja      short def_4C313B; jumptable 00000000004C313B default case
    mov     [rbp+bio], bio_0
    xor     r12d, r12d
    lea     rcx, jpt_4C313B
    movsxd  rdx, ds:(jpt_4C313B - 6238C4h)[rcx+rax*4]
    add     rdx, rcx
    xor     r14d, r14d
    xor     ebx, ebx
    xor     esi, esi
    xor     ecx, ecx
    xor     eax, eax
def_4C313B:
    jmp     rdx; switch jump
    mov     rax, [p7_0+20h]; jumptable 00000000004C313B case 22
    mov     rbx, [rax+8]
    mov     rdi, [rax+28h]; p7
    call    PKCS7_get_octet_string
    xor     r12d, r12d
    xor     r14d, r14d
    jmp     loc_4C31E9
    call    ERR_new; jumptable 00000000004C313B default case
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 11Bh; line
    call    ERR_set_debug
    xor     ebx, ebx
    mov     edi, 21h ; '!'
    mov     esi, 70h ; 'p'
    jmp     loc_4C34BE
    mov     rax, [p7_0+20h]; jumptable 00000000004C313B case 23
    mov     rcx, [rax+10h]
    mov     r14, [rcx+18h]
    test    evp_cipher, evp_cipher
    jz      loc_4C347B
    mov     rsi, [rax+8]
    mov     rcx, [rcx+8]
    xor     r12d, r12d
    xor     ebx, ebx
    jmp     short loc_4C31CF
    mov     rax, [p7_0+20h]; jumptable 00000000004C313B case 24
    mov     rcx, [rax+28h]
    mov     r14, [rcx+18h]
    test    evp_cipher, evp_cipher
    jz      loc_4C3495
    mov     rsi, [rax+30h]
    mov     rbx, [rax+8]
    mov     rcx, [rcx+8]
    xor     r12d, r12d
loc_4C31CF:
    xor     eax, eax
    jmp     short loc_4C31ED; jumptable 00000000004C313B case 21
    mov     rax, [p7_0+20h]; jumptable 00000000004C313B case 25
    mov     r12, [rax+8]
    mov     rdi, [rax+10h]; p7
    call    PKCS7_get_octet_string
    xor     r14d, r14d
    xor     ebx, ebx
loc_4C31E9:
    xor     esi, esi
    xor     ecx, ecx
loc_4C31ED:
    mov     [rbp+btmp], xalg_0; jumptable 00000000004C313B case 21
    mov     [rbp+rsk], rsk_0
    mov     [rbp+os], os_0
    mov     [rbp+p7], p7_0
    mov     rdi, md_sk; sk
    call    ossl_check_const_X509_ALGOR_sk_type
    mov     md_sk, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     short loc_4C324F
    lea     r15, [rbp+out]
    xor     r13d, r13d
    nop     dword ptr [rax+rax+00h]
loc_4C3220:
    mov     rdi, rbx; st
    mov     esi, r13d; i
    call    OPENSSL_sk_value
    mov     rdi, r15; pbio
    mov     rsi, rax; alg
    call    pkcs7_bio_add_digest
    test    eax, eax
    jz      loc_4C3439
    add     r13d, 1
    mov     rdi, rbx; st
    call    OPENSSL_sk_num
    cmp     r13d, eax
    jl      short loc_4C3220
loc_4C324F:
    test    xa, xa
    jz      short loc_4C3268
    lea     rdi, [rbp+out]; pbio
    mov     rsi, xa; alg
    call    pkcs7_bio_add_digest
    test    eax, eax
    jz      loc_4C3588
loc_4C3268:
    test    evp_cipher, evp_cipher
    mov     r13, [rbp+p7]
    jz      loc_4C34DD
    call    BIO_f_cipher
    mov     rdi, rax; method
    call    BIO_new
    mov     rbx, rax
    test    rax, rax
    jz      loc_4C3443
    lea     rcx, [rbp+parg]; parg
    mov     rdi, btmp_0; b
    mov     esi, 81h; cmd
    xor     edx, edx; larg
    call    BIO_ctrl
    mov     rdi, evp_cipher; cipher
    call    EVP_CIPHER_get_key_length
    mov     [rbp+keylen], eax
    mov     rdi, evp_cipher; cipher
    call    EVP_CIPHER_get_iv_length
    mov     r15d, eax
    mov     rdi, evp_cipher; cipher
    call    EVP_CIPHER_get_type
    mov     edi, eax; ctx
    call    OBJ_nid2obj
    mov     rcx, [rbp+btmp]
    mov     [rcx], rax
    test    r15d, r15d
    jle     short loc_4C32EB
    movsxd  rdx, r15d; num
    lea     rsi, [rbp+iv]; buf
    xor     r12d, r12d
    xor     ecx, ecx; strength
    call    RAND_bytes_ex
    test    eax, eax
    jle     err
loc_4C32EB:
    call    ERR_set_mark
    mov     rdi, evp_cipher; cipher
    call    EVP_CIPHER_get0_name
    mov     rsi, rax; algorithm
    call    EVP_CIPHER_fetch
    mov     r12, rax
    call    ERR_pop_to_mark
    test    fetched_cipher, fetched_cipher
    cmovnz  evp_cipher, fetched_cipher
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
    jle     loc_4C358A
    mov     rdi, [rbp+parg]; ctx
    xor     r12d, r12d
    lea     rcx, [rbp+key]; key
    lea     r8, [rbp+iv]; iv
    mov     esi, 0; cipher
    xor     edx, edx; impl
    mov     r9d, 1; enc
    call    EVP_CipherInit_ex
    test    eax, eax
    jle     err
    test    r15d, r15d
    jle     short loc_4C33B7
    mov     rax, [rbp+btmp]
    mov     rsi, [rax+8]
    test    rsi, rsi
    jnz     short loc_4C33A6
    mov     cipher, rax
    call    ASN1_TYPE_new
    mov     rsi, rax; type
    mov     [r14+8], rax
    test    rax, rax
    jz      loc_4C358A
loc_4C33A6:
    mov     rdi, [rbp+parg]; c
    call    EVP_CIPHER_param_to_asn1
    test    eax, eax
    js      loc_4C358A
loc_4C33B7:
    mov     [rbp+btmp], btmp_0
    mov     rdi, [rbp+rsk]; sk
    call    ossl_check_const_PKCS7_RECIP_INFO_sk_type
    mov     ivlen, rax
    mov     rdi, rax; st
    call    OPENSSL_sk_num
    test    eax, eax
    jle     short loc_4C340E
    xor     r12d, r12d
    lea     r14, [rbp+key]
    xor     ebx, ebx
loc_4C33DF:
    mov     rdi, r15; st
    mov     esi, ebx; i
    call    OPENSSL_sk_value
    mov     rdi, ri; ri
    mov     rsi, r14; key
    mov     edx, [rbp+keylen]; keylen
    call    pkcs7_encode_rinfo
    test    eax, eax
    jle     loc_4C34CC
    add     ebx, 1
    mov     rdi, r15; st
    call    OPENSSL_sk_num
    cmp     ebx, eax
    jl      short loc_4C33DF
loc_4C340E:
    movsxd  rsi, [rbp+keylen]
    lea     rdi, [rbp+key]
    call    OPENSSL_cleanse
    mov     rdi, [rbp+out]; b
    test    out_0, out_0
    jz      loc_4C34D5
    mov     rsi, [rbp+btmp]; bio
    call    BIO_push
    jmp     loc_4C34DD
loc_4C3439:
    xor     r12d, r12d
    xor     ebx, ebx
    jmp     err
loc_4C3443:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 12Dh; line
    call    ERR_set_debug
    xor     r12d, r12d
    mov     edi, 21h ; '!'; lib
    mov     esi, 80020h; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     err
loc_4C347B:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 110h
    jmp     short loc_4C34AD
loc_4C3495:
    call    ERR_new
    lea     rdi, aCryptoPkcs7Pk7_0; "crypto/pkcs7/pk7_doit.c"
    lea     rdx, aPkcs7Datainit; "PKCS7_dataInit"
    mov     esi, 107h; line
loc_4C34AD:
    call    ERR_set_debug
    xor     ebx, ebx
    mov     edi, 21h ; '!'; lib
    mov     esi, 74h ; 't'; reason
loc_4C34BE:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     loc_4C358A
loc_4C34CC:
    mov     i, [rbp+btmp]
    jmp     err
loc_4C34D5:
    mov     rax, [rbp+btmp]
    mov     [rbp+out], rax
loc_4C34DD:
    mov     r14, [rbp+bio]
    test    r14, r14
    jz      short loc_4C34FF
loc_4C34E6:
    mov     rbx, [rbp+out]
    test    out_0, out_0
    jz      short loc_4C3532
    mov     rdi, out_0; b
    mov     rsi, bio_0; bio
    call    BIO_push
    jmp     loc_4C35A8
loc_4C34FF:
    mov     rdi, [r13+18h]; a
    call    OBJ_obj2nid
    cmp     eax, 16h
    jnz     short loc_4C353B
    mov     rdi, r13; p7
    mov     esi, 2; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    PKCS7_ctrl
    test    rax, rax
    jz      short loc_4C353B
    call    BIO_s_null
    mov     rdi, rax; method
    call    BIO_new
    jmp     short loc_4C3553
loc_4C3532:
    mov     [rbp+out], bio_0
    mov     out_0, bio_0
    jmp     short loc_4C35A8
loc_4C353B:
    mov     rax, [rbp+os]
    test    rax, rax
    jz      short loc_4C355D
    mov     esi, [rax]; len
    test    esi, esi
    jle     short loc_4C355D
    mov     rdi, [rax+8]; buf
    call    BIO_new_mem_buf
loc_4C3553:
    mov     r14, rax
    test    rax, rax
    jnz     short loc_4C34E6
    jmp     short loc_4C3588
loc_4C355D:
    call    BIO_s_mem
    mov     rdi, rax; method
    call    BIO_new
    test    rax, rax
    jz      short loc_4C3588
    mov     r14, rax
    mov     rdi, rax; b
    mov     esi, 82h; cmd
    xor     edx, edx; larg
    xor     ecx, ecx; parg
    call    BIO_ctrl
    jmp     loc_4C34E6
loc_4C3588:
    xor     ebx, ebx
loc_4C358A:
    xor     r12d, r12d
    mov     rdi, fetched_cipher; cipher
    call    EVP_CIPHER_free
    mov     rdi, [rbp+out]; bio
    call    BIO_free_all
    mov     rdi, btmp_0; bio
    call    BIO_free_all
    xor     ebx, ebx
loc_4C35A8:
    mov     rax, rbx
    add     rsp, 98h
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

