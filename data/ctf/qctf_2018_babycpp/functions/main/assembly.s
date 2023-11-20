main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 70h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    call    _Z9user_initv; user_init(void)
    mov     esi, offset aWelcomeComeToQ; "Welcome come to QCTF 2018."
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     esi, offset aInputN; "input n:"
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     esi, offset t
    mov     edi, offset _ZSt3cin@@GLIBCXX_3_4
    call    __ZStrsIcSt11char_traitsIcEERSt13basic_istreamIT_T0_ES6_PS3_; std::operator>><char,std::char_traits<char>>(std::istream &,char*)
    mov     edi, offset t; nptr
    call    _atoi
    mov     cs:n, eax
loc_400F73:
    call    _Z9show_menuv; show_menu(void)
    lea     rax, [rbp+var_61]
    mov     rsi, rax
    mov     edi, offset _ZSt3cin@@GLIBCXX_3_4
    call    __ZStrsIcSt11char_traitsIcEERSt13basic_istreamIT_T0_ES6_RS3_; std::operator>><char,std::char_traits<char>>(std::istream &,char&)
    movzx   eax, [rbp+var_61]
    sub     eax, 30h ; '0'
    mov     [rbp+var_61], al
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     rdi, rax; stream
    call    _fflush
    movzx   eax, [rbp+var_61]
    movsx   eax, al
    cmp     eax, 2
    jz      short loc_400FCD
    cmp     eax, 2
    jg      short loc_400FBA
    cmp     eax, 1
    jz      short loc_400FC6
    jmp     short loc_400FFF
loc_400FBA:
    cmp     eax, 3
    jz      short loc_400FDB
    cmp     eax, 4
    jz      short loc_400FE9
    jmp     short loc_400FFF
loc_400FC6:
    call    _Z10change_numv; change_num(void)
    jmp     short loc_400FFF
loc_400FCD:
    lea     rax, [rbp+var_60]
    mov     rdi, rax; int *
    call    _Z9get_arrayPi; get_array(int *)
    jmp     short loc_400FFF
loc_400FDB:
    lea     rax, [rbp+var_60]
    mov     rdi, rax; int *
    call    _Z9do_uniquePi; do_unique(int *)
    jmp     short loc_400FFF
loc_400FE9:
    mov     eax, 0
    mov     rdx, [rbp+var_8]
    xor     rdx, fs:28h
    jz      short locret_401009
    jmp     short loc_401004
loc_400FFF:
    jmp     loc_400F73
loc_401004:
    call    ___stack_chk_fail
locret_401009:
    leave
    retn
main endp

