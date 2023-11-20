sub_11F0 proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, asc_1448; "___________                __      ____"...
    call    puts
    lea     rdi, asc_14A0; "\\_   _____/____    _______/  |_   /   "...
    call    puts
    lea     rdi, asc_14F8; " |    __) \\__  \\  /  ___/\\   __\\  "...
    call    puts
    lea     rdi, asc_1550; " |     \\   / __ \\_\\___ \\  |  |    /"...
    call    puts
    lea     rdi, asc_15A8; " \\___  /  (____  /____  > |__|   /____"...
    call    puts
    lea     rdi, asc_1600; "     \\/        \\/     \\/            "...
    call    puts
    lea     rdi, byte_1446; s
    call    puts
    nop
    pop     rbp
    retn
sub_11F0 endp

