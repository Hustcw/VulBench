sub_400CC6 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], 0
    mov     edi, offset aListOfIndexedP; "List of indexed papers:"
    call    _puts
    mov     [rbp+var_4], 0
    jmp     short loc_400D3A
loc_400CE8:
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 6
    mov     rdx, rax
    shl     rdx, 4
    add     rax, rdx
    lea     rcx, byte_6020A0[rax]
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 6
    mov     rdx, rax
    shl     rdx, 4
    add     rax, rdx
    add     rax, 100h
    lea     rdx, byte_6020A0[rax]
    mov     eax, [rbp+var_4]
    mov     esi, eax
    mov     edi, offset aDSS; "[%d] %s \"%s\"\n"
    mov     eax, 0
    call    _printf
    add     [rbp+var_4], 1
loc_400D3A:
    mov     eax, cs:dword_60208C
    cmp     [rbp+var_4], eax
    jl      short loc_400CE8
    mov     edi, offset asc_4011CE; "\n"
    call    _puts
    nop
    leave
    retn
sub_400CC6 endp

