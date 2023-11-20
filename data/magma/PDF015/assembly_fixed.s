EmbFile::save2(_IO_FILE *) proc
    push    rbp
    push    r14
    push    rbx
    mov     r14, f
    mov     rbx, this
    add     this, 28h ; '('
    mov     rdi, rbx; this
    call    _ZNK6Object8isStreamEv; Object::isStream(void)
    test    al, al
    jz      short loc_429C4E
    mov     rdi, rbx; this
    call    _ZN6Object11streamResetEv; Object::streamReset(void)
    mov     rdi, rbx; this
    call    _ZN6Object13streamGetCharEv; Object::streamGetChar(void)
    mov     bpl, 1
    cmp     eax, 0FFFFFFFFh
    jz      short loc_429C47
    nop     word ptr [c+c+00000000h]
    nop     dword ptr [c+00h]
loc_429C30:
    mov     edi, eax; c
    mov     rsi, f; stream
    call    _fputc
    mov     rdi, rbx; this
    call    _ZN6Object13streamGetCharEv; Object::streamGetChar(void)
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_429C30
loc_429C47:
    mov     eax, ebp
    pop     rbx
    pop     f
    pop     rbp
    retn
loc_429C4E:
    xor     ebp, ebp
    jmp     short loc_429C47
EmbFile::save2(_IO_FILE *) endp

