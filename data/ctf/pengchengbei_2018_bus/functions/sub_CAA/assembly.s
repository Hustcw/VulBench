sub_CAA proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_20], 0
    jmp     short loc_CEB
loc_CCA:
    mov     eax, [rbp+var_20]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202080
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_CF3
    add     [rbp+var_20], 1
loc_CEB:
    cmp     [rbp+var_20], 1Fh
    jle     short loc_CCA
    jmp     short loc_CF4
loc_CF3:
    nop
loc_CF4:
    mov     edi, 80h; size
    call    _malloc
    mov     [rbp+ptr], rax
    lea     rdi, aWhereDoYouWant; "Where do you want to go: "
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+ptr]
    mov     esi, 80h
    mov     rdi, rax
    call    sub_B72
    mov     rax, [rbp+ptr]
    mov     rdi, rax
    call    sub_C37
    mov     [rbp+var_1C], eax
    cmp     [rbp+var_1C], 0FFFFFFFFh
    jnz     short loc_D69
    mov     eax, [rbp+var_20]
    cdqe
    lea     rcx, ds:0[rax*8]
    lea     rax, qword_202080
    mov     rdx, [rbp+ptr]
    mov     [rcx+rax], rdx
    mov     rax, cs:qword_202060
    add     rax, 1
    mov     cs:qword_202060, rax
    jmp     short loc_D87
loc_D69:
    lea     rdi, aOkMorePeopleHu; "OK,more people huh?"
    call    _puts
    mov     eax, [rbp+var_1C]
    mov     [rbp+var_20], eax
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
loc_D87:
    lea     rdi, aHowManyPeople; "How many people: "
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_18]
    mov     rsi, rax
    lea     rdi, aLu; "%lu"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, [rbp+var_20]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202180
    mov     rdx, [rdx+rax]
    mov     rax, [rbp+var_18]
    lea     rcx, [rdx+rax]
    mov     eax, [rbp+var_20]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202180
    mov     [rdx+rax], rcx
    lea     rdi, aDone; "Done!"
    call    _puts
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_E09
    call    ___stack_chk_fail
locret_E09:
    leave
    retn
sub_CAA endp

