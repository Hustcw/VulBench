ask proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aMenu; "Menu:"
    call    _puts
    lea     rdi, a1AddEdge; "1. add edge"
    call    _puts
    lea     rdi, a2FindPath; "2. find path"
    call    _puts
    lea     rdi, a3GetFlag; "3. get flag"
    call    _puts
    lea     rdi, a4Exit; "4. exit:"
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_D21
    call    ___stack_chk_fail
locret_D21:
    leave
    retn
ask endp

