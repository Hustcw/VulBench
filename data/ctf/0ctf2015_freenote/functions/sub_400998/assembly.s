sub_400998 proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset s; "== 0ops Free Note =="
    call    _puts
    mov     edi, offset a1ListNote; "1. List Note"
    call    _puts
    mov     edi, offset a2NewNote; "2. New Note"
    call    _puts
    mov     edi, offset a3EditNote; "3. Edit Note"
    call    _puts
    mov     edi, offset a4DeleteNote; "4. Delete Note"
    call    _puts
    mov     edi, offset a5Exit; "5. Exit"
    call    _puts
    mov     edi, offset asc_4011FA; "===================="
    call    _puts
    mov     edi, offset format; "Your choice: "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_40094E
    pop     rbp
    retn
sub_400998 endp

