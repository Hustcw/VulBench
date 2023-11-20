main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, 0
    call    init
loc_128E:
    mov     eax, 0
    call    menu
    mov     eax, 0
    call    read_atoi
    mov     [rbp+var_4], eax
    mov     eax, [rbp+var_4]
    cmp     eax, 3
    jz      short loc_12E4
    cmp     eax, 3
    jg      short loc_12BE
    cmp     eax, 1
    jz      short loc_12CC
    cmp     eax, 2
    jz      short loc_12D8
    jmp     short loc_1312
loc_12BE:
    cmp     eax, 5
    jz      short loc_12F0
    cmp     eax, 29Ah
    jz      short loc_1306
    jmp     short loc_1312
loc_12CC:
    mov     eax, 0
    call    create
    jmp     short loc_131C
loc_12D8:
    mov     eax, 0
    call    show
    jmp     short loc_131C
loc_12E4:
    mov     eax, 0
    call    dele
    jmp     short loc_131C
loc_12F0:
    lea     rdi, aByeBye; "bye,bye!!"
    call    puts_flush
    mov     edi, 0; status
    call    _exit
loc_1306:
    mov     eax, 0
    call    backdoor
    jmp     short loc_131C
loc_1312:
    mov     edi, 0; status
    call    _exit
loc_131C:
    jmp     loc_128E
main endp

