add proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+i], 0
    mov     [rbp+i], 0
    jmp     short loc_B83
loc_B62:
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_B8B
    add     [rbp+i], 1
loc_B83:
    cmp     [rbp+i], 2
    jle     short loc_B62
    jmp     short loc_B8C
loc_B8B:
    nop
loc_B8C:
    cmp     [rbp+i], 3
    jz      loc_CCE
    lea     rdi, aAddSize; "add size: "
    call    _puts
    lea     rdi, a10x20; "1. 0x20"
    call    _puts
    lea     rdi, a20x400; "2. 0x400"
    call    _puts
    mov     [rbp+sz], 0
    mov     [rbp+sz_choice], 0
    lea     rax, [rbp+sz_choice]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+sz_choice]
    cmp     eax, 1
    jnz     short loc_BF1
    mov     [rbp+sz], 60h ; '`'
    jmp     short loc_BF9
loc_BF1:
    mov     [rbp+sz], 400h
    nop
loc_BF9:
    cmp     [rbp+sz], 400h
    jnz     short loc_C35
    movzx   eax, cs:add_times
    test    al, al
    jnz     short loc_C1F
    movzx   eax, cs:add_times
    add     eax, 1
    mov     cs:add_times, al
    jmp     short loc_C35
loc_C1F:
    lea     rdi, aErrorJustCanMa; "Error: just can malloc chunk whose size"...
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_C35:
    mov     eax, [rbp+sz]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     rcx, rax
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     [rdx+rax], rcx
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    mov     edx, 10h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rdi, aContent; "content: "
    call    _puts
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, note_ptr
    mov     rax, [rdx+rax]
    mov     edx, [rbp+sz]; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    mov     eax, 0
    call    _read
    lea     rdi, aSuccess; "success"
    call    _puts
    jmp     short loc_CDA
loc_CCE:
    lea     rdi, aErrorCanNotAdd; "Error: can not add any more"
    call    _puts
loc_CDA:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_CEF
    call    ___stack_chk_fail
locret_CEF:
    leave
    retn
add endp

