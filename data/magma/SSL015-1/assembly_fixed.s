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

