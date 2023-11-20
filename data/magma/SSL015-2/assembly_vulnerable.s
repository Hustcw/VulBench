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

