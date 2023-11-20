sub_11E5 proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:stdin
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stdout
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     rax, cs:stderr
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setbuf
    mov     edi, 1000h; size
    call    _malloc
    mov     cs:qword_4058, rax
    mov     rax, cs:qword_4058
    test    rax, rax
    jnz     short loc_1258
    lea     rdi, s; "What?"
    call    _puts
    mov     edi, 0FFFFFFFFh; status
    call    _exit
loc_1258:
    mov     rax, cs:qword_4058
    and     rax, 0FFFFFFFFFFFFF000h
    mov     cs:qword_4050, rax
    mov     edx, 100h; n
    mov     esi, 0; c
    lea     rdi, unk_4060; s
    call    _memset
    mov     edi, 1Eh; seconds
    call    _alarm
    nop
    pop     rbp
    retn
sub_11E5 endp

