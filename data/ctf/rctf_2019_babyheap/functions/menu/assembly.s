menu proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, a1Add; "1. add     "
    call    puts
    lea     rdi, a2Edit; "2. edit    "
    call    puts
    lea     rdi, a3Delete; "3. delete  "
    call    puts
    lea     rdi, a4Show; "4. show    "
    call    puts
    lea     rdi, a5Exit; "5. exit    "
    call    puts
    lea     rdi, aChoice; "Choice: "
    call    puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_D2E
    call    __stack_chk_fail
locret_D2E:
    leave
    retn
menu endp

