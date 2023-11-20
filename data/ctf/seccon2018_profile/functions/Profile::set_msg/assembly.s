Profile::set_msg proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_8], rdi
    mov     [rbp+var_10], rsi
    mov     rax, [rbp+var_8]
    mov     rdx, [rbp+var_10]
    mov     rsi, rdx
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEaSERKS4_; std::string::operator=(std::string const&)
    nop
    leave
    retn
Profile::set_msg endp

