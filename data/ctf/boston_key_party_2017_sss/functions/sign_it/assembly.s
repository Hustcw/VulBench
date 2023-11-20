sign_it proc
    push    rbp
    mov     rbp, rsp
    push    r13
    push    r12
    push    rbx
    sub     rsp, 38h
    mov     rax, fs:28h
    mov     [rbp+var_28], rax
    xor     eax, eax
    mov     rax, cs:exec_guy
    test    rax, rax
    jnz     short loc_400ECB
    mov     esi, 1; size
    mov     edi, 24h ; '$'; nmemb
    call    _calloc
    mov     cs:exec_guy, rax
    mov     rax, cs:exec_guy
    mov     cs:s_exec_guy, rax
    mov     rax, cs:exec_guy
    add     rax, 1
    mov     cs:m_exec_guy, rax
    mov     rax, cs:s_exec_guy
    mov     qword ptr [rax+14h], offset deny_command
    mov     rax, cs:s_exec_guy
    mov     qword ptr [rax+1Ch], offset exec_command
loc_400ECB:
    mov     edi, offset s; "what command do you want to sign?"
    call    _puts
    mov     edi, offset asc_401622; ">_ "
    mov     eax, 0
    call    _printf
    mov     edx, 100h; nbytes
    mov     esi, offset global; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_3C], eax
    mov     eax, [rbp+var_3C]
    cdqe
    mov     ds:global[rax], 0
    mov     [rbp+s1], offset global
    mov     rax, [rbp+s1]
    mov     esi, offset kLs; "ls\n"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jz      short loc_400F72
    mov     rax, [rbp+s1]
    mov     esi, offset kPwd; "pwd\n"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jz      short loc_400F72
    mov     rax, [rbp+s1]
    mov     esi, offset kId; "id\n"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jz      short loc_400F72
    mov     rax, [rbp+s1]
    mov     esi, offset kWhoami; "whoami\n"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jz      short loc_400F72
    mov     edi, offset aNotGoingToSign; "not going to sign that for you..."
    call    _puts
    jmp     loc_401081
loc_400F72:
    movzx   eax, cs:byte_602240
    test    al, al
    jz      short loc_400FDB
    mov     rax, [rbp+s1]
    mov     rdi, rax; s
    call    _strlen
    mov     r13, rax
    mov     rax, cs:key
    mov     rdi, rax; s
    call    _strlen
    mov     r12d, eax
    mov     rbx, cs:key
    call    _EVP_md5
    mov     rdi, rax
    mov     rax, [rbp+s1]
    sub     rsp, 8
    lea     rdx, [rbp+var_44]
    push    rdx
    mov     r9d, 0
    mov     r8, r13
    mov     rcx, rax
    mov     edx, r12d
    mov     rsi, rbx
    call    _HMAC
    add     rsp, 10h
    mov     [rbp+var_38], rax
    jmp     short loc_401037
loc_400FDB:
    mov     rax, [rbp+s1]
    mov     rdi, rax; s
    call    _strlen
    mov     r13, rax
    mov     rax, cs:key
    mov     rdi, rax; s
    call    _strlen
    mov     r12d, eax
    mov     rbx, cs:key
    call    _EVP_sha1
    mov     rdi, rax
    mov     rax, [rbp+s1]
    sub     rsp, 8
    lea     rdx, [rbp+var_44]
    push    rdx
    mov     r9d, 0
    mov     r8, r13
    mov     rcx, rax
    mov     edx, r12d
    mov     rsi, rbx
    call    _HMAC
    add     rsp, 10h
    mov     [rbp+var_38], rax
loc_401037:
    mov     edi, offset aSignature; "signature: "
    call    _puts
    mov     [rbp+var_40], 0
    jmp     short loc_40106F
loc_40104A:
    mov     edx, [rbp+var_40]
    mov     rax, [rbp+var_38]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    mov     esi, eax
    mov     edi, offset a02x; "%02x"
    mov     eax, 0
    call    _printf
    add     [rbp+var_40], 1
loc_40106F:
    mov     eax, [rbp+var_44]
    cmp     [rbp+var_40], eax
    jb      short loc_40104A
    mov     edi, offset byte_40165B; s
    call    _puts
loc_401081:
    mov     rax, [rbp+var_28]
    xor     rax, fs:28h
    jz      short loc_401095
    call    ___stack_chk_fail
loc_401095:
    lea     rsp, [rbp-18h]
    pop     rbx
    pop     r12
    pop     r13
    pop     rbp
    retn
sign_it endp

