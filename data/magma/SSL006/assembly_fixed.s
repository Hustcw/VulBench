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
    jle     short loc_5EFADF
    mov     r12, in
    mov     r14, ctx
    movsxd  rcx, dword ptr [rdi+4]; dlen
    cmp     rcx, 51h ; 'Q'
    jge     loc_5EFC06
    mov     ebx, r8d
    mov     r13, out
    movsxd  rsi, dword ptr [ctx]
    mov     rax, rcx
    sub     rax, rsi
    cmp     eax, r8d
    jle     short loc_5EFAE6
    lea     rdi, [ctx+rsi]
    add     rdi, 8; dest
    movsxd  outl_0, ebx; n
    mov     rsi, in; src
    call    _memcpy
    add     [ctx], ebx
    jmp     loc_5EFBF2
loc_5EFADF:
    xor     eax, eax
    jmp     loc_5EFBF7
loc_5EFAE6:
    mov     [rbp+outl], outl_0
    test    esi, esi
    jz      short loc_5EFB59
    lea     rdi, [ctx+rsi]
    add     rdi, 8; dest
    lea     r15, [ctx+8]
    mov     rsi, in; src
    mov     [rbp+var_38], i
    mov     rdx, i; n
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
    jnz     short loc_5EFB3C
    mov     byte ptr [out+0], 0Ah
    add     out, 1
    add     total, 1
loc_5EFB3C:
    mov     j, [rbp+var_38]
    add     in, rax
    sub     ebx, eax
    mov     byte ptr [out+0], 0
    mov     ecx, [ctx+4]
    cmp     total, 7FFFFFFFh
    jbe     short loc_5EFB70
    jmp     short loc_5EFBBE
loc_5EFB59:
    xor     r15d, r15d
    cmp     total, 7FFFFFFFh
    ja      short loc_5EFBBE
    nop     word ptr [rax+rax+00000000h]
    nop
loc_5EFB70:
    cmp     ebx, ecx
    jl      short loc_5EFBBE
loc_5EFB74:
    mov     rdi, ctx; ctx
    mov     rsi, out; t
    mov     rdx, in; f
    call    evp_encodeblock_int
    movsxd  rcx, dword ptr [ctx+4]
    cdqe
    add     out, rax
    add     total, rax
    test    byte ptr [ctx+5Ch], 1
    jnz     short loc_5EFBA2
    mov     byte ptr [out+0], 0Ah
    add     out, 1
    add     total, 1
loc_5EFBA2:
    add     in, rcx
    sub     ebx, ecx
    mov     byte ptr [out+0], 0
    mov     eax, 80000000h
    cmp     total, rax
    jnb     short loc_5EFBBE
    mov     ecx, [ctx+4]
    cmp     ebx, ecx
    jge     short loc_5EFB74
loc_5EFBBE:
    test    total, 0FFFFFFFF80000000h
    jz      short loc_5EFBD5
    mov     rax, [rbp+outl]
    mov     dword ptr [rax], 0
    xor     eax, eax
    jmp     short loc_5EFBF7
loc_5EFBD5:
    test    ebx, ebx
    jz      short loc_5EFBE8
    lea     rdi, [ctx+8]; dest
    movsxd  rdx, ebx; n
    mov     rsi, in; src
    call    _memcpy
loc_5EFBE8:
    mov     [ctx], ebx
    mov     rax, [rbp+outl]
    mov     [rax], r15d
loc_5EFBF2:
    mov     eax, 1
loc_5EFBF7:
    add     rsp, 18h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     rbp
    retn
loc_5EFC06:
    lea     rdi, aAssertionFaile_181; "assertion failed: ctx->length <= (int)s"...
    lea     out, aCryptoEvpEncod; "crypto/evp/encode.c"
    mov     edx, 0ABh; line
    call    OPENSSL_die
EVP_EncodeUpdate endp

