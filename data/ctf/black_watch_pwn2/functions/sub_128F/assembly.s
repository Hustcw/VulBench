sub_128F proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 70h
    mov     r8d, 0
    mov     ecx, 0
    mov     edx, 0
    mov     esi, 1
    mov     edi, 26h ; '&'; option
    mov     eax, 0
    call    _prctl
    mov     [rbp+var_60], 20h ; ' '
    mov     [rbp+var_5E], 0
    mov     [rbp+var_5D], 0
    mov     [rbp+var_5C], 4
    mov     [rbp+var_58], 15h
    mov     [rbp+var_56], 0
    mov     [rbp+var_55], 9
    mov     [rbp+var_54], 0C000003Eh
    mov     [rbp+var_50], 20h ; ' '
    mov     [rbp+var_4E], 0
    mov     [rbp+var_4D], 0
    mov     [rbp+var_4C], 0
    mov     [rbp+var_48], 35h ; '5'
    mov     [rbp+var_46], 7
    mov     [rbp+var_45], 0
    mov     [rbp+var_44], 40000000h
    mov     [rbp+var_40], 15h
    mov     [rbp+var_3E], 6
    mov     [rbp+var_3D], 0
    mov     [rbp+var_3C], 3Bh ; ';'
    mov     [rbp+var_38], 15h
    mov     [rbp+var_36], 0
    mov     [rbp+var_35], 4
    mov     [rbp+var_34], 1
    mov     [rbp+var_30], 20h ; ' '
    mov     [rbp+var_2E], 0
    mov     [rbp+var_2D], 0
    mov     [rbp+var_2C], 24h ; '$'
    mov     [rbp+var_28], 15h
    mov     [rbp+var_26], 0
    mov     [rbp+var_25], 2
    mov     [rbp+var_24], 0
    mov     [rbp+var_20], 20h ; ' '
    mov     [rbp+var_1E], 0
    mov     [rbp+var_1D], 0
    mov     [rbp+var_1C], 20h ; ' '
    mov     [rbp+var_18], 15h
    mov     [rbp+var_16], 1
    mov     [rbp+var_15], 0
    mov     [rbp+var_14], 10h
    mov     [rbp+var_10], 6
    mov     [rbp+var_E], 0
    mov     [rbp+var_D], 0
    mov     [rbp+var_C], 7FFF0000h
    mov     [rbp+var_8], 6
    mov     [rbp+var_6], 0
    mov     [rbp+var_5], 0
    mov     [rbp+var_4], 0
    mov     [rbp+var_70], 0Ch
    lea     rax, [rbp+var_60]
    mov     [rbp+var_68], rax
    lea     rax, [rbp+var_70]
    mov     rdx, rax
    mov     esi, 2
    mov     edi, 16h; option
    mov     eax, 0
    call    _prctl
    nop
    leave
    retn
sub_128F endp

