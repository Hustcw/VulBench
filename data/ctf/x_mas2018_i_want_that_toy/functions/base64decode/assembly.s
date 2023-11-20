base64decode proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 50h
    mov     [rbp+s], rdi
    mov     [rbp+var_50], rsi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _strlen
    mov     [rbp+var_10], rax
    mov     rax, cs:decoding_table
    test    rax, rax
    jnz     short loc_1559
    mov     eax, 0
    call    build_decoding_table
loc_1559:
    mov     rax, [rbp+var_10]
    and     eax, 3
    test    rax, rax
    jz      short loc_156F
    mov     eax, 0
    jmp     loc_17BB
loc_156F:
    mov     rax, [rbp+var_10]
    shr     rax, 2
    mov     rdx, rax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    mov     [rbp+var_18], rax
    mov     rax, [rbp+var_10]
    lea     rdx, [rax-1]
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 3Dh ; '='
    jnz     short loc_15A2
    sub     [rbp+var_18], 1
loc_15A2:
    mov     rax, [rbp+var_10]
    lea     rdx, [rax-2]
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 3Dh ; '='
    jnz     short loc_15BD
    sub     [rbp+var_18], 1
loc_15BD:
    cmp     [rbp+var_50], 0
    jnz     short loc_15CE
    mov     eax, 0
    jmp     loc_17BB
loc_15CE:
    mov     [rbp+var_34], 0
    mov     [rbp+var_30], 0
    jmp     loc_17A8
loc_15E1:
    mov     eax, [rbp+var_34]
    movsxd  rdx, eax
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 3Dh ; '='
    jnz     short loc_1600
    add     [rbp+var_34], 1
    mov     eax, 0
    jmp     short loc_162A
loc_1600:
    mov     rcx, cs:decoding_table
    mov     eax, [rbp+var_34]
    lea     edx, [rax+1]
    mov     [rbp+var_34], edx
    movsxd  rdx, eax
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   rax, al
    add     rax, rcx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
loc_162A:
    mov     [rbp+var_2C], eax
    mov     eax, [rbp+var_34]
    movsxd  rdx, eax
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 3Dh ; '='
    jnz     short loc_164C
    add     [rbp+var_34], 1
    mov     eax, 0
    jmp     short loc_1676
loc_164C:
    mov     rcx, cs:decoding_table
    mov     eax, [rbp+var_34]
    lea     edx, [rax+1]
    mov     [rbp+var_34], edx
    movsxd  rdx, eax
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   rax, al
    add     rax, rcx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
loc_1676:
    mov     [rbp+var_28], eax
    mov     eax, [rbp+var_34]
    movsxd  rdx, eax
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 3Dh ; '='
    jnz     short loc_1698
    add     [rbp+var_34], 1
    mov     eax, 0
    jmp     short loc_16C2
loc_1698:
    mov     rcx, cs:decoding_table
    mov     eax, [rbp+var_34]
    lea     edx, [rax+1]
    mov     [rbp+var_34], edx
    movsxd  rdx, eax
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   rax, al
    add     rax, rcx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
loc_16C2:
    mov     [rbp+var_24], eax
    mov     eax, [rbp+var_34]
    movsxd  rdx, eax
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 3Dh ; '='
    jnz     short loc_16E4
    add     [rbp+var_34], 1
    mov     eax, 0
    jmp     short loc_170E
loc_16E4:
    mov     rcx, cs:decoding_table
    mov     eax, [rbp+var_34]
    lea     edx, [rax+1]
    mov     [rbp+var_34], edx
    movsxd  rdx, eax
    mov     rax, [rbp+s]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   rax, al
    add     rax, rcx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
loc_170E:
    mov     [rbp+var_20], eax
    mov     eax, [rbp+var_2C]
    shl     eax, 12h
    mov     edx, eax
    mov     eax, [rbp+var_28]
    shl     eax, 0Ch
    add     edx, eax
    mov     eax, [rbp+var_24]
    shl     eax, 6
    add     edx, eax
    mov     eax, [rbp+var_20]
    add     eax, edx
    mov     [rbp+var_1C], eax
    mov     eax, [rbp+var_30]
    cdqe
    cmp     [rbp+var_18], rax
    jbe     short loc_175B
    mov     eax, [rbp+var_1C]
    shr     eax, 10h
    mov     ecx, eax
    mov     eax, [rbp+var_30]
    lea     edx, [rax+1]
    mov     [rbp+var_30], edx
    movsxd  rdx, eax
    mov     rax, [rbp+var_50]
    add     rax, rdx
    mov     edx, ecx
    mov     [rax], dl
loc_175B:
    mov     eax, [rbp+var_30]
    cdqe
    cmp     [rbp+var_18], rax
    jbe     short loc_1785
    mov     eax, [rbp+var_1C]
    shr     eax, 8
    mov     ecx, eax
    mov     eax, [rbp+var_30]
    lea     edx, [rax+1]
    mov     [rbp+var_30], edx
    movsxd  rdx, eax
    mov     rax, [rbp+var_50]
    add     rax, rdx
    mov     edx, ecx
    mov     [rax], dl
loc_1785:
    mov     eax, [rbp+var_30]
    cdqe
    cmp     [rbp+var_18], rax
    jbe     short loc_17A8
    mov     eax, [rbp+var_30]
    lea     edx, [rax+1]
    mov     [rbp+var_30], edx
    movsxd  rdx, eax
    mov     rax, [rbp+var_50]
    add     rax, rdx
    mov     edx, [rbp+var_1C]
    mov     [rax], dl
loc_17A8:
    mov     eax, [rbp+var_34]
    cdqe
    cmp     [rbp+var_10], rax
    ja      loc_15E1
    mov     rax, [rbp+var_50]
loc_17BB:
    mov     rsi, [rbp+var_8]
    xor     rsi, fs:28h
    jz      short locret_17CF
    call    ___stack_chk_fail
locret_17CF:
    leave
    retn
base64decode endp

