sub_40161D proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     [rbp+var_28], rdi
    mov     [rbp+s], rsi
    cmp     [rbp+var_28], 0
    jz      loc_4018C7
    mov     rax, [rbp+var_28]
    mov     eax, [rax+8]
    cdqe
    shl     rax, 3
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+ptr], rax
    mov     [rbp+var_18], 0
    mov     rdx, cs:delim
    mov     rax, [rbp+s]
    mov     rsi, rdx; delim
    mov     rdi, rax; s
    call    _strtok
    mov     [rbp+s1], rax
    jmp     loc_401860
loc_401677:
    mov     rax, [rbp+s1]
    lea     rsi, s2; "push"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_4016AE
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     qword ptr [rax], 11h
    jmp     loc_401844
loc_4016AE:
    mov     rax, [rbp+s1]
    lea     rsi, aPop; "pop"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_4016E5
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     qword ptr [rax], 12h
    jmp     loc_401844
loc_4016E5:
    mov     rax, [rbp+s1]
    lea     rsi, aAdd; "add"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_40171C
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     qword ptr [rax], 21h ; '!'
    jmp     loc_401844
loc_40171C:
    mov     rax, [rbp+s1]
    lea     rsi, aSub; "sub"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_401753
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     qword ptr [rax], 22h ; '"'
    jmp     loc_401844
loc_401753:
    mov     rax, [rbp+s1]
    lea     rsi, aMul; "mul"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_40178A
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     qword ptr [rax], 23h ; '#'
    jmp     loc_401844
loc_40178A:
    mov     rax, [rbp+s1]
    lea     rsi, aDiv; "div"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_4017C1
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     qword ptr [rax], 24h ; '$'
    jmp     loc_401844
loc_4017C1:
    mov     rax, [rbp+s1]
    lea     rsi, aLoad; "load"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_4017F5
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     qword ptr [rax], 31h ; '1'
    jmp     short loc_401844
loc_4017F5:
    mov     rax, [rbp+s1]
    lea     rsi, aSave; "save"
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jnz     short loc_401829
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     qword ptr [rax], 32h ; '2'
    jmp     short loc_401844
loc_401829:
    mov     eax, [rbp+var_18]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     qword ptr [rax], 0FFh
loc_401844:
    add     [rbp+var_18], 1
    mov     rax, cs:delim
    mov     rsi, rax; delim
    mov     edi, 0; s
    call    _strtok
    mov     [rbp+s1], rax
loc_401860:
    mov     rax, [rbp+var_28]
    mov     eax, [rax+8]
    cmp     [rbp+var_18], eax
    jge     short loc_401877
    cmp     [rbp+s1], 0
    jnz     loc_401677
loc_401877:
    mov     eax, [rbp+var_18]
    sub     eax, 1
    mov     [rbp+var_14], eax
    jmp     short loc_4018B0
loc_401882:
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]
    mov     rax, [rbp+ptr]
    add     rax, rdx
    mov     rdx, [rax]
    mov     rax, [rbp+var_28]
    mov     rsi, rdx
    mov     rdi, rax
    call    sub_40144E
    test    eax, eax
    jz      short loc_4018B8
    sub     [rbp+var_14], 1
loc_4018B0:
    cmp     [rbp+var_14], 0
    jns     short loc_401882
    jmp     short loc_4018B9
loc_4018B8:
    nop
loc_4018B9:
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    jmp     short locret_4018C8
loc_4018C7:
    nop
locret_4018C8:
    leave
    retn
sub_40161D endp

