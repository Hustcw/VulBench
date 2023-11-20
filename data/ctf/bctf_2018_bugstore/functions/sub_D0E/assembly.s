sub_D0E proc
    sub     rsp, 8
    cmp     cs:byte_202048, 0
    jnz     short loc_D50
    mov     cs:byte_202048, 1
    lea     rsi, qword_202040
    lea     rdi, aLlu; "%llu"
    mov     eax, 0
    call    __isoc99_scanf
    mov     rax, cs:qword_202040
    mov     rdx, 45524F5453475542h
    mov     [rax], rdx
    jmp     short loc_D5C
loc_D50:
    lea     rdi, aAinTItCoolByeN; "ain't it cool, bye now"
    call    puts
loc_D5C:
    add     rsp, 8
    retn
sub_D0E endp

