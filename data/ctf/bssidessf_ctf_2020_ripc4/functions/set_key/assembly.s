set_key proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 40h
    mov     [rbp+ws], rdi
    lea     rdi, aKeyHex; "key (hex)"
    call    prompt
    mov     [rbp+key_data], rax
    cmp     [rbp+key_data], 0
    jnz     short loc_15F4
    lea     rdi, aNoKey; "No key!"
    call    _puts
    jmp     locret_17F0
loc_15F4:
    mov     rax, [rbp+key_data]
    mov     rdi, rax; s
    call    _strlen
    mov     [rbp+key_len], rax
    cmp     [rbp+key_len], 200h
    ja      short loc_1621
    cmp     [rbp+key_len], 1
    jbe     short loc_1621
    mov     rax, [rbp+key_len]
    and     eax, 1
    test    rax, rax
    jz      short loc_1632
loc_1621:
    lea     rdi, aInvalidKeyLeng; "Invalid key length!"
    call    _puts
    jmp     locret_17F0
loc_1632:
    mov     [rbp+i], 0
    jmp     short loc_169F
loc_163B:
    mov     eax, [rbp+i]
    movsxd  rdx, eax
    mov     rax, [rbp+key_data]
    lea     rcx, [rdx+rax]
    lea     rax, [rbp+byte]
    mov     rdx, rax
    lea     rsi, a02x; "%02x"
    mov     rdi, rcx
    mov     eax, 0
    call    ___isoc99_sscanf
    mov     [rbp+rv], eax
    cmp     [rbp+rv], 1
    jz      short loc_167E
    lea     rdi, aInvalidKeyData; "Invalid key data!"
    call    _puts
    jmp     locret_17F0
loc_167E:
    mov     ecx, [rbp+byte]
    mov     eax, [rbp+i]
    mov     edx, eax
    shr     edx, 1Fh
    add     eax, edx
    sar     eax, 1
    movsxd  rdx, eax
    mov     rax, [rbp+key_data]
    add     rax, rdx
    mov     edx, ecx
    mov     [rax], dl
    add     [rbp+i], 2
loc_169F:
    mov     eax, [rbp+i]
    cdqe
    cmp     [rbp+key_len], rax
    ja      short loc_163B
    shr     [rbp+key_len], 1
    mov     rax, [rbp+ws]
    mov     rax, [rax+18h]
    test    rax, rax
    jz      short loc_16D7
    mov     rax, [rbp+ws]
    mov     rax, [rax+18h]
    mov     rdi, rax; ptr
    call    secure_free
    mov     rax, [rbp+ws]
    mov     qword ptr [rax+18h], 0
loc_16D7:
    mov     edi, 100h; sz
    call    secure_malloc
    mov     rdx, [rbp+ws]
    mov     [rdx+18h], rax
    mov     [rbp+i_0], 0
    jmp     short loc_170B
loc_16F2:
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+i_0]
    cdqe
    add     rax, rdx
    mov     edx, [rbp+i_0]
    mov     [rax], dl
    add     [rbp+i_0], 1
loc_170B:
    cmp     [rbp+i_0], 0FFh
    jle     short loc_16F2
    mov     [rbp+j], 0
    mov     [rbp+i_1], 0
    jmp     loc_17BE
loc_1727:
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+i_1]
    cdqe
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   edx, al
    mov     eax, [rbp+j]
    lea     ecx, [rdx+rax]
    mov     eax, [rbp+i_1]
    cdqe
    mov     edx, 0
    div     [rbp+key_len]
    mov     rax, [rbp+key_data]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    movsx   eax, al
    add     eax, ecx
    and     eax, 0FFh
    mov     [rbp+j], eax
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+i_1]
    cdqe
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    mov     [rbp+tmp], al
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+j]
    cdqe
    lea     rcx, [rdx+rax]
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+i_1]
    cdqe
    add     rdx, rax
    movzx   eax, byte ptr [rcx]
    mov     [rdx], al
    mov     rax, [rbp+ws]
    mov     rdx, [rax+18h]
    mov     eax, [rbp+j]
    cdqe
    add     rdx, rax
    movzx   eax, [rbp+tmp]
    mov     [rdx], al
    add     [rbp+i_1], 1
loc_17BE:
    cmp     [rbp+i_1], 0FFh
    jle     loc_1727
    mov     rax, [rbp+key_len]
    lea     rdx, [rax+rax]; n
    mov     rax, [rbp+key_data]
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rdi, aKeyHasBeenSet; "Key has been set."
    call    _puts
locret_17F0:
    leave
    retn
set_key endp

