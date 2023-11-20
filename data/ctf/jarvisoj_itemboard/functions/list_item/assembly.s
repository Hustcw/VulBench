list_item proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rdi, aItemList; "Item list"
    call    _puts
    mov     [rbp+i], 0
    jmp     short loc_D51
loc_CFB:
    lea     rax, item_array
    mov     rax, [rax]
    mov     edx, [rbp+i]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_D4D
    lea     rax, item_array
    mov     rax, [rax]
    mov     edx, [rbp+i]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rax, rdx
    mov     rax, [rax]
    mov     rdx, [rax]
    mov     eax, [rbp+i]
    mov     esi, eax
    lea     rdi, format; "No.%d\tname:%s\n"
    mov     eax, 0
    call    _printf
loc_D4D:
    add     [rbp+i], 1
loc_D51:
    mov     eax, cs:items_cnt
    cmp     [rbp+i], eax
    jl      short loc_CFB
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    leave
    retn
list_item endp

