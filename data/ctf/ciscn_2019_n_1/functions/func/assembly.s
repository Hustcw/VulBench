func proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 30h
    pxor    xmm0, xmm0
    movss   [rbp+var_4], xmm0
    mov     edi, offset s; "Let's guess the number."
    call    _puts
    lea     rax, [rbp+var_30]
    mov     rdi, rax
    mov     eax, 0
    call    _gets
    movss   xmm0, [rbp+var_4]
    ucomiss xmm0, cs:dword_4007F4
    jp      short loc_4006CF
    movss   xmm0, [rbp+var_4]
    ucomiss xmm0, cs:dword_4007F4
    jnz     short loc_4006CF
    mov     edi, offset command; "cat /flag"
    mov     eax, 0
    call    _system
    jmp     short loc_4006D9
loc_4006CF:
    mov     edi, offset aItsValueShould; "Its value should be 11.28125"
    call    _puts
loc_4006D9:
    nop
    leave
    retn
func endp

