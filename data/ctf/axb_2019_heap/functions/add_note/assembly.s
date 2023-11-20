add_note proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    lea     rdi, aEnterTheIndexY; "Enter the index you want to create (0-1"...
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+size+4]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     eax, dword ptr [rbp+size+4]
    test    eax, eax
    js      short loc_D33
    mov     eax, dword ptr [rbp+size+4]
    cmp     eax, 0Ah
    jle     short loc_D44
loc_D33:
    lea     rdi, aYouCanTHackMe; "You can't hack me!"
    call    _puts
    jmp     loc_F6D
loc_D44:
    lea     rax, counts
    mov     eax, [rax]
    cmp     eax, 0Ah
    jbe     short loc_D68
    lea     rdi, aFull; "full!"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_D68:
    lea     rdi, aEnterASize; "Enter a size:"
    call    _puts
    lea     rax, [rbp+size]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    ___isoc99_scanf
    lea     rax, key
    movzx   eax, byte ptr [rax]
    cmp     al, 2Bh ; '+'
    jnz     loc_E3B
    lea     rdi, aEnterTheConten; "Enter the content: "
    call    _puts
    mov     eax, dword ptr [rbp+size]
    mov     eax, eax
    mov     ebx, dword ptr [rbp+size+4]
    mov     rdi, rax; size
    call    _malloc
    mov     rcx, rax
    lea     rax, note
    movsxd  rdx, ebx
    shl     rdx, 4
    add     rax, rdx
    mov     [rax], rcx
    mov     ecx, dword ptr [rbp+size+4]
    mov     eax, dword ptr [rbp+size]
    lea     rdx, note
    movsxd  rcx, ecx
    shl     rcx, 4
    add     rdx, rcx
    add     rdx, 8
    mov     [rdx], eax
    mov     edx, dword ptr [rbp+size+4]
    lea     rax, note
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jnz     loc_EF0
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     rcx, rax; s
    mov     edx, 5; n
    mov     esi, 1; size
    lea     rdi, aError; "error"
    call    _fwrite
    mov     edi, 0; status
    call    _exit
loc_E3B:
    mov     eax, dword ptr [rbp+size]
    cmp     eax, 80h
    jbe     loc_EE2
    lea     rdi, aEnterTheConten; "Enter the content: "
    call    _puts
    mov     eax, dword ptr [rbp+size]
    mov     eax, eax
    mov     ebx, dword ptr [rbp+size+4]
    mov     rdi, rax; size
    call    _malloc
    mov     rcx, rax
    lea     rax, note
    movsxd  rdx, ebx
    shl     rdx, 4
    add     rax, rdx
    mov     [rax], rcx
    mov     ecx, dword ptr [rbp+size+4]
    mov     eax, dword ptr [rbp+size]
    lea     rdx, note
    movsxd  rcx, ecx
    shl     rcx, 4
    add     rdx, rcx
    add     rdx, 8
    mov     [rdx], eax
    mov     edx, dword ptr [rbp+size+4]
    lea     rax, note
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jnz     short loc_EF0
    mov     rax, cs:stderr_ptr
    mov     rax, [rax]
    mov     rcx, rax; s
    mov     edx, 5; n
    mov     esi, 1; size
    lea     rdi, aError; "error"
    call    _fwrite
    mov     edi, 0; status
    call    _exit
loc_EE2:
    lea     rdi, aYouCanTHackMe; "You can't hack me!"
    call    _puts
    jmp     short loc_F6D
loc_EF0:
    mov     eax, dword ptr [rbp+size+4]
    cdqe
    shl     rax, 4
    mov     rdx, rax
    lea     rax, note
    add     rax, rdx
    mov     rdi, rax
    call    check_pass
    test    eax, eax
    jnz     short loc_F28
    lea     rdi, aGoOutHacker; "go out!hacker!"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_F28:
    mov     edx, dword ptr [rbp+size]
    mov     ecx, dword ptr [rbp+size+4]
    lea     rax, note
    movsxd  rcx, ecx
    shl     rcx, 4
    add     rax, rcx
    mov     rax, [rax]
    mov     esi, edx
    mov     rdi, rax
    call    get_input
    lea     rax, counts
    mov     eax, [rax]
    lea     edx, [rax+1]
    lea     rax, counts
    mov     [rax], edx
    lea     rdi, aDone; "Done!"
    call    _puts
loc_F6D:
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_F81
    call    ___stack_chk_fail
loc_F81:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
add_note endp

