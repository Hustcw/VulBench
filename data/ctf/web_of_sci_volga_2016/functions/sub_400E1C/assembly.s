sub_400E1C proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     qword ptr [rbp+nptr], 0
    mov     [rbp+var_28], 0
    mov     [rbp+var_20], 0
    mov     [rbp+var_18], 0
    mov     [rbp+var_38], 0
    mov     [rbp+var_34], 0
loc_400E61:
    mov     edi, offset aChooseCommandT; "Choose command to perform"
    call    _puts
    mov     edi, offset a1AddPaper; "[1]. Add paper"
    call    _puts
    mov     edi, offset a2DeletePaper; "[2]. Delete paper"
    call    _puts
    mov     edi, offset a3ListPapers; "[3]. List papers"
    call    _puts
    mov     edi, offset a4ViewPaperInfo; "[4]. View paper info"
    call    _puts
    mov     edi, offset a5Exit; "[5]. Exit\n"
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
    mov     [rbp+var_38], eax
    mov     edi, offset asc_4011CE; "\n"
    call    _puts
    cmp     [rbp+var_38], 5; switch 6 cases
    ja      def_400EE6; jumptable 0000000000400EE6 default case, case 0
    mov     eax, [rbp+var_38]
    mov     rax, ds:jpt_400EE6[rax*8]
def_400EE6:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000400EE6 case 1
    call    sub_4009AB
    jmp     loc_400FB1
    mov     edi, offset aEnterIndexOfPa; jumptable 0000000000400EE6 case 2
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+nptr]
    mov     rdi, rax
    call    _gets
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_34], eax
    mov     eax, [rbp+var_34]
    mov     edi, eax
    call    sub_400C0F
    jmp     loc_400FB1
    mov     eax, 0; jumptable 0000000000400EE6 case 3
    call    sub_400CC6
    jmp     short loc_400FB1
    mov     edi, offset aEnterIndexOfPa_0; jumptable 0000000000400EE6 case 4
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+nptr]
    mov     rdi, rax
    call    _gets
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_34], eax
    cmp     [rbp+var_34], 0
    js      short loc_400F77
    mov     eax, cs:dword_60208C
    cmp     [rbp+var_34], eax
    jl      short loc_400F8D
loc_400F77:
    mov     eax, [rbp+var_34]
    mov     esi, eax
    mov     edi, offset aWrongPaperInde; "Wrong paper index %d\n\n\n"
    mov     eax, 0
    call    _printf
    jmp     short loc_400FB1
loc_400F8D:
    mov     eax, [rbp+var_34]
    cdqe
    shl     rax, 6
    mov     rdx, rax
    shl     rdx, 4
    add     rax, rdx
    add     rax, 6020A0h
    mov     rdi, rax
    call    sub_400D52
    jmp     short loc_400FB1
    nop; jumptable 0000000000400EE6 default case, case 0
loc_400FB1:
    jmp     loc_400E61
    nop; jumptable 0000000000400EE6 case 5
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400FCB
    call    ___stack_chk_fail
locret_400FCB:
    leave
    retn
sub_400E1C endp

