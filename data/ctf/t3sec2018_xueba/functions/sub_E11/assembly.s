sub_E11 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, cs:dword_20204C
    cmp     eax, 1
    jle     short loc_E49
    lea     rdi, aYouAreReallyAn; "You are really annoying!"
    call    puts
    mov     edi, 0; status
    call    exit
loc_E49:
    lea     rdi, aIndex; "Index:"
    call    puts
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aU; "%u"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, cs:dword_20204C
    add     eax, 1
    mov     cs:dword_20204C, eax
    lea     rdi, aWhichLetterDoY; "Which letter do you want to change?"
    call    puts
    lea     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    movzx   eax, [rbp+buf]
    movsx   eax, al
    mov     edx, [rbp+var_C]
    mov     edx, edx
    mov     rcx, rdx
    shl     rcx, 5
    lea     rdx, unk_202060
    add     rdx, rcx
    mov     esi, eax; c
    mov     rdi, rdx; s
    call    strchr
    test    rax, rax
    jnz     short loc_ED8
    lea     rdi, aNoSuchLetter; "No such letter"
    call    puts
    jmp     short loc_F2A
loc_ED8:
    lea     rax, [rbp+var_D]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    movzx   eax, [rbp+buf]
    movsx   eax, al
    mov     edx, [rbp+var_C]
    mov     edx, edx
    mov     rcx, rdx
    shl     rcx, 5
    lea     rdx, unk_202060
    add     rdx, rcx
    mov     esi, eax; c
    mov     rdi, rdx; s
    call    strchr
    mov     rdx, rax
    movzx   eax, [rbp+var_D]
    mov     [rdx], al
    lea     rdi, aDone; "Done!"
    call    puts
loc_F2A:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_F3E
    call    __stack_chk_fail
locret_F3E:
    leave
    retn
sub_E11 endp

