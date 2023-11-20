main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, 0
    call    initIO
loc_401063:
    mov     eax, 0
    call    dispMenu
    mov     eax, 0
    call    readNum
    mov     [rbp+var_8], rax
    cmp     [rbp+var_8], 1
    jnz     short loc_40108E
    mov     eax, 0
    call    createUser
    jmp     short loc_401063
loc_40108E:
    cmp     [rbp+var_8], 2
    jnz     short loc_4010A1
    mov     eax, 0
    call    deleteUser
    jmp     short loc_401063
loc_4010A1:
    cmp     [rbp+var_8], 3
    jnz     short loc_4010B4
    mov     eax, 0
    call    editUser
    jmp     short loc_401063
loc_4010B4:
    cmp     [rbp+var_8], 4
    jnz     short loc_4010C7
    mov     eax, 0
    call    printUser
    jmp     short loc_401063
loc_4010C7:
    cmp     [rbp+var_8], 5
    jnz     short loc_4010DA
    mov     eax, 0
    call    addMoney
    jmp     short loc_401063
loc_4010DA:
    cmp     [rbp+var_8], 6
    jnz     short loc_4010F0
    mov     eax, 0
    call    buyGift
    jmp     loc_401063
loc_4010F0:
    cmp     [rbp+var_8], 7
    jnz     short loc_4010FE
    mov     eax, 0
    jmp     short locret_40110D
loc_4010FE:
    mov     edi, offset aInvalidChoice; "Invalid Choice"
    call    puts
    jmp     loc_401063
locret_40110D:
    leave
    retn
main endp

