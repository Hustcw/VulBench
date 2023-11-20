main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     [rbp+var_4], edi
    mov     [rbp+var_10], rsi
    mov     rax, [rbp+var_10]
    mov     rax, [rax]
    mov     rdi, rax
    call    sub_400B35
    call    sub_400B5C
    lea     rdi, format; "Put the code: "
    mov     eax, 0
    call    _printf
    mov     esi, 400h
    lea     rdi, byte_6024E0
    call    sub_400C37
    mov     cs:byte_6024C1, 0
    jmp     loc_400AFE
loc_400898:
    mov     cs:byte_6028E0, 0
    movzx   eax, cs:byte_6028E1
    cmp     al, 3Eh ; '>'
    jnz     short loc_4008BA
    movzx   eax, cs:byte_6024C0
    add     eax, 1
    mov     cs:byte_6024C0, al
loc_4008BA:
    movzx   eax, cs:byte_6028E1
    cmp     al, 3Ch ; '<'
    jnz     short loc_4008D5
    movzx   eax, cs:byte_6024C0
    sub     eax, 1
    mov     cs:byte_6024C0, al
loc_4008D5:
    movzx   eax, cs:byte_6028E1
    cmp     al, 2Bh ; '+'
    jnz     short loc_40090A
    movzx   eax, cs:byte_6024C0
    movsx   eax, al
    movsxd  rcx, eax
    lea     rdx, byte_6020C0
    movzx   edx, byte ptr [rcx+rdx]
    add     edx, 1
    mov     ecx, edx
    movsxd  rdx, eax
    lea     rax, byte_6020C0
    mov     [rdx+rax], cl
loc_40090A:
    movzx   eax, cs:byte_6028E1
    cmp     al, 2Dh ; '-'
    jnz     short loc_40093F
    movzx   eax, cs:byte_6024C0
    movsx   eax, al
    movsxd  rcx, eax
    lea     rdx, byte_6020C0
    movzx   edx, byte ptr [rcx+rdx]
    sub     edx, 1
    mov     ecx, edx
    movsxd  rdx, eax
    lea     rax, byte_6020C0
    mov     [rdx+rax], cl
loc_40093F:
    movzx   eax, cs:byte_6028E1
    cmp     al, 2Eh ; '.'
    jnz     short loc_400976
    mov     rdx, cs:stdout
    movzx   eax, cs:byte_6024C0
    movsx   eax, al
    movsxd  rcx, eax
    lea     rax, byte_6020C0
    movzx   eax, byte ptr [rcx+rax]
    movsx   eax, al
    mov     rsi, rdx; fp
    mov     edi, eax; c
    call    __IO_putc
loc_400976:
    movzx   eax, cs:byte_6028E1
    cmp     al, 2Ch ; ','
    jnz     loc_400A1E
    movzx   eax, cs:byte_6024C0
    movsx   eax, al
    movsxd  rdx, eax
    lea     rax, byte_6020C0
    add     rax, rdx
    mov     edx, 1; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    jmp     short loc_400A1E
loc_4009B0:
    movzx   eax, cs:byte_6024C1
    movsx   eax, al
    movsxd  rdx, eax
    lea     rax, byte_6024E0
    movzx   eax, byte ptr [rdx+rax]
    cmp     al, 5Bh ; '['
    jnz     short loc_4009DC
    movzx   eax, cs:byte_6028E0
    add     eax, 1
    mov     cs:byte_6028E0, al
loc_4009DC:
    movzx   eax, cs:byte_6024C1
    movsx   eax, al
    movsxd  rdx, eax
    lea     rax, byte_6024E0
    movzx   eax, byte ptr [rdx+rax]
    cmp     al, 5Dh ; ']'
    jnz     short loc_400A0E
    movzx   eax, cs:byte_6028E0
    mov     edx, eax
    sub     edx, 1
    mov     cs:byte_6028E0, dl
    cmp     al, 1
    jz      short loc_400A4F
loc_400A0E:
    movzx   eax, cs:byte_6024C1
    add     eax, 1
    mov     cs:byte_6024C1, al
loc_400A1E:
    movzx   eax, cs:byte_6028E1
    cmp     al, 5Bh ; '['
    jnz     loc_400AC0
    movzx   eax, cs:byte_6024C0
    movsx   eax, al
    movsxd  rdx, eax
    lea     rax, byte_6020C0
    movzx   eax, byte ptr [rdx+rax]
    test    al, al
    jz      loc_4009B0
    jmp     short loc_400AC0
loc_400A4F:
    nop
    jmp     short loc_400AC0
loc_400A52:
    movzx   eax, cs:byte_6024C1
    movsx   eax, al
    movsxd  rdx, eax
    lea     rax, byte_6024E0
    movzx   eax, byte ptr [rdx+rax]
    cmp     al, 5Dh ; ']'
    jnz     short loc_400A7E
    movzx   eax, cs:byte_6028E0
    add     eax, 1
    mov     cs:byte_6028E0, al
loc_400A7E:
    movzx   eax, cs:byte_6024C1
    movsx   eax, al
    movsxd  rdx, eax
    lea     rax, byte_6024E0
    movzx   eax, byte ptr [rdx+rax]
    cmp     al, 5Bh ; '['
    jnz     short loc_400AB0
    movzx   eax, cs:byte_6028E0
    mov     edx, eax
    sub     edx, 1
    mov     cs:byte_6028E0, dl
    cmp     al, 1
    jz      short loc_400AED
loc_400AB0:
    movzx   eax, cs:byte_6024C1
    sub     eax, 1
    mov     cs:byte_6024C1, al
loc_400AC0:
    movzx   eax, cs:byte_6028E1
    cmp     al, 5Dh ; ']'
    jnz     short loc_400AEE
    movzx   eax, cs:byte_6024C0
    movsx   eax, al
    movsxd  rdx, eax
    lea     rax, byte_6020C0
    movzx   eax, byte ptr [rdx+rax]
    test    al, al
    jnz     loc_400A52
    jmp     short loc_400AEE
loc_400AED:
    nop
loc_400AEE:
    movzx   eax, cs:byte_6024C1
    add     eax, 1
    mov     cs:byte_6024C1, al
loc_400AFE:
    movzx   eax, cs:byte_6024C1
    movsx   eax, al
    movsxd  rdx, eax
    lea     rax, byte_6024E0
    movzx   eax, byte ptr [rdx+rax]
    mov     cs:byte_6028E1, al
    movzx   eax, cs:byte_6028E1
    test    al, al
    jnz     loc_400898
    mov     edi, 1; status
    call    _exit
main endp

