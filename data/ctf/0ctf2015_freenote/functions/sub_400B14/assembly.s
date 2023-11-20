sub_400B14 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, cs:qword_6020A8
    mov     rax, [rax+8]
    test    rax, rax
    jle     loc_400BB6
    mov     [rbp+var_4], 0
    jmp     short loc_400B9F
loc_400B39:
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 10h
    mov     rax, [rax]
    cmp     rax, 1
    jnz     short loc_400B9B
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 20h ; ' '
    mov     rdx, [rax]
    mov     eax, [rbp+var_4]
    mov     esi, eax
    mov     edi, offset aDS; "%d. %s\n"
    mov     eax, 0
    call    _printf
loc_400B9B:
    add     [rbp+var_4], 1
loc_400B9F:
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, cs:qword_6020A8
    mov     rax, [rax]
    cmp     rdx, rax
    jl      short loc_400B39
    jmp     short locret_400BC0
loc_400BB6:
    mov     edi, offset aYouNeedToCreat; "You need to create some new notes first"...
    call    _puts
locret_400BC0:
    leave
    retn
sub_400B14 endp

