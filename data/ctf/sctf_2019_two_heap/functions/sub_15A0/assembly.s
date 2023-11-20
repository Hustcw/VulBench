sub_15A0 proc
    sub     rsp, 18h
    lea     rdi, aInputTheIndex; "Input the index:"
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    call    _puts
    xor     eax, eax
    call    sub_13E0
    cdqe
    cmp     rax, 7
    jbe     short loc_15E0
    xor     edi, edi; status
    call    _exit
loc_15E0:
    mov     rcx, [rsp+18h+var_10]
    xor     rcx, fs:28h
    jnz     short loc_1609
    shl     rax, 4
    lea     rdx, unk_4020
    mov     rdi, [rdx+rax+8]; ptr
    add     rsp, 18h
    jmp     _free
loc_1609:
    call    ___stack_chk_fail
sub_15A0 endp

