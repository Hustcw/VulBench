menu proc
    push    rbp
    mov     rbp, rsp
    lea     rdi, asc_11CB; "\n***********************"
    call    puts
    lea     rdi, aWelcomeToTheMa; "Welcome to the magic book world!"
    call    puts
    lea     rdi, asc_1209; "***********************"
    call    puts
    lea     rdi, a1CreateABook; "1.create a book"
    call    puts
    lea     rdi, a2ShowTheConten; "2.show the content"
    call    puts
    lea     rdi, a3ThrowABook; "3.throw a book"
    call    puts
    lea     rdi, a4WriteSomethin; "4.write something on the book"
    call    puts
    lea     rdi, a5ExitTheWorld; "5.exit the world"
    call    puts
    lea     rdi, aYourChoice; "Your choice: "
    mov     eax, 0
    call    printf
    pop     rbp
    retn
menu endp

