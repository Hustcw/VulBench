main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 34h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    call    init
    call    welcome
loc_8048A5D:
    call    menu
    sub     esp, 8
    lea     eax, [ebp+nptr]
    push    eax
    push    offset aS; "%s"
    call    ___isoc99_scanf
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+nptr]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     [ebp+var_30], eax
    cmp     [ebp+var_30], 5; switch 6 cases
    ja      def_8048A9F; jumptable 08048A9F default case, case 0
    mov     eax, [ebp+var_30]
    shl     eax, 2
    add     eax, offset jpt_8048A9F
    mov     eax, [eax]
def_8048A9F:
    jmp     eax; switch jump
    call    openfile; jumptable 08048A9F case 1
    jmp     loc_8048B3B
    call    readfile; jumptable 08048A9F case 2
    jmp     loc_8048B3B
    call    writefile; jumptable 08048A9F case 3
    jmp     short loc_8048B3B
    call    closefile; jumptable 08048A9F case 4
    jmp     short loc_8048B3B
    sub     esp, 0Ch; jumptable 08048A9F case 5
    push    offset aLeaveYourName; "Leave your name :"
    call    _printf
    add     esp, 10h
    sub     esp, 8
    push    offset name
    push    offset aS; "%s"
    call    ___isoc99_scanf
    add     esp, 10h
    sub     esp, 8
    push    offset name
    push    offset aThankYouSSeeYo; "Thank you %s ,see you next time\n"
    call    _printf
    add     esp, 10h
    mov     eax, ds:fp
    test    eax, eax
    jz      short loc_8048B17
    mov     eax, ds:fp
    sub     esp, 0Ch
    push    eax; stream
    call    _fclose
    add     esp, 10h
loc_8048B17:
    sub     esp, 0Ch
    push    0; status
    call    _exit
    sub     esp, 0Ch; jumptable 08048A9F default case, case 0
    push    offset aInvaildChoice; "Invaild choice"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    0; status
    call    _exit
loc_8048B3B:
    jmp     loc_8048A5D
main endp

