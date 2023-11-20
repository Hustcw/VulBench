menu proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aWelcomeToAlgor; "----------Welcome to algorithm party---"...
    call    _puts
    lea     rdi, aDoYouKnowSpfa; "--------------do you know SPFA---------"...
    call    _puts
    lea     rdi, aWhyIsItSoSpeci; "------------why is it so special-------"...
    call    _puts
    lea     rdi, aOKeOrNegativeL; "-----------O(KE) or negative loop------"...
    call    _puts
    lea     rdi, asc_1168; "---------------------------------------"...
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_CB7
    call    ___stack_chk_fail
locret_CB7:
    leave
    retn
menu endp

