sub_AD0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    lea     rdi, aYouReallyDonTN; "You really don't need it?"
    call    _puts
    mov     rax, [rbp+var_8]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2021E0
    mov     rax, [rdx+rax]
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, [rbp+var_8]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2021E0
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, [rbp+var_8]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_2021E0
    mov     qword ptr [rdx+rax], 0
    nop
    leave
    retn
sub_AD0 endp

