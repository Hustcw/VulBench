main proc
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    call    sub_AF0
loc_979:
    xor     eax, eax
    call    sub_C70
    cmp     eax, 1
    jz      short loc_99D
loc_985:
    cmp     eax, 2
    jnz     short loc_9B0
    xor     eax, eax
    call    sub_D90
    xor     eax, eax
    call    sub_C70
    cmp     eax, 1
    jnz     short loc_985
loc_99D:
    xor     eax, eax
    call    sub_CD0
    jmp     short loc_979
loc_9B0:
    xor     edi, edi; status
    call    exit
main endp

