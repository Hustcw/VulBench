dump_notes proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     [ebp+id], 0
    jmp     short loc_80487EB
loc_80487BF:
    mov     eax, [ebp+id]
    lea     edx, [eax+1]
    mov     [ebp+id], edx
    mov     [esp+4], eax; id
    mov     eax, [ebp+node]
    mov     [esp], eax; node
    call    print_note
    mov     dword ptr [esp], offset byte_8048AB7; s
    call    _puts
    mov     eax, [ebp+node]
    mov     eax, [eax]
    mov     [ebp+node], eax
loc_80487EB:
    cmp     [ebp+node], 0
    jz      short locret_80487FC
    mov     eax, [ebp+node]
    movzx   eax, byte ptr [eax+4]
    test    al, al
    jnz     short loc_80487BF
locret_80487FC:
    leave
    retn
dump_notes endp

