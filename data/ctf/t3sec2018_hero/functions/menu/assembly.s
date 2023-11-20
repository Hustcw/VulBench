menu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, a1AddHero; "1. add hero"
    call    puts
    lea     rdi, a2ShowHero; "2. show hero"
    call    puts
    lea     rdi, a3EditHero; "3. edit hero"
    call    puts
    lea     rdi, a4RemoveHero; "4. remove hero"
    call    puts
    lea     rdi, a5Exit; "5. exit"
    call    puts
    lea     rdi, aYourChoice; "Your choice: "
    mov     eax, 0
    call    printf
    nop
    pop     rbp
    retn
menu endp

