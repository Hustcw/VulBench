main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stderr@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     [rbp+buf], 0
    mov     [rbp+var_18], 0
    mov     [rbp+var_28], 8
    lea     rdi, aHi; "Hi!"
    call    _puts
    lea     rdi, aYouCurrentlyHa; "You currently have 8 coins!. With each "...
    call    _puts
    mov     rax, cs:system_ptr
    mov     rsi, rax
    lea     rdi, format; "Here is system : 0x%016llx\n"
    mov     eax, 0
    call    _printf
    jmp     loc_1436
loc_130D:
    mov     eax, [rbp+var_28]
    mov     esi, eax
    lea     rdi, aSelectYourActi; "Select your action! (coins : %d)\n"
    mov     eax, 0
    call    _printf
    lea     rdi, a1Malloc; "[ 1 ] : malloc"
    call    _puts
    lea     rdi, a2Free; "[ 2 ] : free"
    call    _puts
    lea     rdi, a3Write; "[ 3 ] : write"
    call    _puts
    lea     rdi, a4Bye; "[ 4 ] : bye!"
    call    _puts
    mov     eax, 0
    call    read_num
    cmp     rax, 2
    jz      short loc_13BE
    cmp     rax, 2
    ja      short loc_1374
    cmp     rax, 1
    jz      short loc_138D
    jmp     loc_1436
loc_1374:
    cmp     rax, 3
    jz      loc_1407
    cmp     rax, 4
    jz      loc_142B
    jmp     loc_1436
loc_138D:
    lea     rdi, aHowMuch; "How much?"
    call    _puts
    mov     eax, 0
    call    read_num
    mov     [rbp+var_24], eax
    mov     eax, [rbp+var_24]
    mov     edi, eax
    call    malloc_wrapper
    mov     [rbp+buf], rax
    mov     rax, [rbp+buf]
    mov     [rbp+var_18], rax
    jmp     short loc_1436
loc_13BE:
    lea     rdi, aWhere; "where?"
    call    _puts
    mov     eax, 0
    call    read_num
    mov     [rbp+var_10], rax
    mov     rdx, [rbp+var_10]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     [rbp+ptr], rax
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, [rbp+buf]
    cmp     rax, [rbp+ptr]
    jnz     short loc_1436
    mov     [rbp+buf], 0
    jmp     short loc_1436
loc_1407:
    lea     rdi, aWhat; "what?"
    call    _puts
    mov     rax, [rbp+buf]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    jmp     short loc_1436
loc_142B:
    mov     eax, 0
    call    bye
loc_1436:
    mov     eax, [rbp+var_28]
    lea     edx, [rax-1]
    mov     [rbp+var_28], edx
    test    eax, eax
    jnz     loc_130D
    mov     eax, 0
    call    bye
main endp

