edit_note proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     dword ptr [esp], offset aWhichNoteToEdi; "Which note to edit: "
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
    jnz     short loc_80486DA
    jmp     short locret_8048711
loc_80486DA:
    mov     dword ptr [esp], offset aYourNewData; "Your new data: "
    call    _printf
    mov     eax, ds:stdin@@GLIBC_2_0
    mov     edx, [ebp+node]
    add     edx, 4
    mov     [esp+8], eax; stream
    mov     dword ptr [esp+4], 80h; n
    mov     [esp], edx; s
    call    _fgets
    mov     dword ptr [esp], offset s; "Done!"
    call    _puts
locret_8048711:
    leave
    retn
edit_note endp

