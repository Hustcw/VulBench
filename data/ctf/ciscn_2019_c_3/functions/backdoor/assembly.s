backdoor proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 400h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     [rbp+var_3F8], 0
    lea     rdi, aCanTBeatDownTh; "Can't beat down them?Let me add the att"...
    call    puts_flush
    lea     rdi, aWeapon; "weapon:"
    call    puts_flush
    mov     eax, 0
    call    read_atoi
    mov     [rbp+var_3F4], eax
    cmp     [rbp+var_3F4], 0
    js      short loc_1160
    cmp     [rbp+var_3F4], 8
    jg      short loc_1160
    mov     eax, [rbp+var_3F4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_1160
    jmp     short loc_114F
loc_1123:
    mov     eax, [rbp+var_3F4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rax, [rdx+rax]
    mov     rdx, [rax]
    add     rdx, 1
    mov     [rax], rdx
    add     [rbp+var_3F8], 1
loc_114F:
    mov     eax, [rbp+var_3F4]
    sub     eax, 1
    cmp     eax, [rbp+var_3F8]
    jg      short loc_1123
loc_1160:
    mov     eax, [rbp+var_3F4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rax, [rdx+rax]
    add     rax, 8
    mov     rsi, [rax]
    mov     eax, [rbp+var_3F4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rax, [rdx+rax]
    mov     rcx, [rax]
    mov     eax, [rbp+var_3F4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rax, [rdx+rax]
    lea     rdx, [rax+10h]
    lea     rax, [rbp+s]
    mov     r9, rsi
    mov     r8, rcx
    mov     rcx, rdx
    lea     rdx, aWeaponsNameSAt; "weapons'name: %s\nattack_times: %lu\nat"...
    mov     esi, 100h; maxlen
    mov     rdi, rax; s
    mov     eax, 0
    call    _snprintf
    lea     rax, [rbp+s]
    mov     rdi, rax
    call    puts_flush
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_120C
    call    ___stack_chk_fail
locret_120C:
    leave
    retn
backdoor endp

