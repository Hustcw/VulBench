show_num proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+var_18], rdi
    mov     eax, cs:n
    cmp     eax, 13h
    jg      short loc_400D01
    mov     [rbp+var_4], 0
loc_400CC1:
    mov     eax, cs:n
    cmp     [rbp+var_4], eax
    jge     short loc_400D43
    mov     eax, [rbp+var_4]
    cdqe
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     eax, [rax]
    mov     esi, eax
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZNSolsEi; std::ostream::operator<<(int)
    mov     esi, offset unk_401274
    mov     rdi, rax
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    add     [rbp+var_4], 1
    jmp     short loc_400CC1
loc_400D01:
    mov     [rbp+var_4], 0
loc_400D08:
    cmp     [rbp+var_4], 13h
    jg      short loc_400D43
    mov     eax, [rbp+var_4]
    cdqe
    lea     rdx, ds:0[rax*4]
    mov     rax, [rbp+var_18]
    add     rax, rdx
    mov     eax, [rax]
    mov     esi, eax
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZNSolsEi; std::ostream::operator<<(int)
    mov     esi, offset unk_401274
    mov     rdi, rax
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    add     [rbp+var_4], 1
    jmp     short loc_400D08
loc_400D43:
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    nop
    leave
    retn
show_num endp

