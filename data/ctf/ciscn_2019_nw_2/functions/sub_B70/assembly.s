sub_B70 proc
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    mov     eax, cs:dword_202010
    test    eax, eax
    jz      short loc_C00
    lea     rdi, aIndex; "index:"
    call    _puts
    lea     rsi, [rsp+18h+var_14]
    lea     rdi, aD; "%d"
    xor     eax, eax
    call    ___isoc99_scanf
    mov     rdi, cs:stdin; fp
    call    __IO_getc
    movsxd  rax, [rsp+18h+var_14]
    cmp     eax, 9
    jbe     short loc_BE0
loc_BC3:
    mov     rax, [rsp+18h+var_10]
    xor     rax, fs:28h
    jnz     short loc_C0E
    add     rsp, 18h
    retn
loc_BE0:
    lea     rdx, qword_202040
    mov     rdi, [rdx+rax*8]; ptr
    test    rdi, rdi
    jz      short loc_BC3
    call    _free
    sub     cs:dword_202010, 1
    jmp     short loc_BC3
loc_C00:
    lea     rdi, aNoMoreFreeAvai; "no more free available"
    call    _puts
    jmp     short loc_BC3
loc_C0E:
    call    ___stack_chk_fail
sub_B70 endp

