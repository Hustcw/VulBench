sub_D2E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aInputTheIndex; "Input the index:"
    call    puts
    mov     [rbp+var_14], 0
    mov     dword ptr [rbp+nbytes], 0
    lea     rax, [rbp+var_14]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_14]
    cmp     eax, 9
    jg      loc_E7B
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2020A0
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      loc_E7B
    lea     rdi, aInputSize; "Input size:"
    call    puts
    lea     rax, [rbp+nbytes]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, dword_202060
    mov     edx, [rdx+rax]
    mov     eax, dword ptr [rbp+nbytes]
    cmp     edx, eax
    jnb     short loc_E00
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, dword_202060
    mov     eax, [rdx+rax]
    mov     dword ptr [rbp+nbytes], eax
loc_E00:
    lea     rdi, aInputNewConten; "Input new content:"
    call    puts
    mov     eax, dword ptr [rbp+nbytes]
    mov     ecx, eax
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2020A0
    mov     rax, [rdx+rax]
    mov     rdx, rcx; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     dword ptr [rbp+nbytes+4], eax
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, dword_202060
    mov     eax, [rdx+rax]
    cmp     eax, dword ptr [rbp+nbytes+4]
    jnz     short loc_E89
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2020A0
    mov     rdx, [rdx+rax]
    mov     eax, dword ptr [rbp+nbytes+4]
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_E89
loc_E7B:
    lea     rdi, aEditFail; "Edit fail"
    call    puts
    jmp     short loc_E8A
loc_E89:
    nop
loc_E8A:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_E9F
    call    __stack_chk_fail
locret_E9F:
    leave
    retn
sub_D2E endp

