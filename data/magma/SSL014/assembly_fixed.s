ASN1_TYPE_cmp proc
    mov     eax, 0FFFFFFFFh
    test    a, a
    jz      short locret_452427
    test    b, b
    jz      short locret_452427
    mov     ecx, [a]
    cmp     ecx, [b]
    jnz     short locret_452427
    cmp     ecx, 1
    jz      short loc_452421
    cmp     ecx, 5
    jz      short loc_452428
    cmp     ecx, 6
    jnz     short loc_45242B
    mov     a, [a+8]; a
    mov     b, [b+8]; b
    jmp     OBJ_cmp
loc_452421:
    mov     eax, [a+8]
    sub     eax, [b+8]
locret_452427:
    retn
loc_452428:
    xor     eax, eax
    retn
loc_45242B:
    mov     a, [a+8]; a
    mov     b, [b+8]; b
    jmp     ASN1_STRING_cmp
ASN1_TYPE_cmp endp

