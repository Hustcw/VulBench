addNote proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+i], 0
    jmp     short loc_D97
loc_D76:
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, notes
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_D9F
    add     [rbp+i], 1
loc_D97:
    cmp     [rbp+i], 0Eh
    jle     short loc_D76
    jmp     short loc_DA0
loc_D9F:
    nop
loc_DA0:
    cmp     [rbp+i], 0Fh
    jnz     short loc_DBC
    mov     esi, 1; newline
    lea     rdi, aFull; "full!"
    call    myputs
    jmp     locret_EB3
loc_DBC:
    mov     edi, 10h; size
    call    _malloc
    mov     rcx, rax
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, notes
    mov     [rdx+rax], rcx
    mov     esi, 0; newline
    lea     rdi, aSizeOfYourNote; "size of your note >>"
    call    myputs
    mov     eax, 0
    call    getNumber
    mov     [rbp+size], eax
    cmp     [rbp+size], 18h
    jg      short loc_E10
    cmp     [rbp+size], 0
    js      short loc_E10
    mov     eax, [rbp+size]
    jmp     short loc_E15
loc_E10:
    mov     eax, 18h
loc_E15:
    mov     [rbp+size], eax
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, notes
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_E50
    mov     esi, 1; newline
    lea     rdi, aErrorInMallocN; "error in malloc note"
    call    myputs
    mov     edi, 0; status
    call    _exit
loc_E50:
    mov     esi, 0; newline
    lea     rdi, aInputYourConte; "input your content >>"
    call    myputs
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, notes
    mov     rax, [rdx+rax]
    mov     edx, [rbp+size]
    mov     esi, edx; size
    mov     rdi, rax; buf
    call    getContent
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, states
    mov     dword ptr [rdx+rax], 1
    mov     esi, 1; newline
    lea     rdi, aSuccess; "success"
    call    myputs
    nop
locret_EB3:
    leave
    retn
addNote endp

