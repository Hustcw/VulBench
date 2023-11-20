X509v3_addr_get_afi proc
    xor     eax, eax
    test    f, f
    jz      short locret_4FEC24
    mov     rcx, [f]
    test    rcx, rcx
    jz      short locret_4FEC24
    mov     rcx, [rcx+8]
    test    rcx, rcx
    jz      short locret_4FEC24
    movzx   edx, byte ptr [rcx]
    shl     edx, 8
    movzx   eax, byte ptr [rcx+1]
    or      eax, edx
locret_4FEC24:
    retn
X509v3_addr_get_afi endp

