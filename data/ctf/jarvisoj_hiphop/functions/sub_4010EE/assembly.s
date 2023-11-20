sub_4010EE proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 18h
    mov     [rbp+var_18], rdi
    mov     rax, [rbp+var_18]
    mov     dword ptr [rax], 61747461h
    mov     word ptr [rax+4], 6B63h
    mov     byte ptr [rax+6], 0
    mov     rax, [rbp+var_18]
    add     rax, 28h ; '('
    mov     rdi, rax
    call    sub_400CD6
    mov     rax, [rbp+var_18]
    mov     byte ptr [rax+20h], 0
    mov     [rbp+var_4], 1
loc_40112D:
    cmp     [rbp+var_4], 7
    jg      short loc_401147
    mov     rdx, [rbp+var_18]
    mov     eax, [rbp+var_4]
    cdqe
    mov     byte ptr [rdx+rax+20h], 0
    add     [rbp+var_4], 1
    jmp     short loc_40112D
loc_401147:
    nop
    leave
    retn
sub_4010EE endp

