sub_89A proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+nptr], rdi
    mov     [rbp+var_20], rsi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    jmp     short loc_921
loc_8C2:
    movzx   eax, [rbp+buf]
    cmp     al, 20h ; ' '
    jz      short loc_8DA
    movzx   eax, [rbp+buf]
    cmp     al, 0Ah
    jz      short loc_8DA
    movzx   eax, [rbp+buf]
    test    al, al
    jnz     short loc_8EC
loc_8DA:
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+nptr]
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_953
loc_8EC:
    movzx   eax, [rbp+buf]
    cmp     al, 39h ; '9'
    jg      short loc_917
    movzx   eax, [rbp+buf]
    cmp     al, 2Fh ; '/'
    jle     short loc_917
    mov     eax, [rbp+var_C]
    lea     edx, [rax+1]
    mov     [rbp+var_C], edx
    movsxd  rdx, eax
    mov     rax, [rbp+nptr]
    add     rdx, rax
    movzx   eax, [rbp+buf]
    mov     [rdx], al
    jmp     short loc_921
loc_917:
    mov     eax, 0
    call    sub_880
loc_921:
    mov     eax, [rbp+var_C]
    add     eax, 1
    cdqe
    cmp     rax, [rbp+var_20]
    jnb     short loc_953
    lea     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    mov     eax, 0
    call    read
    cmp     eax, 0FFFFFFFFh
    jnz     loc_8C2
loc_953:
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+nptr]
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    atoi
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_983
    call    __stack_chk_fail
locret_983:
    leave
    retn
sub_89A endp

