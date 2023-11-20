sub_14A0 proc
    push    r13
    push    r12
    push    rbp
    lea     rbp, unk_4020
    push    rbx
    mov     r13, rbp
    xor     ebx, ebx
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rsp+38h+var_30], rax
    xor     eax, eax
    mov     rax, rbp
    nop     dword ptr [rax+00000000h]
loc_14D0:
    cmp     qword ptr [rax+8], 0
    jz      short loc_14F0
    add     rbx, 1
    add     rax, 10h
    cmp     rbx, 8
    jnz     short loc_14D0
loc_14E5:
    xor     edi, edi; status
    call    _exit
loc_14F0:
    lea     rdi, aInputTheSize; "Input the size:"
    call    _puts
    xor     eax, eax
    call    sub_13E0
    and     eax, 0FFFFFFF8h
    mov     r12d, eax
    lea     rax, stdout
    cmp     r12d, 80h
    jg      short loc_14E5
    nop     dword ptr [rax+00000000h]
loc_1520:
    cmp     [rbp+0], r12d
    jz      short loc_1580
    add     rbp, 10h
    cmp     rax, rbp
    jnz     short loc_1520
    movsxd  rdi, r12d; size
    call    _malloc
    mov     rbp, rax
    test    rax, rax
    jz      short loc_14E5
    lea     rdi, aInputTheNote; "Input the note:"
    shl     rbx, 4
    call    _puts
    add     rbx, r13
    mov     esi, r12d
    mov     rdi, rbp
    call    sub_1350
    mov     [rbx], r12d
    mov     [rbx+8], rbp
    mov     rax, [rsp+38h+var_30]
    xor     rax, fs:28h
    jnz     short loc_1593
    add     rsp, 18h
    pop     rbx
    pop     rbp
    pop     r12
    pop     r13
    retn
loc_1580:
    lea     rdi, aIDonTLikeTheSa; "I don't like the same size!"
    call    _puts
    xor     edi, edi; status
    call    _exit
loc_1593:
    call    ___stack_chk_fail
sub_14A0 endp

