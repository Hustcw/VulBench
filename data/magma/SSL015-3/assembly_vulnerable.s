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

