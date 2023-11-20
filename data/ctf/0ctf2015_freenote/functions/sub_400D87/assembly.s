sub_400D87 proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     edi, offset aNoteNumber; "Note number: "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_40094E
    mov     [rbp+var_18], eax
    cmp     [rbp+var_18], 0
    js      short loc_400DF1
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax
    mov     rax, cs:qword_6020A8
    mov     rax, [rax]
    cmp     rdx, rax
    jge     short loc_400DF1
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 10h
    mov     rax, [rax]
    cmp     rax, 1
    jz      short loc_400E00
loc_400DF1:
    mov     edi, offset aInvalidNumber; "Invalid number!"
    call    _puts
    jmp     loc_400F76
loc_400E00:
    mov     edi, offset aLengthOfNote; "Length of note: "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_40094E
    mov     [rbp+var_1C], eax
    cmp     [rbp+var_1C], 0
    jg      short loc_400E31
    mov     edi, offset aInvalidLength; "Invalid length!"
    call    _puts
    jmp     loc_400F76
loc_400E31:
    cmp     [rbp+var_1C], 1000h
    jle     short loc_400E41
    mov     [rbp+var_1C], 1000h
loc_400E41:
    mov     eax, [rbp+var_1C]
    movsxd  rcx, eax
    mov     rsi, cs:qword_6020A8
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rsi
    add     rax, 10h
    mov     rax, [rax+8]
    cmp     rcx, rax
    jz      loc_400F2C
    mov     eax, [rbp+var_1C]
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
    mov     eax, [rbp+var_1C]
    add     eax, edx
    mov     [rbp+var_14], eax
    mov     rbx, cs:qword_6020A8
    mov     eax, [rbp+var_14]
    movsxd  rcx, eax
    mov     rsi, cs:qword_6020A8
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rsi
    add     rax, 20h ; ' '
    mov     rax, [rax]
    mov     rsi, rcx; size
    mov     rdi, rax; ptr
    call    _realloc
    mov     rcx, rax
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rbx
    add     rax, 20h ; ' '
    mov     [rax], rcx
    mov     rsi, cs:qword_6020A8
    mov     eax, [rbp+var_1C]
    movsxd  rcx, eax
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rsi
    add     rax, 10h
    mov     [rax+8], rcx
loc_400F2C:
    mov     edi, offset aEnterYourNote; "Enter your note: "
    mov     eax, 0
    call    _printf
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_18]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 20h ; ' '
    mov     rax, [rax]
    mov     edx, [rbp+var_1C]
    mov     esi, edx
    mov     rdi, rax
    call    sub_40085D
    mov     edi, offset aDone; "Done."
    call    _puts
loc_400F76:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
sub_400D87 endp

