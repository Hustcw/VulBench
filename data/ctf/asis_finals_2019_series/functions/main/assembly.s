main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 210h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rsi, modes; "r"
    lea     rdi, filename; "description.txt"
    call    _fopen
    mov     [rbp+stream], rax
    cmp     [rbp+stream], 0
    jnz     short loc_E12
    lea     rdi, aFileNotFound; "File not found"
    call    sub_A97
loc_E12:
    mov     rdx, [rbp+stream]
    lea     rax, [rbp+ptr]
    mov     rcx, rdx; stream
    mov     edx, 1F8h; n
    mov     esi, 1; size
    mov     rdi, rax; ptr
    call    _fread
    lea     rax, [rbp+ptr]
    mov     rdi, rax; s
    call    _puts
    mov     eax, 0
    call    sub_B74
    mov     eax, 0
    call    sub_BBF
    mov     eax, 0
    call    sub_C1A
    mov     eax, 0
    call    sub_C79
    mov     eax, 0
    call    sub_D5D
    lea     rdi, aBye; "Bye!"
    call    _puts
    mov     eax, 0
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_E9B
    call    ___stack_chk_fail
locret_E9B:
    leave
    retn
main endp

