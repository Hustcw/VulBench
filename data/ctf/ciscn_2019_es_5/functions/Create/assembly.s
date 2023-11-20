Create proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_C], 0
    jmp     short loc_C07
loc_BE6:
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, flist
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_C0F
    add     [rbp+var_C], 1
loc_C07:
    cmp     [rbp+var_C], 9
    jle     short loc_BE6
    jmp     short loc_C10
loc_C0F:
    nop
loc_C10:
    cmp     [rbp+var_C], 0Ah
    jnz     short loc_C2C
    lea     rdi, aFullFlag; "Full flag!"
    call    _puts
    mov     eax, 0
    jmp     locret_CFC
loc_C2C:
    mov     edi, 10h; size
    call    _malloc
    mov     [rbp+var_8], rax
    lea     rdi, aSize; "size?>"
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    read_int
    mov     edx, eax
    mov     rax, [rbp+var_8]
    mov     [rax+8], edx
    mov     rax, [rbp+var_8]
    mov     eax, [rax+8]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     rdx, rax
    mov     rax, [rbp+var_8]
    mov     [rax], rdx
    mov     rax, [rbp+var_8]
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_C9B
    lea     rdi, aCanNotMalloc; "Can not malloc!"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_C9B:
    lea     rdi, aContent; "content:"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+var_8]
    mov     edx, [rax+8]
    mov     rax, [rbp+var_8]
    mov     rax, [rax]
    mov     esi, edx
    mov     rdi, rax
    call    secure_read
    mov     rax, [rbp+var_8]
    mov     dword ptr [rax+0Ch], 1
    mov     eax, [rbp+var_C]
    cdqe
    lea     rcx, ds:0[rax*8]
    lea     rax, flist
    mov     rdx, [rbp+var_8]
    mov     [rcx+rax], rdx
    lea     rdi, aOk; "OK!"
    call    _puts
    mov     eax, 0
locret_CFC:
    leave
    retn
Create endp

