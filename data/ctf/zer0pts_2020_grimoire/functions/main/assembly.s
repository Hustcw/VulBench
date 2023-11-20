main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    call    initialize
loc_1494:
    call    show_menu
    call    read_int
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_C]
    cmp     eax, 2
    jz      short loc_14C8
    cmp     eax, 2
    jg      short loc_14B5
    cmp     eax, 1
    jz      short loc_14C1
    jmp     short loc_14DD
loc_14B5:
    cmp     eax, 3
    jz      short loc_14CF
    cmp     eax, 4
    jz      short loc_14D6
    jmp     short loc_14DD
loc_14C1:
    call    grimoire_open
    jmp     short loc_14EA
loc_14C8:
    call    grimoire_read
    jmp     short loc_14EA
loc_14CF:
    call    grimoire_edit
    jmp     short loc_14EA
loc_14D6:
    call    grimoire_close
    jmp     short loc_14EA
loc_14DD:
    lea     rdi, aInvalidChoice; "Invalid choice."
    call    _puts
    nop
loc_14EA:
    jmp     short loc_1494
main endp

