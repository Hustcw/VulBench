show_item proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rdi, aWhichItem; "Which item?"
    call    _puts
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    mov     eax, 0
    call    read_num
    mov     [rbp+index], eax
    mov     eax, cs:items_cnt
    cmp     [rbp+index], eax
    jge     short loc_DCD
    lea     rax, item_array
    mov     rax, [rax]
    mov     edx, [rbp+index]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_DDB
loc_DCD:
    lea     rdi, aHacker; "Hacker!"
    call    _puts
    jmp     short locret_E4E
loc_DDB:
    lea     rax, item_array
    mov     rax, [rax]
    mov     edx, [rbp+index]
    movzx   edx, dl
    shl     rdx, 3
    add     rax, rdx
    mov     rax, [rax]
    mov     [rbp+item], rax
    lea     rdi, aItemDetail; "Item Detail:"
    call    _puts
    mov     rax, [rbp+item]
    mov     rax, [rax]
    mov     rsi, rax
    lea     rdi, aNameS; "Name:%s\n"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+item]
    mov     rax, [rax+8]
    mov     rsi, rax
    lea     rdi, aDescriptionS; "Description:%s\n"
    mov     eax, 0
    call    _printf
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
locret_E4E:
    leave
    retn
show_item endp

