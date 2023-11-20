find_node_by_id proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     eax, [ebp+id]
    mov     [ebp+n], eax
    jmp     short loc_80485D2
loc_80485CA:
    mov     eax, [ebp+node]
    mov     eax, [eax]
    mov     [ebp+node], eax
loc_80485D2:
    mov     eax, [ebp+node]
    mov     eax, [eax]
    test    eax, eax
    jz      short loc_80485E8
    mov     eax, [ebp+n]
    lea     edx, [eax-1]
    mov     [ebp+n], edx
    test    eax, eax
    jg      short loc_80485CA
loc_80485E8:
    cmp     [ebp+n], 0
    jle     short loc_8048608
    mov     eax, [ebp+id]
    mov     [esp+4], eax
    mov     dword ptr [esp], offset format; "Can not found note with id %d\n"
    call    _printf
    mov     eax, 0
    jmp     short locret_804860B
loc_8048608:
    mov     eax, [ebp+node]
locret_804860B:
    leave
    retn
find_node_by_id endp

