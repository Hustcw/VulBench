edit proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    movzx   eax, cs:edit_times
    cmp     al, 2
    jz      loc_DFF
    lea     rdi, aIndex; "index: "
    call    _puts
    mov     [rbp+i], 0
    mov     [rbp+size], 0
    lea     rax, [rbp+i]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+i]
    test    eax, eax
    js      loc_DF1
    mov     eax, [rbp+i]
    cmp     eax, 2
    jg      loc_DF1
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_DF1
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    sub     rax, 8
    mov     rax, [rax]
    and     rax, 0FFFFFFFFFFFFFFE8h
    mov     [rbp+size], rax
    lea     rdi, aContent; "content: "
    call    _puts
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    mov     rdx, [rbp+size]; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    mov     eax, 0
    call    _read
    movzx   eax, cs:edit_times
    add     eax, 1
    mov     cs:edit_times, al
    jmp     short loc_E0B
loc_DF1:
    lea     rdi, aError; "Error"
    call    _puts
    jmp     short loc_E0B
loc_DFF:
    lea     rdi, aCanNotEditAnyM; "can not edit any more"
    call    _puts
loc_E0B:
    lea     rdi, aSuccess; "success"
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_E2C
    call    ___stack_chk_fail
locret_E2C:
    leave
    retn
edit endp

