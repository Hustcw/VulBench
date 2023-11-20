sub_CD0 proc
    push    rbx
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    mov     eax, cs:dword_202010
    test    eax, eax
    jz      loc_D77
    lea     rsi, aInputTheSize; "Input the size:"
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
    xor     eax, eax
    call    sub_C10
    movsxd  rbx, eax
    cmp     ebx, 7Fh
    ja      short loc_D6B
    lea     rsi, aInputTheConten; "Input the content:"
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
    mov     rdi, rbx; size
    call    malloc
    mov     rsi, rbx
    mov     rdi, rax
    mov     cs:ptr, rax
    call    sub_B70
    lea     rdi, aDone; "Done!"
    call    puts
    sub     cs:dword_202010, 1
    mov     rax, [rsp+18h+var_10]
    xor     rax, fs:28h
    jnz     short loc_D7E
    add     rsp, 10h
    pop     rbx
    retn
loc_D6B:
    lea     rdi, aInvalidSize; "Invalid size!"
    call    puts
loc_D77:
    xor     edi, edi; status
    call    exit
loc_D7E:
    call    __stack_chk_fail
sub_CD0 endp

