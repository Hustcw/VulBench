add_note proc
    push    ebp
    mov     ebp, esp
    sub     esp, 28h
    mov     [ebp+id], 0
    jmp     short loc_8048628
loc_804861C:
    mov     eax, [ebp+node]
    mov     eax, [eax]
    mov     [ebp+node], eax
    add     [ebp+id], 1
loc_8048628:
    mov     eax, [ebp+node]
    mov     eax, [eax]
    test    eax, eax
    jz      short loc_804863C
    mov     eax, [ebp+node]
    movzx   eax, byte ptr [eax+4]
    test    al, al
    jnz     short loc_804861C
loc_804863C:
    mov     dword ptr [esp], offset aInputYourNote; "Input your note: "
    call    _printf
    mov     eax, ds:stdin@@GLIBC_2_0
    mov     edx, [ebp+node]
    add     edx, 4
    mov     [esp+8], eax; stream
    mov     dword ptr [esp+4], 80h; n
    mov     [esp], edx; s
    call    _fgets
    mov     eax, [ebp+node]
    add     eax, 4
    mov     [esp], eax; s
    call    _strlen
    lea     edx, [eax+1]
    mov     eax, [ebp+node]
    add     eax, edx
    lea     edx, [eax+4]
    mov     eax, [ebp+node]
    mov     [eax], edx
    mov     eax, [ebp+node]
    mov     eax, [eax]
    mov     byte ptr [eax+4], 0
    mov     eax, [ebp+id]
    mov     [esp+4], eax
    mov     dword ptr [esp], offset aOkYourNoteIdIs; "Ok! Your note id is %d\n"
    call    _printf
    leave
    retn
add_note endp

