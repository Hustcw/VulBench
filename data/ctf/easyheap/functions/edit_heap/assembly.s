edit_heap proc
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
    mov     [rbp+var_1C], eax
    cmp     [rbp+var_1C], 0
    js      short loc_400A9E
    cmp     [rbp+var_1C], 9
    jle     short loc_400AB2
loc_400A9E:
    mov     edi, offset aOutOfBound; "Out of bound!"
    call    _puts
    mov     edi, 0; status
    call    __exit
loc_400AB2:
    mov     eax, [rbp+var_1C]
    cdqe
    mov     rax, ds:heaparray[rax*8]
    test    rax, rax
    jz      short loc_400B32
    mov     edi, offset aSizeOfHeap; "Size of Heap : "
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
    mov     [rbp+var_18], rax
    mov     edi, offset aContentOfHeap_0; "Content of heap : "
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_1C]
    cdqe
    mov     rax, ds:heaparray[rax*8]
    mov     rdx, [rbp+var_18]
    mov     rsi, rdx
    mov     rdi, rax
    call    read_input
    mov     edi, offset aDone; "Done !"
    call    _puts
    jmp     short loc_400B3C
loc_400B32:
    mov     edi, offset aNoSuchHeap; "No such heap !"
    call    _puts
loc_400B3C:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400B51
    call    ___stack_chk_fail
locret_400B51:
    leave
    retn
edit_heap endp

