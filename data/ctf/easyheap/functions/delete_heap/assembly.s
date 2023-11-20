delete_heap proc
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
    js      short loc_400BAA
    cmp     [rbp+var_14], 9
    jle     short loc_400BBE
loc_400BAA:
    mov     edi, offset aOutOfBound; "Out of bound!"
    call    _puts
    mov     edi, 0; status
    call    __exit
loc_400BBE:
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:heaparray[rax*8]
    test    rax, rax
    jz      short loc_400C02
    mov     eax, [rbp+var_14]
    cdqe
    mov     rax, ds:heaparray[rax*8]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+var_14]
    cdqe
    mov     ds:heaparray[rax*8], 0
    mov     edi, offset aDone; "Done !"
    call    _puts
    jmp     short loc_400C0C
loc_400C02:
    mov     edi, offset aNoSuchHeap; "No such heap !"
    call    _puts
loc_400C0C:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400C21
    call    ___stack_chk_fail
locret_400C21:
    leave
    retn
delete_heap endp

