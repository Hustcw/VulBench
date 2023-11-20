addMoney proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     edi, offset aIndex; "Index:"
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    readNum
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 2
    jg      short loc_400DDB
    cmp     [rbp+var_4], 0
    jns     short loc_400DE5
loc_400DDB:
    mov     edi, 1; status
    call    exit
loc_400DE5:
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_400E3A
    mov     eax, [rbp+var_4]
    cdqe
    shl     rax, 4
    add     rax, 602060h
    mov     rax, [rax]
    mov     edx, [rbp+var_4]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rdx, 602060h
    mov     rdx, [rdx]
    mov     rdx, [rdx+8]
    add     rdx, 1
    mov     [rax+8], rdx
    mov     edi, offset asc_4012CE; ":)"
    call    puts
    jmp     short locret_400E44
loc_400E3A:
    mov     edi, offset asc_4012B0; ":("
    call    puts
locret_400E44:
    leave
    retn
addMoney endp

