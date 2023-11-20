menu proc
    push    rbp
    mov     rbp, rsp
    mov     edx, 18h; n
    mov     esi, offset asc_4011C2; "***********************\n"
    mov     edi, 1; fd
    call    _write
    mov     edx, 0Fh; n
    mov     esi, offset a1AddNewNote; "1.Add new note\n"
    mov     edi, 1; fd
    call    _write
    mov     edx, 10h; n
    mov     esi, offset a2DeleteANote; "2.Delete a note\n"
    mov     edi, 1; fd
    call    _write
    mov     edx, 0Eh; n
    mov     esi, offset a3ShowANote; "3.Show a note\n"
    mov     edi, 1; fd
    call    _write
    mov     edx, 7; n
    mov     esi, offset a4Exit; "4.Exit\n"
    mov     edi, 1; fd
    call    _write
    mov     edx, 18h; n
    mov     esi, offset asc_4011C2; "***********************\n"
    mov     edi, 1; fd
    call    _write
    mov     edx, 0Dh; n
    mov     esi, offset aYourChoice; "Your choice: "
    mov     edi, 1; fd
    call    _write
    nop
    pop     rbp
    retn
menu endp

