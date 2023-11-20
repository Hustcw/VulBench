remove_item proc
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
    jge     short loc_EAD
    lea     rax, item_array
    mov     rax, [rax]
    mov     edx, [rbp+index]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_EBB
loc_EAD:
    lea     rdi, aHacker; "Hacker!"
    call    _puts
    jmp     short locret_F38
loc_EBB:
    lea     rax, item_array
    mov     rax, [rax]
    mov     edx, [rbp+index]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rax, rdx
    mov     rax, [rax]
    mov     rax, [rax+10h]
    lea     rdx, item_array
    mov     rdx, [rdx]
    mov     ecx, [rbp+index]
    movsxd  rcx, ecx
    shl     rcx, 3
    add     rdx, rcx
    mov     rdx, [rdx]
    mov     rdi, rdx
    call    rax
    lea     rax, item_array
    mov     rax, [rax]
    mov     edx, [rbp+index]
    movsxd  rdx, edx
    shl     rdx, 3
    add     rax, rdx
    mov     rax, [rax]
    mov     rdi, rax; offset
    call    set_null
    lea     rdi, aTheItemHasBeen; "The item has been removed"
    call    _puts
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
locret_F38:
    leave
    retn
remove_item endp

