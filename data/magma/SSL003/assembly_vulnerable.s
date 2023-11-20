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
    jz      loc_42EF4F
    mov     r13, rax
    mov     [rbp+pb], pb_0
    call    ERR_set_mark
    xor     ecx, ecx
    xor     r15d, r15d
    xor     r14d, r14d
    mov     [rbp+str], b
loc_42ED0E:
    mov     [rbp+eos], eos_0
    mov     r12, r15
loc_42ED15:
    mov     r15, len
    sub     r15, off
    cmp     diff, 9
    jnb     short loc_42EDA0
    mov     ebx, 8
    sub     rbx, diff
    mov     rsi, want_0
    add     rsi, len; len
    jb      loc_42EFD7
    mov     rdi, b; str
    call    BUF_MEM_grow_clean
    test    rax, rax
    jz      loc_42EFD7
    mov     rsi, [b+8]
    add     rsi, len; data
    mov     rdi, [rbp+in]; b
    mov     edx, ebx; dlen
    call    BIO_read
    test    diff, diff
    jnz     short loc_42ED65
    test    eax, eax
    js      loc_42F034
loc_42ED65:
    test    eax, eax
    jle     short loc_42ED7A
    cdqe
    add     len, rax
    jb      loc_42F077
    mov     diff, r14
    sub     r15, off
loc_42ED7A:
    mov     want_0, [b+8]
    mov     b, off
    add     rbx, off
    mov     [rbp+q], q_0
    test    diff, diff
    jnz     short loc_42EDAE
    jmp     err
loc_42EDA0:
    mov     rbx, [b+8]
    mov     b, off
    add     rbx, off
    mov     [rbp+q], rbx
loc_42EDAE:
    lea     rdi, [rbp+q]; pp
    lea     rsi, [rbp+slen]; plength
    lea     rdx, [rbp+tag]; ptag
    lea     rcx, [rbp+xclass]; pclass
    mov     r8, diff; omax
    call    ASN1_get_object
    mov     r12d, eax
    test    r12b, r12b
    jns     short loc_42EDEB
    call    ERR_peek_last_error
    mov     rdi, rax; errcode
    call    ERR_GET_REASON_1
    cmp     eax, 9Bh
    jnz     err
    call    ERR_pop_to_mark
loc_42EDEB:
    mov     eax, dword ptr [rbp+q]
    sub     eax, ebx
    movsxd  diff, eax
    add     r15, r13
    test    r12b, 1
    jnz     loc_42EEFC
    mov     inf, [rbp+slen]
    mov     rcx, [rbp+eos]
    test    ecx, ecx
    jz      short loc_42EE1B
    test    slen_0, slen_0
    jnz     short loc_42EE1B
    cmp     [rbp+tag], 0
    jz      loc_42EF15
loc_42EE1B:
    mov     rax, len
    sub     rax, off
    mov     r13, slen_0
    sub     r13, rax
    jbe     short loc_42EE4D
    cmp     chunk_max, 7FFFFFFFh
    ja      loc_42F051
    mov     rax, len
    not     rax
    cmp     chunk_max, rax
    ja      loc_42F051
    mov     rbx, chunk_max
    test    chunk_max, chunk_max
    jnz     short loc_42EE8D
loc_42EE4D:
    add     slen_0, off
    jb      loc_42F01A
loc_42EE56:
    test    ecx, ecx
    mov     r13, [rbp+str]
    jnz     loc_42ED15
    jmp     loc_42EF25
loc_42EE70:
    mov     rbx, [rbp+want]
    sub     rbx, r12
    cmp     chunk_max, 3FFFFFFFh
    setb    cl
    shl     chunk_max, cl
    test    want_0, want_0
    mov     rcx, [rbp+eos]
    jz      short loc_42EEEA
loc_42EE8D:
    cmp     want_0, chunk_max
    mov     slen_0, want_0
    cmova   r12, chunk_max
    lea     rsi, [chunk+len]; len
    mov     rdi, [rbp+str]; str
    call    BUF_MEM_grow_clean
    test    rax, rax
    jz      loc_42EFF1
    mov     [rbp+want], want_0
    test    chunk, chunk
    jz      short loc_42EE70
    mov     rbx, chunk
    nop     dword ptr [rax+00000000h]
loc_42EEC0:
    mov     rax, [rbp+str]
    mov     rsi, [rax+8]
    add     rsi, len; data
    mov     rdi, [rbp+in]; b
    mov     edx, ebx; dlen
    call    BIO_read
    test    eax, eax
    jle     loc_42EF81
    cdqe
    add     len, rax
    sub     chunk, rax
    jnz     short loc_42EEC0
    jmp     short loc_42EE70
loc_42EEEA:
    mov     r12, [rbp+slen]
    add     slen_0, off
    jnb     loc_42EE56
    jmp     loc_42F01A
loc_42EEFC:
    mov     rcx, [rbp+eos]
    cmp     ecx, 0FFFFFFFFh
    jz      loc_42F0A3
    add     ecx, 1
    mov     r13, [rbp+str]
    jmp     loc_42ED0E
loc_42EF15:
    mov     slen_0, off
    add     ecx, 0FFFFFFFFh
    mov     r13, [rbp+str]
    jnz     loc_42ED0E
loc_42EF25:
    test    off, 0FFFFFFFF80000000h
    jz      loc_42F06B
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 100h
    jmp     loc_42F08F
loc_42EF4F:
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
    jmp     short loc_42EFBF
loc_42EF81:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0E5h; line
loc_42EF99:
    call    ERR_set_debug
    mov     edi, 0Dh; lib
    mov     esi, 8Eh; reason
loc_42EFA8:
    xor     edx, edx; fmt
    xor     eax, eax
    call    ERR_set_error
    call    ERR_clear_last_mark
    mov     rdi, [rbp+str]; a
    call    BUF_MEM_free
loc_42EFBF:
    mov     r12d, 0FFFFFFFFh
loc_42EFC5:
    mov     eax, r12d
    add     rsp, 48h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_42EFD7:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 89h
    jmp     short loc_42F009
loc_42EFF1:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0D4h; line
loc_42F009:
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 0C0100h
    jmp     short loc_42EFA8
loc_42F01A:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0F4h
    jmp     short loc_42F08F
loc_42F034:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 8Eh
    jmp     loc_42EF99
loc_42F051:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0C7h
    jmp     short loc_42F08F
loc_42F06B:
    mov     rax, [rbp+pb]
    mov     [rax], r13
    jmp     loc_42EFC5
loc_42F077:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 93h; line
loc_42F08F:
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 9Bh
    jmp     loc_42EFA8
loc_42F0A3:
    call    ERR_new
    lea     rdi, aCryptoAsn1AD2i; "crypto/asn1/a_d2i_fp.c"
    lea     rdx, aAsn1D2iReadBio; "asn1_d2i_read_bio"
    mov     esi, 0AFh; line
    call    ERR_set_debug
    mov     edi, 0Dh
    mov     esi, 7Bh ; '{'
    jmp     loc_42EFA8
asn1_d2i_read_bio endp

