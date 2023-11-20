readpost proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 0Ch
    push    offset aIndex; "Index?"
    call    _puts
    add     esp, 10h
    mov     eax, ds:stdin@@GLIBC_2_0
    sub     esp, 4
    push    eax
    push    8
    lea     eax, [ebp+var_14]
    push    eax
    call    readline
    add     esp, 10h
    sub     esp, 4
    lea     eax, [ebp+var_1C]
    push    eax
    push    offset aD; "%d"
    lea     eax, [ebp+var_14]
    push    eax
    call    ___isoc99_sscanf
    add     esp, 10h
    mov     edx, [ebp+var_1C]
    mov     eax, ds:numposts
    cmp     edx, eax
    jge     short loc_8048A33
    mov     eax, [ebp+var_1C]
    test    eax, eax
    jns     short loc_8048A45
loc_8048A33:
    sub     esp, 0Ch
    push    offset aInvalidIndex; "Invalid index!"
    call    _puts
    add     esp, 10h
    jmp     short loc_8048A98
loc_8048A45:
    mov     eax, [ebp+var_1C]
    mov     eax, ds:posts[eax*4]
    mov     [ebp+var_18], eax
    mov     eax, ds:isadmin
    test    eax, eax
    jnz     short loc_8048A76
    mov     eax, [ebp+var_18]
    mov     eax, [eax]
    test    eax, eax
    jz      short loc_8048A76
    sub     esp, 0Ch
    push    offset aAdminOnly; "Admin only!"
    call    _puts
    add     esp, 10h
    jmp     short loc_8048A98
loc_8048A76:
    mov     eax, [ebp+var_18]
    lea     ecx, [eax+44h]
    mov     eax, [ebp+var_18]
    lea     edx, [eax+4]
    mov     eax, [ebp+var_18]
    add     eax, 24h ; '$'
    push    ecx
    push    edx
    push    eax
    push    offset aSBySS; "%s by %s:\n%s\n"
    call    _printf
    add     esp, 10h
loc_8048A98:
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_8048AA9
    call    ___stack_chk_fail
locret_8048AA9:
    leave
    retn
readpost endp

