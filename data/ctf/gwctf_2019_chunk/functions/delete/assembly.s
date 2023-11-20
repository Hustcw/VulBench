delete proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_10], 0
    lea     rdi, aWhichOneToThro; "Which one to throw?"
    call    puts
    lea     rax, [rbp+var_10]
    mov     rsi, rax
    lea     rdi, unk_1108
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_10]
    cmp     eax, 0Ah
    jg      short loc_D99
    mov     eax, [rbp+var_10]
    test    eax, eax
    jns     short loc_DAA
loc_D99:
    lea     rdi, aWrong; "Wrong!\n"
    call    puts
    mov     [rbp+var_C], eax
    jmp     short loc_E04
loc_DAA:
    mov     eax, [rbp+var_10]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, chunk
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    free
    mov     eax, [rbp+var_10]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, chunk
    mov     qword ptr [rdx+rax], 0
    mov     eax, cs:number
    sub     eax, 1
    mov     cs:number, eax
    lea     rdi, aDone; "Done!\n"
    call    puts
    mov     [rbp+var_C], eax
loc_E04:
    mov     eax, [rbp+var_C]
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_E1B
    call    __stack_chk_fail
locret_E1B:
    leave
    retn
delete endp

