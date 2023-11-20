main proc
    push    rbp
    mov     rbp, rsp
    add     rsp, 0FFFFFFFFFFFFFF80h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_7C], 0
    mov     edi, 0; timer
    call    _time
    mov     edi, eax; seed
    call    _srand
    mov     [rbp+var_7C], 0
loc_401BAF:
    cmp     [rbp+var_7C], 0F9h
    jg      loc_401CAD
    movzx   eax, cs:byte_6033F0
    test    al, al
    jz      short loc_401BF1
    mov     edi, offset aWhatSYourName; "What's your name?"
    call    _puts
    lea     rax, [rbp+var_70]
    mov     rsi, rax
    mov     edi, offset aS; "%s"
    mov     eax, 0
    call    _scanf
    mov     eax, 0
    jmp     loc_401CBC
loc_401BF1:
    mov     edi, offset byte_6033A0
    call    sub_4014C8
    mov     edi, offset aChoice; "choice:"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_80]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    _scanf
    mov     eax, [rbp+var_80]
    cmp     eax, 5; switch 6 cases
    ja      short def_401C32; jumptable 0000000000401C32 default case, case 0
    mov     eax, eax
    mov     rax, ds:jpt_401C32[rax*8]
def_401C32:
    jmp     rax; switch jump
    mov     edi, offset byte_6033A0; jumptable 0000000000401C32 case 1
    call    sub_4014AE
    jmp     short loc_401C88
    lea     rax, [rbp+newthread]; jumptable 0000000000401C32 case 2
    mov     ecx, 0; arg
    mov     edx, offset start_routine; start_routine
    mov     esi, 0; attr
    mov     rdi, rax; newthread
    call    _pthread_create
    jmp     short loc_401C88
    mov     edi, offset byte_6033A0; jumptable 0000000000401C32 case 3
    call    sub_401728
    jmp     short loc_401C88
    mov     edi, offset byte_6033A0; jumptable 0000000000401C32 case 4
    call    sub_401704
    jmp     short loc_401C88
    mov     edi, offset byte_6033A0; jumptable 0000000000401C32 case 5
    call    sub_401942
    jmp     short loc_401C88
    mov     eax, 0; jumptable 0000000000401C32 default case, case 0
    jmp     short loc_401CBC
loc_401C88:
    mov     eax, [rbp+var_80]
    cmp     eax, 2
    jnz     short loc_401CA4
    mov     edi, offset byte_6033A0
    call    sub_4019A4
    mov     edi, 0; seconds
    call    _sleep
loc_401CA4:
    add     [rbp+var_7C], 1
    jmp     loc_401BAF
loc_401CAD:
    mov     edi, offset aGameOver_0; "Game Over"
    call    _puts
    mov     eax, 0
loc_401CBC:
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_401CD0
    call    ___stack_chk_fail
locret_401CD0:
    leave
    retn
main endp

