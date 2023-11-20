sub_9C0 proc
    push    ebp
    mov     ebp, esp
    push    esi
    push    ebx
    sub     esp, 90h
    call    sub_890
    add     ebx, (offset off_2F74 - $)
    mov     eax, [ebp+arg_0]
    mov     [ebp+var_8C], eax
    mov     eax, [ebp+arg_4]
    mov     [ebp+var_90], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    cmp     [ebp+arg_8], 0
    jnz     short loc_A07
    mov     eax, [ebp+var_8C]
    mov     [ebp+s], eax
    jmp     loc_A89
loc_A07:
    mov     eax, [ebp+var_8C]
    sub     eax, 4
    mov     [ebp+s], eax
    mov     [ebp+var_80], 0
    jmp     short loc_A83
loc_A1C:
    lea     eax, (unk_300C - 2F74h)[ebx]
    mov     eax, [eax]
    mov     edx, [eax+240h]
    mov     eax, [ebp+var_80]
    lea     esi, [edx+eax]
    call    _rand
    mov     edx, eax
    mov     eax, edx
    sar     eax, 1Fh
    shr     eax, 18h
    add     edx, eax
    movzx   edx, dl
    sub     edx, eax
    mov     eax, edx
    mov     [esi], al
    lea     eax, (unk_300C - 2F74h)[ebx]
    mov     eax, [eax]
    mov     edx, [eax+240h]
    mov     eax, [ebp+var_80]
    add     eax, edx
    movzx   eax, byte ptr [eax]
    test    al, al
    jnz     short loc_A7F
    lea     eax, (unk_300C - 2F74h)[ebx]
    mov     eax, [eax]
    mov     edx, [eax+240h]
    mov     eax, [ebp+var_80]
    add     eax, edx
    movzx   edx, byte ptr [eax]
    add     edx, 1
    mov     [eax], dl
loc_A7F:
    add     [ebp+var_80], 1
loc_A83:
    cmp     [ebp+var_80], 3
    jle     short loc_A1C
loc_A89:
    sub     esp, 0Ch
    lea     eax, [ebp+var_78]
    push    eax
    call    _MD5_Init
    add     esp, 10h
    cmp     eax, 1
    jz      short loc_AB9
    sub     esp, 0Ch
    lea     eax, (aMd5Init_0 - 2F74h)[ebx]; "MD5_Init"
    push    eax; s
    call    _perror
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_AB9:
    sub     esp, 0Ch
    push    [ebp+s]; s
    call    _strlen
    add     esp, 10h
    sub     esp, 4
    push    eax
    push    [ebp+s]
    lea     eax, [ebp+var_78]
    push    eax
    call    _MD5_Update
    add     esp, 10h
    cmp     eax, 1
    jz      short loc_AFB
    sub     esp, 0Ch
    lea     eax, (aMd5Update_0 - 2F74h)[ebx]; "MD5_Update"
    push    eax; s
    call    _perror
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_AFB:
    sub     esp, 8
    lea     eax, [ebp+var_78]
    push    eax
    lea     eax, [ebp+var_1C]
    push    eax
    call    _MD5_Final
    add     esp, 10h
    cmp     eax, 1
    jz      short loc_B2F
    sub     esp, 0Ch
    lea     eax, (aMd5Final_0 - 2F74h)[ebx]; "MD5_Final"
    push    eax; s
    call    _perror
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_B2F:
    mov     [ebp+var_80], 0
    jmp     short loc_B6D
loc_B38:
    lea     edx, [ebp+var_1C]
    mov     eax, [ebp+var_80]
    add     eax, edx
    movzx   eax, byte ptr [eax]
    movzx   eax, al
    mov     edx, [ebp+var_80]
    add     edx, edx
    mov     ecx, edx
    mov     edx, [ebp+var_90]
    add     edx, ecx
    sub     esp, 4
    push    eax
    lea     eax, (a02x - 2F74h)[ebx]; "%02x"
    push    eax; format
    push    edx; s
    call    _sprintf
    add     esp, 10h
    add     [ebp+var_80], 1
loc_B6D:
    cmp     [ebp+var_80], 0Fh
    jle     short loc_B38
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_B85
    call    sub_FF0
loc_B85:
    lea     esp, [ebp-8]
    pop     ebx
    pop     esi
    pop     ebp
    retn
sub_9C0 endp

