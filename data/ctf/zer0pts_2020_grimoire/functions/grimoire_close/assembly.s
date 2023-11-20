grimoire_close proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:fp
    test    rax, rax
    jnz     short loc_10A6
    lea     rdi, aYouDonTEvenOpe; "You don't even open the book."
    call    _puts
    jmp     short loc_10D6
loc_10A6:
    lea     rdi, aYouClosedTheBo; "You closed the book before something ba"...
    call    _puts
    mov     rax, cs:fp
    mov     rdi, rax; stream
    call    _fclose
    mov     cs:fp, 0
    mov     cs:init, 0
loc_10D6:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_10EA
    call    ___stack_chk_fail
locret_10EA:
    leave
    retn
grimoire_close endp

