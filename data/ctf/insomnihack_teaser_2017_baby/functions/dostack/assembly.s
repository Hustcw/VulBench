dostack proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 430h
    mov     [rbp+fd], edi
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, [rbp+fd]
    lea     rsi, aHowMuchBytesYo; "How much bytes you want to send ? "
    mov     edi, eax
    call    sendstr
    lea     rsi, [rbp+buf]; buf
    mov     eax, [rbp+fd]
    mov     ecx, 0; flags
    mov     edx, 0Ah; n
    mov     edi, eax; fd
    call    _recv
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_414], eax
    mov     eax, [rbp+var_414]
    movsxd  rdx, eax
    lea     rcx, [rbp+buf]
    mov     eax, [rbp+fd]
    mov     rsi, rcx
    mov     edi, eax
    call    recvlen
    mov     eax, [rbp+fd]
    lea     rsi, aGoodLuck; "Good luck !\n"
    mov     edi, eax
    call    sendstr
    mov     eax, 0
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_14C6
    call    ___stack_chk_fail
locret_14C6:
    leave
    retn
dostack endp

