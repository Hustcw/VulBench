sub_80493D0 proc
    push    ebx
    call    sub_8049130
    add     ebx, (offset off_804C000 - $)
    sub     esp, 8
    call    ___stack_chk_fail
sub_80493D0 endp

