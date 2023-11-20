sub_C1D proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aInputTheIndex; "Input the index:"
    call    puts
    mov     [rbp+var_C], 0
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    test    eax, eax
    js      loc_CF8
    mov     eax, [rbp+var_C]
    cmp     eax, 9
    jg      loc_CF8
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2020A0
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_CF8
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2020A0
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2020A0
    mov     qword ptr [rdx+rax], 0
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, dword_202060
    mov     dword ptr [rdx+rax], 0
    lea     rdi, aDeleteSuccess; "Delete success"
    call    puts
    jmp     short loc_D04
loc_CF8:
    lea     rdi, aDeleteFail; "Delete fail"
    call    puts
loc_D04:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_D19
    call    __stack_chk_fail
locret_D19:
    leave
    retn
sub_C1D endp

