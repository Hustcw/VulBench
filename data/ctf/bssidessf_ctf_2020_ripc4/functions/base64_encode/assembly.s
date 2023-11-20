base64_encode proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 50h
    mov     [rbp+src], rdi
    mov     [rbp+len], rsi
    mov     [rbp+out_len], rdx
    mov     rax, [rbp+len]
    shl     rax, 2
    mov     rdx, 0AAAAAAAAAAAAAAABh
    mul     rdx
    mov     rax, rdx
    shr     rax, 1
    add     rax, 4
    mov     [rbp+olen], rax
    mov     rax, [rbp+olen]
    mov     rdx, 0E38E38E38E38E38Fh
    mul     rdx
    mov     rax, rdx
    shr     rax, 6
    add     [rbp+olen], rax
    add     [rbp+olen], 1
    mov     rax, [rbp+olen]
    cmp     rax, [rbp+len]
    jnb     short loc_1E79
    mov     eax, 0
    jmp     locret_2123
loc_1E79:
    mov     rax, [rbp+olen]
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+out], rax
    cmp     [rbp+out], 0
    jnz     short loc_1E9A
    mov     eax, 0
    jmp     locret_2123
loc_1E9A:
    mov     rdx, [rbp+src]
    mov     rax, [rbp+len]
    add     rax, rdx
    mov     [rbp+end], rax
    mov     rax, [rbp+src]
    mov     [rbp+in], rax
    mov     rax, [rbp+out]
    mov     [rbp+pos], rax
    mov     [rbp+line_len], 0
    jmp     loc_1FCC
loc_1EC5:
    mov     rax, [rbp+in]
    movzx   eax, byte ptr [rax]
    shr     al, 2
    movzx   ecx, al
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    movsxd  rdx, ecx
    lea     rcx, base64_table
    movzx   edx, byte ptr [rdx+rcx]
    mov     [rax], dl
    mov     rax, [rbp+in]
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    shl     eax, 4
    and     eax, 30h
    mov     edx, eax
    mov     rax, [rbp+in]
    add     rax, 1
    movzx   eax, byte ptr [rax]
    shr     al, 4
    movzx   eax, al
    mov     ecx, edx
    or      ecx, eax
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    movsxd  rdx, ecx
    lea     rcx, base64_table
    movzx   edx, byte ptr [rdx+rcx]
    mov     [rax], dl
    mov     rax, [rbp+in]
    add     rax, 1
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    shl     eax, 2
    and     eax, 3Ch
    mov     edx, eax
    mov     rax, [rbp+in]
    add     rax, 2
    movzx   eax, byte ptr [rax]
    shr     al, 6
    movzx   eax, al
    mov     ecx, edx
    or      ecx, eax
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    movsxd  rdx, ecx
    lea     rcx, base64_table
    movzx   edx, byte ptr [rdx+rcx]
    mov     [rax], dl
    mov     rax, [rbp+in]
    add     rax, 2
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    and     eax, 3Fh
    mov     ecx, eax
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    movsxd  rdx, ecx
    lea     rcx, base64_table
    movzx   edx, byte ptr [rdx+rcx]
    mov     [rax], dl
    add     [rbp+in], 3
    add     [rbp+line_len], 4
    cmp     [rbp+line_len], 47h ; 'G'
    jle     short loc_1FCC
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    mov     byte ptr [rax], 0Ah
    mov     [rbp+line_len], 0
loc_1FCC:
    mov     rax, [rbp+end]
    sub     rax, [rbp+in]
    cmp     rax, 2
    jg      loc_1EC5
    mov     rax, [rbp+end]
    cmp     rax, [rbp+in]
    jz      loc_20EA
    mov     rax, [rbp+in]
    movzx   eax, byte ptr [rax]
    shr     al, 2
    movzx   ecx, al
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    movsxd  rdx, ecx
    lea     rcx, base64_table
    movzx   edx, byte ptr [rdx+rcx]
    mov     [rax], dl
    mov     rax, [rbp+end]
    sub     rax, [rbp+in]
    cmp     rax, 1
    jnz     short loc_2062
    mov     rax, [rbp+in]
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    shl     eax, 4
    and     eax, 30h
    mov     ecx, eax
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    movsxd  rdx, ecx
    lea     rcx, base64_table
    movzx   edx, byte ptr [rdx+rcx]
    mov     [rax], dl
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    mov     byte ptr [rax], 3Dh ; '='
    jmp     short loc_20D7
loc_2062:
    mov     rax, [rbp+in]
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    shl     eax, 4
    and     eax, 30h
    mov     edx, eax
    mov     rax, [rbp+in]
    add     rax, 1
    movzx   eax, byte ptr [rax]
    shr     al, 4
    movzx   eax, al
    mov     ecx, edx
    or      ecx, eax
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    movsxd  rdx, ecx
    lea     rcx, base64_table
    movzx   edx, byte ptr [rdx+rcx]
    mov     [rax], dl
    mov     rax, [rbp+in]
    add     rax, 1
    movzx   eax, byte ptr [rax]
    movzx   eax, al
    shl     eax, 2
    and     eax, 3Ch
    mov     ecx, eax
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    movsxd  rdx, ecx
    lea     rcx, base64_table
    movzx   edx, byte ptr [rdx+rcx]
    mov     [rax], dl
loc_20D7:
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    mov     byte ptr [rax], 3Dh ; '='
    add     [rbp+line_len], 4
loc_20EA:
    cmp     [rbp+line_len], 0
    jz      short loc_20FF
    mov     rax, [rbp+pos]
    lea     rdx, [rax+1]
    mov     [rbp+pos], rdx
    mov     byte ptr [rax], 0Ah
loc_20FF:
    mov     rax, [rbp+pos]
    mov     byte ptr [rax], 0
    cmp     [rbp+out_len], 0
    jz      short loc_211F
    mov     rax, [rbp+pos]
    sub     rax, [rbp+out]
    mov     rdx, rax
    mov     rax, [rbp+out_len]
    mov     [rax], rdx
loc_211F:
    mov     rax, [rbp+out]
locret_2123:
    leave
    retn
base64_encode endp

