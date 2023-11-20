doheap proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 440h
    mov     [rbp+fd], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, [rbp+s]
    mov     edx, 400h; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    mov     eax, [rbp+fd]
    lea     rsi, aHelpYourselfWi; "Help yourself with the following functi"...
    mov     edi, eax
    call    sendstr
loc_160D:
    mov     eax, [rbp+fd]
    lea     rsi, a1Alloc2Free3Re; "   1. Alloc\n   2. Free\n   3. Read int"...
    mov     edi, eax
    call    sendstr
    mov     eax, [rbp+fd]
    lea     rsi, aYourChoice; "Your choice > "
    mov     edi, eax
    call    sendstr
    lea     rsi, [rbp+nptr]
    mov     eax, [rbp+fd]
    lea     rcx, asc_1D3B; "\n"
    mov     edx, 10h
    mov     edi, eax
    call    recvlen_until
    movzx   eax, [rbp+nptr]
    movsx   eax, al
    sub     eax, 31h ; '1'; switch 5 cases
    cmp     eax, 4
    ja      def_1686; jumptable 0000000000001686 default case
    mov     eax, eax
    lea     rdx, ds:0[rax*4]
    lea     rax, jpt_1686
    mov     eax, ds:(jpt_1686 - 1E1Ch)[rdx+rax]
    movsxd  rdx, eax
    lea     rax, jpt_1686
    add     rax, rdx
def_1686:
    jmp     rax; switch jump
    mov     eax, [rbp+fd]; jumptable 0000000000001686 case 49
    lea     rsi, aChooseChunk; "Choose chunk > "
    mov     edi, eax
    call    sendstr
    lea     rsi, [rbp+nptr]
    mov     eax, [rbp+fd]
    lea     rcx, asc_1D3B; "\n"
    mov     edx, 10h
    mov     edi, eax
    call    recvlen_until
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_428], eax
    cmp     [rbp+var_428], 0
    js      loc_177F
    cmp     [rbp+var_428], 7Fh
    jg      loc_177F
    mov     eax, [rbp+fd]
    lea     rsi, aChooseSize; "Choose size > "
    mov     edi, eax
    call    sendstr
    lea     rsi, [rbp+nptr]
    mov     eax, [rbp+fd]
    lea     rcx, asc_1D3B; "\n"
    mov     edx, 10h
    mov     edi, eax
    call    recvlen_until
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_424], eax
    mov     eax, [rbp+var_424]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     rdx, rax
    mov     eax, [rbp+var_428]
    cdqe
    mov     [rbp+rax*8+s], rdx
    mov     eax, [rbp+var_428]
    cdqe
    mov     rcx, [rbp+rax*8+s]
    mov     edx, [rbp+var_428]
    mov     eax, [rbp+fd]
    lea     rsi, fmt; "Allocated chunk %d @ %016llx\n"
    mov     edi, eax; fd
    mov     eax, 0
    call    _dprintf
    jmp     loc_1948
loc_177F:
    jmp     loc_1948
    mov     eax, [rbp+fd]; jumptable 0000000000001686 case 50
    lea     rsi, aChooseChunk; "Choose chunk > "
    mov     edi, eax
    call    sendstr
    lea     rsi, [rbp+nptr]
    mov     eax, [rbp+fd]
    lea     rcx, asc_1D3B; "\n"
    mov     edx, 10h
    mov     edi, eax
    call    recvlen_until
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_428], eax
    cmp     [rbp+var_428], 0
    js      short loc_17F6
    cmp     [rbp+var_428], 7Fh
    jg      short loc_17F6
    mov     eax, [rbp+var_428]
    cdqe
    mov     rax, [rbp+rax*8+s]
    mov     rdi, rax; ptr
    call    _free
    jmp     loc_1948
loc_17F6:
    jmp     loc_1948
    mov     eax, [rbp+fd]; jumptable 0000000000001686 case 51
    lea     rsi, aChooseChunk; "Choose chunk > "
    mov     edi, eax
    call    sendstr
    lea     rsi, [rbp+nptr]
    mov     eax, [rbp+fd]
    lea     rcx, asc_1D3B; "\n"
    mov     edx, 10h
    mov     edi, eax
    call    recvlen_until
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_428], eax
    cmp     [rbp+var_428], 0
    js      short loc_18BC; jumptable 0000000000001686 case 52
    cmp     [rbp+var_428], 7Fh
    jg      short loc_18BC; jumptable 0000000000001686 case 52
    mov     eax, [rbp+fd]
    lea     rsi, aChooseSize; "Choose size > "
    mov     edi, eax
    call    sendstr
    lea     rsi, [rbp+nptr]
    mov     eax, [rbp+fd]
    lea     rcx, asc_1D3B; "\n"
    mov     edx, 10h
    mov     edi, eax
    call    recvlen_until
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_424], eax
    mov     eax, [rbp+var_424]
    movsxd  rdx, eax
    mov     eax, [rbp+var_428]
    cdqe
    mov     rcx, [rbp+rax*8+s]
    mov     eax, [rbp+fd]
    mov     rsi, rcx
    mov     edi, eax
    call    recvlen
loc_18BC:
    mov     [rbp+var_428], 0; jumptable 0000000000001686 case 52
    jmp     short loc_18F8
loc_18C8:
    mov     eax, [rbp+var_428]
    cdqe
    mov     rdx, [rbp+rax*8+s]
    mov     eax, [rbp+fd]
    lea     rsi, a16llx; "[%16llx]"
    mov     edi, eax; fd
    mov     eax, 0
    call    _dprintf
    add     [rbp+var_428], 1
loc_18F8:
    cmp     [rbp+var_428], 7Fh
    jg      short loc_1916
    mov     eax, [rbp+var_428]
    cdqe
    mov     rax, [rbp+rax*8+s]
    test    rax, rax
    jnz     short loc_18C8
loc_1916:
    mov     eax, [rbp+fd]
    lea     rsi, asc_1D3B; "\n"
    mov     edi, eax; fd
    mov     eax, 0
    call    _dprintf
    jmp     short loc_1948
    mov     eax, 0; jumptable 0000000000001686 case 53
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_1952
    jmp     short loc_194D
    nop; jumptable 0000000000001686 default case
loc_1948:
    jmp     loc_160D
loc_194D:
    call    ___stack_chk_fail
locret_1952:
    leave
    retn
doheap endp

