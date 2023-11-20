main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 4
    mov     eax, ds:stdout@@GLIBC_2_0
    push    0; n
    push    2; modes
    push    0; buf
    push    eax; stream
    call    _setvbuf
    add     esp, 10h
    mov     eax, ds:__bss_start
    push    0; n
    push    2; modes
    push    0; buf
    push    eax; stream
    call    _setvbuf
    add     esp, 10h
loc_80489C8:
    call    menu
    call    read_int
    cmp     eax, 2
    jz      short loc_80489F6
    cmp     eax, 2
    jg      short loc_80489E3
    cmp     eax, 1
    jz      short loc_80489EF
    jmp     short loc_8048A0E
loc_80489E3:
    cmp     eax, 3
    jz      short loc_80489FD
    cmp     eax, 4
    jz      short loc_8048A04
    jmp     short loc_8048A0E
loc_80489EF:
    call    add_note
    jmp     short loc_8048A1F
loc_80489F6:
    call    show_note
    jmp     short loc_8048A1F
loc_80489FD:
    call    del_note
    jmp     short loc_8048A1F
loc_8048A04:
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_8048A0E:
    sub     esp, 0Ch
    push    offset aInvalidChoice; "Invalid choice"
    call    _puts
    add     esp, 10h
    nop
loc_8048A1F:
    jmp     short loc_80489C8
main endp

