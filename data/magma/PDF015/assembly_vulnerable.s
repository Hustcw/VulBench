EmbFile::save2(_IO_FILE *) proc
    push    r14
    push    rbx
    push    rax
    mov     r14, f
    mov     rbx, this
    add     this, 28h ; '('
    mov     rdi, rbx; this
    call    _ZN6Object11streamResetEv; Object::streamReset(void)
    nop     word ptr [rax+rax+00000000h]
loc_475BA0:
    mov     rdi, rbx; this
    call    _ZN6Object13streamGetCharEv; Object::streamGetChar(void)
    cmp     eax, 0FFFFFFFFh
    jz      short loc_475BB9
    mov     edi, eax; c
    mov     rsi, f; stream
    call    _fputc
    jmp     short loc_475BA0
loc_475BB9:
    mov     al, 1
    add     rsp, 8
    pop     rbx
    pop     f
    retn
EmbFile::save2(_IO_FILE *) endp

