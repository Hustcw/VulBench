main proc
    push    ebp
    mov     ebp, esp
    and     esp, 0FFFFFFF0h
    sub     esp, 50h
    mov     eax, [ebp+arg_0]
    mov     [esp+1Ch], eax
    mov     eax, [ebp+arg_4]
    mov     [esp+18h], eax
    mov     eax, large gs:14h
    mov     [esp+4Ch], eax
    xor     eax, eax
    cmp     dword ptr [esp+1Ch], 2
    jnz     short loc_8048CAC
    mov     eax, [esp+18h]
    add     eax, 4
    mov     eax, [eax]
    mov     [esp], eax; nptr
    call    _atoi
    mov     [esp+28h], eax
    jmp     short loc_8048CB4
loc_8048CAC:
    mov     dword ptr [esp+28h], 1FF5h
loc_8048CB4:
    mov     dword ptr [esp+8], 0; protocol
    mov     dword ptr [esp+4], 1; type
    mov     dword ptr [esp], 2; domain
    call    _socket
    mov     ds:dword_804B1BC, eax
    mov     eax, ds:dword_804B1BC
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_8048CF7
    mov     dword ptr [esp], offset aSocketError; "[!] socket Error!"
    call    _perror
    mov     dword ptr [esp], 1; status
    call    _exit
loc_8048CF7:
    mov     word ptr [esp+2Ch], 2
    mov     eax, [esp+28h]
    movzx   eax, ax
    mov     [esp], eax; hostshort
    call    _htons
    mov     [esp+2Eh], ax
    mov     dword ptr [esp+30h], 0
    mov     dword ptr [esp+4], 8; n
    lea     eax, [esp+2Ch]
    add     eax, 8
    mov     [esp], eax; s
    call    _bzero
    mov     dword ptr [esp+24h], 1
    mov     eax, ds:dword_804B1BC
    mov     dword ptr [esp+10h], 4; optlen
    lea     edx, [esp+50h+optval]
    mov     [esp+0Ch], edx; optval
    mov     dword ptr [esp+8], 2; optname
    mov     dword ptr [esp+4], 1; level
    mov     [esp], eax; fd
    call    _setsockopt
    mov     eax, ds:dword_804B1BC
    mov     dword ptr [esp+8], 10h; len
    lea     edx, [esp+50h+addr]
    mov     [esp+4], edx; addr
    mov     [esp], eax; fd
    call    _bind
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_8048DA0
    mov     dword ptr [esp], offset aBindError; "[!] bind Error!"
    call    _perror
    mov     dword ptr [esp], 1; status
    call    _exit
loc_8048DA0:
    mov     eax, ds:dword_804B1BC
    mov     dword ptr [esp+4], 400h; n
    mov     [esp], eax; fd
    call    _listen
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_8048DD2
    mov     dword ptr [esp], offset aListenError; "[!] listen Error!"
    call    _perror
    mov     dword ptr [esp], 1; status
    call    _exit
loc_8048DD2:
    mov     dword ptr [esp+20h], 10h
    mov     eax, ds:dword_804B1BC
    lea     edx, [esp+50h+addr_len]
    mov     [esp+8], edx; addr_len
    lea     edx, [esp+50h+var_14]
    mov     [esp+4], edx; addr
    mov     [esp], eax; fd
    call    _accept
    mov     ds:fd, eax
    mov     eax, ds:fd
    cmp     eax, 0FFFFFFFFh
    jnz     short loc_8048E14
    mov     dword ptr [esp], offset aAcceptError; "[!] accept Error!"
    call    _perror
    jmp     short loc_8048E7A
loc_8048E14:
    call    _fork
    test    eax, eax
    jnz     short loc_8048E4C
    call    sub_8048B87
    mov     eax, ds:dword_804B1BC
    mov     [esp], eax; fd
    call    _close
    mov     eax, ds:fd
    mov     [esp], eax; fd
    call    _close
    nop
    mov     eax, [esp+4Ch]
    xor     eax, large gs:14h
    jz      short locret_8048E84
    jmp     short loc_8048E7F
loc_8048E4C:
    mov     eax, ds:fd
    mov     [esp], eax; fd
    call    _close
    nop
loc_8048E5A:
    mov     dword ptr [esp+8], 1; options
    mov     dword ptr [esp+4], 0; stat_loc
    mov     dword ptr [esp], 0FFFFFFFFh; pid
    call    _waitpid
    test    eax, eax
    jg      short loc_8048E5A
loc_8048E7A:
    jmp     loc_8048DD2
loc_8048E7F:
    call    ___stack_chk_fail
locret_8048E84:
    leave
    retn
main endp

