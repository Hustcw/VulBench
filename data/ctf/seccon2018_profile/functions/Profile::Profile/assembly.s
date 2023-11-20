Profile::Profile proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     [rbp+var_18], rdi
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev; std::string::basic_string(void)
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev; std::string::basic_string(void)
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     esi, offset unk_401734
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEaSEPKc; std::string::operator=(char const*)
    mov     rax, [rbp+var_18]
    mov     dword ptr [rax+40h], 0
    mov     rax, [rbp+var_18]
    mov     esi, offset unk_401734
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEaSEPKc; std::string::operator=(char const*)
    jmp     short loc_4015E7
    mov     rbx, rax
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    jmp     short loc_4015D0
    mov     rbx, rax
loc_4015D0:
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    mov     rax, rbx
    mov     rdi, rax; struct _Unwind_Exception *
    call    __Unwind_Resume
loc_4015E7:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
Profile::Profile endp

