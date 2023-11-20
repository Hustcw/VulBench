insert proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+name], rdi
    mov     [rbp+size], rsi
    mov     [rbp+desc], rdx
    mov     [rbp+idx], ecx
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rdx, [rbp+size]
    mov     [rax+50h], rdx
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rdx, [rbp+desc]
    mov     [rax+58h], rdx
    lea     rax, table
    mov     edx, [rbp+idx]
    movsxd  rdx, edx
    mov     rax, [rax+rdx*8]
    mov     rdx, rax
    mov     rax, [rbp+name]
    mov     rsi, rax; src
    mov     rdi, rdx; dest
    call    strcpy
    mov     eax, 0
    leave
    retn
insert endp

