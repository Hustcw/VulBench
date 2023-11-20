sub_80486F7 proc
    push    ebp
    mov     ebp, esp
    sub     esp, 18h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     eax, ds:stdout
    push    eax; s
    push    2Ch ; ','; n
    push    1; size
    push    offset asc_8048A00; "\n*************************************"...
    call    _fwrite
    add     esp, 10h
    mov     eax, ds:stdout
    push    eax; s
    push    2Bh ; '+'; n
    push    1; size
    push    offset aWe1c0meT0B0ldf; "******We1c0me t0 b0ldfrev's noteb00k***"...
    call    _fwrite
    add     esp, 10h
    mov     eax, ds:stdout
    push    eax; s
    push    2Bh ; '+'; n
    push    1; size
    push    offset asc_8048A5C; "***************************************"...
    call    _fwrite
    add     esp, 10h
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short locret_804875F
    call    ___stack_chk_fail
locret_804875F:
    leave
    retn
sub_80486F7 endp

