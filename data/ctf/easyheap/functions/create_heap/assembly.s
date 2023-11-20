create_heap proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+size], 0
    mov     [rbp+var_1C], 0
    jmp     loc_400A26
loc_40095C:
    mov     eax, [rbp+var_1C]
    cdqe
    mov     rax, ds:heaparray[rax*8]
    test    rax, rax
    jnz     loc_400A22
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
    mov     [rbp+size], rax
    mov     rax, [rbp+size]
    mov     rdi, rax; size
    call    _malloc
    mov     rdx, rax
    mov     eax, [rbp+var_1C]
    cdqe
    mov     ds:heaparray[rax*8], rdx
    mov     eax, [rbp+var_1C]
    cdqe
    mov     rax, ds:heaparray[rax*8]
    test    rax, rax
    jnz     short loc_4009EB
    mov     edi, offset aAllocateError; "Allocate Error"
    call    _puts
    mov     edi, 2; status
    call    _exit
loc_4009EB:
    mov     edi, offset aContentOfHeap; "Content of heap:"
    mov     eax, 0
    call    _printf
    mov     eax, [rbp+var_1C]
    cdqe
    mov     rax, ds:heaparray[rax*8]
    mov     rdx, [rbp+size]
    mov     rsi, rdx
    mov     rdi, rax
    call    read_input
    mov     edi, offset aSuccessful; "SuccessFul"
    call    _puts
    jmp     short loc_400A30
loc_400A22:
    add     [rbp+var_1C], 1
loc_400A26:
    cmp     [rbp+var_1C], 9
    jle     loc_40095C
loc_400A30:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400A45
    call    ___stack_chk_fail
locret_400A45:
    leave
    retn
create_heap endp

