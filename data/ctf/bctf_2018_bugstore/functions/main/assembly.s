main proc
    push    rbx
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rsp+18h+var_10], rax
    xor     eax, eax
    call    sub_A4A
    mov     rbx, rsp
loc_D7E:
    mov     eax, 0
    call    sub_AFE
    mov     edx, 2; nbytes
    mov     rsi, rbx; buf
    mov     edi, 0; fd
    call    read
    movzx   eax, [rsp+18h+var_18]
    cmp     al, 45h ; 'E'
    jz      short loc_DDA
    cmp     al, 45h ; 'E'
    jg      short loc_DAC
    cmp     al, 41h ; 'A'
    jz      short loc_DB6
    jmp     short loc_D7E
loc_DAC:
    cmp     al, 46h ; 'F'
    jz      short loc_DCE
    cmp     al, 53h ; 'S'
    jz      short loc_DC2
    jmp     short loc_D7E
loc_DB6:
    mov     eax, 0
    call    sub_D0E
    jmp     short loc_D7E
loc_DC2:
    mov     eax, 0
    call    sub_CB5
    jmp     short loc_D7E
loc_DCE:
    mov     eax, 0
    call    sub_C62
    jmp     short loc_D7E
loc_DDA:
    mov     edi, 0; status
    call    exit
main endp

