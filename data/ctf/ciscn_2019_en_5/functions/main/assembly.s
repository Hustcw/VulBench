main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    sub_BD5
loc_1166:
    mov     eax, 0
    call    sub_D38
    mov     eax, 0
    call    sub_CD3
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_C]
    cmp     eax, 2
    jz      short loc_11A9
    cmp     eax, 2
    jg      short loc_1191
    cmp     eax, 1
    jz      short loc_119D
    jmp     short loc_11CD
loc_1191:
    cmp     eax, 3
    jz      short loc_11B5
    cmp     eax, 4
    jz      short loc_11C1
    jmp     short loc_11CD
loc_119D:
    mov     eax, 0
    call    sub_DA7
    jmp     short loc_11D9
loc_11A9:
    mov     eax, 0
    call    sub_102F
    jmp     short loc_11D9
loc_11B5:
    mov     eax, 0
    call    sub_F09
    jmp     short loc_11D9
loc_11C1:
    mov     eax, 0
    call    sub_10D1
    jmp     short loc_11D9
loc_11CD:
    lea     rdi, aInvalidOption; "Invalid option"
    call    puts
loc_11D9:
    jmp     short loc_1166
main endp

