show proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIndex; "index: "
    call    _puts
    mov     [rbp+i], 0
    lea     rax, [rbp+i]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+i]
    test    eax, eax
    js      short loc_ECA
    mov     eax, [rbp+i]
    cmp     eax, 2
    jg      short loc_ECA
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_ECA
    lea     rdi, aContent; "content: "
    call    _puts
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    mov     rdi, rax; s
    call    _puts
    jmp     short loc_ED6
loc_ECA:
    lea     rdi, aError; "Error"
    call    _puts
loc_ED6:
    lea     rdi, aSuccess; "success"
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_EF7
    call    ___stack_chk_fail
locret_EF7:
    leave
    retn
show endp

