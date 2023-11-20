print_note proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, [ebp+id]
    mov     [esp+4], eax
    mov     dword ptr [esp], offset aNoteIdD; "Note id  : %d\n"
    call    _printf
    mov     eax, [ebp+node]
    mov     eax, [eax]
    mov     [esp+4], eax
    mov     dword ptr [esp], offset aNextNoteP; "Next note: %p\n"
    call    _printf
    mov     eax, [ebp+node]
    add     eax, 4
    mov     [esp+4], eax
    mov     dword ptr [esp], offset aNoteDataS; "Note data: %s\n"
    call    _printf
    mov     dword ptr [esp], offset asc_8048A91; "----------------"
    call    _puts
    leave
    retn
print_note endp

