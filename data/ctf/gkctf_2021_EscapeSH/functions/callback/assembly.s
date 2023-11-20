callback proc
    push    r14
    push    r13
    mov     r14, rdx
    push    r12
    push    rbp
    mov     r12, rdi
    push    rbx
    mov     rax, [rdi+8]
    test    rax, rax
    jz      short loc_11AE
    cmp     byte ptr [rax], 0
    cmovnz  r14, rax
loc_11AE:
    movzx   r13d, word ptr [r12+18h]
    xor     ebx, ebx
    xor     ebp, ebp
    test    r13, r13
    jnz     short loc_11D5
    jmp     loc_1247
loc_11C8:
    add     rbp, 1
    add     rbx, 38h ; '8'
    cmp     r13, rbp
    jz      short loc_1247
loc_11D5:
    mov     rax, rbx
    add     rax, [r12+10h]
    cmp     dword ptr [rax], 1
    jnz     short loc_11C8
    cmp     qword ptr [rax+28h], 0
    jz      short loc_11C8
    mov     edx, [rax+4]
    test    edx, edx
    jz      short loc_11C8
    lea     rdi, aLibX8664LinuxG; "/lib/x86_64-linux-gnu/libc.so.6"
    mov     ecx, 1Fh
    mov     rsi, r14
    repe cmpsb
    jnz     short loc_11C8
    mov     rsi, [rax+10h]
    add     rsi, [r12]
    lea     rdi, aMonitor; "monitor"
    mov     ecx, 7
    add     rsi, 3C4B10h
    repe cmpsb
    jnz     short loc_1252
    lea     rdi, s; "the monitor shell:"
    add     rbp, 1
    add     rbx, 38h ; '8'
    call    puts
    lea     rdi, command; "/bin/sh"
    call    system
    cmp     r13, rbp
    jnz     short loc_11D5
loc_1247:
    pop     rbx
    xor     eax, eax
    pop     rbp
    pop     r12
    pop     r13
    pop     r14
    retn
loc_1252:
    lea     rdi, aLueluelue; "lueluelue.."
    call    puts
    jmp     short loc_1247
callback endp

