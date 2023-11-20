sub_9B0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:qword_202090
    cmp     rax, 13h
    jbe     short loc_9E5
    lea     rdi, s; "Your shopping cart is full now!"
    call    _puts
    jmp     loc_ABA
loc_9E5:
    lea     rdi, aHowLongIsYourG; "How long is your goods name?"
    call    _puts
    mov     rdx, cs:stdin; stream
    lea     rax, [rbp+s]
    mov     esi, 18h; n
    mov     rdi, rax; s
    call    _fgets
    lea     rax, [rbp+s]
    mov     edx, 0; base
    mov     esi, 0; endptr
    mov     rdi, rax; nptr
    call    _strtoul
    mov     [rbp+size], rax
    mov     edi, 10h; size
    call    _malloc
    mov     [rbp+var_28], rax
    mov     rax, [rbp+var_28]
    mov     qword ptr [rax+8], 3E7h
    mov     rax, [rbp+size]
    mov     rdi, rax; size
    call    _malloc
    mov     rdx, rax
    mov     rax, [rbp+var_28]
    mov     [rax], rdx
    lea     rdi, aWhatIsYourGood; "What is your goods name?"
    call    _puts
    mov     rax, [rbp+var_28]
    mov     rax, [rax]
    mov     rdx, [rbp+size]; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     [rbp+var_34], eax
    mov     rax, [rbp+var_28]
    mov     rax, [rax]
    mov     edx, [rbp+var_34]
    movsxd  rdx, edx
    sub     rdx, 1
    add     rax, rdx
    mov     byte ptr [rax], 0
    mov     rax, cs:qword_202090
    lea     rdx, [rax+1]
    mov     cs:qword_202090, rdx
    lea     rcx, ds:0[rax*8]
    lea     rax, qword_2021E0
    mov     rdx, [rbp+var_28]
    mov     [rcx+rax], rdx
loc_ABA:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_ACE
    call    ___stack_chk_fail
locret_ACE:
    leave
    retn
sub_9B0 endp

