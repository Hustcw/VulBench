sub_E9E proc
    push    rbp
    mov     rbp, rsp
    mov     rax, cs:qword_202068
    cmp     rax, 0FFFFFFFFFFFFFFFFh
    jnz     short loc_EC0
    lea     rdi, aSelectADestina; "Select a destination first!"
    call    _puts
    jmp     loc_104B
loc_EC0:
    lea     rdi, aOkLetSGo; "OK, let's go!"
    call    _puts
    mov     rax, cs:qword_202068
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202080
    mov     rax, [rdx+rax]
    mov     rdi, rax; ptr
    call    _free
    mov     rax, cs:qword_202068
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202080
    mov     qword ptr [rdx+rax], 0
    mov     rax, cs:qword_202068
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202180
    mov     qword ptr [rdx+rax], 0
    mov     rdx, cs:qword_202060
    mov     rax, cs:qword_202068
    sub     rdx, rax
    mov     rax, rdx
    sub     rax, 1
    shl     rax, 3
    mov     rsi, rax
    mov     rax, cs:qword_202068
    add     rax, 1
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202080
    lea     rcx, [rdx+rax]
    mov     rax, cs:qword_202068
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202080
    add     rax, rdx
    mov     rdx, rsi; n
    mov     rsi, rcx; src
    mov     rdi, rax; dest
    call    _memcpy
    mov     rdx, cs:qword_202060
    mov     rax, cs:qword_202068
    sub     rdx, rax
    mov     rax, rdx
    sub     rax, 1
    shl     rax, 3
    mov     rsi, rax
    mov     rax, cs:qword_202068
    add     rax, 1
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202180
    lea     rcx, [rdx+rax]
    mov     rax, cs:qword_202068
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202180
    add     rax, rdx
    mov     rdx, rsi; n
    mov     rsi, rcx; src
    mov     rdi, rax; dest
    call    _memcpy
    mov     rax, cs:qword_202060
    sub     rax, 1
    mov     cs:qword_202060, rax
    mov     rax, cs:qword_202060
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202080
    mov     qword ptr [rdx+rax], 0
    mov     rax, cs:qword_202060
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202180
    mov     qword ptr [rdx+rax], 0
    mov     cs:qword_202068, 0FFFFFFFFFFFFFFFFh
loc_104B:
    pop     rbp
    retn
sub_E9E endp

