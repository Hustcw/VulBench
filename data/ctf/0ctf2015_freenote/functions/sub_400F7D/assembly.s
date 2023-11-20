sub_400F7D proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, cs:qword_6020A8
    mov     rax, [rax+8]
    test    rax, rax
    jle     loc_40107B
    mov     edi, offset aNoteNumber; "Note number: "
    mov     eax, 0
    call    _printf
    mov     eax, 0
    call    sub_40094E
    mov     [rbp+var_4], eax
    cmp     [rbp+var_4], 0
    js      short loc_400FD0
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, cs:qword_6020A8
    mov     rax, [rax]
    cmp     rdx, rax
    jl      short loc_400FDF
loc_400FD0:
    mov     edi, offset aInvalidNumber; "Invalid number!"
    call    _puts
    jmp     locret_401085
loc_400FDF:
    mov     rax, cs:qword_6020A8
    mov     rdx, [rax+8]
    sub     rdx, 1
    mov     [rax+8], rdx
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 10h
    mov     qword ptr [rax], 0
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 10h
    mov     qword ptr [rax+8], 0
    mov     rcx, cs:qword_6020A8
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 3
    add     rax, rcx
    add     rax, 20h ; ' '
    mov     rax, [rax]
    mov     rdi, rax; ptr
    call    _free
    mov     edi, offset aDone; "Done."
    call    _puts
    jmp     short locret_401085
loc_40107B:
    mov     edi, offset aNoNotesYet; "No notes yet."
    call    _puts
locret_401085:
    leave
    retn
sub_400F7D endp

