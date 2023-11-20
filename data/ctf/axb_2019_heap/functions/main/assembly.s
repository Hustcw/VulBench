main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     eax, 0
    call    init
    mov     eax, 0
    call    banner
loc_1186:
    mov     eax, 0
    call    menu
    mov     eax, 0
    call    get_int
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 1
    jnz     short loc_11AF
    mov     eax, 0
    call    add_note
    jmp     short loc_1186
loc_11AF:
    cmp     [rbp+var_4], 2
    jnz     short loc_11C1
    mov     eax, 0
    call    delete_note
    jmp     short loc_1186
loc_11C1:
    cmp     [rbp+var_4], 3
    jnz     short loc_11D5
    lea     rdi, aNone; "None!"
    call    _puts
    jmp     short loc_1186
loc_11D5:
    cmp     [rbp+var_4], 4
    jnz     short loc_11E7
    mov     eax, 0
    call    edit_note
    jmp     short loc_1186
loc_11E7:
    lea     rdi, aNoSuchChoices; "No such choices!"
    call    _puts
    jmp     short loc_1186
main endp

