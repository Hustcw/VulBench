sub_D3F proc
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
    jnz     short loc_DEE
    mov     eax, [rbp+var_C]
    mov     eax, eax
    shl     rax, 5
    mov     rdx, rax
    lea     rax, unk_202078
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     eax, [rbp+var_C]
    mov     eax, eax
    shl     rax, 5
    mov     rdx, rax
    lea     rax, unk_202070
    mov     qword ptr [rdx+rax], 0
    mov     eax, cs:dword_202050
    sub     eax, 1
    mov     cs:dword_202050, eax
    lea     rdi, aDone; "Done!"
    call    puts
    jmp     short loc_DFA
loc_DEE:
    lea     rdi, aNoSuchNote; "No such note!"
    call    puts
loc_DFA:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_E0F
    call    __stack_chk_fail
locret_E0F:
    leave
    retn
sub_D3F endp

