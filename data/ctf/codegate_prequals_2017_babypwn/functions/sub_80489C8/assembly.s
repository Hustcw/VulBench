sub_80489C8 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, [ebp+arg_0]
    mov     [ebp+s], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    cmp     [ebp+s], 0
    jz      short loc_80489EF
    mov     eax, [ebp+s]
    movzx   eax, byte ptr [eax]
    test    al, al
    jnz     short loc_80489F4
loc_80489EF:
    mov     eax, [ebp+s]
    jmp     short loc_8048A5E
loc_80489F4:
    mov     eax, [ebp+s]
    mov     [ebp+var_14], eax
    mov     eax, [ebp+s]
    mov     [esp], eax; s
    call    _strlen
    lea     edx, [eax-1]
    mov     eax, [ebp+s]
    add     eax, edx
    mov     [ebp+var_10], eax
    jmp     short loc_8048A53
loc_8048A12:
    mov     eax, [ebp+var_14]
    movzx   edx, byte ptr [eax]
    mov     eax, [ebp+var_10]
    movzx   eax, byte ptr [eax]
    xor     edx, eax
    mov     eax, [ebp+var_14]
    mov     [eax], dl
    mov     eax, [ebp+var_10]
    movzx   edx, byte ptr [eax]
    mov     eax, [ebp+var_14]
    movzx   eax, byte ptr [eax]
    xor     edx, eax
    mov     eax, [ebp+var_10]
    mov     [eax], dl
    mov     eax, [ebp+var_14]
    movzx   edx, byte ptr [eax]
    mov     eax, [ebp+var_10]
    movzx   eax, byte ptr [eax]
    xor     edx, eax
    mov     eax, [ebp+var_14]
    mov     [eax], dl
    add     [ebp+var_14], 1
    sub     [ebp+var_10], 1
loc_8048A53:
    mov     eax, [ebp+var_10]
    cmp     eax, [ebp+var_14]
    ja      short loc_8048A12
    mov     eax, [ebp+s]
loc_8048A5E:
    mov     ecx, [ebp+var_C]
    xor     ecx, large gs:14h
    jz      short locret_8048A6F
    call    ___stack_chk_fail
locret_8048A6F:
    leave
    retn
sub_80489C8 endp

