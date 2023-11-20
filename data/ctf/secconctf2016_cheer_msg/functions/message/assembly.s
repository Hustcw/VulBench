message proc
    push    ebp
    mov     ebp, esp
    sub     esp, 68h
    mov     eax, [ebp+arg_0]
    mov     [ebp+s], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     dword ptr [esp], offset aMessage; "Message >> "
    call    _printf
    mov     eax, [ebp+n]
    mov     [esp+4], eax; n
    mov     eax, [ebp+s]
    mov     [esp], eax; s
    call    getnline
    mov     dword ptr [esp], offset aOopsIForgotToA; "\nOops! I forgot to ask your name...\nC"...
    call    _printf
    mov     dword ptr [esp+4], 40h ; '@'; n
    lea     eax, [ebp+var_4C]
    mov     [esp], eax; s
    call    getnline
    mov     eax, [ebp+s]
    mov     [esp+8], eax
    lea     eax, [ebp+var_4C]
    mov     [esp+4], eax
    mov     dword ptr [esp], offset aThankYouSMessa; "\nThank you %s!\nMessage : %s\n"
    call    _printf
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_80486BB
    call    ___stack_chk_fail
locret_80486BB:
    leave
    retn
message endp

