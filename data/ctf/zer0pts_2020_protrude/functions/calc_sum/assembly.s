calc_sum proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 28h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     rax, cs:n
    shl     rax, 2
    lea     rdx, [rax+0Fh]
    mov     eax, 10h
    sub     rax, 1
    add     rax, rdx
    mov     ecx, 10h
    mov     edx, 0
    div     rcx
    imul    rax, 10h
    sub     rsp, rax
    mov     rax, rsp
    add     rax, 0Fh
    shr     rax, 4
    shl     rax, 4
    mov     [rbp+var_20], rax
    mov     [rbp+var_30], 0
    jmp     short loc_400934
loc_4008F2:
    mov     rax, [rbp+var_30]
    add     rax, 1
    mov     rsi, rax
    lea     rdi, format; "num[%ld] = "
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+var_30]
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+var_20]
    lea     rbx, [rdx+rax]
    mov     eax, 0
    call    read_long
    mov     [rbx], rax
    add     [rbp+var_30], 1
loc_400934:
    cmp     [rbp+var_30], 0
    js      short loc_400948
    mov     rax, cs:n
    cmp     [rbp+var_30], rax
    jl      short loc_4008F2
loc_400948:
    mov     [rbp+var_28], 0
    mov     [rbp+var_30], 0
    jmp     short loc_400979
loc_40095A:
    mov     rax, [rbp+var_30]
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+var_20]
    add     rax, rdx
    mov     rax, [rax]
    add     [rbp+var_28], rax
    add     [rbp+var_30], 1
loc_400979:
    mov     rax, cs:n
    cmp     [rbp+var_30], rax
    jl      short loc_40095A
    mov     rax, [rbp+var_28]
    mov     rsi, rax
    lea     rdi, aSumLd; "SUM = %ld\n"
    mov     eax, 0
    call    _printf
    nop
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_4009B3
    call    ___stack_chk_fail
loc_4009B3:
    mov     rbx, [rbp+var_8]
    leave
    retn
calc_sum endp

