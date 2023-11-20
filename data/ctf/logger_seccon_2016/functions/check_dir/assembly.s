check_dir proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 90h
    lea     rax, [rbp+var_90]
    mov     rsi, rax; stat_buf
    mov     edi, offset filename; "/tmp/logger"
    call    stat
    test    eax, eax
    jz      short loc_400E63
    mov     edi, offset aStatErrorTmpLo; "Stat error. /tmp/logger exists?"
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_400E63:
    mov     eax, [rbp+var_78]
    and     eax, 0F000h
    cmp     eax, 4000h
    jnz     short loc_400E79
    mov     eax, 1
    jmp     short locret_400E7E
loc_400E79:
    mov     eax, 0
locret_400E7E:
    leave
    retn
check_dir endp

