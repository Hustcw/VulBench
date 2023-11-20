sub_4009AB proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 480h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     qword ptr [rbp+nptr], 0
    mov     [rbp+var_468], 0
    mov     [rbp+var_460], 0
    mov     [rbp+var_458], 0
    mov     [rbp+var_474], 0
    lea     rsi, [rbp+var_450]
    mov     eax, 0
    mov     edx, 88h
    mov     rdi, rsi
    mov     rcx, rdx
    rep stosq
    mov     eax, cs:dword_60208C
    cmp     eax, 18h
    jle     short loc_400A2F
    mov     edi, offset aTooManyPapersA; "Too many papers are already indexed"
    call    _puts
    jmp     loc_400BF9
loc_400A2F:
    mov     edi, offset aAddPaperMenu; "Add paper menu"
    call    _puts
    mov     edi, offset a1AddName; "[1]. Add name"
    call    _puts
    mov     edi, offset a2AddAuthors; "[2]. Add authors"
    call    _puts
    mov     edi, offset a3AddAbstract; "[3]. Add abstract"
    call    _puts
    mov     edi, offset a4AddTags; "[4]. Add tags"
    call    _puts
    mov     edi, offset a5ViewPaperInfo; "[5]. View paper info"
    call    _puts
    mov     edi, offset a6Quit; "[6]. Quit"
    call    _puts
    mov     edi, offset a7QuitWithoutSa; "[7]. Quit without saving\n"
    call    _puts
    mov     edi, offset asc_4011CB; "> "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+nptr]
    mov     rdi, rax
    call    _gets
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_474], eax
    mov     edi, offset asc_4011CE; "\n"
    call    _puts
    cmp     [rbp+var_474], 7; switch 8 cases
    ja      def_400AD7; jumptable 0000000000400AD7 default case, case 0
    mov     eax, [rbp+var_474]
    mov     rax, ds:jpt_400AD7[rax*8]
def_400AD7:
    jmp     rax; switch jump
    mov     edi, offset aPaperName; jumptable 0000000000400AD7 case 1
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_450]
    mov     rdi, rax
    call    _gets
    mov     edi, offset asc_4011CE; "\n"
    call    _puts
    jmp     loc_400BF3
    mov     edi, offset aPaperAuthors; jumptable 0000000000400AD7 case 2
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_450]
    add     rax, 100h
    mov     rdi, rax
    call    _gets
    mov     edi, offset asc_4011CE; "\n"
    call    _puts
    jmp     loc_400BF3
    mov     edi, offset aPaperAbstract; jumptable 0000000000400AD7 case 3
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_450]
    add     rax, 200h
    mov     rdi, rax
    call    _gets
    mov     edi, offset asc_4011CE; "\n"
    call    _puts
    jmp     loc_400BF3
    mov     edi, offset aPaperTags; jumptable 0000000000400AD7 case 4
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_450]
    add     rax, 400h
    mov     rdi, rax
    call    _gets
    mov     edi, offset asc_4011CE; "\n"
    call    _puts
    jmp     short loc_400BF3
    lea     rax, [rbp+var_450]; jumptable 0000000000400AD7 case 5
    mov     rdi, rax
    call    sub_400D52
    jmp     short loc_400BF3
    mov     eax, cs:dword_60208C; jumptable 0000000000400AD7 case 6
    cdqe
    shl     rax, 6
    mov     rdx, rax
    shl     rdx, 4
    add     rax, rdx
    add     rax, 6020A0h
    mov     rdx, rax
    lea     rsi, [rbp+var_450]
    mov     eax, 88h
    mov     rdi, rdx
    mov     rcx, rax
    rep movsq
    mov     eax, cs:dword_60208C
    add     eax, 1
    mov     cs:dword_60208C, eax
    jmp     short loc_400BF9
    nop; jumptable 0000000000400AD7 default case, case 0
loc_400BF3:
    jmp     loc_400A2F
    nop; jumptable 0000000000400AD7 case 7
loc_400BF9:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400C0D
    call    ___stack_chk_fail
locret_400C0D:
    leave
    retn
sub_4009AB endp

