del proc
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
    js      loc_1086
    mov     eax, [rbp+i]
    cmp     eax, 2
    jg      loc_1086
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      loc_1086
    movzx   eax, cs:delete_times
    cmp     al, 1
    jnz     short loc_1038
    lea     rdi, aWarningDeleteT; "Warning: delete too often."
    call    _puts
    lea     rdi, aPleaseNoteThat; "please note that why and when you delet"...
    call    _puts
    mov     eax, 0
    call    edit
    lea     rdi, aWarningSomethi; "Warning: something changed when delete "...
    call    _puts
    lea     rdi, aWarningYouCanN; "Warning: you can not edit any more"
    call    _puts
    mov     cs:edit_times, 2
loc_1038:
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    myfree
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     qword ptr [rdx+rax], 0
    movzx   eax, cs:delete_times
    add     eax, 1
    mov     cs:delete_times, al
    jmp     short loc_1092
loc_1086:
    lea     rdi, aError; "Error"
    call    _puts
loc_1092:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_10A7
    call    ___stack_chk_fail
locret_10A7:
    leave
    retn
del endp

