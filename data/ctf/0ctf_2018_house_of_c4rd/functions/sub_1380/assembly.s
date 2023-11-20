sub_1380 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0B0h
    mov     eax, 21h ; '!'
    mov     ecx, eax
    mov     rdx, fs:28h
    mov     [rbp+var_8], rdx
    mov     [rbp+var_88], rdi
    mov     [rbp+var_8C], esi
    mov     rdi, rcx; size
    call    _malloc
    lea     rdi, [rbp+var_68]
    mov     [rbp+var_98], rax
    call    _MD5_Init
    lea     rdi, [rbp+var_68]
    mov     rsi, [rbp+var_88]
    movsxd  rdx, [rbp+var_8C]
    mov     [rbp+var_9C], eax
    call    _MD5_Update
    lea     rsi, [rbp+var_68]
    lea     rdi, [rbp+var_80]
    mov     [rbp+var_A0], eax
    call    _MD5_Final
    mov     [rbp+var_90], 0
    mov     [rbp+var_A4], eax
loc_1404:
    cmp     [rbp+var_90], 10h
    jge     loc_1467
    mov     eax, 20h ; ' '
    mov     esi, eax; maxlen
    lea     rdx, format; "%02x"
    mov     rcx, [rbp+var_98]
    mov     eax, [rbp+var_90]
    shl     eax, 1
    movsxd  rdi, eax
    add     rcx, rdi
    movsxd  rdi, [rbp+var_90]
    movzx   eax, [rbp+rdi+var_80]
    mov     rdi, rcx; s
    mov     ecx, eax
    mov     al, 0
    call    _snprintf
    mov     [rbp+var_A8], eax
    mov     eax, [rbp+var_90]
    add     eax, 1
    mov     [rbp+var_90], eax
    jmp     loc_1404
loc_1467:
    mov     rax, [rbp+var_98]
    mov     rcx, fs:28h
    mov     rdx, [rbp+var_8]
    cmp     rcx, rdx
    mov     [rbp+var_B0], rax
    jnz     loc_149B
    mov     rax, [rbp+var_B0]
    add     rsp, 0B0h
    pop     rbp
    retn
loc_149B:
    call    ___stack_chk_fail
sub_1380 endp

