main proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 78h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     eax, 0
    call    getegid
    mov     [rbp+rgid], eax
    mov     edx, [rbp+rgid]; sgid
    mov     ecx, [rbp+rgid]
    mov     eax, [rbp+rgid]
    mov     esi, ecx; egid
    mov     edi, eax; rgid
    mov     eax, 0
    call    setresgid
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    setbuf
    mov     [rbp+var_28], 0
    mov     edi, 20h ; ' '; size
    call    malloc
    mov     [rbp+var_30], rax
    lea     rdi, aCommandsANameA; "Commands:\n A <name> - Add a team membe"...
    call    puts
loc_B24:
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     rdx, rax
    mov     esi, 0FFh
    lea     rdi, input
    mov     eax, 0
    call    gets
    movzx   eax, cs:input
    cmp     al, 41h ; 'A'
    jnz     loc_BDE
    mov     eax, [rbp+var_28]
    cmp     eax, 8
    jle     short loc_B69
    lea     rdi, aYourTeamIsTooL; "Your team is too large!"
    call    puts
    jmp     short loc_B24
loc_B69:
    mov     rdx, [rbp+var_30]
    mov     eax, [rbp+var_28]
    cdqe
    lea     rbx, [rdx+rax]
    call    rand
    mov     ecx, eax
    mov     edx, 66666667h
    mov     eax, ecx
    imul    edx
    sar     edx, 2
    mov     eax, ecx
    sar     eax, 1Fh
    sub     edx, eax
    mov     eax, edx
    shl     eax, 2
    add     eax, edx
    add     eax, eax
    sub     ecx, eax
    mov     edx, ecx
    mov     eax, edx
    mov     [rbx], al
    mov     edi, 100h; size
    call    malloc
    mov     [rbp+dest], rax
    mov     rax, [rbp+dest]
    lea     rsi, src; src
    mov     rdi, rax; dest
    call    strcpy
    mov     eax, [rbp+var_28]
    cdqe
    mov     rdx, [rbp+dest]
    mov     [rbp+rax*8+var_70], rdx
    mov     eax, [rbp+var_28]
    add     eax, 1
    mov     [rbp+var_28], eax
    jmp     loc_B24
loc_BDE:
    movzx   eax, cs:input
    cmp     al, 46h ; 'F'
    jnz     short loc_BFF
    mov     edx, [rbp+var_28]
    mov     rax, [rbp+var_30]
    mov     esi, edx
    mov     rdi, rax
    call    fight
    jmp     loc_B24
loc_BFF:
    movzx   eax, cs:input
    cmp     al, 51h ; 'Q'
    jnz     short loc_C2C
    lea     rdi, aThanksForPlayi; "Thanks for playing!"
    call    puts
    mov     eax, 0
    mov     rbx, [rbp+var_18]
    xor     rbx, fs:28h
    jz      short loc_C42
    jmp     short loc_C3D
loc_C2C:
    lea     rdi, aTryAgain; "Try again"
    call    puts
    jmp     loc_B24
loc_C3D:
    call    __stack_chk_fail
loc_C42:
    add     rsp, 78h
    pop     rbx
    pop     rbp
    retn
main endp

