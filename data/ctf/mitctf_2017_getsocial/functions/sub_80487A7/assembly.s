sub_80487A7 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, ds:dword_8049FB8
    mov     [ebp+var_C], eax
    mov     [ebp+var_10], 0
    mov     [ebp+var_14], 0
    jmp     short loc_80487FE
loc_80487C5:
    mov     eax, [ebp+var_C]
    mov     [ebp+var_10], eax
    mov     eax, [ebp+var_C]
    mov     eax, [eax+8Ch]
    mov     [ebp+var_C], eax
    add     [ebp+var_14], 1
    cmp     [ebp+var_14], 0F423Fh
    jbe     short loc_80487FE
    sub     esp, 0Ch
    push    offset aMemoryError; "[MEMORY ERROR]"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_80487FE:
    cmp     [ebp+var_C], 0
    jnz     short loc_80487C5
    sub     esp, 0Ch
    push    90h; size
    call    _malloc
    add     esp, 10h
    mov     [ebp+dest], eax
    mov     eax, [ebp+dest]
    sub     esp, 4
    push    8Ch; n
    push    [ebp+src]; src
    push    eax; dest
    call    _memcpy
    add     esp, 10h
    mov     eax, [ebp+dest]
    mov     byte ptr [eax+8Bh], 0
    mov     eax, [ebp+var_10]
    mov     edx, [ebp+dest]
    mov     [eax+8Ch], edx
    mov     eax, ds:dword_8049FB4
    add     eax, 1
    mov     ds:dword_8049FB4, eax
    leave
    retn
sub_80487A7 endp

