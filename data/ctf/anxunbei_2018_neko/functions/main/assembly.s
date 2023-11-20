main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 14h
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
    sub     esp, 0Ch
    push    offset s; "***************************************"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048912; "            /\\____/\\    __"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048930; "          .'  \"\"\"\"  `,-'  `--.__"
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048954; "     __,- :   -  -   ;  \" ::     `-. -"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aSssssSssss; "  ,-sssss `._  `' _,'\"     ,'~~~::`.ss"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aSsssssSsssss; " |ssssss ,' ,_`--'_    __,' ::  `  `.ss"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aSssssssSsssss; "|sssssss `-._____~ `,,'_______,---_;; s"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aSsssssssssSsss; " |ssssssssss     `--'~{__   ____   ,'ss"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aSsssssssssssss; "  `-ssssssssssssssssss ~~~~~~~~~~~~ sss"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aSsssssssssssss_0; "      `---.sssssssssssssssssssss.---' "
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset asc_8048A90; "***************************************"...
    call    _puts
    add     esp, 10h
    sub     esp, 0Ch
    push    offset aHeyDoYouLikeCa; "Hey!Do you like cats?"
    call    _puts
    add     esp, 10h
    sub     esp, 8
    lea     eax, [ebp+var_9]
    push    eax
    push    offset aC; "%c"
    call    ___isoc99_scanf
    add     esp, 10h
    movzx   eax, [ebp+var_9]
    cmp     al, 79h ; 'y'
    jz      short loc_8048688
    movzx   eax, [ebp+var_9]
    cmp     al, 59h ; 'Y'
    jnz     short loc_804868F
loc_8048688:
    call    play
    jmp     short loc_80486C1
loc_804868F:
    movzx   eax, [ebp+var_9]
    cmp     al, 6Eh ; 'n'
    jz      short loc_804869F
    movzx   eax, [ebp+var_9]
    cmp     al, 4Eh ; 'N'
    jnz     short loc_80486B1
loc_804869F:
    sub     esp, 0Ch
    push    offset aNoThereIsNoFla; "No...there is no flag for the guy who d"...
    call    _puts
    add     esp, 10h
    jmp     short loc_80486C1
loc_80486B1:
    sub     esp, 0Ch
    push    offset aAnswerMyQuesti; "answer my question OK?"
    call    _puts
    add     esp, 10h
loc_80486C1:
    mov     eax, 0
    mov     ecx, [ebp+var_4]
    leave
    lea     esp, [ecx-4]
    retn
main endp

