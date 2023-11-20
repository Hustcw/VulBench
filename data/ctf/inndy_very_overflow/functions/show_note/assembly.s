show_note proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     dword ptr [esp], offset aWhichNoteToSho; "Which note to show: "
    call    _printf
    call    read_integer
    mov     [ebp+id], eax
    mov     eax, [ebp+id]
    mov     [esp+4], eax; id
    mov     eax, [ebp+node]
    mov     [esp], eax; node
    call    find_node_by_id
    mov     [ebp+node], eax
    cmp     [ebp+node], 0
    jnz     short loc_804879C
    jmp     short locret_80487AE
loc_804879C:
    mov     eax, [ebp+id]
    mov     [esp+4], eax; id
    mov     eax, [ebp+node]
    mov     [esp], eax; node
    call    print_note
locret_80487AE:
    leave
    retn
show_note endp

