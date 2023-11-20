main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 424h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     eax, ds:stdout
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    mov     eax, ds:stdin
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    jmp     loc_80486F1
loc_8048615:
    sub     esp, 0Ch
    push    offset s; "I'm busy. Please leave your message:"
    call    _puts
    add     esp, 10h
    sub     esp, 4
    push    400h; nbytes
    lea     eax, [ebp+buf]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aWhichMessageSl; "Which message slot?"
    call    _puts
    add     esp, 10h
    sub     esp, 4
    push    10h; nbytes
    lea     eax, [ebp+nptr]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+nptr]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     [ebp+var_420], eax
    sub     esp, 0Ch
    lea     eax, [ebp+buf]
    push    eax; s
    call    _strlen
    add     esp, 10h
    cmp     eax, 8
    jbe     short loc_80486AA
    sub     esp, 0Ch
    push    offset aMessageTooLong; "Message too long, truncated."
    call    _puts
    add     esp, 10h
    mov     [ebp+var_404], 0
loc_80486AA:
    cmp     [ebp+var_420], 40h ; '@'
    jg      short loc_80486BE
    movzx   eax, [ebp+nptr]
    cmp     al, 2Dh ; '-'
    jnz     short loc_80486D0
loc_80486BE:
    sub     esp, 0Ch
    push    offset aOutOfBound; "Out of bound."
    call    _puts
    add     esp, 10h
    jmp     short loc_80486F1
loc_80486D0:
    sub     esp, 0Ch
    lea     eax, [ebp+buf]
    push    eax; s
    call    _strdup
    add     esp, 10h
    mov     edx, eax
    mov     eax, [ebp+var_420]
    mov     ds:dword_804A060[eax*4], edx
loc_80486F1:
    mov     eax, ds:dword_804A04C
    lea     edx, [eax+1]
    mov     ds:dword_804A04C, edx
    cmp     eax, 2
    jle     loc_8048615
    sub     esp, 0Ch
    push    offset aHereIsYourMess; "Here is your messages:"
    call    _puts
    add     esp, 10h
    mov     [ebp+var_424], 0
    jmp     short loc_8048760
loc_8048724:
    mov     eax, [ebp+var_424]
    mov     eax, ds:dword_804A060[eax*4]
    test    eax, eax
    jz      short loc_8048759
    mov     eax, [ebp+var_424]
    mov     eax, ds:dword_804A060[eax*4]
    sub     esp, 4
    push    eax
    push    [ebp+var_424]
    push    offset format; "%d: %s\n"
    call    _printf
    add     esp, 10h
loc_8048759:
    add     [ebp+var_424], 1
loc_8048760:
    cmp     [ebp+var_424], 3Fh ; '?'
    jle     short loc_8048724
    sub     esp, 0Ch
    push    offset aGoodbye; "Goodbye"
    call    _puts
    add     esp, 10h
    mov     eax, 0
    mov     ecx, [ebp+var_C]
    xor     ecx, large gs:14h
    jz      short loc_804878F
    call    ___stack_chk_fail
loc_804878F:
    mov     ecx, [ebp+var_4]
    leave
    lea     esp, [ecx-4]
    retn
main endp

