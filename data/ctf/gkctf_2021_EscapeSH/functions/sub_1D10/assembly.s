sub_1D10 proc
    push    rbx
    lea     rbx, qword_204040
    xor     esi, esi; type
    mov     rdi, [rbx+8]; name
    call    access
    test    eax, eax
    jz      short loc_1D40
    mov     rdi, [rbx+8]; path
    mov     esi, 1FFh; mode
    call    mkdir
    cmp     eax, 0FFFFFFFFh
    jz      short loc_1D50
    pop     rbx
    retn
loc_1D40:
    pop     rbx
    lea     rdi, aTheDirHadExist; "the dir had exist!"
    jmp     puts
loc_1D50:
    pop     rbx
    lea     rdi, aMkdirError; "mkdir error"
    jmp     puts
sub_1D10 endp

