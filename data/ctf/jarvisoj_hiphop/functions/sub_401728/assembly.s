sub_401728 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    sub_401402
    mov     edi, offset aChoice; "choice:"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    _scanf
    mov     eax, [rbp+var_C]
    test    eax, eax
    jle     short loc_40178A
    mov     eax, [rbp+var_C]
    cmp     eax, 9
    jle     short loc_401799
loc_40178A:
    mov     edi, offset aWrongChoice; "Wrong Choice"
    call    _puts
    jmp     loc_401835
loc_401799:
    mov     eax, [rbp+var_C]
    cmp     eax, 4
    jle     short loc_4017F9
    mov     rax, [rbp+var_18]
    mov     rax, [rax+10h]
    cmp     rax, 2
    jle     short loc_4017ED
    mov     eax, [rbp+var_C]
    lea     edx, [rax-1]
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     esi, edx
    mov     rdi, rax
    call    sub_40114A
    mov     eax, [rbp+var_C]
    sub     eax, 1
    cdqe
    shl     rax, 5
    add     rax, 603140h
    mov     rsi, rax
    mov     edi, offset aChangeSkillS; "Change Skill: %s\n"
    mov     eax, 0
    call    _printf
    jmp     short loc_401835
loc_4017ED:
    mov     edi, offset aYouHaveNotLear; "You have not learned this skill yet"
    call    _puts
    jmp     short loc_401835
loc_4017F9:
    mov     eax, [rbp+var_C]
    lea     edx, [rax-1]
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     esi, edx
    mov     rdi, rax
    call    sub_40114A
    mov     eax, [rbp+var_C]
    sub     eax, 1
    cdqe
    shl     rax, 5
    add     rax, 603140h
    mov     rsi, rax
    mov     edi, offset aChangeSkillS; "Change Skill: %s\n"
    mov     eax, 0
    call    _printf
loc_401835:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_401849
    call    ___stack_chk_fail
locret_401849:
    leave
    retn
sub_401728 endp

