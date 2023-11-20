doSomeThing proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+seed], rdi
    mov     [rbp+index], esi
    cmp     [rbp+index], 0Fh
    jg      loc_1055
    cmp     [rbp+index], 0
    js      loc_1055
    mov     eax, [rbp+index]
    cdqe
    lea     rdx, ds:0[rax*4]
    lea     rax, states
    mov     eax, [rdx+rax]
    test    eax, eax
    jz      loc_1055
    mov     eax, [rbp+index]
    movsxd  rdx, eax
    mov     rax, [rbp+seed]
    add     rax, rdx
    movzx   eax, byte ptr [rax]
    mov     [rbp+start], al
    mov     [rbp+i], 0
    jmp     short loc_103C
loc_FD7:
    mov     eax, [rbp+index]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, notes
    mov     rdx, [rdx+rax]
    mov     eax, [rbp+i]
    cdqe
    add     rax, rdx
    movzx   esi, byte ptr [rax]
    mov     rdx, cs:key
    movzx   ecx, [rbp+start]
    mov     eax, [rbp+i]
    add     eax, ecx
    cdqe
    add     rax, rdx
    movzx   ecx, byte ptr [rax]
    mov     eax, [rbp+index]
    cdqe
    lea     rdx, ds:0[rax*8]
    lea     rax, notes
    mov     rdx, [rdx+rax]
    mov     eax, [rbp+i]
    cdqe
    add     rax, rdx
    xor     esi, ecx
    mov     edx, esi
    mov     [rax], dl
    add     [rbp+i], 1
loc_103C:
    cmp     [rbp+i], 0Fh
    jle     short loc_FD7
    mov     esi, 1; newline
    lea     rdi, aSuccess; "success"
    call    myputs
    jmp     short locret_1056
loc_1055:
    nop
locret_1056:
    leave
    retn
doSomeThing endp

