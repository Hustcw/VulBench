replace proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 54h
    jmp     loc_80490FF
loc_8048F2D:
    lea     eax, [ebp+var_3D]
    mov     [esp], eax
    call    __ZNSaIcEC1Ev; std::allocator<char>::allocator(void)
    mov     dword ptr [esp+8], 0; unsigned int
    mov     eax, [ebp+arg_8]
    mov     [esp+4], eax; std::string *
    mov     eax, [ebp+arg_4]
    mov     [esp], eax; this
    call    __ZNKSs4findERKSsj; std::string::find(std::string const&,uint)
    mov     [ebp+var_3C], eax
    lea     eax, [ebp+var_38]
    mov     edx, [ebp+arg_4]
    mov     [esp+4], edx
    mov     [esp], eax; this
    call    __ZNSs5beginEv; std::string::begin(void)
    sub     esp, 4
    lea     eax, [ebp+var_34]
    lea     edx, [ebp+var_3C]
    mov     [esp+8], edx
    lea     edx, [ebp+var_38]
    mov     [esp+4], edx
    mov     [esp], eax
    call    _ZNK9__gnu_cxx17__normal_iteratorIPcSsEplERKi; __gnu_cxx::__normal_iterator<char *,std::string>::operator+(int const&)
    sub     esp, 4
    lea     eax, [ebp+var_30]
    mov     edx, [ebp+arg_4]
    mov     [esp+4], edx
    mov     [esp], eax; this
    call    __ZNSs5beginEv; std::string::begin(void)
    sub     esp, 4
    lea     eax, [ebp+var_3D]
    mov     [esp+0Ch], eax
    mov     eax, [ebp+var_34]
    mov     [esp+8], eax
    mov     eax, [ebp+var_30]
    mov     [esp+4], eax
    lea     eax, [ebp+var_44]
    mov     [esp], eax
    call    _ZNSsC2IN9__gnu_cxx17__normal_iteratorIPcSsEEEET_S4_RKSaIcE; std::string::string<__gnu_cxx::__normal_iterator<char *,std::string>>(__gnu_cxx::__normal_iterator<char *,std::string>,__gnu_cxx::__normal_iterator<char *,std::string>,std::allocator<char> const&)
    lea     eax, [ebp+var_3D]
    mov     [esp], eax
    call    __ZNSaIcED1Ev; std::allocator<char>::~allocator()
    lea     eax, [ebp+var_29]
    mov     [esp], eax
    call    __ZNSaIcEC1Ev; std::allocator<char>::allocator(void)
    lea     eax, [ebp+var_28]
    mov     edx, [ebp+arg_4]
    mov     [esp+4], edx
    mov     [esp], eax; this
    call    __ZNSs3endEv; std::string::end(void)
    sub     esp, 4
    mov     eax, [ebp+arg_8]
    mov     [esp], eax; this
    call    __ZNKSs6lengthEv; std::string::length(void)
    mov     [ebp+var_24], eax
    mov     dword ptr [esp+8], 0; unsigned int
    mov     eax, [ebp+arg_8]
    mov     [esp+4], eax; std::string *
    mov     eax, [ebp+arg_4]
    mov     [esp], eax; this
    call    __ZNKSs4findERKSsj; std::string::find(std::string const&,uint)
    mov     [ebp+var_1C], eax
    lea     eax, [ebp+var_18]
    mov     edx, [ebp+arg_4]
    mov     [esp+4], edx
    mov     [esp], eax; this
    call    __ZNSs5beginEv; std::string::begin(void)
    sub     esp, 4
    lea     eax, [ebp+var_20]
    lea     edx, [ebp+var_1C]
    mov     [esp+8], edx
    lea     edx, [ebp+var_18]
    mov     [esp+4], edx
    mov     [esp], eax
    call    _ZNK9__gnu_cxx17__normal_iteratorIPcSsEplERKi; __gnu_cxx::__normal_iterator<char *,std::string>::operator+(int const&)
    sub     esp, 4
    lea     eax, [ebp+var_14]
    lea     edx, [ebp+var_24]
    mov     [esp+8], edx
    lea     edx, [ebp+var_20]
    mov     [esp+4], edx
    mov     [esp], eax
    call    _ZNK9__gnu_cxx17__normal_iteratorIPcSsEplERKi; __gnu_cxx::__normal_iterator<char *,std::string>::operator+(int const&)
    sub     esp, 4
    lea     eax, [ebp+var_29]
    mov     [esp+0Ch], eax
    mov     eax, [ebp+var_28]
    mov     [esp+8], eax
    mov     eax, [ebp+var_14]
    mov     [esp+4], eax
    lea     eax, [ebp+var_48]
    mov     [esp], eax
    call    _ZNSsC2IN9__gnu_cxx17__normal_iteratorIPcSsEEEET_S4_RKSaIcE; std::string::string<__gnu_cxx::__normal_iterator<char *,std::string>>(__gnu_cxx::__normal_iterator<char *,std::string>,__gnu_cxx::__normal_iterator<char *,std::string>,std::allocator<char> const&)
    lea     eax, [ebp+var_29]
    mov     [esp], eax
    call    __ZNSaIcED1Ev; std::allocator<char>::~allocator()
    lea     eax, [ebp+var_C]
    mov     edx, [ebp+arg_C]
    mov     [esp+8], edx
    lea     edx, [ebp+var_44]
    mov     [esp+4], edx
    mov     [esp], eax; std::string *
    call    _ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_S8_; std::operator+<char>(std::string const&,std::string const&)
    sub     esp, 4
    lea     eax, [ebp+var_10]
    lea     edx, [ebp+var_48]
    mov     [esp+8], edx
    lea     edx, [ebp+var_C]
    mov     [esp+4], edx
    mov     [esp], eax; std::string *
    call    _ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_S8_; std::operator+<char>(std::string const&,std::string const&)
    sub     esp, 4
    lea     eax, [ebp+var_10]
    mov     [esp+4], eax
    mov     eax, [ebp+arg_4]
    mov     [esp], eax
    call    __ZNSsaSERKSs; std::string::operator=(std::string const&)
    lea     eax, [ebp+var_10]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    lea     eax, [ebp+var_C]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    lea     eax, [ebp+var_48]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    lea     eax, [ebp+var_44]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
loc_80490FF:
    mov     dword ptr [esp+8], 0; unsigned int
    mov     eax, [ebp+arg_8]
    mov     [esp+4], eax; std::string *
    mov     eax, [ebp+arg_4]
    mov     [esp], eax; this
    call    __ZNKSs4findERKSsj; std::string::find(std::string const&,uint)
    cmp     eax, 0FFFFFFFFh
    setnz   al
    test    al, al
    jnz     loc_8048F2D
    mov     eax, [ebp+arg_4]
    mov     [esp+4], eax; std::string *
    mov     eax, [ebp+arg_0]
    mov     [esp], eax; this
    call    __ZNSsC1ERKSs; std::string::string(std::string const&)
    jmp     short loc_80491A5
    mov     ebx, eax
    lea     eax, [ebp+var_3D]
    mov     [esp], eax
    call    __ZNSaIcED1Ev; std::allocator<char>::~allocator()
    mov     eax, ebx
    mov     [esp], eax
    call    __Unwind_Resume
    mov     ebx, eax
    lea     eax, [ebp+var_29]
    mov     [esp], eax
    call    __ZNSaIcED1Ev; std::allocator<char>::~allocator()
    jmp     short loc_8049190
    mov     ebx, eax
    lea     eax, [ebp+var_10]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    jmp     short loc_8049172
    mov     ebx, eax
loc_8049172:
    lea     eax, [ebp+var_C]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    jmp     short loc_8049181
    mov     ebx, eax
loc_8049181:
    lea     eax, [ebp+var_48]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    jmp     short loc_8049190
    mov     ebx, eax
loc_8049190:
    lea     eax, [ebp+var_44]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    mov     eax, ebx
    mov     [esp], eax
    call    __Unwind_Resume
loc_80491A5:
    mov     eax, [ebp+arg_0]
    mov     ebx, [ebp+var_4]
    leave
    retn    4
replace endp

