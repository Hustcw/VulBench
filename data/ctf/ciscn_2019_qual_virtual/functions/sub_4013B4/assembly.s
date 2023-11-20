sub_4013B4 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_14], edi
    mov     edi, 10h; size
    call    _malloc
    mov     [rbp+ptr], rax
    cmp     [rbp+ptr], 0
    jnz     short loc_4013DB
    mov     eax, 0
    jmp     short locret_40144C
loc_4013DB:
    mov     eax, [rbp+var_14]
    cdqe
    shl     rax, 3
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+s], rax
    cmp     [rbp+s], 0
    jnz     short loc_40140A
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, 0
    jmp     short locret_40144C
loc_40140A:
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*8]; n
    mov     rax, [rbp+s]
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    mov     rax, [rbp+ptr]
    mov     rdx, [rbp+s]
    mov     [rax], rdx
    mov     rax, [rbp+ptr]
    mov     edx, [rbp+var_14]
    mov     [rax+8], edx
    mov     rax, [rbp+ptr]
    mov     dword ptr [rax+0Ch], 0FFFFFFFFh
    mov     rax, [rbp+ptr]
locret_40144C:
    leave
    retn
sub_4013B4 endp

