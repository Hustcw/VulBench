buildnest proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 28h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     [rbp+size], 0
    mov     [rbp+var_2C], 0
    jmp     loc_400A4E
loc_400927:
    mov     eax, [rbp+var_2C]
    cdqe
    mov     rax, ds:nests[rax*8]
    test    rax, rax
    jnz     loc_400A4A
    mov     edi, 10h; size
    call    _malloc
    mov     rdx, rax
    mov     eax, [rbp+var_2C]
    cdqe
    mov     ds:nests[rax*8], rdx
    mov     eax, [rbp+var_2C]
    cdqe
    mov     rax, ds:nests[rax*8]
    test    rax, rax
    jnz     short loc_40097D
    mov     edi, offset aNopeSomethingW; "Nope.something wrong.."
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_40097D:
    mov     edi, offset aHowBigIsTheNes; "how big is the nest ?"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    cdqe
    mov     [rbp+size], rax
    mov     eax, [rbp+var_2C]
    cdqe
    mov     rbx, ds:nests[rax*8]
    mov     rax, [rbp+size]
    mov     rdi, rax; size
    call    _malloc
    mov     [rbx+8], rax
    mov     eax, [rbp+var_2C]
    cdqe
    mov     rax, ds:nests[rax*8]
    mov     rax, [rax+8]
    test    rax, rax
    jnz     short loc_4009FB
    mov     edi, offset aNopeSomethingW; "Nope.something wrong.."
    call    _puts
    mov     edi, 2; status
    call    _exit
loc_4009FB:
    mov     eax, [rbp+var_2C]
    cdqe
    mov     rax, ds:nests[rax*8]
    mov     rdx, [rbp+size]
    mov     [rax], rdx
    mov     edi, offset aWhatStuffYouWa; "what stuff you wanna put in the nest?"
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_2C]
    cdqe
    mov     rax, ds:nests[rax*8]
    mov     rax, [rax+8]
    mov     rdx, [rbp+size]
    mov     rsi, rdx
    mov     rdi, rax
    call    myread
    mov     edi, offset aThxBuddy; "Thx buddy."
    call    _puts
    jmp     short loc_400A58
loc_400A4A:
    add     [rbp+var_2C], 1
loc_400A4E:
    cmp     [rbp+var_2C], 9
    jle     loc_400927
loc_400A58:
    nop
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_400A6D
    call    ___stack_chk_fail
loc_400A6D:
    add     rsp, 28h
    pop     rbx
    pop     rbp
    retn
buildnest endp

