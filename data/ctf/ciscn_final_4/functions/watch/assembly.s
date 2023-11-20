watch proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 120h
    mov     [rbp+pid], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    mov     rdi, rax; stat_loc
    call    wait
loc_400E55:
    mov     eax, [rbp+pid]
    mov     ecx, 0
    mov     edx, 0
    mov     esi, eax
    mov     edi, 18h; request
    mov     eax, 0
    call    ptrace
    lea     rcx, [rbp+stat_loc]
    mov     eax, [rbp+pid]
    mov     edx, 0; options
    mov     rsi, rcx; stat_loc
    mov     edi, eax; pid
    call    waitpid
    mov     eax, [rbp+stat_loc]
    mov     [rbp+var_110], eax
    mov     eax, [rbp+var_110]
    and     eax, 7Fh
    test    eax, eax
    jz      short loc_400EE8
    mov     eax, [rbp+stat_loc]
    mov     [rbp+var_100], eax
    mov     eax, [rbp+var_100]
    and     eax, 7Fh
    add     eax, 1
    sar     al, 1
    test    al, al
    jg      short loc_400EE8
    mov     eax, [rbp+stat_loc]
    mov     [rbp+var_F0], eax
    mov     eax, [rbp+var_F0]
    and     eax, 0FF00h
    sar     eax, 8
    cmp     eax, 5
    jz      short loc_400EF2
loc_400EE8:
    mov     edi, 0FFFFFFFFh; status
    call    exit
loc_400EF2:
    lea     rdx, [rbp+var_E0]
    mov     eax, [rbp+pid]
    mov     rcx, rdx
    mov     edx, 0
    mov     esi, eax
    mov     edi, 0Ch; request
    mov     eax, 0
    call    ptrace
    mov     rax, [rbp+var_68]
    mov     [rbp+var_E8], rax
    cmp     [rbp+var_E8], 2
    jz      short loc_400F59
    cmp     [rbp+var_E8], 9
    jz      short loc_400F59
    cmp     [rbp+var_E8], 39h ; '9'
    jz      short loc_400F59
    cmp     [rbp+var_E8], 3Ah ; ':'
    jz      short loc_400F59
    cmp     [rbp+var_E8], 65h ; 'e'
    jnz     loc_400E55
loc_400F59:
    mov     edi, offset aHeyWhatAreYouD; "hey! what are you doing?"
    call    puts
    mov     edi, 0FFFFFFFFh; status
    call    exit
watch endp

