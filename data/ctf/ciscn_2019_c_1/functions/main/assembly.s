main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, 0
    call    init
    mov     edi, offset aEeeeeeeHhIii; "EEEEEEE                            hh  "...
    call    _puts
    mov     edi, offset aEeMmMmMmmmAaAa; "EE      mm mm mmmm    aa aa   cccc hh  "...
    call    _puts
    mov     edi, offset aEeeeeMmmMmMmAa; "EEEEE   mmm  mm  mm  aa aaa cc     hhhh"...
    call    _puts
    mov     edi, offset aEeMmmMmMmAaAaa; "EE      mmm  mm  mm aa  aaa cc     hh  "...
    call    _puts
    mov     edi, offset aEeeeeeeMmmMmMm; "EEEEEEE mmm  mm  mm  aaa aa  ccccc hh  "...
    call    _puts
    mov     edi, offset asc_400CE0; "======================================="...
    call    _puts
    mov     edi, offset aWelcomeToThisE; "Welcome to this Encryption machine\n"
    call    _puts
    mov     eax, 0
    call    begin
loc_400B8A:
    mov     edi, 0; stream
    call    _fflush
    mov     [rbp+var_4], 0
    lea     rax, [rbp+var_4]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    call    _getchar
    mov     eax, [rbp+var_4]
    cmp     eax, 2
    jz      short loc_400BDE
    cmp     eax, 3
    jz      short loc_400BF4
    cmp     eax, 1
    jnz     short loc_400C05
    mov     eax, 0
    call    encrypt
    mov     eax, 0
    call    begin
    jmp     short loc_400C16
loc_400BDE:
    mov     edi, offset aIThinkYouCanDo; "I think you can do it by yourself"
    call    _puts
    mov     eax, 0
    call    begin
    jmp     short loc_400C16
loc_400BF4:
    mov     edi, offset aBye; "Bye!"
    call    _puts
    mov     eax, 0
    jmp     short locret_400C1B
loc_400C05:
    mov     edi, offset aSomethingWrong; "Something Wrong!"
    call    _puts
    mov     eax, 0
    jmp     short locret_400C1B
loc_400C16:
    jmp     loc_400B8A
locret_400C1B:
    leave
    retn
main endp

