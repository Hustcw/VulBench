run proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 24h
    call    __x86_get_pc_thunk_bx
    add     ebx, (offset _GLOBAL_OFFSET_TABLE_ - $)
    mov     eax, [ebp+arg_0]
    mov     [ebp+s1], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 4
    push    2; n
    lea     eax, (aLs - 4000h)[ebx]; "ls"
    push    eax; s2
    push    [ebp+s1]; s1
    call    _strncmp
    add     esp, 10h
    test    eax, eax
    jnz     short loc_1292
    sub     esp, 0Ch
    lea     eax, (aBinLsLas - 4000h)[ebx]; "/bin/ls -las"
    push    eax; command
    call    _system
    add     esp, 10h
    jmp     loc_135B
loc_1292:
    sub     esp, 4
    push    4; n
    lea     eax, (aEcho - 4000h)[ebx]; "echo"
    push    eax; s2
    push    [ebp+s1]; s1
    call    _strncmp
    add     esp, 10h
    test    eax, eax
    jnz     short loc_12C4
    mov     eax, [ebp+s1]
    add     eax, 5
    sub     esp, 0Ch
    push    eax; format
    call    _printf
    add     esp, 10h
    jmp     loc_135B
loc_12C4:
    sub     esp, 4
    push    4; n
    lea     eax, (aZooo - 4000h)[ebx]; "zooo"
    push    eax; s2
    push    [ebp+s1]; s1
    call    _strncmp
    add     esp, 10h
    test    eax, eax
    jnz     short loc_12F3
    mov     eax, (poem - 4000h)[ebx]
    sub     esp, 0Ch
    push    eax; s
    call    _puts
    add     esp, 10h
    jmp     short loc_135B
loc_12F3:
    mov     eax, [ebp+s1]
    movzx   edx, byte ptr [eax]
    movzx   eax, ds:(byte_23B8 - 4000h)[ebx]
    movzx   edx, dl
    movzx   eax, al
    sub     edx, eax
    mov     eax, edx
    test    eax, eax
    jz      short loc_135B
    mov     eax, [ebp+s1]
    movzx   edx, byte ptr [eax]
    movzx   eax, ds:(byte_23BA - 4000h)[ebx]
    movzx   edx, dl
    movzx   eax, al
    sub     edx, eax
    mov     eax, edx
    test    eax, eax
    jnz     short loc_1333
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_1333:
    sub     esp, 8
    lea     eax, (asc_23BC - 4000h)[ebx]; " "
    push    eax; delim
    push    [ebp+s1]; s
    call    _strtok
    add     esp, 10h
    sub     esp, 8
    push    eax
    lea     eax, (aRshCommandNotF - 4000h)[ebx]; "rsh: command not found: %s"
    push    eax; format
    call    _printf
    add     esp, 10h
loc_135B:
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_136D
    call    __stack_chk_fail_local
loc_136D:
    mov     ebx, [ebp+var_4]
    leave
    retn
run endp

