sub_BB1 proc
    push    rbp
    mov     rbp, rsp
    lea     rax, qword_202090
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_BE4
    lea     rax, qword_202090
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    free
    lea     rax, qword_202090
    mov     qword ptr [rax], 0
loc_BE4:
    lea     rdi, aDeleteSuccess; "Delete success"
    call    puts
    nop
    pop     rbp
    retn
sub_BB1 endp

