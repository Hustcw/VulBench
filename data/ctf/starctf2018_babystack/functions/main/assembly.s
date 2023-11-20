main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdin
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setbuf
    mov     rax, cs:stdout
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setbuf
    mov     edi, offset byte_400C96; s
    call    puts
    mov     edi, offset asc_400C98; " #   #    ####    #####  ######"
    call    puts
    mov     edi, offset asc_400CB8; "  # #    #    #     #    #"
    call    puts
    mov     edi, offset asc_400CD8; "### ###  #          #    #####"
    call    puts
    mov     edi, offset asc_400CF7; "  # #    #          #    #"
    call    puts
    mov     edi, offset asc_400D12; " #   #   #    #     #    #"
    call    puts
    mov     edi, offset asc_400D2D; "          ####      #    #"
    call    puts
    mov     edi, offset byte_400C96; s
    call    puts
    lea     rax, [rbp+newthread]
    mov     ecx, 0; arg
    mov     edx, offset start_routine; start_routine
    mov     esi, 0; attr
    mov     rdi, rax; newthread
    call    pthread_create
    mov     rax, [rbp+newthread]
    mov     esi, 0; thread_return
    mov     rdi, rax; th
    call    pthread_join
    test    eax, eax
    jz      short loc_400B6D
    mov     edi, offset aExitFailure; "exit failure"
    call    puts
    mov     eax, 1
    jmp     short loc_400B7C
loc_400B6D:
    mov     edi, offset aByeBye; "Bye bye"
    call    puts
    mov     eax, 0
loc_400B7C:
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_400B90
    call    __stack_chk_fail
locret_400B90:
    leave
    retn
main endp

