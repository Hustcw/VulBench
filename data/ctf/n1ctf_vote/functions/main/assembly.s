main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdin
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     edi, 1Eh; seconds
    call    _alarm
loc_401225:
    mov     edi, offset a0Create; "0: Create"
    call    sub_400C00
    mov     edi, offset a1Show; "1: Show"
    call    sub_400C00
    mov     edi, offset a2Vote; "2: Vote"
    call    sub_400C00
    mov     edi, offset a3Result; "3: Result"
    call    sub_400C00
    mov     edi, offset a4Cancel; "4: Cancel"
    call    sub_400C00
    mov     edi, offset a5Exit; "5: Exit"
    call    sub_400C00
    mov     edi, offset aAction; "Action: "
    call    sub_400C52
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_401290
    mov     edi, 1; status
    call    _exit
loc_401290:
    mov     eax, [rbp+var_C]
    test    eax, eax
    jnz     short loc_4012A1
    mov     eax, 0
    call    sub_400D2C
loc_4012A1:
    mov     eax, [rbp+var_C]
    cmp     eax, 1
    jnz     short loc_4012B3
    mov     eax, 0
    call    sub_400E02
loc_4012B3:
    mov     eax, [rbp+var_C]
    cmp     eax, 2
    jnz     short loc_4012C5
    mov     eax, 0
    call    sub_400F09
loc_4012C5:
    mov     eax, [rbp+var_C]
    cmp     eax, 3
    jnz     short loc_4012D7
    mov     eax, 0
    call    sub_400FCB
loc_4012D7:
    mov     eax, [rbp+var_C]
    cmp     eax, 4
    jnz     short loc_4012E9
    mov     eax, 0
    call    sub_40109D
loc_4012E9:
    mov     eax, [rbp+var_C]
    cmp     eax, 5
    jnz     loc_401225
    mov     edi, offset aBye; "Bye"
    call    sub_400C00
    mov     edi, 0; status
    call    _exit
main endp

