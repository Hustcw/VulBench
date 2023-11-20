change_num proc
    push    rbp
    mov     rbp, rsp
    mov     esi, offset t
    mov     edi, offset _ZSt3cin@@GLIBCXX_3_4
    call    __ZStrsIcSt11char_traitsIcEERSt13basic_istreamIT_T0_ES6_PS3_; std::operator>><char,std::char_traits<char>>(std::istream &,char*)
    mov     edi, offset t; nptr
    call    _atoi
    mov     cs:n, eax
    mov     edx, 8; n
    mov     esi, 0; c
    mov     edi, offset t; s
    call    _memset
    nop
    pop     rbp
    retn
change_num endp

