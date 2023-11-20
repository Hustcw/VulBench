EVP_EncodeUpdate proc
    push    rbp
    mov     rbp, rsp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 18h
    mov     dword ptr [outl_0], 0
    test    r8d, r8d
    jle     short loc_5D0EF9
    mov     r12, in
    mov     r14, ctx
    mov     ecx, [rdi+4]; dlen
    cmp     ecx, 51h ; 'Q'
    jge     loc_5D1026
    mov     ebx, r8d
    mov     r13, out
    movsxd  rax, dword ptr [ctx]
    lea     esi, [rax+inl]
    cmp     esi, ecx
    jge     short loc_5D0F00
    lea     rdi, [ctx+rax]
    add     rdi, 8; dest
    movsxd  outl_0, ebx; n
    mov     rsi, in; src
    call    _memcpy
    add     [ctx], ebx
    jmp     loc_5D1012
loc_5D0EF9:
    xor     eax, eax
    jmp     loc_5D1017
loc_5D0F00:
    mov     [rbp+outl], outl_0
    test    eax, eax
    jz      short loc_5D0F75
    sub     ecx, eax
    lea     rdi, [ctx+rax]
    add     rdi, 8; dest
    lea     r15, [ctx+8]
    movsxd  rdx, ecx; n
    mov     rsi, in; src
    mov     [rbp+var_38], rdx
    call    _memcpy
    mov     ecx, [ctx+4]; dlen
    mov     rdi, ctx; ctx
    mov     rsi, out; t
    mov     rdx, r15; f
    call    evp_encodeblock_int
    mov     dword ptr [ctx], 0
    movsxd  r15, eax
    add     out, total
    test    byte ptr [ctx+5Ch], 1
    jnz     short loc_5D0F58
    mov     byte ptr [out+0], 0Ah
    add     out, 1
    add     total, 1
loc_5D0F58:
    mov     j, [rbp+var_38]
    add     in, rax
    sub     ebx, eax
    mov     byte ptr [out+0], 0
    mov     ecx, [ctx+4]
    cmp     total, 7FFFFFFFh
    jbe     short loc_5D0F90
    jmp     short loc_5D0FDE
loc_5D0F75:
    xor     r15d, r15d
    cmp     total, 7FFFFFFFh
    ja      short loc_5D0FDE
    nop     word ptr [rax+rax+00000000h]
    nop     dword ptr [rax+rax+00h]
loc_5D0F90:
    cmp     ebx, ecx
    jl      short loc_5D0FDE
loc_5D0F94:
    mov     rdi, ctx; ctx
    mov     rsi, out; t
    mov     rdx, in; f
    call    evp_encodeblock_int
    movsxd  rcx, dword ptr [ctx+4]
    cdqe
    add     out, rax
    add     total, rax
    test    byte ptr [ctx+5Ch], 1
    jnz     short loc_5D0FC2
    mov     byte ptr [out+0], 0Ah
    add     out, 1
    add     total, 1
loc_5D0FC2:
    add     in, rcx
    sub     ebx, ecx
    mov     byte ptr [out+0], 0
    mov     eax, 80000000h
    cmp     total, rax
    jnb     short loc_5D0FDE
    mov     ecx, [ctx+4]
    cmp     ebx, ecx
    jge     short loc_5D0F94
loc_5D0FDE:
    test    total, 0FFFFFFFF80000000h
    jz      short loc_5D0FF5
    mov     rax, [rbp+outl]
    mov     dword ptr [rax], 0
    xor     eax, eax
    jmp     short loc_5D1017
loc_5D0FF5:
    test    ebx, ebx
    jz      short loc_5D1008
    lea     rdi, [ctx+8]; dest
    movsxd  rdx, ebx; n
    mov     rsi, in; src
    call    _memcpy
loc_5D1008:
    mov     [ctx], ebx
    mov     rax, [rbp+outl]
    mov     [rax], r15d
loc_5D1012:
    mov     eax, 1
loc_5D1017:
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_5D1026:
    lea     rdi, aAssertionFaile_139; "assertion failed: ctx->length <= (int)s"...
    lea     out, aCryptoEvpEncod; "crypto/evp/encode.c"
    mov     edx, 0ABh; line
    call    OPENSSL_die
EVP_EncodeUpdate endp

