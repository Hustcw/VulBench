sub_1410 proc
    lea     rsi, aEscapesh; "EscapeSh"
    lea     rdi, callback; callback
    sub     rsp, 8
    call    dl_iterate_phdr
    test    eax, eax
    jnz     short loc_1430
    add     rsp, 8
    retn
loc_1430:
    mov     rax, cs:stderr_ptr
    lea     rdi, aDlIteratePhdrF; "dl_iterate_phdr() failed.\n"
    mov     edx, 1Ah; n
    mov     esi, 1; size
    mov     rcx, [rax]; s
    call    fwrite
    mov     edi, 1; status
    call    exit
sub_1410 endp

