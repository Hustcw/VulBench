sub_D81 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, cs:qword_202098
    cmp     rax, 13h
    jbe     short loc_DA7
    lea     rdi, aYouAlreadyHave; "You already have enough money!"
    call    _puts
    jmp     locret_E46
loc_DA7:
    lea     rdi, aIWillGiveYou99; "I will give you $9999, but what's the  "...
    call    _puts
    mov     edi, 10h; size
    call    _malloc
    mov     [rbp+var_8], rax
    mov     rax, [rbp+var_8]
    mov     qword ptr [rax+8], 270Fh
    mov     rax, cs:stdin
    mov     rdx, cs:qword_202098
    lea     rcx, ds:0[rdx*8]
    lea     rdx, byte_2020A0
    add     rcx, rdx
    mov     rdx, rax; stream
    mov     esi, 8; n
    mov     rdi, rcx; s
    call    _fgets
    mov     rax, cs:qword_202098
    lea     rdx, ds:0[rax*8]
    lea     rax, byte_2020A0
    add     rdx, rax
    mov     rax, [rbp+var_8]
    mov     [rax], rdx
    mov     rax, cs:qword_202098
    lea     rdx, [rax+1]
    mov     cs:qword_202098, rdx
    lea     rcx, ds:0[rax*8]
    lea     rax, unk_202140
    mov     rdx, [rbp+var_8]
    mov     [rcx+rax], rdx
locret_E46:
    leave
    retn
sub_D81 endp

