encrypt proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 48h
    lea     rdx, [rbp+s]
    mov     eax, 0
    mov     ecx, 6
    mov     rdi, rdx
    rep stosq
    mov     rdx, rdi
    mov     [rdx], ax
    add     rdx, 2
    mov     edi, offset aInputYourPlain; "Input your Plaintext to be encrypted"
    call    _puts
    lea     rax, [rbp+s]
    mov     rdi, rax
    mov     eax, 0
    call    _gets
    jmp     loc_400AB4
loc_4009E7:
    mov     eax, cs:x
    mov     eax, eax
    movzx   eax, [rbp+rax+s]
    cmp     al, 60h ; '`'
    jle     short loc_400A27
    mov     eax, cs:x
    mov     eax, eax
    movzx   eax, [rbp+rax+s]
    cmp     al, 7Ah ; 'z'
    jg      short loc_400A27
    mov     eax, cs:x
    mov     edx, cs:x
    mov     edx, edx
    movzx   edx, [rbp+rdx+s]
    xor     edx, 0Dh
    mov     eax, eax
    mov     [rbp+rax+s], dl
    jmp     short loc_400AA5
loc_400A27:
    mov     eax, cs:x
    mov     eax, eax
    movzx   eax, [rbp+rax+s]
    cmp     al, 40h ; '@'
    jle     short loc_400A67
    mov     eax, cs:x
    mov     eax, eax
    movzx   eax, [rbp+rax+s]
    cmp     al, 5Ah ; 'Z'
    jg      short loc_400A67
    mov     eax, cs:x
    mov     edx, cs:x
    mov     edx, edx
    movzx   edx, [rbp+rdx+s]
    xor     edx, 0Eh
    mov     eax, eax
    mov     [rbp+rax+s], dl
    jmp     short loc_400AA5
loc_400A67:
    mov     eax, cs:x
    mov     eax, eax
    movzx   eax, [rbp+rax+s]
    cmp     al, 2Fh ; '/'
    jle     short loc_400AA5
    mov     eax, cs:x
    mov     eax, eax
    movzx   eax, [rbp+rax+s]
    cmp     al, 39h ; '9'
    jg      short loc_400AA5
    mov     eax, cs:x
    mov     edx, cs:x
    mov     edx, edx
    movzx   edx, [rbp+rdx+s]
    xor     edx, 0Fh
    mov     eax, eax
    mov     [rbp+rax+s], dl
loc_400AA5:
    mov     eax, cs:x
    add     eax, 1
    mov     cs:x, eax
loc_400AB4:
    mov     eax, cs:x
    mov     ebx, eax
    lea     rax, [rbp+s]
    mov     rdi, rax; s
    call    _strlen
    cmp     rbx, rax
    jb      loc_4009E7
    mov     edi, offset aCiphertext; "Ciphertext"
    call    _puts
    lea     rax, [rbp+s]
    mov     rdi, rax; s
    call    _puts
    nop
    add     rsp, 48h
    pop     rbx
    pop     rbp
    retn
encrypt endp

