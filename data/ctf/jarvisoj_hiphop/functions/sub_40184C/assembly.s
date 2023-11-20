sub_40184C proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     rax, [rbp+var_8]
    mov     rax, [rax+18h]
    test    rax, rax
    jg      short loc_4018D0
    mov     rax, [rbp+var_8]
    mov     rax, [rax+10h]
    cmp     rax, 2
    jle     short loc_401889
    mov     rax, [rbp+var_8]
    mov     rdi, rax
    call    sub_4018D4
    mov     edi, 0FFFFFFFFh; status
    call    _exit
loc_401889:
    mov     edi, offset aYouWinBossIsUp; "You Win! Boss is upgrading.."
    call    _puts
    mov     rax, [rbp+var_8]
    mov     rax, [rax+10h]
    add     eax, 1
    mov     edx, eax
    mov     rax, [rbp+var_8]
    add     rax, 10h
    mov     esi, edx
    mov     rdi, rax
    call    sub_4013A0
    mov     rax, [rbp+var_8]
    mov     rax, [rax+10h]
    add     rax, 1
    mov     rsi, rax
    mov     edi, offset aLevelD; "level:%d\n"
    mov     eax, 0
    call    _printf
loc_4018D0:
    nop
    leave
    retn
sub_40184C endp

