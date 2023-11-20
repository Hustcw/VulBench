grimoire_open proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:fp
    test    rax, rax
    jz      short loc_100C
    lea     rdi, aTheDeskIsOccup; "The desk is occupied with another book."
    call    _puts
    jmp     short loc_105F
loc_100C:
    lea     rsi, modes; "r"
    lea     rdi, filepath; filename
    call    _fopen
    mov     cs:fp, rax
    mov     rax, cs:fp
    test    rax, rax
    jnz     short loc_1053
    lea     rsi, aNoSuchFileOrDi; "No such file or directory"
    lea     rdi, filepath
    call    error
    lea     rdi, aYouLostTheGrim; "You lost the grimoire..."
    call    _puts
    jmp     short loc_105F
loc_1053:
    lea     rdi, aYouOpenedTheFo; "You opened the forbidden grimoire."
    call    _puts
loc_105F:
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1073
    call    ___stack_chk_fail
locret_1073:
    leave
    retn
grimoire_open endp

