check_pos proc
    sub     esp, 1Ch
    mov     eax, ds:dword_8057F88
    sub     eax, ds:dword_8058150
    cdq
    xor     eax, edx
    sub     eax, edx
    cmp     eax, 2
    jg      short loc_8049E15
    mov     [esp+1Ch+s], offset aTttssssssLavaI; "TttsSSSss ... lava is good for you."
    call    _puts
    mov     eax, ds:dword_8057F90
    sub     eax, 28h ; '('
    mov     ds:dword_8057F90, eax
    test    eax, eax
    jg      short loc_8049E43
    mov     [esp+1Ch+s], offset aTriedToSwimInL; "*Tried to swim in lava*"
    call    do_die
loc_8049E15:
    cmp     eax, 9
    jg      short loc_8049E43
    mov     [esp+1Ch+s], offset aSoHot; "So hot!!"
    call    _puts
    mov     eax, ds:dword_8057F90
    sub     eax, 1
    mov     ds:dword_8057F90, eax
    test    eax, eax
    jg      short loc_8049E43
    mov     [esp+1Ch+s], offset aBurnedToDeath; "*Burned to death*"
    call    do_die
loc_8049E43:
    add     esp, 1Ch
    retn
check_pos endp

