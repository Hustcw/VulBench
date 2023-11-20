sub_E3E proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    push    rax
    xor     eax, eax
    jz      short loc_E5E
    add     rsp, 4
loc_E5E:
    pop     rax
    mov     eax, cs:dword_20202C
    test    eax, eax
    jnz     short loc_E7A
    lea     rdi, aNoPig; "No pig"
    call    puts
    jmp     loc_F27
loc_E7A:
    lea     rdi, aWhichPigDoYouW; "Which pig do you want to eat:"
    mov     eax, 0
    call    printf
    lea     rax, [rbp+var_C]
    mov     rsi, rax
    lea     rdi, aD; "%d"
    mov     eax, 0
    call    __isoc99_scanf
    mov     eax, [rbp+var_C]
    cmp     eax, 63h ; 'c'
    ja      short loc_EC8
    mov     eax, [rbp+var_C]
    mov     eax, eax
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    test    rax, rax
    jnz     short loc_EDB
loc_EC8:
    lea     rdi, aInvalidChoice; "Invalid choice"
    call    puts
    mov     eax, 0
    jmp     short loc_F2C
loc_EDB:
    mov     edi, 0; seed
    call    srand
    mov     eax, [rbp+var_C]
    mov     eax, eax
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    mov     dword ptr [rax], 0
    mov     eax, [rbp+var_C]
    mov     eax, eax
    lea     rdx, ds:0[rax*8]
    lea     rax, qword_202040
    mov     rax, [rdx+rax]
    mov     rax, [rax+8]
    mov     rdi, rax; ptr
    call    free
loc_F27:
    mov     eax, 0
loc_F2C:
    mov     rcx, [rbp+var_8]
    xor     rcx, fs:28h
    jz      short locret_F40
    call    __stack_chk_fail
locret_F40:
    leave
    retn
sub_E3E endp

