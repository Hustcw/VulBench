main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 120h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     eax, 0
    call    welcome
loc_401085:
    mov     eax, 0
    call    menu
    mov     eax, 0
    call    input_choice
    mov     [rbp+var_114], eax
    mov     eax, [rbp+var_114]
    cmp     eax, 2
    jz      short loc_4010CE
    cmp     eax, 2
    jg      short loc_4010B6
    cmp     eax, 1
    jz      short loc_4010C2
    jmp     short loc_4010F0
loc_4010B6:
    cmp     eax, 3
    jz      short loc_4010DA
    cmp     eax, 4
    jz      short loc_4010E6
    jmp     short loc_4010F0
loc_4010C2:
    mov     eax, 0
    call    uadd
    jmp     short loc_4010F0
loc_4010CE:
    mov     eax, 0
    call    udelete
    jmp     short loc_4010F0
loc_4010DA:
    mov     eax, 0
    call    ushow
    jmp     short loc_4010F0
loc_4010E6:
    mov     edi, 0; status
    call    _exit
loc_4010F0:
    mov     edx, 8; n
    mov     esi, offset aRemark; "REMARK: "
    mov     edi, 1; fd
    call    _write
    lea     rax, [rbp+buf]
    mov     edx, 100h; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    jmp     loc_401085
main endp

