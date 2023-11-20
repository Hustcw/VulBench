sub_C8F proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    push    rax
    xor     eax, eax
    jz      short loc_CAF
    add     rsp, 4
loc_CAF:
    pop     rax
    mov     [rbp+s], 0
    mov     [rbp+buf], 0
    mov     dword ptr [rbp+size], 0
    mov     eax, cs:dword_20202C
    cmp     eax, 63h ; 'c'
    ja      loc_E23
    mov     edi, 28h ; '('; size
    call    malloc
    mov     [rbp+s], rax
    mov     rax, [rbp+s]
    mov     edx, 28h ; '('; n
    mov     esi, 0; c
    mov     rdi, rax; s
    call    memset
    lea     rdi, aLengthOfTheNam; "Length of the name :"
    mov     eax, 0
    call    printf
    lea     rax, [rbp+size]
    mov     rsi, rax
    lea     rdi, aU; "%u"
    mov     eax, 0
    call    __isoc99_scanf
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_D32
    mov     edi, 0FFFFFFFFh; status
    call    exit
loc_D32:
    mov     eax, dword ptr [rbp+size]
    mov     eax, eax
    mov     rdi, rax; size
    call    malloc
    mov     [rbp+buf], rax
    cmp     [rbp+buf], 0
    jnz     short loc_D60
    lea     rdi, aError; "error !"
    call    puts
    mov     edi, 0FFFFFFFFh; status
    call    exit
loc_D60:
    lea     rdi, aTheNameOfPig; "The name of pig :"
    mov     eax, 0
    call    printf
    mov     eax, dword ptr [rbp+size]
    mov     edx, eax; nbytes
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    read
    mov     rax, [rbp+s]
    mov     rdx, [rbp+buf]
    mov     [rax+8], rdx
    lea     rdi, aTheTypeOfThePi; "The type of the pig :"
    mov     eax, 0
    call    printf
    mov     rax, [rbp+s]
    add     rax, 10h
    mov     rsi, rax
    lea     rdi, a23s; "%23s"
    mov     eax, 0
    call    __isoc99_scanf
    mov     rax, [rbp+s]
    mov     dword ptr [rax], 1
    mov     dword ptr [rbp+size+4], 0
    jmp     short loc_E0E
loc_DD3:
    mov     eax, dword ptr [rbp+size+4]
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_E0A
    mov     eax, dword ptr [rbp+size+4]
    lea     rcx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rdx, [rbp+s]
    mov     [rcx+rax], rdx
    jmp     short loc_E14
loc_E0A:
    add     dword ptr [rbp+size+4], 1
loc_E0E:
    cmp     dword ptr [rbp+size+4], 63h ; 'c'
    jbe     short loc_DD3
loc_E14:
    mov     eax, cs:dword_20202C
    add     eax, 1
    mov     cs:dword_20202C, eax
loc_E23:
    mov     eax, 0
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_E3C
    call    __stack_chk_fail
locret_E3C:
    leave
    retn
sub_C8F endp

