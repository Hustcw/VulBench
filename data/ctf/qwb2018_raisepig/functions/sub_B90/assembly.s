sub_B90 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, s; s
    call    puts
    lea     rdi, asc_1355; "            ,-,------, "
    call    puts
    lea     rdi, asc_136D; "          _ \\(\\(_,--'  "
    call    puts
    lea     rdi, asc_1385; "     <`--'\\>/(/(__     "
    call    puts
    lea     rdi, asc_139D; "     /. .  `'` '  \\    "
    call    puts
    lea     rdi, asc_13B5; "    ('')  ,        @   "
    call    puts
    lea     rdi, asc_13CD; "     `-._,        /    "
    call    puts
    lea     rdi, asc_13E5; "        )-)_/--( >     "
    call    puts
    lea     rdi, asc_13FD; "       ''''  ''''      "
    call    puts
    lea     rdi, s; s
    call    puts
    lea     rdi, a1RaiseAPig; "1 . Raise a pig "
    call    puts
    lea     rdi, a2VisitPigs; "2 . Visit pigs "
    call    puts
    lea     rdi, a3EatAPig; "3 . Eat a pig"
    call    puts
    lea     rdi, a4EatTheWholePi; "4 . Eat the whole Pig Farm"
    call    puts
    lea     rdi, a5LeaveTheFarm; "5 . Leave the Farm"
    call    puts
    lea     rdi, s; s
    call    puts
    lea     rdi, format; "Your choice : "
    mov     eax, 0
    call    printf
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_C8D
    call    __stack_chk_fail
locret_C8D:
    leave
    retn
sub_B90 endp

