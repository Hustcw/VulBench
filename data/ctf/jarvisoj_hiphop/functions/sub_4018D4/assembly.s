sub_4018D4 proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 90h
    mov     [rbp+var_88], rdi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     edi, offset aCongraturation; "Congraturation! You win!"
    call    _puts
    mov     rax, [rbp+var_88]
    mov     byte ptr [rax+50h], 1
    call    _getegid
    mov     [rbp+rgid], eax
    mov     edx, [rbp+rgid]
    mov     eax, [rbp+rgid]
    mov     esi, edx; egid
    mov     edi, eax; rgid
    call    _setregid
    mov     edi, offset command; "/bin/cat /home/hunting/flag"
    call    _system
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_401940
    call    ___stack_chk_fail
locret_401940:
    leave
    retn
sub_4018D4 endp

