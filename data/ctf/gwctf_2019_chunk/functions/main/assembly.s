main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_14], edi
    mov     [rbp+var_20], rsi
    mov     [rbp+var_28], rdx
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    init
loc_AFC:
    mov     eax, 0
    call    menu
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, unk_1108
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 1
    jnz     short loc_B32
    mov     eax, 0
    call    add
    jmp     short loc_AFC
loc_B32:
    nop
    mov     eax, [rbp+var_C]
    cmp     eax, 3
    jnz     short loc_B47
    mov     eax, 0
    call    delete
    jmp     short loc_AFC
loc_B47:
    mov     eax, [rbp+var_C]
    cmp     eax, 2
    jnz     short loc_B5B
    mov     eax, 0
    call    show
    jmp     short loc_AFC
loc_B5B:
    mov     eax, [rbp+var_C]
    cmp     eax, 4
    jnz     short loc_B6F
    mov     eax, 0
    call    edit
    jmp     short loc_AFC
loc_B6F:
    mov     eax, [rbp+var_C]
    cmp     eax, 5
    jnz     short loc_B8D
    lea     rdi, s; "See you tomorrow~"
    call    puts
    mov     edi, 0; status
    call    exit
loc_B8D:
    lea     rdi, aInvalidChoice; "Invalid choice!"
    call    puts
    jmp     loc_AFC
main endp

