get_array proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 28h
    mov     [rbp+var_28], rdi
    mov     ebx, cs:n
    mov     esi, offset aInput; "input "
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, ebx
    mov     rdi, rax
    call    __ZNSolsEi; std::ostream::operator<<(int)
    mov     esi, offset aNum; " num:"
    mov     rdi, rax
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     [rbp+var_14], 0
loc_400EA3:
    mov     eax, cs:n
    cmp     [rbp+var_14], eax
    jge     short loc_400EF8
    mov     esi, offset t
    mov     edi, offset _ZSt3cin@@GLIBCXX_3_4
    call    __ZStrsIcSt11char_traitsIcEERSt13basic_istreamIT_T0_ES6_PS3_; std::operator>><char,std::char_traits<char>>(std::istream &,char*)
    mov     eax, [rbp+var_14]
    cdqe
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_28]
    lea     rbx, [rdx+rax]
    mov     edi, offset t; nptr
    call    _atoi
    mov     [rbx], eax
    mov     edx, 8; n
    mov     esi, 0; c
    mov     edi, offset t; s
    call    _memset
    add     [rbp+var_14], 1
    jmp     short loc_400EA3
loc_400EF8:
    nop
    add     rsp, 28h
    pop     rbx
    pop     rbp
    retn
get_array endp

