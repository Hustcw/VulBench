initProc proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 50h
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
    lea     rsi, alarmHandler; handler
    mov     edi, 0Eh; sig
    call    _signal
    mov     edi, 1Eh; seconds
    call    _alarm
    mov     r8d, 0
    mov     ecx, 0
    mov     edx, 0
    mov     esi, 1
    mov     edi, 26h ; '&'; option
    mov     eax, 0
    call    _prctl
    mov     [rbp+sfi.code], 20h ; ' '
    mov     [rbp+sfi.jt], 0
    mov     [rbp+sfi.jf], 0
    mov     [rbp+sfi.k], 4
    mov     [rbp+sfi.code+8], 15h
    mov     [rbp+sfi.jt+8], 0
    mov     [rbp+sfi.jf+8], 5
    mov     [rbp+sfi.k+8], 0C000003Eh
    mov     [rbp+sfi.code+10h], 20h ; ' '
    mov     [rbp+sfi.jt+10h], 0
    mov     [rbp+sfi.jf+10h], 0
    mov     [rbp+sfi.k+10h], 0
    mov     [rbp+sfi.code+18h], 35h ; '5'
    mov     [rbp+sfi.jt+18h], 0
    mov     [rbp+sfi.jf+18h], 1
    mov     [rbp+sfi.k+18h], 40000000h
    mov     [rbp+sfi.code+20h], 15h
    mov     [rbp+sfi.jt+20h], 0
    mov     [rbp+sfi.jf+20h], 2
    mov     [rbp+sfi.k+20h], 0FFFFFFFFh
    mov     [rbp+sfi.code+28h], 15h
    mov     [rbp+sfi.jt+28h], 1
    mov     [rbp+sfi.jf+28h], 0
    mov     [rbp+sfi.k+28h], 3Bh ; ';'
    mov     [rbp+sfi.code+30h], 6
    mov     [rbp+sfi.jt+30h], 0
    mov     [rbp+sfi.jf+30h], 0
    mov     [rbp+sfi.k+30h], 7FFF0000h
    mov     [rbp+sfi.code+38h], 6
    mov     [rbp+sfi.jt+38h], 0
    mov     [rbp+sfi.jf+38h], 0
    mov     [rbp+sfi.k+38h], 0
    mov     [rbp+sfp.len], 8
    lea     rax, [rbp+sfi]
    mov     [rbp+sfp.filter], rax
    lea     rax, [rbp+sfp]
    mov     rdx, rax
    mov     esi, 2
    mov     edi, 16h; option
    mov     eax, 0
    call    _prctl
    nop
    leave
    retn
initProc endp

