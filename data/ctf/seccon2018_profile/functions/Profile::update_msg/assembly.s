Profile::update_msg proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    __ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv; std::string::c_str(void)
    mov     [rbp+ptr], rax
    mov     rax, [rbp+ptr]
    mov     rdi, rax; ptr
    call    _malloc_usable_size
    mov     qword ptr [rbp+var_8], rax
    cmp     qword ptr [rbp+var_8], 0
    setz    al
    test    al, al
    jz      short loc_4010EC
    mov     esi, offset aUnableToUpdate; "Unable to update message."
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    jmp     short locret_40110F
loc_4010EC:
    mov     esi, offset aInputNewMessag; "Input new message >> "
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     rax, qword ptr [rbp+var_8]
    mov     edx, eax
    mov     rax, [rbp+ptr]
    mov     esi, edx; unsigned int
    mov     rdi, rax; char *
    call    _Z4getnPcj; getn(char *,uint)
locret_40110F:
    leave
    retn
Profile::update_msg endp

