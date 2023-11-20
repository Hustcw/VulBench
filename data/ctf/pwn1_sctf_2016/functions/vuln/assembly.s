vuln proc
    push    ebp
    mov     ebp, esp
    push    ebx
    sub     esp, 54h
    mov     dword ptr [esp], offset format; "Tell me something about yourself: "
    call    _printf
    mov     eax, ds:_edata
    mov     [esp+8], eax; stream
    mov     dword ptr [esp+4], 20h ; ' '; n
    lea     eax, [ebp+s]
    mov     [esp], eax; s
    call    _fgets
    lea     eax, [ebp+s]
    mov     [esp+4], eax
    mov     dword ptr [esp], offset input
    call    __ZNSsaSEPKc; std::string::operator=(char const*)
    lea     eax, [ebp+var_11]
    mov     [esp], eax
    call    __ZNSaIcEC1Ev; std::allocator<char>::allocator(void)
    lea     eax, [ebp+var_11]
    mov     [esp+8], eax
    mov     dword ptr [esp+4], offset aYou; "you"
    lea     eax, [ebp+var_18]
    mov     [esp], eax
    call    __ZNSsC1EPKcRKSaIcE; std::string::string(char const*,std::allocator<char> const&)
    lea     eax, [ebp+var_9]
    mov     [esp], eax
    call    __ZNSaIcEC1Ev; std::allocator<char>::allocator(void)
    lea     eax, [ebp+var_9]
    mov     [esp+8], eax
    mov     dword ptr [esp+4], offset aI; "I"
    lea     eax, [ebp+var_10]
    mov     [esp], eax
    call    __ZNSsC1EPKcRKSaIcE; std::string::string(char const*,std::allocator<char> const&)
    lea     eax, [ebp+var_1C]
    lea     edx, [ebp+var_18]
    mov     [esp+0Ch], edx
    lea     edx, [ebp+var_10]
    mov     [esp+8], edx
    mov     dword ptr [esp+4], offset input
    mov     [esp], eax; std::string *
    call    replace
    sub     esp, 4
    lea     eax, [ebp+var_1C]
    mov     [esp+4], eax
    mov     dword ptr [esp], offset input
    call    __ZNSsaSERKSs; std::string::operator=(std::string const&)
    lea     eax, [ebp+var_1C]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    lea     eax, [ebp+var_10]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    lea     eax, [ebp+var_9]
    mov     [esp], eax
    call    __ZNSaIcED1Ev; std::allocator<char>::~allocator()
    lea     eax, [ebp+var_18]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    lea     eax, [ebp+var_11]
    mov     [esp], eax
    call    __ZNSaIcED1Ev; std::allocator<char>::~allocator()
    mov     dword ptr [esp], offset input; this
    call    __ZNKSs5c_strEv; std::string::c_str(void)
    mov     [esp+4], eax; src
    lea     eax, [ebp+s]
    mov     [esp], eax; dest
    call    _strcpy
    lea     eax, [ebp+s]
    mov     [esp+4], eax
    mov     dword ptr [esp], offset aSoS; "So, %s\n"
    call    _printf
    jmp     short loc_8049328
    mov     ebx, eax
    lea     eax, [ebp+var_1C]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    jmp     short loc_80492EA
    mov     ebx, eax
loc_80492EA:
    lea     eax, [ebp+var_10]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    jmp     short loc_80492F9
    mov     ebx, eax
loc_80492F9:
    lea     eax, [ebp+var_9]
    mov     [esp], eax
    call    __ZNSaIcED1Ev; std::allocator<char>::~allocator()
    lea     eax, [ebp+var_18]
    mov     [esp], eax; void *
    call    __ZNSsD1Ev; std::string::~string()
    jmp     short loc_8049313
    mov     ebx, eax
loc_8049313:
    lea     eax, [ebp+var_11]
    mov     [esp], eax
    call    __ZNSaIcED1Ev; std::allocator<char>::~allocator()
    mov     eax, ebx
    mov     [esp], eax
    call    __Unwind_Resume
loc_8049328:
    mov     ebx, [ebp+var_4]
    leave
    retn
vuln endp

