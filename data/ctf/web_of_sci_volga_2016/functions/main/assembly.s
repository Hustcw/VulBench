main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], edi
    mov     [rbp+var_10], rsi
    mov     rax, cs:stdout
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     edi, 0; timer
    call    _time
    mov     edi, eax; seed
    call    _srand
    mov     eax, 0
    call    sub_4007CD
    test    eax, eax
    jz      short loc_40102A
    mov     edi, offset aServiceIsProvi; "Service is provided for humans only!"
    call    _puts
    mov     eax, 1
    jmp     short locret_401039
loc_40102A:
    mov     eax, 0
    call    sub_400E1C
    mov     eax, 0
locret_401039:
    leave
    retn
main endp

