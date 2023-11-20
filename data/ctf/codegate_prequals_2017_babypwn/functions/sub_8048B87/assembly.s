sub_8048B87 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 138h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     [ebp+var_124], offset sub_804880D
    lea     eax, [ebp+var_124]
    add     eax, 4
    mov     [esp], eax; set
    call    _sigemptyset
    mov     [ebp+var_A0], 0
    mov     eax, [ebp+var_A0]
    or      eax, 20000000h
    mov     [ebp+var_A0], eax
    lea     eax, [ebp+var_98]
    mov     [esp+8], eax; oact
    lea     eax, [ebp+var_124]
    mov     [esp+4], eax; act
    mov     dword ptr [esp], 0Eh; sig
    call    _sigaction
    test    eax, eax
    jns     short loc_8048C0D
    mov     dword ptr [esp], offset s; "[!] Sigaction Error!"
    call    _perror
    mov     dword ptr [esp], 0; status
    call    _exit
loc_8048C0D:
    mov     dword ptr [esp], 5; seconds
    call    _alarm
    call    sub_8048851
    call    sub_8048A71
    call    sub_8048881
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_8048C39
    call    ___stack_chk_fail
locret_8048C39:
    leave
    retn
sub_8048B87 endp

