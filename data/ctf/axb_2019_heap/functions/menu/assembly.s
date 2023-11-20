menu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1AddNote; "1. add note"
    call    _puts
    lea     rdi, a2DeleNote; "2. dele note"
    call    _puts
    lea     rdi, a3ShowNoteSCont; "3. show note's content"
    call    _puts
    lea     rdi, a4EditNote; "4. edit note"
    call    _puts
    lea     rdi, aEnterAOption; "Enter a option: "
    call    _puts
    lea     rdi, asc_133D; ">> "
    mov     eax, 0
    call    _printf
    nop
    pop     rbp
    retn
menu endp

