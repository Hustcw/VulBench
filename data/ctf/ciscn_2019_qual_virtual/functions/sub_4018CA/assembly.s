sub_4018CA proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    cmp     [rbp+var_18], 0
    jz      loc_401961
    mov     rax, [rbp+var_18]
    mov     eax, [rax+0Ch]
    cmp     eax, 0FFFFFFFFh
    jz      short loc_401964
    mov     [rbp+var_4], 0
    jmp     short loc_401925
loc_4018F6:
    mov     rax, [rbp+var_18]
    mov     rax, [rax]
    mov     edx, [rbp+var_4]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rax, rdx
    mov     rax, [rax]
    mov     rsi, rax
    lea     rdi, format; "%d "
    mov     eax, 0
    call    _printf
    add     [rbp+var_4], 1
loc_401925:
    mov     rax, [rbp+var_18]
    mov     eax, [rax+0Ch]
    cmp     [rbp+var_4], eax
    jl      short loc_4018F6
    mov     rax, [rbp+var_18]
    mov     rdx, [rax]
    mov     rax, [rbp+var_18]
    mov     eax, [rax+0Ch]
    cdqe
    shl     rax, 3
    add     rax, rdx
    mov     rax, [rax]
    mov     rsi, rax
    lea     rdi, aD_0; "%d\n"
    mov     eax, 0
    call    _printf
    jmp     short locret_401965
loc_401961:
    nop
    jmp     short locret_401965
loc_401964:
    nop
locret_401965:
    leave
    retn
sub_4018CA endp

