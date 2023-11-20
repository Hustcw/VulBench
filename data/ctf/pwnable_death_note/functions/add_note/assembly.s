add_note proc
    push    ebp
    mov     ebp, esp
    sub     esp, 68h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    sub     esp, 0Ch
    push    offset format; "Index :"
    call    _printf
    add     esp, 10h
    call    read_int
    mov     [ebp+var_60], eax
    cmp     [ebp+var_60], 0Ah
    jle     short loc_8048798
    sub     esp, 0Ch
    push    offset aOutOfBound; "Out of bound !!"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_8048798:
    sub     esp, 0Ch
    push    offset aName; "Name :"
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    50h ; 'P'; nbytes
    lea     eax, [ebp+s]
    push    eax; buf
    call    read_input
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+s]
    push    eax; s
    call    is_printable
    add     esp, 10h
    test    eax, eax
    jz      short loc_8048806
    sub     esp, 0Ch
    lea     eax, [ebp+s]
    push    eax; s
    call    _strdup
    add     esp, 10h
    mov     edx, eax
    mov     eax, [ebp+var_60]
    mov     ds:note[eax*4], edx
    sub     esp, 0Ch
    push    offset aDone; "Done !"
    call    _puts
    add     esp, 10h
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_8048825
    jmp     short loc_8048820
loc_8048806:
    sub     esp, 0Ch
    push    offset aItMustBeAPrint; "It must be a printable name !"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    0FFFFFFFFh; status
    call    _exit
loc_8048820:
    call    ___stack_chk_fail
locret_8048825:
    leave
    retn
add_note endp

