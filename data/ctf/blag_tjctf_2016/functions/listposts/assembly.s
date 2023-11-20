listposts proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     [ebp+var_14], 0
    jmp     short loc_80489B3
loc_8048984:
    mov     eax, [ebp+var_14]
    mov     eax, ds:posts[eax*4]
    mov     [ebp+var_10], eax
    mov     eax, [ebp+var_10]
    lea     edx, [eax+4]
    mov     eax, [ebp+var_10]
    add     eax, 24h ; '$'
    push    edx
    push    eax
    push    [ebp+var_14]
    push    offset format; "Post #%d: %s by %s\n"
    call    _printf
    add     esp, 10h
    add     [ebp+var_14], 1
loc_80489B3:
    mov     eax, ds:numposts
    cmp     [ebp+var_14], eax
    jl      short loc_8048984
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_80489CE
    call    ___stack_chk_fail
locret_80489CE:
    leave
    retn
listposts endp

