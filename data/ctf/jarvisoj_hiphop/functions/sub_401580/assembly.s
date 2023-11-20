sub_401580 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_4], 0
    mov     edi, offset aSkillActivatio; "\n====================================="...
    call    _puts
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     rsi, rax
    mov     edi, offset aYouUseS; "\rYou use %s\n"
    mov     eax, 0
    call    _printf
    mov     [rbp+var_4], 0
loc_4015BE:
    cmp     [rbp+var_4], 8
    jg      short loc_4015F2
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 5
    lea     rdx, aAttack[rax]; "attack"
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     rsi, rdx; s2
    mov     rdi, rax; s1
    call    _strcmp
    test    eax, eax
    jz      short loc_4015F1
    add     [rbp+var_4], 1
    jmp     short loc_4015BE
loc_4015F1:
    nop
loc_4015F2:
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     rdi, rax
    call    sub_40117C
    movzx   eax, cs:byte_603380
    test    al, al
    jz      short loc_40162C
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     rsi, rax
    mov     edi, offset aYouAreAlreadyU; "You are already using the skill. Skill "...
    mov     eax, 0
    call    _printf
    jmp     loc_4016EA
loc_40162C:
    mov     cs:byte_603380, 1
    cmp     [rbp+var_4], 4
    jle     short loc_401689
    mov     rax, [rbp+var_18]
    mov     rax, [rax+48h]
    test    rax, rax
    js      short loc_40167D
    mov     rax, [rbp+var_18]
    mov     rdx, [rax+18h]
    mov     rax, [rbp+var_18]
    mov     rax, [rax+48h]
    sub     rdx, rax
    mov     rax, [rbp+var_18]
    mov     [rax+18h], rdx
    mov     rax, [rbp+var_18]
    mov     rax, [rax+18h]
    mov     rsi, rax
    mov     edi, offset aBossSHpIsLd; "Boss's hp is %ld\n"
    mov     eax, 0
    call    _printf
    jmp     short loc_4016D9
loc_40167D:
    mov     edi, offset aDamageCanTBeNe; "Damage can't be negative number!"
    call    _puts
    jmp     short loc_4016D9
loc_401689:
    mov     rax, [rbp+var_18]
    mov     rax, [rax+48h]
    test    rax, rax
    js      short loc_4016CF
    mov     rax, [rbp+var_18]
    mov     rdx, [rax+18h]
    mov     rax, [rbp+var_18]
    mov     rax, [rax+48h]
    cdqe
    sub     rdx, rax
    mov     rax, [rbp+var_18]
    mov     [rax+18h], rdx
    mov     rax, [rbp+var_18]
    mov     rax, [rax+18h]
    mov     rsi, rax
    mov     edi, offset aBossSHpIsLd; "Boss's hp is %ld\n"
    mov     eax, 0
    call    _printf
    jmp     short loc_4016D9
loc_4016CF:
    mov     edi, offset aDamageCanTBeNe; "Damage can't be negative number!"
    call    _puts
loc_4016D9:
    mov     edi, offset unk_6033A0
    call    sub_40184C
    mov     cs:byte_603380, 0
loc_4016EA:
    mov     rax, [rbp+var_18]
    mov     qword ptr [rax+48h], 0
    mov     edi, offset asc_402138; "\n====================================="...
    call    _puts
    nop
    leave
    retn
sub_401580 endp

