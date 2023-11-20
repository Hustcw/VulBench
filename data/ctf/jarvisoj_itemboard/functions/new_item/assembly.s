new_item proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 410h
    mov     edi, 18h; size
    call    _malloc
    mov     [rbp+item], rax
    lea     rax, item_array
    mov     rcx, [rax]
    mov     eax, cs:items_cnt
    lea     edx, [rax+1]
    mov     cs:items_cnt, edx
    cdqe
    shl     rax, 3
    lea     rdx, [rcx+rax]
    mov     rax, [rbp+item]
    mov     [rdx], rax
    mov     edi, 20h ; ' '; size
    call    _malloc
    mov     rdx, rax
    mov     rax, [rbp+item]
    mov     [rax], rdx
    mov     rax, [rbp+item]
    lea     rdx, item_free
    mov     [rax+10h], rdx
    lea     rdi, aNewItem; "New Item"
    call    _puts
    lea     rdi, aItemName; "Item name?"
    call    _puts
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    lea     rax, [rbp+buf]
    mov     ecx, 0Ah; endchar
    mov     edx, 20h ; ' '; len
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read_until
    mov     rax, [rbp+item]
    mov     rax, [rax]
    lea     rdx, [rbp+buf]
    mov     rsi, rdx; src
    mov     rdi, rax; dest
    call    _strcpy
    lea     rdi, aDescriptionSLe; "Description's len?"
    call    _puts
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    mov     eax, 0
    call    read_num
    mov     [rbp+content_len], eax
    mov     eax, [rbp+content_len]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     rdx, rax
    mov     rax, [rbp+item]
    mov     [rax+8], rdx
    lea     rdi, aDescription; "Description?"
    call    _puts
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    mov     edx, [rbp+content_len]; len
    lea     rax, [rbp+buf]
    mov     ecx, 0Ah; endchar
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read_until
    mov     rax, [rbp+item]
    mov     rax, [rax+8]
    lea     rdx, [rbp+buf]
    mov     rsi, rdx; src
    mov     rdi, rax; dest
    call    _strcpy
    lea     rdi, aAddItemSuccess; "Add Item Successfully!"
    call    _puts
    leave
    retn
new_item endp

