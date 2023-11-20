main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40h
    mov     [rbp+var_34], edi
    mov     [rbp+var_40], rsi
    mov     eax, 0
    call    sub_401DA9
    mov     edi, 20h ; ' '; size
    call    _malloc
    mov     [rbp+s], rax
    mov     edi, 40h ; '@'
    call    sub_4013B4
    mov     [rbp+var_20], rax
    mov     edi, 80h
    call    sub_4013B4
    mov     [rbp+var_18], rax
    mov     edi, 40h ; '@'
    call    sub_4013B4
    mov     [rbp+var_10], rax
    mov     edi, 400h; size
    call    _malloc
    mov     [rbp+ptr], rax
    lea     rdi, s; "Your program name:"
    call    _puts
    mov     rax, [rbp+s]
    mov     esi, 20h ; ' '
    mov     rdi, rax
    call    sub_401E14
    lea     rdi, aYourInstructio; "Your instruction:"
    call    _puts
    mov     rax, [rbp+ptr]
    mov     esi, 400h
    mov     rdi, rax
    call    sub_401E14
    mov     rdx, [rbp+ptr]
    mov     rax, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40161D
    lea     rdi, aYourStackData; "Your stack data:"
    call    _puts
    mov     rax, [rbp+ptr]
    mov     esi, 400h
    mov     rdi, rax
    call    sub_401E14
    mov     rdx, [rbp+ptr]
    mov     rax, [rbp+var_20]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40151A
    mov     rdx, [rbp+var_10]
    mov     rcx, [rbp+var_20]
    mov     rax, [rbp+var_18]
    mov     rsi, rcx
    mov     rdi, rax
    call    sub_401967
    test    eax, eax
    jz      short loc_40131F
    lea     rdi, asc_40203F; "-------"
    call    _puts
    mov     rax, [rbp+s]
    mov     rdi, rax; s
    call    _puts
    mov     rax, [rbp+var_20]
    mov     rdi, rax
    call    sub_4018CA
    lea     rdi, asc_40203F; "-------"
    call    _puts
    jmp     short loc_40132B
loc_40131F:
    lea     rdi, aYourProgramCra; "Your Program Crash :)"
    call    _puts
loc_40132B:
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    sub_401381
    mov     rax, [rbp+var_20]
    mov     rdi, rax
    call    sub_401381
    mov     rax, [rbp+var_10]
    mov     rdi, rax
    call    sub_401381
    mov     eax, 0
    leave
    retn
main endp

