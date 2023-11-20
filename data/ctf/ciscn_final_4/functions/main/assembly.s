main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 120h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    init
    call    fork
    mov     [rbp+var_114], eax
    cmp     [rbp+var_114], 0
    jns     short loc_400FB9
    mov     edi, offset aSomethingWrong; "something wrong!"
    call    puts
    mov     edi, 0FFFFFFFFh; status
    call    exit
loc_400FB9:
    cmp     [rbp+var_114], 0
    jz      short loc_400FEC
    mov     eax, [rbp+var_114]
    mov     edi, eax
    call    watch
    mov     eax, 0
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      locret_401121
    jmp     loc_40111C
loc_400FEC:
    mov     esi, 1
    mov     edi, 1; option
    mov     eax, 0
    call    prctl
    mov     ecx, 0
    mov     edx, 0
    mov     esi, 0
    mov     edi, 0; request
    mov     eax, 0
    call    ptrace
    call    getpid
    mov     esi, 13h; sig
    mov     edi, eax; pid
    call    kill
    mov     edi, offset aYouCanTCallThe; "you can't call the execve syscall, so y"...
    call    puts
    mov     edi, offset aAndBewaredSome; "and bewared!, something is watching you"...
    call    puts
    lea     rax, [rbp+s]
    mov     edx, 100h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    mov     edi, offset aWhatIsYourName; "what is your name? "
    call    puts
    lea     rax, [rbp+s]
    mov     edx, 0FFh; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    lea     rax, [rbp+s]
    mov     rsi, rax
    mov     edi, offset format; "hi ! %s\n"
    mov     eax, 0
    call    printf
loc_401098:
    mov     eax, 0
    call    menu
    lea     rax, [rbp+var_118]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_118]
    cmp     eax, 2
    jz      short loc_4010EA
    cmp     eax, 2
    jg      short loc_4010D2
    cmp     eax, 1
    jz      short loc_4010DE
    jmp     short loc_40110C
loc_4010D2:
    cmp     eax, 3
    jz      short loc_4010F6
    cmp     eax, 4
    jz      short loc_401102
    jmp     short loc_40110C
loc_4010DE:
    mov     eax, 0
    call    new
    jmp     short loc_401117
loc_4010EA:
    mov     eax, 0
    call    delete
    jmp     short loc_401117
loc_4010F6:
    mov     eax, 0
    call    mwrite
    jmp     short loc_401117
loc_401102:
    mov     edi, 0; status
    call    exit
loc_40110C:
    mov     edi, offset aInvalidChoice; "Invalid choice!"
    call    puts
    nop
loc_401117:
    jmp     loc_401098
loc_40111C:
    call    __stack_chk_fail
locret_401121:
    leave
    retn
main endp

