vuln proc
    push    ebp
    mov     ebp, esp
    sub     esp, 4228h
    mov     [ebp+loop_switch], 1
    mov     dword ptr [esp+8], 4200h; n
    mov     dword ptr [esp+4], 0; c
    lea     eax, [ebp+buffer]
    mov     [esp], eax; s
    call    _memset
    jmp     short loc_80488EB
loc_8048883:
    call    choose
    cmp     eax, 5; switch 6 cases
    ja      short def_8048894; jumptable 08048894 default case, case 0
    mov     eax, ds:jpt_8048894[eax*4]
def_8048894:
    jmp     eax; switch jump
    lea     eax, [ebp+buffer]; jumptable 08048894 case 1
    mov     [esp], eax; node
    call    add_note
    jmp     short loc_80488EB
    lea     eax, [ebp+buffer]; jumptable 08048894 case 2
    mov     [esp], eax; node
    call    edit_note
    jmp     short loc_80488EB
    lea     eax, [ebp+buffer]; jumptable 08048894 case 3
    mov     [esp], eax; node
    call    show_note
    jmp     short loc_80488EB
    lea     eax, [ebp+buffer]; jumptable 08048894 case 4
    mov     [esp], eax; node
    call    dump_notes
    jmp     short loc_80488EB
    mov     [ebp+loop_switch], 0; jumptable 08048894 case 5
    jmp     short loc_80488EB
    mov     dword ptr [esp], offset aInvalidOption; jumptable 08048894 default case, case 0
    call    _puts
loc_80488EB:
    cmp     [ebp+loop_switch], 0
    jnz     short loc_8048883
    leave
    retn
vuln endp

