menu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, aWelcomeToMyBar; "Welcome to my bar!!"
    call    puts_flush
    mov     edi, 0Ah; c
    call    _putchar
    lea     rdi, aBeCarefulThatA; "Be careful that a group of drunks are c"...
    call    puts_flush
    mov     edi, 0Ah; c
    call    _putchar
    lea     rdi, format; "——You can choose a weapon to fight them"...
    mov     eax, 0
    call    _printf
    mov     edi, 0Ah; c
    call    _putchar
    lea     rdi, a1CreateAWeapon; "1: Create a weapon"
    call    puts_flush
    lea     rdi, a2ShowMeWeapon; "2: Show me weapon"
    call    puts_flush
    lea     rdi, a3FightFightFig; "3: Fight!!Fight!!Fight!!"
    call    puts_flush
    lea     rdi, a5YouAreALoserB; "5: You are a loser!!byebye!!"
    call    puts_flush
    lea     rdi, aCommand; "Command: "
    call    puts_flush
    nop
    pop     rbp
    retn
menu endp

