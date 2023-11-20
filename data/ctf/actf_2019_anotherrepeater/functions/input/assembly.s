input proc
    push    ebp
    mov     ebp, esp
    push    edi
    push    esi
    push    ebx
    sub     esp, 41Ch
    mov     [ebp+buf], 3F3F3Fh
    lea     eax, [ebp+var_417]
    mov     ecx, 3FDh
    mov     ebx, 0
    mov     [eax], ebx
    mov     [eax+ecx-4], ebx
    lea     edx, [eax+4]
    and     edx, 0FFFFFFFCh
    sub     eax, edx
    add     ecx, eax
    and     ecx, 0FFFFFFFCh
    shr     ecx, 2
    mov     edi, edx
    mov     eax, ebx
    rep stosd
    sub     esp, 8
    lea     eax, [ebp+var_41E]
    push    eax
    push    offset aHd; "%hd"
    call    ___isoc99_scanf
    add     esp, 10h
    movzx   eax, [ebp+var_41E]
    cmp     ax, 400h
    jle     short loc_804870F
    sub     esp, 0Ch
    push    offset aNoWayYouCanTRe; "No way, you can't repeat so many chars!"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_804870F:
    movzx   eax, [ebp+var_41E]
    mov     [ebp+var_1A], ax
    movzx   eax, [ebp+var_1A]
    sub     esp, 4
    push    eax
    lea     eax, [ebp+buf]
    push    eax
    push    offset format; "%x %u\n"
    call    _printf
    add     esp, 10h
    movzx   eax, [ebp+var_1A]
    sub     esp, 4
    push    eax; nbytes
    lea     eax, [ebp+buf]
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    mov     edx, offset str; "WTF?"
    lea     eax, [ebp+buf]
    mov     ecx, 100h
    mov     edi, edx
    mov     esi, eax
    rep movsd
    mov     eax, esi
    mov     edx, edi
    movzx   ecx, byte ptr [eax]
    mov     [edx], cl
    lea     edx, [edx+1]
    lea     eax, [eax+1]
    nop
    lea     esp, [ebp-0Ch]
    pop     ebx
    pop     esi
    pop     edi
    pop     ebp
    retn
input endp

