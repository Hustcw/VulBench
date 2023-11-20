sub_400846 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_C], 0
    jmp     short loc_4008D2
loc_40086D:
    lea     rax, [rbp+buf]
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    mov     eax, 0
    call    _read
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_4008A1
    mov     edi, offset s; "error!"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_4008A1:
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rdx, rax
    movzx   eax, [rbp+buf]
    mov     [rdx], al
    movzx   eax, [rbp+buf]
    cmp     al, 0Ah
    jnz     short loc_4008CE
    mov     eax, [rbp+var_C]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
    jmp     short loc_4008ED
loc_4008CE:
    add     [rbp+var_C], 1
loc_4008D2:
    mov     eax, [rbp+var_C]
    cmp     eax, [rbp+var_1C]
    jl      short loc_40086D
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, [rax-1]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     byte ptr [rax], 0
loc_4008ED:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_400901
    call    ___stack_chk_fail
locret_400901:
    leave
    retn
sub_400846 endp

