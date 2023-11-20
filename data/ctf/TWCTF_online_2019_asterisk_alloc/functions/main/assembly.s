main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    call    initialize
loc_D72:
    call    print_menu
    lea     rdi, aYourChoice; "Your choice: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    call    _getchar
    mov     eax, [rbp+var_C]
    cmp     eax, 5; switch 6 cases
    ja      short def_DCE; jumptable 0000000000000DCE default case, case 0
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_DCE
    mov     eax, ds:(jpt_DCE - 0F28h)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_DCE
    add     rax, rdx
def_DCE:
    jmp     rax; switch jump
    call    call_malloc; jumptable 0000000000000DCE case 1
    jmp     short loc_E02
    call    call_calloc; jumptable 0000000000000DCE case 2
    jmp     short loc_E02
    call    call_realloc; jumptable 0000000000000DCE case 3
    jmp     short loc_E02
    call    call_free; jumptable 0000000000000DCE case 4
    jmp     short loc_E02
    mov     edi, 0; jumptable 0000000000000DCE case 5
    call    __exit
    lea     rdi, aInvalidChoice; jumptable 0000000000000DCE default case, case 0
    call    _puts
loc_E02:
    jmp     loc_D72
main endp

