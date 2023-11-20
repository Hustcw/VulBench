Profile::show proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     [rbp+var_18], rdi
    mov     rax, [rbp+var_18]
    lea     rbx, [rax+20h]
    mov     esi, offset aName; "Name : "
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     rsi, rbx
    mov     rdi, rax
    call    __ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE; std::operator<<<char>(std::ostream &,std::string const&)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     rax, [rbp+var_18]
    mov     ebx, [rax+40h]
    mov     esi, offset aAge; "Age  : "
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, ebx
    mov     rdi, rax
    call    __ZNSolsEi; std::ostream::operator<<(int)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     rbx, [rbp+var_18]
    mov     esi, offset aMsg; "Msg  : "
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     rsi, rbx
    mov     rdi, rax
    call    __ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKNSt7__cxx1112basic_stringIS4_S5_T1_EE; std::operator<<<char>(std::ostream &,std::string const&)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    nop
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
Profile::show endp

