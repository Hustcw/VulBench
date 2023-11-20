sub_E0B proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 90h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWhereIsYourDes; "Where is your destination:"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_90]
    mov     esi, 80h
    mov     rdi, rax
    call    sub_B72
    lea     rax, [rbp+var_90]
    mov     rdi, rax
    call    sub_C37
    cdqe
    mov     cs:qword_202068, rax
    mov     rax, cs:qword_202068
    cmp     rax, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_E7B
    lea     rdi, aNoSuchPlace; "No such place!"
    call    _puts
loc_E7B:
    lea     rdi, aDone; "Done!"
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_E9C
    call    ___stack_chk_fail
locret_E9C:
    leave
    retn
sub_E0B endp

