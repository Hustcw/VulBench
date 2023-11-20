crash_nest proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aIndex; "Index :"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+buf]
    mov     edx, 4; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_14], eax
    cmp     [rbp+var_14], 0
    js      short loc_400C91
    cmp     [rbp+var_14], 9
    jle     short loc_400CA5
loc_400C91:
    mov     edi, offset aOobMyBoy; "OOB!My Boy!"
    call    _puts
    mov     edi, 0; status
    call    __exit
loc_400CA5:
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:nests[rax*8]
    test    rax, rax
    jz      short loc_400D02
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:nests[rax*8]
    mov     rax, [rax+8]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:nests[rax*8]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+var_14]
    cdqe
    mov     ds:nests[rax*8], 0
    mov     edi, offset aNowAnotherW0od; "Now another w0odpeck3r lost his house :"...
    call    _puts
    jmp     short loc_400D0C
loc_400D02:
    mov     edi, offset aNoSuchNest; "No such nest !"
    call    _puts
loc_400D0C:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400D21
    call    ___stack_chk_fail
locret_400D21:
    leave
    retn
crash_nest endp

