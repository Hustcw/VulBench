asn1_d2i_read_bio proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 48h
    mov     rbx, pb_0
    mov     [rbp+in], in_0
    call    BUF_MEM_new
    test    rax, rax
    jz      loc_571EE7
    mov     r12, rax
    mov     [rbp+pb], pb_0
    call    ERR_set_mark
    xor     ecx, ecx
    xor     r15d, r15d
    xor     r14d, r14d
    mov     [rbp+str], b
loc_571C8E:
    mov     [rbp+eos], eos_0
    mov     r13, r15
loc_571C95:
    mov     r15, len
    sub     r15, off
    cmp     diff, 9
    jnb     short loc_571D20
    mov     ebx, 8
    sub     rbx, diff
    mov     rsi, want
    add     rsi, len; len
    jb      loc_571F6F
    mov     rdi, b; str
    call    BUF_MEM_grow_clean
    test    rax, rax
    jz      loc_571F6F
    mov     rsi, [b+8]
    add     rsi, len; data
    mov     rdi, [rbp+in]; b
    mov     edx, ebx; dlen
    call    BIO_read
    test    diff, diff
    jnz     short loc_571CE6
    test    eax, eax
    js      loc_571FCC
loc_571CE6:
    test    eax, eax
    jle     short loc_571CFB
    cdqe
    add     len, rax
    jb      loc_57200F
    mov     diff, r14
    sub     r15, off
loc_571CFB:
    mov     want, [b+8]
    mov     b, off
    add     rbx, off
    mov     [rbp+q], q_0
    test    diff, diff
    jnz     short loc_571D2F
    jmp     err
loc_571D20:
    mov     rbx, [b+8]
    mov     b, off
    add     rbx, off
    mov     [rbp+q], rbx
loc_571D2F:
    lea     rdi, [rbp+q]; pp
    lea     rsi, [rbp+slen]; plength
    lea     rdx, [rbp+tag]; ptag
    lea     rcx, [rbp+xclass]; pclass
    mov     r8, diff; omax
    call    ASN1_get_object
    mov     r13d, eax
    test    r13b, r13b
    jns     short loc_571D6C
    call    ERR_peek_last_error
    mov     rdi, rax; errcode
    call    ERR_GET_REASON_10
    cmp     eax, 9Bh
    jnz     err
    call    ERR_pop_to_mark
loc_571D6C:
    mov     eax, dword ptr [rbp+q]
    sub     eax, ebx
    movsxd  diff, eax
    add     r15, r12
    test    r13b, 1
    jnz     loc_571E94
    mov     inf, [rbp+slen]
    mov     rcx, [rbp+eos]
    test    ecx, ecx
    jz      short loc_571D9C
    test    slen_0, slen_0
    jnz     short loc_571D9C
    cmp     [rbp+tag], 0
    jz      loc_571EAD
loc_571D9C:
    mov     rax, len
    sub     rax, off
    mov     r12, slen_0
    sub     r12, rax
    jbe     short loc_571DE0
    cmp     want, 7FFFFFFFh
    ja      loc_571FE9
    mov     rax, len
    not     rax
    cmp     want, rax
    ja      loc_571FE9
    test    want, want
    jz      short loc_571DE0
    mov     ebx, 4000h
    jmp     short loc_571E19
loc_571DE0:
    mov     r12, [rbp+str]
    add     slen_0, off
    jb      loc_571FB2
loc_571DED:
    test    ecx, ecx
    jnz     loc_571C95
    jmp     loc_571EBD
loc_571E00:
    sub     want, r13
    mov     rbx, [rbp+chunk_max]
    cmp     rbx, 3FFFFFFFh
    setb    cl
    shl     rbx, cl
    test    want, want
    jz      short loc_571E7A
loc_571E19:
    cmp     want, chunk_max_0
    mov     slen_0, want
    cmova   r13, chunk_max_0
    lea     rsi, [len+chunk]; len
    mov     rdi, [rbp+str]; str
    call    BUF_MEM_grow_clean
    test    rax, rax
    jz      loc_571F89
    mov     [rbp+chunk_max], chunk_max_0
    test    chunk, chunk
    jz      short loc_571E00
    mov     rbx, chunk
    nop     word ptr [rax+rax+00000000h]
    nop
loc_571E50:
    mov     rax, [rbp+str]
    mov     rsi, [rax+8]
    add     rsi, len; data
    mov     rdi, [rbp+in]; b
    mov     edx, ebx; dlen
    call    BIO_read
    test    eax, eax
    jle     loc_571F19
    cdqe
    add     len, rax
    sub     chunk, rax
    jnz     short loc_571E50
    jmp     short loc_571E00
loc_571E7A:
    mov     r13, [rbp+slen]
    mov     want, [rbp+str]
    mov     rcx, [rbp+eos]
    add     slen_0, off
    jnb     loc_571DED
    jmp     loc_571FB2
loc_571E94:
    mov     rcx, [rbp+eos]
    cmp     ecx, 0FFFFFFFFh
    jz      loc_57203B
    add     ecx, 1
    mov     r12, [rbp+str]
    jmp     loc_571C8E
loc_571EAD:
    mov     slen_0, off
    add     ecx, 0FFFFFFFFh
    mov     r12, [rbp+str]
    jnz     loc_571C8E
loc_571EBD:
    test    off, 0FFFFFFFF80000000h
    jz      loc_572003
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 100h
    jmp     loc_572027
loc_571EE7:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 7Eh ; '~'; line
    call    ERR_set_debug
    mov     edi, 0Dh; lib
    mov     esi, 0C0100h; reason
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    jmp     short loc_571F57
loc_571F19:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0E5h; line
loc_571F31:
    call    ERR_set_debug
    mov     edi, 0Dh; lib
    mov     esi, 8Eh; reason
loc_571F40:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    call    ERR_clear_last_mark
    mov     rdi, [rbp+str]; a
    call    BUF_MEM_free
loc_571F57:
    mov     r13d, 0FFFFFFFFh
loc_571F5D:
    mov     eax, r13d
    add     rsp, 48h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_571F6F:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 89h
    jmp     short loc_571FA1
loc_571F89:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0D4h; line
loc_571FA1:
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 0C0100h
    jmp     short loc_571F40
loc_571FB2:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0F4h
    jmp     short loc_572027
loc_571FCC:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 8Eh
    jmp     loc_571F31
loc_571FE9:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0C7h
    jmp     short loc_572027
loc_572003:
    mov     rax, [rbp+pb]
    mov     [rax], r12
    jmp     loc_571F5D
loc_57200F:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 93h; line
loc_572027:
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 9Bh
    jmp     loc_571F40
loc_57203B:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0AFh; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 7Bh ; '{'
    jmp     loc_571F40
asn1_d2i_read_bio endp

