parse_query_string proc
    push    rbp
    mov     rbp, rsp
    add     rsp, 0FFFFFFFFFFFFFF80h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     cs:req_cvar, 0
    lea     rax, qs
    mov     rax, [rax]
    lea     rsi, delim; "&"
    mov     rdi, rax; s
    call    _strtok
    mov     [rbp+s], rax
    jmp     loc_193D
loc_1851:
    mov     rax, [rbp+s]
    mov     esi, 3Dh ; '='; c
    mov     rdi, rax; s
    call    _strchr
    mov     [rbp+var_78], rax
    mov     rax, [rbp+var_78]
    mov     byte ptr [rax], 0
    mov     rcx, [rbp+s]
    lea     rax, [rbp+dest]
    mov     edx, 20h ; ' '; n
    mov     rsi, rcx; src
    mov     rdi, rax; dest
    call    _strncpy
    mov     rax, [rbp+var_78]
    add     rax, 1
    lea     rdx, [rbp+dest]
    add     rdx, 20h ; ' '
    mov     rsi, rdx
    mov     rdi, rax
    call    base64decode
    mov     eax, cs:req_cvar
    lea     edx, [rax+1]
    mov     cs:req_cvar, edx
    movsxd  rdx, eax
    mov     rax, rdx
    add     rax, rax
    add     rax, rdx
    shl     rax, 5
    lea     rdx, reqvars
    add     rax, rdx
    mov     rdx, qword ptr [rbp+dest]
    mov     rcx, [rbp+var_68]
    mov     [rax], rdx
    mov     [rax+8], rcx
    mov     rdx, [rbp+var_60]
    mov     rcx, [rbp+var_58]
    mov     [rax+10h], rdx
    mov     [rax+18h], rcx
    mov     rdx, [rbp+var_50]
    mov     rcx, [rbp+var_48]
    mov     [rax+20h], rdx
    mov     [rax+28h], rcx
    mov     rdx, [rbp+var_40]
    mov     rcx, [rbp+var_38]
    mov     [rax+30h], rdx
    mov     [rax+38h], rcx
    mov     rdx, [rbp+var_30]
    mov     rcx, [rbp+var_28]
    mov     [rax+40h], rdx
    mov     [rax+48h], rcx
    mov     rdx, [rbp+var_20]
    mov     rcx, [rbp+var_18]
    mov     [rax+50h], rdx
    mov     [rax+58h], rcx
    lea     rsi, delim; "&"
    mov     edi, 0; s
    call    _strtok
    mov     [rbp+s], rax
loc_193D:
    cmp     [rbp+s], 0
    jnz     loc_1851
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_195D
    call    ___stack_chk_fail
locret_195D:
    leave
    retn
parse_query_string endp

