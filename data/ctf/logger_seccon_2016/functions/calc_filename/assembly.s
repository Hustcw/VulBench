calc_filename proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 138h
    mov     [rbp+src], rdi
    mov     [rbp+var_130], rsi
    mov     [rbp+var_138], rdx
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    movzx   eax, cs:word_4013F5
    mov     word ptr [rbp+dest], ax
    lea     rdx, [rbp+var_9E]
    mov     eax, 0
    mov     [rdx], ax
    add     rdx, 2
    mov     [rdx], eax
    add     rdx, 4
    mov     ecx, 0Fh
    mov     rdi, rdx
    rep stosq
    mov     rdx, [rbp+src]
    lea     rax, [rbp+dest]
    mov     rsi, rdx; src
    mov     rdi, rax; dest
    call    _strcat
    mov     rdx, [rbp+var_130]
    lea     rax, [rbp+dest]
    mov     rsi, rdx; src
    mov     rdi, rax; dest
    call    _strcat
    lea     rax, [rbp+var_110]
    mov     rdi, rax
    call    _MD5_Init
    cmp     eax, 1
    jz      short loc_400D39
    mov     edi, offset s; "Initialization error."
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_400D39:
    lea     rax, [rbp+dest]
    mov     rdi, rax; s
    call    _strlen
    mov     rdx, rax
    lea     rcx, [rbp+dest]
    lea     rax, [rbp+var_110]
    mov     rsi, rcx
    mov     rdi, rax
    call    _MD5_Update
    cmp     eax, 1
    jz      short loc_400D7D
    mov     edi, offset aUpdateError; "Update error."
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_400D7D:
    lea     rdx, [rbp+var_110]
    lea     rax, [rbp+var_B0]
    mov     rsi, rdx
    mov     rdi, rax
    call    _MD5_Final
    cmp     eax, 1
    jz      short loc_400DAF
    mov     edi, offset aFinalizationEr; "Finalization error."
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_400DAF:
    mov     [rbp+var_114], 0
    jmp     short loc_400DFE
loc_400DBB:
    mov     eax, [rbp+var_114]
    cdqe
    movzx   eax, [rbp+rax+var_B0]
    movzx   eax, al
    mov     edx, [rbp+var_114]
    add     edx, edx
    movsxd  rcx, edx
    mov     rdx, [rbp+var_138]
    add     rcx, rdx
    mov     edx, eax
    mov     esi, offset format; "%02x"
    mov     rdi, rcx; s
    mov     eax, 0
    call    _sprintf
    add     [rbp+var_114], 1
loc_400DFE:
    cmp     [rbp+var_114], 0Fh
    jle     short loc_400DBB
    mov     rax, [rbp+var_138]
    mov     rbx, [rbp+var_18]
    xor     rbx, fs:28h
    jz      short loc_400E22
    call    ___stack_chk_fail
loc_400E22:
    add     rsp, 138h
    pop     rbx
    pop     rbp
    retn
calc_filename endp

