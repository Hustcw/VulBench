SPFA proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 1FC0h
    mov     [rbp+var_1FB4], edi
    mov     [rbp+var_1FB8], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_1F9C], 0
    lea     rax, [rbp+s]
    mov     edx, 0FBCh; n
    mov     esi, 7Fh; c
    mov     rdi, rax; s
    call    _memset
    lea     rax, [rbp+var_FD0]
    mov     edx, 0FBCh; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    mov     [rbp+var_1FA8], 0
    mov     [rbp+var_1FA4], 1
    mov     eax, [rbp+var_1FB4]
    cdqe
    mov     [rbp+rax*4+s], 0
    mov     eax, [rbp+var_1FB4]
    cdqe
    mov     [rbp+rax*4+var_FD0], 1
    mov     eax, [rbp+var_1FB4]
    mov     cs:qu, eax
    jmp     loc_C05
loc_A76:
    mov     eax, [rbp+var_1FA8]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, qu
    mov     eax, [rdx+rax]
    mov     [rbp+var_1F98], eax
    add     [rbp+var_1FA8], 1
    mov     eax, [rbp+var_1F98]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, head
    mov     eax, [rdx+rax]
    mov     [rbp+var_1FA0], eax
    jmp     loc_BE5
loc_AC2:
    mov     eax, [rbp+var_1FA0]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, to
    mov     eax, [rdx+rax]
    mov     [rbp+var_1F94], eax
    mov     eax, [rbp+var_1F94]
    cdqe
    mov     edx, [rbp+rax*4+s]
    mov     eax, [rbp+var_1F98]
    cdqe
    mov     ecx, [rbp+rax*4+s]
    mov     eax, [rbp+var_1FA0]
    cdqe
    lea     rsi, ds:0[rax*4]
    lea     rax, len
    mov     eax, [rsi+rax]
    add     eax, ecx
    cmp     edx, eax
    jl      loc_BC5
    mov     eax, [rbp+var_1F98]
    cdqe
    mov     edx, [rbp+rax*4+s]
    mov     eax, [rbp+var_1FA0]
    cdqe
    lea     rcx, ds:0[rax*4]
    lea     rax, len
    mov     eax, [rcx+rax]
    add     edx, eax
    mov     eax, [rbp+var_1F94]
    cdqe
    mov     [rbp+rax*4+s], edx
    mov     eax, [rbp+var_1F94]
    cdqe
    mov     eax, [rbp+rax*4+var_FD0]
    test    eax, eax
    jnz     short loc_BC5
    mov     eax, [rbp+var_1F94]
    cdqe
    mov     [rbp+rax*4+var_FD0], 1
    mov     eax, [rbp+var_1FA4]
    cdqe
    lea     rcx, ds:0[rax*4]
    lea     rax, qu
    mov     edx, [rbp+var_1F94]
    mov     [rcx+rax], edx
    add     [rbp+var_1FA4], 1
    cmp     [rbp+var_1FA4], 3E8h
    jle     short loc_BC5
    lea     rdi, s; "queue overflow error!"
    call    _puts
    jmp     short loc_C39
loc_BC5:
    mov     eax, [rbp+var_1FA0]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, next
    mov     eax, [rdx+rax]
    mov     [rbp+var_1FA0], eax
loc_BE5:
    cmp     [rbp+var_1FA0], 0
    jnz     loc_AC2
    mov     eax, [rbp+var_1F98]
    cdqe
    mov     [rbp+rax*4+var_FD0], 0
loc_C05:
    mov     eax, [rbp+var_1FA8]
    cmp     eax, [rbp+var_1FA4]
    jnz     loc_A76
    mov     eax, [rbp+var_1FB8]
    cdqe
    mov     eax, [rbp+rax*4+s]
    mov     esi, eax
    lea     rdi, format; "%d\n"
    mov     eax, 0
    call    _printf
loc_C39:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_C4D
    call    ___stack_chk_fail
locret_C4D:
    leave
    retn
SPFA endp

