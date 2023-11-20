malloc_wrapper proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     dword ptr [rbp+size], edi
    cmp     dword ptr [rbp+size], 400h
    jbe     short loc_1235
    mov     eax, 0
    jmp     short locret_1240
loc_1235:
    mov     eax, dword ptr [rbp+size]
    mov     rdi, rax; size
    call    _malloc
locret_1240:
    leave
    retn
malloc_wrapper endp

