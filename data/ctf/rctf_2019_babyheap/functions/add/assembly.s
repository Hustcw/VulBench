add proc
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 18h
    mov     rax, fs:28h
    mov     [rbp+var_18], rax
    xor     eax, eax
    mov     [rbp+var_20], 0
    jmp     short loc_1057
loc_1053:
    add     [rbp+var_20], 1
loc_1057:
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_20]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rax, rdx
    mov     rax, [rax]
    test    rax, rax
    jz      short loc_1079
    cmp     [rbp+var_20], 0Fh
    jle     short loc_1053
loc_1079:
    cmp     [rbp+var_20], 10h
    jnz     short loc_1095
    lea     rdi, aYouCanT; "You can't"
    call    puts
    mov     edi, 0FFFFFFFFh; status
    call    exit
loc_1095:
    lea     rdi, format; "Size: "
    mov     eax, 0
    call    printf
    mov     eax, 0
    call    get_int
    mov     [rbp+var_1C], eax
    cmp     [rbp+var_1C], 0
    jle     short loc_1114
    cmp     [rbp+var_1C], 1000h
    jg      short loc_1114
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_20]
    movsxd  rdx, edx
    shl     rdx, 4
    add     rdx, rax
    mov     eax, [rbp+var_1C]
    mov     [rdx+8], eax
    mov     rax, cs:ptrs
    mov     edx, [rbp+var_20]
    movsxd  rdx, edx
    shl     rdx, 4
    lea     rbx, [rax+rdx]
    mov     eax, [rbp+var_1C]
    cdqe
    mov     esi, 1; size
    mov     rdi, rax; nmemb
    call    calloc
    mov     [rbx], rax
    lea     rdi, aAddSuccess; "Add success :)"
    call    puts
    jmp     short loc_1120
loc_1114:
    lea     rdi, aInvalidSize; "Invalid size :("
    call    puts
loc_1120:
    nop
    mov     rax, [rbp+var_18]
    xor     rax, fs:28h
    jz      short loc_1135
    call    __stack_chk_fail
loc_1135:
    add     rsp, 18h
    pop     rbx
    pop     rbp
    retn
add endp

