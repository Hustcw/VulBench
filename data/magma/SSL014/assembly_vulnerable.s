ASN1_TYPE_cmp proc
    mov     eax, 0FFFFFFFFh
    test    a, a
    jz      short locret_56CA4E
    test    b, b
    jz      short locret_56CA4E
    mov     ecx, [a]
    cmp     ecx, [b]
    jnz     short locret_56CA4E
    cmp     ecx, 5
    jz      short loc_56CA4C
    cmp     ecx, 6
    jnz     short loc_56CA4F
    mov     a, [a+8]
    mov     b, [b+8]
    jmp     OBJ_cmp
loc_56CA4C:
    xor     eax, eax
locret_56CA4E:
    retn
loc_56CA4F:
    mov     a, [a+8]
    mov     b, [b+8]
    jmp     ASN1_STRING_cmp
ASN1_TYPE_cmp endp

