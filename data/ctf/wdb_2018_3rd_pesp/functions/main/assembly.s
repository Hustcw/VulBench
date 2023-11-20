main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 20h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stdin@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     edi, 10h; size
    call    _malloc
    mov     [rbp+var_18], rax
    mov     rax, [rbp+var_18]
    mov     qword ptr [rax], offset hello_message
    mov     rax, [rbp+var_18]
    mov     qword ptr [rax+8], offset goodbye_message
    mov     rax, [rbp+var_18]
    mov     rdx, [rax]
    mov     eax, 0
    call    rdx
loc_400E3D:
    mov     eax, 0
    call    menu
    lea     rax, [rbp+buf]
    mov     edx, 8; nbytes
    mov     rsi, rax; buf
    mov     edi, 0; fd
    call    _read
    lea     rax, [rbp+buf]
    mov     rdi, rax; nptr
    call    _atoi
    mov     [rbp+var_1C], eax
    cmp     [rbp+var_1C], 5; switch 6 cases
    ja      short def_400E7D; jumptable 0000000000400E7D default case, case 0
    mov     eax, [rbp+var_1C]
    mov     rax, ds:jpt_400E7D[rax*8]
def_400E7D:
    jmp     rax; switch jump
    mov     eax, 0; jumptable 0000000000400E7D case 1
    call    show_item
    jmp     short loc_400ED3
    mov     eax, 0; jumptable 0000000000400E7D case 2
    call    add_item
    jmp     short loc_400ED3
    mov     eax, 0; jumptable 0000000000400E7D case 3
    call    change_item
    jmp     short loc_400ED3
    mov     eax, 0; jumptable 0000000000400E7D case 4
    call    remove_item
    jmp     short loc_400ED3
    mov     rax, [rbp+var_18]; jumptable 0000000000400E7D case 5
    mov     rdx, [rax+8]
    mov     eax, 0
    call    rdx
    mov     edi, 0; status
    call    _exit
    mov     edi, offset aInvaildChoice; jumptable 0000000000400E7D default case, case 0
    call    _puts
    nop
loc_400ED3:
    jmp     loc_400E3D
main endp

