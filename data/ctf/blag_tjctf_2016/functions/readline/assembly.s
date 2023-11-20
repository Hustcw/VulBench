readline proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, [ebp+arg_0]
    mov     [ebp+s], eax
    mov     eax, [ebp+arg_4]
    mov     [ebp+n], eax
    mov     eax, [ebp+arg_8]
    mov     [ebp+stream], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 4
    push    [ebp+stream]; stream
    push    [ebp+n]; n
    push    [ebp+s]; s
    call    _fgets
    add     esp, 10h
    sub     esp, 8
    push    offset reject; "\n"
    push    [ebp+s]; s
    call    _strcspn
    add     esp, 10h
    mov     edx, eax
    mov     eax, [ebp+s]
    add     eax, edx
    mov     byte ptr [eax], 0
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_80487C0
    call    ___stack_chk_fail
locret_80487C0:
    leave
    retn
readline endp

