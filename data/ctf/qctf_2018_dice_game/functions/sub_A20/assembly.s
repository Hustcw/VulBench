sub_A20 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    lea     rdi, format; "Give me the point(1~6): "
    mov     eax, 0
    call    printf
    mov     rax, cs:stdout_ptr
    mov     rax, [rax]
    mov     rdi, rax; stream
    call    fflush
    lea     rax, [rbp+var_4]
    mov     rsi, rax
    lea     rdi, aHd; "%hd"
    mov     eax, 0
    call    __isoc99_scanf
    movzx   eax, [rbp+var_4]
    test    ax, ax
    jle     short loc_A76
    movzx   eax, [rbp+var_4]
    cmp     ax, 6
    jle     short loc_A8C
loc_A76:
    lea     rdi, s; "Invalid value!"
    call    puts
    mov     eax, 0
    jmp     locret_B26
loc_A8C:
    call    rand
    mov     ecx, eax
    mov     edx, 2AAAAAABh
    mov     eax, ecx
    imul    edx
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    mov     eax, edx
    add     eax, eax
    add     eax, edx
    add     eax, eax
    sub     ecx, eax
    mov     edx, ecx
    mov     eax, edx
    add     eax, 1
    mov     [rbp+var_2], ax
    movzx   eax, [rbp+var_4]
    test    ax, ax
    jle     short loc_AD9
    movzx   eax, [rbp+var_4]
    cmp     ax, 6
    jg      short loc_AD9
    cmp     [rbp+var_2], 0
    jle     short loc_AD9
    cmp     [rbp+var_2], 6
    jle     short loc_AF8
loc_AD9:
    lea     rcx, function; "dice_game"
    mov     edx, 18h; line
    lea     rsi, file; "dice_game.c"
    lea     rdi, assertion; "(point>=1 && point<=6) && (sPoint>=1 &&"...
    call    __assert_fail
loc_AF8:
    movzx   eax, [rbp+var_4]
    cmp     ax, [rbp+var_2]
    jnz     short loc_B15
    lea     rdi, aYouWin; "You win."
    call    puts
    mov     eax, 1
    jmp     short locret_B26
loc_B15:
    lea     rdi, aYouLost; "You lost."
    call    puts
    mov     eax, 0
locret_B26:
    leave
    retn
sub_A20 endp

