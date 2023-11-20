sub_C62 proc
    sub     rsp, 8
    cmp     cs:byte_202260, 0
    jnz     short loc_CA4
    mov     cs:byte_202260, 1
    mov     edx, 200h; nbytes
    lea     rsi, unk_202060; buf
    mov     edi, 0; fd
    call    read
    lea     rsi, unk_202060
    mov     edi, 1
    mov     eax, 0
    call    __printf_chk
    jmp     short loc_CB0
loc_CA4:
    lea     rdi, aAinTItCoolByeN; "ain't it cool, bye now"
    call    puts
loc_CB0:
    add     rsp, 8
    retn
sub_C62 endp

