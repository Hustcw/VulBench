X509v3_addr_get_afi proc
    xor     eax, eax
    test    f, f
    jz      short locret_63EE69
    mov     rdx, [f]
    test    rdx, rdx
    jz      short locret_63EE69
    mov     rcx, [rdx+8]
    test    rcx, rcx
    jz      short locret_63EE69
    cmp     dword ptr [rdx], 2
    jl      short locret_63EE69
    movzx   edx, byte ptr [rcx]
    shl     edx, 8
    movzx   eax, byte ptr [rcx+1]
    or      eax, edx
locret_63EE69:
    retn
X509v3_addr_get_afi endp

