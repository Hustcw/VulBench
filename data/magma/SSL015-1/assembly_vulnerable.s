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

