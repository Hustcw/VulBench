start_routine proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 1020h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+s]
    mov     edx, 1000h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    mov     edi, offset s; "Welcome to babystack 2018!"
    call    puts
    mov     edi, offset aHowManyBytesDo; "How many bytes do you want to send?"
    call    puts
    mov     eax, 0
    call    sub_400906
    mov     [rbp+var_1018], rax
    cmp     [rbp+var_1018], 10000h
    jbe     short loc_400A5D
    mov     edi, offset aYouAreGreedy; "You are greedy!"
    call    puts
    mov     eax, 0
    jmp     short loc_400A87
loc_400A5D:
    mov     rdx, [rbp+var_1018]
    lea     rax, [rbp+s]
    mov     rsi, rax
    mov     edi, 0
    call    sub_400957
    mov     edi, offset aItSTimeToSayGo; "It's time to say goodbye."
    call    puts
    mov     eax, 0
loc_400A87:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400A9B
    call    __stack_chk_fail
locret_400A9B:
    leave
    retn
start_routine endp

