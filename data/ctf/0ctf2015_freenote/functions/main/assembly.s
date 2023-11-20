main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, 0
    call    sub_4009FD
    mov     eax, 0
    call    sub_400A49
loc_4010A3:
    mov     eax, 0
    call    sub_400998
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 5; switch 6 cases
    ja      short def_4010C1; jumptable 00000000004010C1 default case, case 0
    mov     eax, [rbp+var_4]
    mov     rax, ds:jpt_4010C1[rax*8]
def_4010C1:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 00000000004010C1 case 1
    call    sub_400B14
    jmp     short loc_40110F
    mov     eax, 0; jumptable 00000000004010C1 case 2
    call    sub_400BC2
    jmp     short loc_40110F
    mov     eax, 0; jumptable 00000000004010C1 case 3
    call    sub_400D87
    jmp     short loc_40110F
    mov     eax, 0; jumptable 00000000004010C1 case 4
    call    sub_400F7D
    jmp     short loc_40110F
    mov     edi, offset aBye; jumptable 00000000004010C1 case 5
    call    _puts
    mov     eax, 0
    jmp     short locret_401111
    mov     edi, offset aInvalid; jumptable 00000000004010C1 default case, case 0
    call    _puts
    nop
loc_40110F:
    jmp     short loc_4010A3
locret_401111:
    leave
    retn
main endp

