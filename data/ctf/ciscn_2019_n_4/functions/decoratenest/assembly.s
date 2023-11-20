decoratenest proc
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
    js      short loc_400ACB
    cmp     [rbp+var_14], 9
    jle     short loc_400ADF
loc_400ACB:
    mov     edi, offset aOobMyBoy; "OOB!My Boy!"
    call    _puts
    mov     edi, 0; status
    call    __exit
loc_400ADF:
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:nests[rax*8]
    test    rax, rax
    jz      short loc_400B3C
    mov     edi, offset aWhatStuffYouWa; "what stuff you wanna put in the nest?"
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:nests[rax*8]
    mov     rax, [rax]
    lea     rdx, [rax+1]
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:nests[rax*8]
    mov     rax, [rax+8]
    mov     rsi, rdx
    mov     rdi, rax
    call    myread
    mov     edi, offset aDone; "Done !"
    call    _puts
    jmp     short loc_400B46
loc_400B3C:
    mov     edi, offset aNoSuchNest; "No such nest !"
    call    _puts
loc_400B46:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400B5B
    call    ___stack_chk_fail
locret_400B5B:
    leave
    retn
decoratenest endp

