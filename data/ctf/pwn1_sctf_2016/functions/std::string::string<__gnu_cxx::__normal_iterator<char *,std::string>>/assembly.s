std::string::string<__gnu_cxx::__normal_iterator<char *,std::string>> proc
    push    ebp; Alternative name is 'std::string::string<__gnu_cxx::__normal_iterator<char *, std::string>>(__gnu_cxx::__normal_iterator<char *, std::string>, __gnu_cxx::__normal_iterator<char *, std::string>, std::allocator<char> const&)'
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, [ebp+arg_C]
    mov     [esp+8], eax
    mov     eax, [ebp+arg_8]
    mov     [esp+4], eax
    mov     eax, [ebp+arg_4]
    mov     [esp], eax
    call    _ZNSs12_S_constructIN9__gnu_cxx17__normal_iteratorIPcSsEEEES2_T_S4_RKSaIcE; std::string::_S_construct<__gnu_cxx::__normal_iterator<char *,std::string>>(__gnu_cxx::__normal_iterator<char *,std::string>,__gnu_cxx::__normal_iterator<char *,std::string>,std::allocator<char> const&)
    mov     edx, [ebp+arg_0]
    mov     ecx, [ebp+arg_C]
    mov     [esp+8], ecx
    mov     [esp+4], eax
    mov     [esp], edx
    call    __ZNSs12_Alloc_hiderC1EPcRKSaIcE; std::string::_Alloc_hider::_Alloc_hider(char *,std::allocator<char> const&)
    leave
    retn
std::string::string<__gnu_cxx::__normal_iterator<char *,std::string>> endp

