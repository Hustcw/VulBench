cmd_set_ip proc
    push    esi
    push    ebx
    sub     esp, 114h
    mov     [esp+11Ch+src], offset aEnterYourIpAdd; "Enter your IP address: "
    mov     [esp+11Ch+ptr], 1
    call    ___printf_chk
    mov     [esp+11Ch+src], 100h; size_t
    lea     esi, [esp+11Ch+var_10C]
    mov     [esp+11Ch+ptr], esi; void *
    call    readn
    mov     ebx, eax
    mov     eax, ds:cp
    mov     [esp+11Ch+ptr], eax; ptr
    call    _free
    mov     [esp+11Ch+ptr], ebx; size
    call    _malloc
    mov     ds:cp, eax
    mov     [esp+11Ch+n], ebx; n
    mov     [esp+11Ch+src], esi; src
    mov     [esp+11Ch+ptr], eax; dest
    call    _memcpy
    add     ebx, ds:cp
    mov     byte ptr [ebx-1], 0
    add     esp, 114h
    pop     ebx
    pop     esi
    retn
cmd_set_ip endp

