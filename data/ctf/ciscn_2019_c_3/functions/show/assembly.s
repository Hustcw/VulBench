show proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 400h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rdi, aIndex; "index: "
    call    puts_flush
    mov     eax, 0
    call    read_atoi
    mov     [rbp+var_3F4], eax
    cmp     [rbp+var_3F4], 0
    js      loc_108C
    cmp     [rbp+var_3F4], 8
    jg      loc_108C
    mov     eax, [rbp+var_3F4]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, weapon_list
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      loc_108C
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
loc_108C:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_10A1
    call    ___stack_chk_fail
locret_10A1:
    leave
    retn
show endp

