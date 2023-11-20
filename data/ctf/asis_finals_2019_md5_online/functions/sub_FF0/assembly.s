sub_FF0 proc
    push    ebx
    call    sub_890
    add     ebx, (offset off_2F74 - $)
    sub     esp, 8
    call    ___stack_chk_fail
sub_FF0 endp

