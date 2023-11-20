main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], 0
    mov     eax, 0
    call    sub_11E5
    mov     eax, 0
    call    sub_1476
    mov     eax, 0
    call    sub_128F
loc_191F:
    mov     eax, 0
    call    sub_14A1
    mov     eax, 0
    call    sub_14F5
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 3
    jz      short loc_19AE
    cmp     [rbp+var_4], 3
    jg      short loc_1953
    cmp     [rbp+var_4], 1
    jz      short loc_196A
    cmp     [rbp+var_4], 2
    jz      short loc_19A0
    jmp     loc_19E2
loc_1953:
    cmp     [rbp+var_4], 5
    jz      short loc_19CA
    cmp     [rbp+var_4], 5
    jl      short loc_19BC
    cmp     [rbp+var_4], 29Ah
    jz      short loc_19D6
    jmp     short loc_19E2
loc_196A:
    mov     rax, cs:qword_4018
    test    rax, rax
    jg      short loc_1980
    mov     eax, 0
    call    sub_1521
loc_1980:
    lea     rdi, unk_4060
    call    sub_153B
    mov     rax, cs:qword_4018
    sub     rax, 1
    mov     cs:qword_4018, rax
    jmp     short loc_19ED
loc_19A0:
    lea     rdi, unk_4060
    call    sub_16E8
    jmp     short loc_19ED
loc_19AE:
    lea     rdi, unk_4060
    call    sub_1766
    jmp     short loc_19ED
loc_19BC:
    lea     rdi, unk_4060
    call    sub_1874
    jmp     short loc_19ED
loc_19CA:
    mov     eax, 0
    call    sub_1521
    jmp     short loc_19ED
loc_19D6:
    mov     eax, 0
    call    sub_13E3
    jmp     short loc_19ED
loc_19E2:
    mov     eax, 0
    call    sub_1521
loc_19ED:
    jmp     loc_191F
main endp

