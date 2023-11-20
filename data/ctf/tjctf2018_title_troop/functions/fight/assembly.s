fight proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     [rbp+var_1C], esi
    mov     [rbp+var_8], 0
    mov     [rbp+var_4], 0
    jmp     short loc_A69
loc_A4F:
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, [rbp+var_18]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
    add     [rbp+var_8], eax
    add     [rbp+var_4], 1
loc_A69:
    mov     eax, [rbp+var_4]
    cmp     eax, [rbp+var_1C]
    jl      short loc_A4F
    mov     eax, 190h
    cmp     [rbp+var_8], eax
    jnz     short loc_A95
    lea     rdi, s; "Wow! Your team is strong! Here, take th"...
    call    puts
    lea     rdi, aRedacted; "[REDACTED]"
    call    puts
    jmp     short loc_AB0
loc_A95:
    mov     edx, 190h
    mov     eax, [rbp+var_8]
    mov     esi, eax
    lea     rdi, format; "Your team had %d strength, but you need"...
    mov     eax, 0
    call    printf
loc_AB0:
    nop
    leave
    retn
fight endp

