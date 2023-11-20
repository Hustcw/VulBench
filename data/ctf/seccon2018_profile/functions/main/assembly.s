main proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 0C8h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    lea     rax, [rbp+var_60]
    mov     rdi, rax; this
    call    _ZN7ProfileC2Ev; Profile::Profile(void)
    lea     rax, [rbp+var_C0]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev; std::string::basic_string(void)
    mov     esi, offset aPleaseIntroduc; "Please introduce yourself!"
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     esi, offset aName_0; "Name >> "
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    lea     rax, [rbp+var_C0]
    mov     rsi, rax
    mov     edi, offset _ZSt3cin@@GLIBCXX_3_4
    call    __ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RNSt7__cxx1112basic_stringIS4_S5_T1_EE; std::operator>><char>(std::istream &,std::string &)
    lea     rdx, [rbp+var_C0]
    lea     rax, [rbp+var_A0]
    mov     rsi, rdx
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_; std::string::basic_string(std::string const&)
    lea     rdx, [rbp+var_A0]
    lea     rax, [rbp+var_60]
    mov     rsi, rdx
    mov     rdi, rax
    call    _ZN7Profile8set_nameENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE; Profile::set_name(std::string)
    lea     rax, [rbp+var_A0]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    mov     esi, offset aAge_0; "Age >> "
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    lea     rax, [rbp+var_C4]
    mov     rsi, rax
    mov     edi, offset _ZSt3cin@@GLIBCXX_3_4
    call    __ZNSirsERi; std::istream::operator>>(int &)
    mov     edx, [rbp+var_C4]
    lea     rax, [rbp+var_60]
    mov     esi, edx; int
    mov     rdi, rax; this
    call    _ZN7Profile7set_ageEi; Profile::set_age(int)
    mov     esi, offset aMessage; "Message >> "
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    lea     rax, [rbp+var_C0]
    mov     rsi, rax
    mov     edi, offset _ZSt3cin@@GLIBCXX_3_4
    call    __ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RNSt7__cxx1112basic_stringIS4_S5_T1_EE; std::operator>><char>(std::istream &,std::string &)
    lea     rdx, [rbp+var_C0]
    lea     rax, [rbp+var_80]
    mov     rsi, rdx
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1ERKS4_; std::string::basic_string(std::string const&)
    lea     rdx, [rbp+var_80]
    lea     rax, [rbp+var_60]
    mov     rsi, rdx
    mov     rdi, rax
    call    _ZN7Profile7set_msgENSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE; Profile::set_msg(std::string)
    lea     rax, [rbp+var_80]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
loc_40131F:
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     esi, offset a1UpdateMessage; "1 : update message"
    mov     rdi, rax
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     esi, offset a2ShowProfile; "2 : show profile"
    mov     rdi, rax
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     esi, offset a0Exit; "0 : exit"
    mov     rdi, rax
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
    mov     esi, offset asc_4017E2; ">> "
    mov     rdi, rax
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    lea     rax, [rbp+var_C4]
    mov     rsi, rax
    mov     edi, offset _ZSt3cin@@GLIBCXX_3_4
    call    __ZNSirsERi; std::istream::operator>>(int &)
    call    _getchar
    mov     eax, [rbp+var_C4]
    cmp     eax, 1
    jz      short loc_4013B4
    cmp     eax, 2
    jz      short loc_4013C2
    jmp     short loc_4013D0
loc_4013B4:
    lea     rax, [rbp+var_60]
    mov     rdi, rax; this
    call    _ZN7Profile10update_msgEv; Profile::update_msg(void)
    jmp     short loc_4013EC
loc_4013C2:
    lea     rax, [rbp+var_60]
    mov     rdi, rax; this
    call    _ZN7Profile4showEv; Profile::show(void)
    jmp     short loc_4013EC
loc_4013D0:
    mov     esi, offset aWrongInput; "Wrong input..."
    mov     edi, offset _ZSt4cout@@GLIBCXX_3_4
    call    __ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc; std::operator<<<std::char_traits<char>>(std::ostream &,char const*)
    mov     esi, offset __ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_; std::endl<char,std::char_traits<char>>(std::ostream &)
    mov     rdi, rax
    call    __ZNSolsEPFRSoS_E; std::ostream::operator<<(std::ostream & (*)(std::ostream &))
loc_4013EC:
    mov     eax, [rbp+var_C4]
    test    eax, eax
    jz      short loc_4013FB
    jmp     loc_40131F
loc_4013FB:
    lea     rax, [rbp+var_C0]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    lea     rax, [rbp+var_60]
    mov     rdi, rax; this
    call    _ZN7ProfileD2Ev; Profile::~Profile()
    mov     eax, 0
    mov     rcx, [rbp+var_18]
    xor     rcx, fs:28h
    jz      short loc_401484
    jmp     short loc_40147F
    mov     rbx, rax
    lea     rax, [rbp+var_A0]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    jmp     short loc_401454
    mov     rbx, rax
    lea     rax, [rbp+var_80]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    jmp     short loc_401454
    mov     rbx, rax
loc_401454:
    lea     rax, [rbp+var_C0]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    jmp     short loc_401468
    mov     rbx, rax
loc_401468:
    lea     rax, [rbp+var_60]
    mov     rdi, rax; this
    call    _ZN7ProfileD2Ev; Profile::~Profile()
    mov     rax, rbx
    mov     rdi, rax; struct _Unwind_Exception *
    call    __Unwind_Resume
loc_40147F:
    call    ___stack_chk_fail
loc_401484:
    add     rsp, 0C8h
    pop     rbx
    pop     rbp
    retn
main endp

