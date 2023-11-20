main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 420h
    mov     [rbp+var_414], edi
    mov     [rbp+var_420], rsi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    disable_buffering
    mov     edi, 5
    call    limit_time
    lea     rdi, aAsciiartTxt; "./asciiart.txt"
    call    print_asciiart
    mov     rdx, cs:flag_path
    mov     rax, cs:banner
    mov     rsi, rdx
    mov     rdi, rax; format
    mov     eax, 0
    call    printf
    mov     rax, rbp
    mov     cs:qword_4100, rax
    mov     rax, rsp
    mov     cs:qword_40F8, rax
    lea     rax, __func___3793; "main"
    mov     cs:debug_info, rax
    lea     rdi, aNumberOfNumber; "Number of numbers to add"
    call    get_long
    mov     [rbp+var_410], rax
    cmp     [rbp+var_410], 7Fh
    jle     short loc_137E
    mov     esi, 7Fh
    lea     rdi, format; "Error, can only handle up to %d (CHAR_M"...
    mov     eax, 0
    call    printf
    mov     eax, 1
    jmp     short loc_13DB
loc_137E:
    mov     rax, [rbp+var_410]
    movzx   edx, al
    lea     rax, [rbp+var_400]
    mov     esi, edx
    mov     rdi, rax
    call    get_data
    mov     rax, [rbp+var_410]
    movzx   edx, al
    lea     rax, [rbp+var_400]
    mov     esi, edx
    mov     rdi, rax
    call    add_nums
    mov     [rbp+var_408], rax
    mov     rax, [rbp+var_408]
    mov     rsi, rax
    lea     rdi, aTotalIsLd; "Total is %ld\n"
    mov     eax, 0
    call    printf
    mov     eax, 0
loc_13DB:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_13EF
    call    ___stack_chk_fail
locret_13EF:
    leave
    retn
main endp

