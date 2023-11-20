cmd_kill proc
    push    ebx
    sub     esp, 118h
    mov     [esp+11Ch+var_118], offset aWhy; "Why???? "
    mov     [esp+11Ch+var_11C], 1
    call    ___printf_chk
    mov     [esp+11Ch+var_118], 100h; size_t
    lea     ebx, [esp+11Ch+var_10C]
    mov     [esp+11Ch+var_11C], ebx; void *
    call    readn
    mov     [esp+eax+11Ch+var_10D], 0
    mov     [esp+11Ch+var_11C], ebx
    call    do_die
cmd_kill endp

