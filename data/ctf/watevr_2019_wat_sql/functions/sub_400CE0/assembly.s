sub_400CE0 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 90h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     cs:dword_6020FC, 0
    mov     [rbp+var_84], 0
    mov     rax, cs:stdin
    mov     rdi, rax; stream
    call    _fflush
    mov     esi, 0; type
    lea     rdi, old; "/home/ctf/replace.tmp"
    call    _access
    cmp     eax, 0FFFFFFFFh
    jz      short loc_400D3F
    lea     rdi, old; "/home/ctf/replace.tmp"
    call    _remove
loc_400D3F:
    lea     rsi, modes; "r"
    lea     rdi, name; filename
    call    _fopen
    mov     [rbp+var_80], rax
    lea     rsi, aW; "w"
    lea     rdi, aReplaceTmp; "replace.tmp"
    call    _fopen
    mov     [rbp+stream], rax
    cmp     [rbp+var_80], 0
    jz      short loc_400D7B
    cmp     [rbp+stream], 0
    jnz     short loc_400DC9
loc_400D7B:
    lea     rdi, s; "Unable to open file."
    call    _puts
    jmp     loc_400E1A
loc_400D8C:
    mov     eax, cs:dword_6022A0
    cmp     [rbp+var_84], eax
    jnz     short loc_400DAF
    mov     rax, [rbp+stream]
    mov     rsi, rax; stream
    lea     rdi, byte_602120; s
    call    _fputs
    jmp     short loc_400DC2
loc_400DAF:
    mov     rdx, [rbp+stream]
    lea     rax, [rbp+s]
    mov     rsi, rdx; stream
    mov     rdi, rax; s
    call    _fputs
loc_400DC2:
    add     [rbp+var_84], 1
loc_400DC9:
    mov     rdx, [rbp+var_80]; stream
    lea     rax, [rbp+s]
    mov     esi, 64h ; 'd'; n
    mov     rdi, rax; s
    call    _fgets
    test    rax, rax
    jnz     short loc_400D8C
    mov     rax, [rbp+var_80]
    mov     rdi, rax; stream
    call    _fclose
    mov     rax, [rbp+stream]
    mov     rdi, rax; stream
    call    _fclose
    lea     rdi, name; filename
    call    _remove
    lea     rsi, name; new
    lea     rdi, old; "/home/ctf/replace.tmp"
    call    _rename
loc_400E1A:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_400E2E
    call    ___stack_chk_fail
locret_400E2E:
    leave
    retn
sub_400CE0 endp

