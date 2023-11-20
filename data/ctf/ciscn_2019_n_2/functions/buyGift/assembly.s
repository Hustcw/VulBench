buyGift proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edi, offset aIndex; "Index:"
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    readNum
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 2
    jg      short loc_400E76
    cmp     [rbp+var_C], 0
    jns     short loc_400E80
loc_400E76:
    mov     edi, 1; status
    call    exit
loc_400E80:
    mov     eax, [rbp+var_C]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    test    rax, rax
    jz      loc_400F43
    mov     eax, [rbp+var_C]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    mov     rax, [rax+8]
    cmp     rax, 100000h
    jle     loc_400F43
    mov     edi, offset aInputTheAddres; "input the address you want to leak:"
    mov     eax, 0
    call    printf
    lea     rax, [rbp+buf]
    mov     rsi, rax
    mov     edi, offset aP; "%p"
    mov     eax, 0
    call    __isoc99_scanf
    mov     edi, offset aInputTheSizeYo; "input the size you want to leak:"
    mov     eax, 0
    call    printf
    lea     rax, [rbp+var_10]
    mov     rsi, rax
    mov     edi, offset aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     edi, offset aData; "data:[[["
    mov     eax, 0
    call    printf
    mov     eax, [rbp+var_10]
    movsxd  rdx, eax; n
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 1; fd
    call    write
    mov     edi, offset asc_40132D; "]]]\n"
    call    puts
    mov     edi, offset asc_4012CE; ":)"
    call    puts
    jmp     short locret_400F4D
loc_400F43:
    mov     edi, offset asc_4012B0; ":("
    call    puts
locret_400F4D:
    leave
    retn
buyGift endp

