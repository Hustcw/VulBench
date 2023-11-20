start_routine proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     edi, 3; seconds
    call    _sleep
    mov     eax, cs:dword_602160
    movsxd  rdx, eax
    mov     rdx, ds:qword_602180[rdx*8]
    add     rdx, 1
    cdqe
    mov     ds:qword_602180[rax*8], rdx
    mov     eax, 0
    leave
    retn
start_routine endp

