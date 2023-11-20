add proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     [rbp+s], 0
    mov     [rbp+buf], 0
    mov     dword ptr [rbp+size], 0
    mov     eax, cs:flowercount
    cmp     eax, 63h ; 'c'
    ja      loc_400B7B
    mov     edi, 28h ; '('; size
    call    _malloc
    mov     [rbp+s], rax
    mov     rax, [rbp+s]
    mov     edx, 28h ; '('; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    _memset
    lea     rdi, aLengthOfTheNam; "Length of the name :"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+size]
    mov     rsi, rax
    lea     rdi, aU; "%u"
    mov     eax, 0
    call    ___isoc99_scanf
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_400A7C
    mov     edi, 0FFFFFFFFh; status
    call    _exit
loc_400A7C:
    mov     eax, dword ptr [rbp+size]
    mov     eax, eax
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+buf], rax
    cmp     [rbp+buf], 0
    jnz     short loc_400AAA
    lea     rdi, aAllocaError; "Alloca error !!"
    call    _puts
    mov     edi, 0FFFFFFFFh; status
    call    _exit
loc_400AAA:
    lea     rdi, aTheNameOfFlowe; "The name of flower :"
    mov     eax, 0
    call    _printf
    mov     eax, dword ptr [rbp+size]
    mov     edx, eax; nbytes
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    mov     rax, [rbp+s]
    mov     rdx, [rbp+buf]
    mov     [rax+8], rdx
    lea     rdi, aTheColorOfTheF; "The color of the flower :"
    mov     eax, 0
    call    _printf
    mov     rax, [rbp+s]
    add     rax, 10h
    mov     rsi, rax
    lea     rdi, a23s; "%23s"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     rax, [rbp+s]
    mov     dword ptr [rax], 1
    mov     dword ptr [rbp+size+4], 0
    jmp     short loc_400B58
loc_400B1D:
    mov     eax, dword ptr [rbp+size+4]
    lea     rdx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_400B54
    mov     eax, dword ptr [rbp+size+4]
    lea     rcx, ds:0[rax*8]
    lea     rax, flowerlist
    mov     rdx, [rbp+s]
    mov     [rcx+rax], rdx
    jmp     short loc_400B5E
loc_400B54:
    add     dword ptr [rbp+size+4], 1
loc_400B58:
    cmp     dword ptr [rbp+size+4], 63h ; 'c'
    jbe     short loc_400B1D
loc_400B5E:
    mov     eax, cs:flowercount
    add     eax, 1
    mov     cs:flowercount, eax
    lea     rdi, aSuccessful; "Successful !"
    call    _puts
    jmp     short loc_400B87
loc_400B7B:
    lea     rdi, aTheGardenIsOve; "The garden is overflow"
    call    _puts
loc_400B87:
    nop
    leave
    retn
add endp

