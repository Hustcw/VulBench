sub_D90 proc
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    mov     eax, cs:dword_202014
    test    eax, eax
    jz      short loc_DE2
    mov     rdi, cs:ptr; ptr
    call    free
    lea     rdi, aDone; "Done!"
    call    puts
    sub     cs:dword_202014, 1
    mov     rax, [rsp+18h+var_10]
    xor     rax, fs:28h
    jnz     short loc_DE9
    add     rsp, 18h
    retn
loc_DE2:
    xor     edi, edi; status
    call    exit
loc_DE9:
    call    __stack_chk_fail
sub_D90 endp

