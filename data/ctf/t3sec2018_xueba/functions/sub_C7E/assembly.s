sub_C7E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIndex; "Index:"
    call    puts
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aU; "%u"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    mov     eax, eax
    shl     rax, 5
    mov     rdx, rax
    lea     rax, unk_202070
    mov     rax, [rdx+rax]
    cmp     rax, 1
    jnz     short loc_D1C
    mov     eax, [rbp+var_C]
    mov     eax, eax
    shl     rax, 5
    mov     rdx, rax
    lea     rax, unk_202078
    mov     rax, [rdx+rax]
    mov     edx, [rbp+var_C]
    mov     edx, edx
    mov     rcx, rdx
    shl     rcx, 5
    lea     rdx, unk_202060
    add     rcx, rdx
    mov     rdx, rax
    mov     rsi, rcx
    lea     rdi, format; "Name %s\nContent:%s\n"
    mov     eax, 0
    call    printf
    jmp     short loc_D28
loc_D1C:
    lea     rdi, aNoSuchNote; "No such note!"
    call    puts
loc_D28:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_D3D
    call    __stack_chk_fail
locret_D3D:
    leave
    retn
sub_C7E endp

