read_n proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+nbytes+4], rdi
    mov     dword ptr [rbp+nbytes], esi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edx, dword ptr [rbp+nbytes]; nbytes
    mov     rax, [rbp+nbytes+4]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     [rbp+var_C], eax
    cmp     [rbp+var_C], 0
    jns     short loc_FE9
    lea     rdi, aReadError; "read() error"
    call    puts
    mov     edi, 0; status
    call    exit
loc_FE9:
    cmp     [rbp+var_C], 0
    jz      short loc_1019
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, [rax-1]
    mov     rax, [rbp+nbytes+4]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    cmp     al, 0Ah
    jnz     short loc_1019
    mov     eax, [rbp+var_C]
    cdqe
    lea     rdx, [rax-1]
    mov     rax, [rbp+nbytes+4]
    add     rax, rdx
    mov     byte ptr [rax], 0
loc_1019:
    mov     eax, [rbp+var_C]
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_1030
    call    __stack_chk_fail
locret_1030:
    leave
    retn
read_n endp

