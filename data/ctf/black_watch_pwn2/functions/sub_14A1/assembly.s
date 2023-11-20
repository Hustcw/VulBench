sub_14A1 proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1GetRedPackets; "1.Get red packets"
    call    _puts
    lea     rdi, a2ThrowRedPacke; "2.Throw red packets"
    call    _puts
    lea     rdi, a3ChangeRedPack; "3.change red packets"
    call    _puts
    lea     rdi, a4WatchRedPacke; "4.watch red packets"
    call    _puts
    lea     rdi, a5Goodbye; "5.Goodbye"
    call    _puts
    lea     rdi, aYourInput; "Your input: "
    mov     eax, 0
    call    _printf
    nop
    pop     rbp
    retn
sub_14A1 endp

