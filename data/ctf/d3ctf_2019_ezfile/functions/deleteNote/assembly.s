deleteNote proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     esi, 0; newline
    lea     rdi, aInputTheIndexT_0; "input the index to delete >>"
    call    myputs
    mov     eax, 0
    call    getNumber
    mov     [rbp+i], eax
    cmp     [rbp+i], 0
    js      short loc_EE7
    cmp     [rbp+i], 0Fh
    jle     short loc_EFA
loc_EE7:
    mov     esi, 1; newline
    lea     rdi, aOutOfIndex; "out of index"
    call    myputs
    jmp     short locret_F77
loc_EFA:
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, notes
    mov     rax, [rdx+rax]
    test    rax, rax
    jz      short loc_F65
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, notes
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    _free
    mov     eax, [rbp+i]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, states
    mov     dword ptr [rdx+rax], 0
    mov     esi, 1; newline
    lea     rdi, aComplete; "complete"
    call    myputs
    jmp     short locret_F77
loc_F65:
    mov     esi, 1; newline
    lea     rdi, aInUsing; "in using"
    call    myputs
    nop
locret_F77:
    leave
    retn
deleteNote endp

