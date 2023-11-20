sub_1460 proc
    push    rbx
    mov     esi, 300h; size
    sub     rsp, 190h
    lea     rdi, path; buf
    mov     rax, fs:28h
    mov     [rsp+198h+var_10], rax
    xor     eax, eax
    call    getcwd
    test    rax, rax
    jz      loc_156B
    mov     rdi, rsp; name
    call    uname
    test    eax, eax
    jnz     loc_1584
    mov     edi, 0Ah; c
    call    putchar
    lea     rdx, [rsp+198h+var_D5]
    lea     rsi, aWelcomeToS; "Welcome to %s\n"
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
    mov     edi, 0Ah; c
    call    putchar
    lea     rdi, asc_23F8; "***************************************"...
    call    puts
    call    getlogin
    lea     rsi, aWelcomeToSYSSh; "** Welcome to %s Y's shell             "...
    mov     rdx, rax
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
    lea     rdi, aPleaseInput1mh; "** Please input \"\x1B[1mhelp\x1B[m\" t"...
    call    puts
    lea     rdi, asc_23F8; "***************************************"...
    call    puts
    lea     rdi, aMmmMMMmmMmmmmm; "        mmm  m    m   mmm mmmmmmm mmmmm"...
    call    puts
    lea     rdi, aMMM; "      m\"   \" #  m\"  m\"   \"   #    "...
    call    puts
    lea     rdi, aMmMMmmmm; "      #   mm #m#    #        #    #mmmm"...
    call    puts
    lea     rdi, aM; "      #    # #  #m  #        #    #    "...
    call    puts
    lea     rdi, aMmmMMmm; "       \"mmm\" #   \"m  \"mmm\"   #    "...
    call    puts
    mov     rax, [rsp+198h+var_10]
    xor     rax, fs:28h
    jnz     short loc_157F
    add     rsp, 190h
    pop     rbx
    retn
loc_156B:
    lea     rdi, aGetPathNameErr; "get path_name error"
    call    puts
    or      edi, 0FFFFFFFFh; status
    call    exit
loc_157F:
    call    __stack_chk_fail
loc_1584:
    lea     rdi, aUname_0; "uname"
    call    perror
    mov     edi, 1; status
    call    exit
sub_1460 endp

