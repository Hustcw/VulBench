main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 24h
    mov     eax, ecx
    mov     edx, [eax]
    mov     [ebp+var_1C], edx
    mov     eax, [eax+4]
    mov     [ebp+var_20], eax
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    mov     eax, ds:stdout@@GLIBC_2_0
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    mov     eax, ds:stderr@@GLIBC_2_0
    sub     esp, 8
    push    0; buf
    push    eax; stream
    call    _setbuf
    add     esp, 10h
    sub     esp, 4
    push    20h ; ' '; n
    push    0; c
    push    offset adminpassword; s
    call    _memset
    add     esp, 10h
    sub     esp, 8
    push    offset modes; "r"
    push    offset aAdminpasswordT; "adminpassword.txt"
    call    _fopen
    add     esp, 10h
    mov     [ebp+stream], eax
    cmp     [ebp+stream], 0
    jnz     short loc_8048E1F
    sub     esp, 0Ch
    push    offset aCanTReadAdminP; "Can't read admin password!"
    call    _printf
    add     esp, 10h
    sub     esp, 0Ch
    push    1; status
    call    _exit
loc_8048E1F:
    sub     esp, 4
    push    [ebp+stream]
    push    20h ; ' '
    push    offset adminpassword
    call    readline
    add     esp, 10h
    sub     esp, 0Ch
    push    [ebp+stream]; stream
    call    _fclose
    add     esp, 10h
    mov     [ebp+var_14], 0
    jmp     short loc_8048E88
loc_8048E4B:
    sub     esp, 0Ch
    push    184h; size
    call    _malloc
    add     esp, 10h
    mov     edx, eax
    mov     eax, [ebp+var_14]
    mov     ds:posts[eax*4], edx
    mov     eax, [ebp+var_14]
    mov     eax, ds:posts[eax*4]
    sub     esp, 4
    push    184h; n
    push    0; c
    push    eax; s
    call    _memset
    add     esp, 10h
    add     [ebp+var_14], 1
loc_8048E88:
    cmp     [ebp+var_14], 7
    jle     short loc_8048E4B
    call    readpostsfromfile
    call    menu
    mov     ecx, [ebp+var_C]
    xor     ecx, large gs:14h
    jz      short loc_8048EA9
    call    ___stack_chk_fail
loc_8048EA9:
    mov     ecx, [ebp+var_4]
    leave
    lea     esp, [ecx-4]
    retn
main endp

