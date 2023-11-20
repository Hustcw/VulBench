main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     edi, 3Ch ; '<'; seconds
    call    _alarm
    lea     rdi, aWelcomeToTheNo; "welcome to the note 2018~"
    call    _puts
loc_F58:
    mov     eax, 0
    call    sub_BD2
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 2
    jz      short loc_F98
    cmp     eax, 3
    jz      short loc_FA4
    cmp     eax, 1
    jnz     short loc_FB0
    mov     eax, 0
    call    sub_C0E
    jmp     short loc_FBD
loc_F98:
    mov     eax, 0
    call    sub_D73
    jmp     short loc_FBD
loc_FA4:
    mov     eax, 0
    call    sub_E37
    jmp     short loc_FBD
loc_FB0:
    lea     rdi, aInvalid; "invalid~"
    call    _puts
    nop
loc_FBD:
    jmp     short loc_F58
main endp

