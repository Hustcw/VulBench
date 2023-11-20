menu proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset s; "--------------------------------"
    call    _puts
    mov     edi, offset aW0odpeck3rSNes; "        w0odpeck3r's Nest       "
    call    _puts
    mov     edi, offset s; "--------------------------------"
    call    _puts
    mov     edi, offset a1BuildANest; " 1. Build a Nest                "
    call    _puts
    mov     edi, offset a2DecorateANest; " 2. Decorate a Nest             "
    call    _puts
    mov     edi, offset a3ShowANest; " 3. Show a Nest                 "
    call    _puts
    mov     edi, offset a4CrashANest; " 4. Crash a Nest                "
    call    _puts
    mov     edi, offset a5LeaveTheTree; " 5. Leave the tree              "
    call    _puts
    mov     edi, offset s; "--------------------------------"
    call    _puts
    mov     edi, offset format; "Your choice :"
    mov     eax, 0
    call    _printf
    nop
    pop     rbp
    retn
menu endp

