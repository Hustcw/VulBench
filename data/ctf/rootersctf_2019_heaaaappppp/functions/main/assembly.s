main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     [rbp+var_20], rsi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    beNice
loc_141B:
    lea     rdi, aUserAdministra; "### USER ADMINISTRATION ###\n"
    call    _puts
    lea     rdi, a0CreateUser; "0) Create user"
    call    _puts
    lea     rdi, a1EditUserName; "1) Edit user name"
    call    _puts
    lea     rdi, a2DeleteUser; "2) Delete user"
    call    _puts
    lea     rdi, a3SendAdminAMes; "3) Send admin a message"
    call    _puts
    lea     rdi, a4Exit; "4) exit"
    call    _puts
    lea     rdi, aEnterYourChoic; "Enter your choice: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 4; switch 5 cases
    ja      short def_14B4; jumptable 00000000000014B4 default case
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_14B4
    mov     eax, ds:(jpt_14B4 - 2130h)[rdx+rax]
    cdqe
    lea     rdx, jpt_14B4
    add     rax, rdx
def_14B4:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 00000000000014B4 case 0
    call    createUser
    jmp     short loc_14FC
    mov     eax, 0; jumptable 00000000000014B4 case 1
    call    editUsername
    jmp     short loc_14FC
    mov     eax, 0; jumptable 00000000000014B4 case 2
    call    deleteUser
    jmp     short loc_14FC
    mov     eax, 0; jumptable 00000000000014B4 case 3
    call    sendMessage
    jmp     short loc_14FC
    mov     edi, 0; jumptable 00000000000014B4 case 4
    call    _exit
    lea     rdi, aWrongChoiceTry; jumptable 00000000000014B4 default case
    call    _puts
loc_14FC:
    jmp     loc_141B
main endp

