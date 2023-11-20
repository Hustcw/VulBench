main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], 0
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setbuf
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setbuf
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setbuf
    mov     eax, 0
    call    sub_11F0
loc_12F1:
    mov     eax, 0
    call    sub_124B
    lea     rax, [rbp+var_4]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     rax, cs:stdin_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fgetc
    mov     eax, [rbp+var_4]
    cmp     eax, 1
    jz      short loc_134E
    cmp     eax, 1
    jg      short loc_1338
    test    eax, eax
    jz      short loc_1344
    jmp     short loc_1372
loc_1338:
    cmp     eax, 2
    jz      short loc_135A
    cmp     eax, 3
    jz      short loc_1366
    jmp     short loc_1372
loc_1344:
    mov     edi, 0; status
    call    exit
loc_134E:
    mov     eax, 0
    call    sub_F29
    jmp     short loc_137F
loc_135A:
    mov     eax, 0
    call    sub_10CD
    jmp     short loc_137F
loc_1366:
    mov     eax, 0
    call    sub_115A
    jmp     short loc_137F
loc_1372:
    lea     rdi, aE; "e?"
    call    puts
    nop
loc_137F:
    jmp     loc_12F1
main endp

