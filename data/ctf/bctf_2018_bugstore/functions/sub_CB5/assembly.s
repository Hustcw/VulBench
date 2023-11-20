sub_CB5 proc
    sub     rsp, 38h
    mov     rax, fs:28h
    mov     [rsp+38h+var_10], rax
    xor     eax, eax
    cmp     cs:byte_202049, 0
    jnz     short loc_CE8
    mov     cs:byte_202049, 1
    mov     rdi, rsp
    mov     esi, 200h
    call    sub_BC6
    jmp     short loc_CF4
loc_CE8:
    lea     rdi, aAinTItCoolByeN; "ain't it cool, bye now"
    call    puts
loc_CF4:
    mov     rax, [rsp+38h+var_10]
    xor     rax, fs:28h
    jz      short loc_D09
    call    __stack_chk_fail
loc_D09:
    add     rsp, 38h
    retn
sub_CB5 endp

