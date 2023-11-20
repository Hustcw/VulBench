sub_8048A71 proc
    push    ebp
    mov     ebp, esp
    push    edi
    push    ebx
    sub     esp, 50h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    lea     ebx, [ebp+var_34]
    mov     eax, 0
    mov     edx, 0Ah
    mov     edi, ebx
    mov     ecx, edx
    rep stosd
loc_8048A97:
    mov     dword ptr [esp], offset asc_8048F9C; "\n===============================\n"
    call    sub_80488B1
    mov     dword ptr [esp], offset a1Echo; "1. Echo\n"
    call    sub_80488B1
    mov     dword ptr [esp], offset a2ReverseEcho; "2. Reverse Echo\n"
    call    sub_80488B1
    mov     dword ptr [esp], offset a3Exit; "3. Exit\n"
    call    sub_80488B1
    mov     dword ptr [esp], offset asc_8048FE4; "===============================\n"
    call    sub_80488B1
    call    sub_804895A
    mov     [ebp+var_3C], eax
    cmp     [ebp+var_3C], 1
    jnz     short loc_8048B10
    mov     dword ptr [esp], offset aInputYourMessa; "Input Your Message : "
    call    sub_80488B1
    mov     dword ptr [esp+4], 64h ; 'd'
    lea     eax, [ebp+var_34]
    mov     [esp], eax
    call    sub_8048907
    mov     [ebp+var_38], eax
    lea     eax, [ebp+var_34]
    mov     [esp], eax
    call    sub_80488B1
    jmp     short loc_8048B76
loc_8048B10:
    cmp     [ebp+var_3C], 2
    jnz     short loc_8048B50
    mov     dword ptr [esp], offset aInputYourMessa; "Input Your Message : "
    call    sub_80488B1
    mov     dword ptr [esp+4], 64h ; 'd'
    lea     eax, [ebp+var_34]
    mov     [esp], eax
    call    sub_8048907
    mov     [ebp+var_38], eax
    lea     eax, [ebp+var_34]
    mov     [esp], eax
    call    sub_80489C8
    lea     eax, [ebp+var_34]
    mov     [esp], eax
    call    sub_80488B1
    jmp     short loc_8048B76
loc_8048B50:
    cmp     [ebp+var_3C], 3
    jnz     short loc_8048B65
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_8048B80
    jmp     short loc_8048B7B
loc_8048B65:
    mov     dword ptr [esp], offset aWrongInput; "\n[!] Wrong Input\n"
    call    sub_80488B1
    jmp     loc_8048A97
loc_8048B76:
    jmp     loc_8048A97
loc_8048B7B:
    call    ___stack_chk_fail
loc_8048B80:
    add     esp, 50h
    pop     ebx
    pop     edi
    pop     ebp
    retn
sub_8048A71 endp

