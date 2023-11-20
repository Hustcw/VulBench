sub_87B proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 24h
    call    sub_590
    add     ebx, (offset off_2FB8 - $)
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
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
    mov     [ebp+var_24], eax
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
    jnz     short loc_948
    mov     edx, [ebp+var_24]
    mov     eax, [ebp+var_20]
    add     eax, edx
    sub     esp, 8
    push    eax
    lea     eax, (aResultD - 2FB8h)[ebx]; "Result: %d\n"
    push    eax; format
    call    _printf
    add     esp, 10h
loc_948:
    movzx   eax, [ebp+var_1A]
    cmp     al, 2Dh ; '-'
    jnz     short loc_969
    mov     eax, [ebp+var_24]
    sub     eax, [ebp+var_20]
    sub     esp, 8
    push    eax
    lea     eax, (aResultD - 2FB8h)[ebx]; "Result: %d\n"
    push    eax; format
    call    _printf
    add     esp, 10h
loc_969:
    movzx   eax, [ebp+var_1A]
    cmp     al, 2Ah ; '*'
    jnz     short loc_98B
    mov     eax, [ebp+var_24]
    imul    eax, [ebp+var_20]
    sub     esp, 8
    push    eax
    lea     eax, (aResultD - 2FB8h)[ebx]; "Result: %d\n"
    push    eax; format
    call    _printf
    add     esp, 10h
loc_98B:
    movzx   eax, [ebp+var_1A]
    cmp     al, 2Fh ; '/'
    jnz     short loc_9AD
    mov     eax, [ebp+var_24]
    cdq
    idiv    [ebp+var_20]
    sub     esp, 8
    push    eax
    lea     eax, (aResultD - 2FB8h)[ebx]; "Result: %d\n"
    push    eax; format
    call    _printf
    add     esp, 10h
loc_9AD:
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_9BF
    call    sub_1030
loc_9BF:
    mov     ebx, [ebp+var_4]
    leave
    retn
sub_87B endp

