show_menu proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, s; "=-=-=-=-=-=-=-=-=-=-=-="
    call    _puts
    lea     rdi, a1OpenTheBook; "1. Open the book"
    call    _puts
    lea     rdi, a2ReadTheBook; "2. Read the book"
    call    _puts
    lea     rdi, a3ReviseTheCont; "3. Revise the contents"
    call    _puts
    lea     rdi, a4CloseTheBook; "4. Close the book"
    call    _puts
    lea     rdi, s; "=-=-=-=-=-=-=-=-=-=-=-="
    call    _puts
    lea     rdi, format; "> "
    mov     eax, 0
    call    _printf
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_DDF
    call    ___stack_chk_fail
locret_DDF:
    leave
    retn
show_menu endp

