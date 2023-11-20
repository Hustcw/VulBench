welcome proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stderr@@GLIBC_2_2_5
    mov     rdi, rax; stream
    call    _fclose
    mov     edi, 3Ch ; '<'; seconds
    call    _alarm
    mov     edx, 9; n
    mov     esi, offset aWelcome; "Welcome!\n"
    mov     edi, 1; fd
    call    _write
    mov     [rbp+var_4], 0
    jmp     short loc_400B0A
loc_400AE6:
    mov     eax, [rbp+var_4]
    movsxd  rdx, eax
    mov     rax, rdx
    shl     rax, 2
    add     rax, rdx
    shl     rax, 5
    add     rax, 6020E0h
    mov     dword ptr [rax], 0
    add     [rbp+var_4], 1
loc_400B0A:
    cmp     [rbp+var_4], 0Fh
    jle     short loc_400AE6
    nop
    leave
    retn
welcome endp

