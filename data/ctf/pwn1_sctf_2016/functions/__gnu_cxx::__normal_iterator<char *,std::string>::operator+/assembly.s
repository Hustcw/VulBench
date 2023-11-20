__gnu_cxx::__normal_iterator<char *,std::string>::operator+ proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, [ebp+arg_4]
    mov     edx, [eax]
    mov     eax, [ebp+arg_8]
    mov     eax, [eax]
    add     eax, edx
    mov     [ebp+var_C], eax
    lea     eax, [ebp+var_C]
    mov     [esp+4], eax
    mov     eax, [ebp+arg_0]
    mov     [esp], eax
    call    _ZN9__gnu_cxx17__normal_iteratorIPcSsEC2ERKS1_; __gnu_cxx::__normal_iterator<char *,std::string>::__normal_iterator(char * const&)
    mov     eax, [ebp+arg_0]
    leave
    retn    4
__gnu_cxx::__normal_iterator<char *,std::string>::operator+ endp

