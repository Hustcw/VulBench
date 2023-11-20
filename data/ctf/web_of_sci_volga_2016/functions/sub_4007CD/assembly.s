sub_4007CD proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 138h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     [rbp+var_134], 0Ah
    mov     [rbp+var_13C], 0
    mov     [rbp+var_130], 0
    mov     [rbp+var_12C], 0
    mov     [rbp+var_128], 0
    mov     [rbp+var_124], 0
    mov     [rbp+var_138], 0
    mov     edi, offset s; "Tell me your name first"
    call    _puts
    lea     rax, [rbp+format]
    mov     rdi, rax
    call    _gets
    lea     rax, [rbp+format]
    mov     rcx, 0FFFFFFFFFFFFFFFFh
    mov     rdx, rax
    mov     eax, 0
    mov     rdi, rdx
    repne scasb
    mov     rax, rcx
    not     rax
    lea     rdx, [rax-1]
    lea     rax, [rbp+format]
    add     rax, rdx
    mov     rbx, 722072756F79202Ch
    mov     [rax], rbx
    mov     rsi, 3A65736E6F707365h
    mov     [rax+8], rsi
    mov     word ptr [rax+10h], 20h ; ' '
    mov     edi, offset aAlrightPassALi; "Alright, pass a little test first, woul"...
    call    _puts
    mov     [rbp+var_13C], 0
    jmp     loc_400961
loc_4008B0:
    call    _rand
    cdq
    shr     edx, 10h
    add     eax, edx
    movzx   eax, ax
    sub     eax, edx
    mov     [rbp+var_130], eax
    call    _rand
    cdq
    shr     edx, 10h
    add     eax, edx
    movzx   eax, ax
    sub     eax, edx
    mov     [rbp+var_12C], eax
    mov     eax, [rbp+var_12C]
    mov     edx, [rbp+var_130]
    add     eax, edx
    mov     [rbp+var_128], eax
    mov     edx, [rbp+var_12C]
    mov     eax, [rbp+var_130]
    mov     esi, eax
    mov     edi, offset format; "%d + %d = ?\n"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+format]
    mov     rdi, rax; format
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+nptr]
    mov     rdi, rax
    call    _gets
    lea     rax, [rbp+nptr]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_124], eax
    mov     eax, [rbp+var_128]
    cmp     eax, [rbp+var_124]
    jnz     short loc_40095A
    add     [rbp+var_138], 1
loc_40095A:
    add     [rbp+var_13C], 1
loc_400961:
    mov     eax, [rbp+var_13C]
    cmp     eax, [rbp+var_134]
    jl      loc_4008B0
    mov     eax, [rbp+var_138]
    cmp     eax, [rbp+var_134]
    jnz     short loc_400988
    mov     eax, 0
    jmp     short loc_40098D
loc_400988:
    mov     eax, 1
loc_40098D:
    mov     rbx, [rbp+var_18]
    xor     rbx, fs:28h
    jz      short loc_4009A1
    call    ___stack_chk_fail
loc_4009A1:
    add     rsp, 138h
    pop     rbx
    pop     rbp
    retn
sub_4007CD endp

