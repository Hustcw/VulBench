ALARMhandler proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], edi
    mov     edi, offset aIMNotGoingToWa; "I'm not going to wait around forever fo"...
    call    _puts
    mov     edi, 1; status
    call    _exit
ALARMhandler endp

