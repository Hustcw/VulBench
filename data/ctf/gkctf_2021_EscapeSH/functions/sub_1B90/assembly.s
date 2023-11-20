sub_1B90 proc
    push    r12
    push    rbp
    push    rbx
    sub     rsp, 320h
    lea     rbx, qword_204040
    mov     rax, fs:28h
    mov     [rsp+338h+var_20], rax
    xor     eax, eax
    mov     [rsp+338h+var_329], 2Fh ; '/'
    mov     rdi, [rbx+8]; path
    test    rdi, rdi
    jz      loc_1C78
    call    chdir
    cmp     eax, 0FFFFFFFFh
    mov     ebp, eax
    jz      short loc_1C00
loc_1BD3:
    mov     rax, [rsp+338h+var_20]
    xor     rax, fs:28h
    jnz     loc_1D05
    add     rsp, 320h
    pop     rbx
    pop     rbp
    pop     r12
    retn
loc_1C00:
    lea     r12, [rsp+338h+buf]
    mov     esi, 300h; size
    mov     rdi, r12; buf
    call    getcwd
    test    rax, rax
    jz      loc_1CF2
    mov     rbx, [rbx+8]
    cmp     byte ptr [rbx], 2Eh ; '.'
    jz      short loc_1C90
loc_1C24:
    lea     rsi, [rsp+338h+var_329]
    mov     ecx, 300h
    mov     edx, 1
    mov     rdi, r12
    call    __strncat_chk
    mov     ecx, 300h
    mov     edx, 3E8h
    mov     rsi, rbx
    mov     rdi, r12
    call    __strncat_chk
loc_1C50:
    mov     rdi, r12; path
    call    chdir
    cmp     eax, 0FFFFFFFFh
    jnz     loc_1BD3
    lea     rdi, aCdNoDir; "cd no dir"
    call    puts
    jmp     loc_1BD3
loc_1C78:
    lea     rdi, path; path
    call    chdir
    jmp     loc_1BD3
loc_1C90:
    movzx   eax, byte ptr [rbx+1]
    cmp     al, 2Eh ; '.'
    jnz     short loc_1CD7
    cmp     byte ptr [rbx+2], 0
    jnz     short loc_1C24
    cmp     [rsp+338h+buf], 0
    jz      short loc_1CEE
    lea     rdx, [r12+1]
    xor     eax, eax
    nop     dword ptr [rax+00h]
loc_1CB0:
    add     rdx, 1
    add     eax, 1
    cmp     byte ptr [rdx-1], 0
    jnz     short loc_1CB0
loc_1CBD:
    movsxd  rdx, eax
loc_1CC0:
    sub     eax, 1
    mov     [rsp+rdx+338h+buf], 0
    movsxd  rdx, eax
    cmp     [rsp+rdx+338h+buf], 2Fh ; '/'
    jnz     short loc_1CC0
    jmp     loc_1C50
loc_1CD7:
    test    al, al
    jnz     loc_1C24
    mov     edi, 0Ah; c
    call    putchar
    jmp     loc_1C50
loc_1CEE:
    xor     eax, eax
    jmp     short loc_1CBD
loc_1CF2:
    lea     rdi, aCdError; "cd error"
    call    puts
    mov     edi, ebp; status
    call    exit
loc_1D05:
    call    __stack_chk_fail
sub_1B90 endp

