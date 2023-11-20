sub_400BC2 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, cs:qword_6020A8
    mov     rdx, [rax+8]
    mov     rax, cs:qword_6020A8
    mov     rax, [rax]
    cmp     rdx, rax
    jl      short loc_400BF3
    mov     edi, offset aUnableToCreate; "Unable to create new note."
    call    _puts
    jmp     locret_400D85
loc_400BF3:
    mov     [rbp+var_14], 0
    jmp     loc_400D6C
loc_400BFF:
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 10h
    mov     rax, [rax]
    test    rax, rax
    jnz     loc_400D68
    mov     edi, offset aLengthOfNewNot; "Length of new note: "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_40094E
    mov     [rbp+var_10], eax
    cmp     [rbp+var_10], 0
    jg      short loc_400C5D
    mov     edi, offset aInvalidLength; "Invalid length!"
    call    _puts
    jmp     locret_400D85
loc_400C5D:
    cmp     [rbp+var_10], 1000h
    jle     short loc_400C6D
    mov     [rbp+var_10], 1000h
loc_400C6D:
    mov     eax, [rbp+var_10]
    cdq
    shr     edx, 19h
    add     eax, edx
    and     eax, 7Fh
    sub     eax, edx
    mov     edx, 80h
    sub     edx, eax
    mov     eax, edx
    sar     eax, 1Fh
    shr     eax, 19h
    add     edx, eax
    and     edx, 7Fh
    sub     edx, eax
    mov     eax, edx
    mov     edx, eax
    mov     eax, [rbp+var_10]
    add     eax, edx
    mov     [rbp+var_C], eax
    mov     eax, [rbp+var_C]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+var_8], rax
    mov     edi, offset aEnterYourNote; "Enter your note: "
    mov     eax, 0
    call    _printf
    mov     edx, [rbp+var_10]
    mov     rax, [rbp+var_8]
    mov     esi, edx
    mov     rdi, rax
    call    sub_40085D
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 10h
    mov     qword ptr [rax], 1
    mov     rsi, cs:qword_6020A8
    mov     eax, [rbp+var_10]
    movsxd  rcx, eax
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rsi
    add     rax, 10h
    mov     [rax+8], rcx
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    lea     rdx, [rax+20h]
    mov     rax, [rbp+var_8]
    mov     [rdx], rax
    mov     rax, cs:qword_6020A8
    mov     rdx, [rax+8]
    add     rdx, 1
    mov     [rax+8], rdx
    mov     edi, offset aDone; "Done."
    call    _puts
    jmp     short locret_400D85
loc_400D68:
    add     [rbp+var_14], 1
loc_400D6C:
    mov     eax, [rbp+var_14]
    movsxd  rdx, eax
    mov     rax, cs:qword_6020A8
    mov     rax, [rax]
    cmp     rdx, rax
    jl      loc_400BFF
locret_400D85:
    leave
    retn
sub_400BC2 endp

