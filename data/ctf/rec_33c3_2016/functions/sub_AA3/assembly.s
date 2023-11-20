sub_AA3 proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 34h
    call    sub_590
    add     ebx, (offset off_2FB8 - $)
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    lea     eax, (sub_A91 - 2FB8h)[ebx]
    mov     [ebp+var_24], eax
    mov     [ebp+var_28], 0
    sub     esp, 0Ch
    lea     eax, (aOperator - 2FB8h)[ebx]; "Operator: "
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    2
    lea     eax, [ebp+var_1A]
    push    eax
    call    sub_6C0
    add     esp, 10h
    movzx   eax, [ebp+var_1A]
    cmp     al, 53h ; 'S'
    jnz     loc_BA1
    sub     esp, 0Ch
    lea     eax, (aOperand - 2FB8h)[ebx]; "Operand: "
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    0Ch
    lea     eax, [ebp+nptr]
    push    eax
    call    sub_6C0
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+nptr]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     [ebp+var_2C], eax
    jmp     short loc_B7F
loc_B36:
    sub     esp, 8
    push    [ebp+var_2C]
    push    [ebp+var_2C]
    mov     eax, [ebp+var_24]
    call    eax
    add     esp, 8
    add     [ebp+var_28], eax
    sub     esp, 0Ch
    lea     eax, (aOperand - 2FB8h)[ebx]; "Operand: "
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    0Ch
    lea     eax, [ebp+nptr]
    push    eax
    call    sub_6C0
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+nptr]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     [ebp+var_2C], eax
loc_B7F:
    movzx   eax, [ebp+nptr]
    cmp     al, 2Eh ; '.'
    jnz     short loc_B36
    sub     esp, 8
    push    [ebp+var_28]
    lea     eax, (aSumD - 2FB8h)[ebx]; "Sum: %d\n"
    push    eax; format
    call    _printf
    add     esp, 10h
    jmp     loc_C6F
loc_BA1:
    sub     esp, 0Ch
    lea     eax, (aOperand - 2FB8h)[ebx]; "Operand: "
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    0Ch
    lea     eax, [ebp+nptr]
    push    eax
    call    sub_6C0
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+nptr]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     [ebp+var_2C], eax
    sub     esp, 0Ch
    lea     eax, (aOperand - 2FB8h)[ebx]; "Operand: "
    push    eax; format
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    0Ch
    lea     eax, [ebp+nptr]
    push    eax
    call    sub_6C0
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+nptr]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     [ebp+var_20], eax
    movzx   eax, [ebp+var_1A]
    cmp     al, 2Bh ; '+'
    jnz     short loc_C24
    sub     esp, 8
    push    [ebp+var_20]
    push    [ebp+var_2C]
    call    sub_9C4
    add     esp, 10h
loc_C24:
    movzx   eax, [ebp+var_1A]
    cmp     al, 2Dh ; '-'
    jnz     short loc_C3D
    sub     esp, 8
    push    [ebp+var_20]
    push    [ebp+var_2C]
    call    sub_9F8
    add     esp, 10h
loc_C3D:
    movzx   eax, [ebp+var_1A]
    cmp     al, 2Ah ; '*'
    jnz     short loc_C56
    sub     esp, 8
    push    [ebp+var_20]
    push    [ebp+var_2C]
    call    sub_A2A
    add     esp, 10h
loc_C56:
    movzx   eax, [ebp+var_1A]
    cmp     al, 2Fh ; '/'
    jnz     short loc_C6F
    sub     esp, 8
    push    [ebp+var_20]
    push    [ebp+var_2C]
    call    sub_A5D
    add     esp, 10h
loc_C6F:
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_C80
    call    sub_1030
loc_C80:
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_AA3 endp

