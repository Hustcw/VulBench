print_menu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1AddAItem; "1.Add a item"
    call    _puts
    lea     rdi, a2ListItems; "2.List items"
    call    _puts
    lea     rdi, a3ShowTheItem; "3.Show the item"
    call    _puts
    lea     rdi, a4RemoveTheItem; "4.Remove the item"
    call    _puts
    lea     rdi, a5Exit; "5.Exit"
    call    _puts
    lea     rdi, aChoose; "choose:"
    call    _puts
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    _fflush
    pop     rbp
    retn
print_menu endp

