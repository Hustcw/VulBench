menu proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset asc_400DE0; "--------------------------------"
    call    _puts
    mov     edi, offset aEasyHeapCreato; "       Easy Heap Creator       "
    call    _puts
    mov     edi, offset asc_400DE0; "--------------------------------"
    call    _puts
    mov     edi, offset a1CreateAHeap; " 1. Create a Heap               "
    call    _puts
    mov     edi, offset a2EditAHeap; " 2. Edit a Heap                 "
    call    _puts
    mov     edi, offset a3DeleteAHeap; " 3. Delete a Heap               "
    call    _puts
    mov     edi, offset a4Exit; " 4. Exit                        "
    call    _puts
    mov     edi, offset asc_400DE0; "--------------------------------"
    call    _puts
    mov     edi, offset format; "Your choice :"
    mov     eax, 0
    call    _printf
    nop
    pop     rbp
    retn
menu endp

