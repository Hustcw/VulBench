main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, 0
    call    sub_400903
loc_400BCB:
    mov     eax, 0
    call    sub_400B76
    mov     eax, 0
    call    sub_400941
    mov     [rbp+var_4], eax
    mov     eax, [rbp+var_4]
    cmp     eax, 2
    jz      short loc_400C0E
    cmp     eax, 2
    jg      short loc_400BF6
    cmp     eax, 1
    jz      short loc_400C02
    jmp     short loc_400C3A
loc_400BF6:
    cmp     eax, 3
    jz      short loc_400C1A
    cmp     eax, 4
    jz      short loc_400C26
    jmp     short loc_400C3A
loc_400C02:
    mov     eax, 0
    call    sub_400990
    jmp     short loc_400C44
loc_400C0E:
    mov     eax, 0
    call    sub_400A58
    jmp     short loc_400C44
loc_400C1A:
    mov     eax, 0
    call    sub_400AC7
    jmp     short loc_400C44
loc_400C26:
    mov     edi, offset aBye; "Bye!"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_400C3A:
    mov     edi, offset aInvalidChoice; "Invalid Choice !"
    call    _puts
loc_400C44:
    jmp     short loc_400BCB
main endp

