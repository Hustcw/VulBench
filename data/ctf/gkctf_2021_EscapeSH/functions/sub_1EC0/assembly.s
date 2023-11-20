sub_1EC0 proc
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbp
    push    rbx
    sub     rsp, 318h
    lea     r14, unk_205B40
    mov     rax, fs:28h
    mov     [rsp+348h+var_40], rax
    xor     eax, eax
    mov     edx, [r14]
    cmp     edx, 1
    jle     loc_201D
    lea     rax, qword_204040
    mov     ebp, 2
    mov     r13, rsp
    lea     rbx, [rax+8]
    jmp     short loc_1F23
loc_1F10:
    mov     r12d, ebp
    add     rbx, 8
    add     ebp, 1
    cmp     edx, r12d
    jle     loc_201D
loc_1F23:
    mov     rax, [rbx]
    cmp     byte ptr [rax], 3Eh ; '>'
    jnz     short loc_1F10
    movzx   ecx, byte ptr [rax+1]
    test    cl, cl
    jnz     loc_2046
    mov     rsi, [rbx+8]
    mov     r12d, ebp
    test    rsi, rsi
    jz      loc_2070
loc_1F47:
    mov     edx, 300h
    mov     rdi, r13
    call    __strcpy_chk
    lea     rsi, aDestFilenameS; "dest_filename = %s"
    mov     rdx, r13
    mov     edi, 1
    xor     eax, eax
    call    __printf_chk
loc_1F6A:
    mov     rax, [rbx]
    cmp     byte ptr [rax], 3Eh ; '>'
    jnz     loc_200A
    movzx   edx, byte ptr [rax+1]
    test    dl, dl
    jnz     short loc_1FC6
    xor     eax, eax
    mov     edx, 1B6h
    mov     esi, 241h; oflag
    mov     rdi, r13; file
    call    open
    test    eax, eax
    mov     r15d, eax
    js      loc_2081
    nop     dword ptr [rax]
loc_1FA0:
    call    fork
    test    eax, eax
    js      short loc_1FA0
    jz      loc_208F
    xor     edx, edx; options
    xor     esi, esi; stat_loc
    mov     edi, eax; pid
    call    waitpid
    mov     rax, [rbx]
    cmp     byte ptr [rax], 3Eh ; '>'
    jnz     short loc_200A
    movzx   edx, byte ptr [rax+1]
loc_1FC6:
    cmp     dl, 3Eh ; '>'
    jnz     short loc_200A
    cmp     byte ptr [rax+2], 0
    jnz     short loc_200A
    xor     eax, eax
    mov     edx, 1B6h
    mov     esi, 441h; oflag
    mov     rdi, r13; file
    call    open
    test    eax, eax
    mov     r15d, eax
    js      loc_2081
loc_1FF0:
    call    fork
    test    eax, eax
    js      short loc_1FF0
    jz      loc_208F
    xor     edx, edx; options
    xor     esi, esi; stat_loc
    mov     edi, eax; pid
    call    waitpid
loc_200A:
    mov     edx, [r14]
    add     rbx, 8
    add     ebp, 1
    cmp     edx, r12d
    jg      loc_1F23
loc_201D:
    mov     rax, [rsp+348h+var_40]
    xor     rax, fs:28h
    jnz     loc_20BD
    add     rsp, 318h
    pop     rbx
    pop     rbp
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    retn
loc_2046:
    cmp     cl, 3Eh ; '>'
    jnz     loc_1F10
    cmp     byte ptr [rax+2], 0
    jnz     loc_1F10
    mov     rsi, [rbx+8]
    mov     r12d, ebp
    test    rsi, rsi
    jnz     loc_1F47
    nop     dword ptr [rax+00000000h]
loc_2070:
    lea     rdi, aOrNoFile; "> or >> no file"
    call    puts
    jmp     loc_1F6A
loc_2081:
    lea     rdi, aOpenOrNoThisFi; "open or no this file false!"
    call    puts
    jmp     short loc_201D
loc_208F:
    mov     esi, 1; fd2
    mov     edi, r15d; fd
    call    dup2
    test    eax, eax
    jns     short loc_20B1
    lea     rdi, aErrInDup2; "err in dup2"
    call    puts
    jmp     loc_201D
loc_20B1:
    call    sub_1930
    xor     edi, edi; status
    call    exit
loc_20BD:
    call    __stack_chk_fail
sub_1EC0 endp

