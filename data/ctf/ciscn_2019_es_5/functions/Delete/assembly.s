Delete proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rdi, aIndex; "Index:"
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    read_int
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 0
    js      short loc_F75
    cmp     [rbp+var_C], 9
    jle     short loc_F8B
loc_F75:
    lea     rdi, aYouWantToSteal; "You want to steal the flag?"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_F8B:
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, flist
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_1014
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, flist
    mov     rax, [rdx+rax]
    mov     [rbp+ptr], rax
    mov     rax, [rbp+ptr]
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, [rbp+ptr]
    mov     qword ptr [rax], 0
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, flist
    mov     qword ptr [rdx+rax], 0
    lea     rdi, aOk; "OK!"
    call    _puts
    jmp     short locret_1021
loc_1014:
    lea     rdi, aNoneFlag; "None flag!"
    call    _puts
    nop
locret_1021:
    leave
    retn
Delete endp

