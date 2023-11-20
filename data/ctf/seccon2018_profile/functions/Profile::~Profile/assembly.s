Profile::~Profile proc
    push    rbp; Alternative name is 'Profile::~Profile()'
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     [rbp+var_18], rdi
    mov     rax, [rbp+var_18]
    add     rax, 20h ; ' '
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    jmp     short loc_40169B
    mov     rbx, rax
    mov     rax, [rbp+var_18]
    mov     rdi, rax
    call    __ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev; std::string::~string()
    mov     rax, rbx
    mov     rdi, rax; struct _Unwind_Exception *
    call    __Unwind_Resume
loc_40169B:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
Profile::~Profile endp

