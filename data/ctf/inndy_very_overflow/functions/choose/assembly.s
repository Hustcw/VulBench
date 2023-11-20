choose proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     dword ptr [esp], offset a1AddNote; "1) add note"
    call    _puts
    mov     dword ptr [esp], offset a2EditNote; "2) edit note"
    call    _puts
    mov     dword ptr [esp], offset a3ShowNote; "3) show note"
    call    _puts
    mov     dword ptr [esp], offset a4DumpNotes; "4) dump notes"
    call    _puts
    mov     dword ptr [esp], offset a5Exit; "5) exit"
    call    _puts
    mov     dword ptr [esp], offset aYourAction; "Your action: "
    call    _printf
    call    read_integer
    leave
    retn
choose endp

