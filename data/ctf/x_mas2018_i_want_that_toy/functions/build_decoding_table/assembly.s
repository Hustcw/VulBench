build_decoding_table proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, 100h; size
    call    _malloc
    mov     cs:decoding_table, rax
    mov     [rbp+var_C], 0
    jmp     short loc_14F7
loc_14D1:
    mov     rdx, cs:decoding_table
    mov     eax, [rbp+var_C]
    cdqe
    lea     rcx, encoding_table
    movzx   eax, byte ptr [rax+rcx]
    movzx   eax, al
    add     rax, rdx
    mov     edx, [rbp+var_C]
    mov     [rax], dl
    add     [rbp+var_C], 1
loc_14F7:
    cmp     [rbp+var_C], 3Fh ; '?'
    jle     short loc_14D1
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1512
    call    ___stack_chk_fail
locret_1512:
    leave
    retn
build_decoding_table endp

