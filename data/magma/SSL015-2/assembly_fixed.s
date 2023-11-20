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

