main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    call    sub_4008A9
    mov     esi, offset aLoadFileServic; "Load file Service\nInput file name: "
    mov     edi, 1
    mov     eax, 0
    call    __printf_chk
    mov     esi, 80h
    mov     edi, offset unk_601040
    call    sub_400986
    mov     esi, offset aInputOffset; "Input offset: "
    mov     edi, 1
    mov     eax, 0
    call    __printf_chk
    call    sub_4009DB
    cdqe
    mov     [rbp+var_8], rax
    mov     esi, offset aInputSize; "Input size: "
    mov     edi, 1
    mov     eax, 0
    call    __printf_chk
    call    sub_4009DB
    cdqe
    mov     [rbp+var_10], rax
    mov     rcx, [rbp+var_10]
    mov     rdx, [rbp+var_8]
    lea     rax, [rbp+var_30]
    mov     esi, offset unk_601040
    mov     rdi, rax
    call    sub_4008FD
    call    sub_4008D8
    mov     eax, 0
    leave
    retn
main endp

