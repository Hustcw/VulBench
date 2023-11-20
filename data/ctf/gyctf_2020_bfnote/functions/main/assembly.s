main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 54h
    mov     eax, large gs:14h
    mov     [ebp+var_C], eax
    xor     eax, eax
    call    sub_80486F7
    mov     eax, ds:stdout
    push    eax; s
    push    19h; n
    push    1; size
    push    offset aGiveYourDescri; "\nGive your description : "
    call    _fwrite
    add     esp, 10h
    sub     esp, 4
    push    32h ; '2'; n
    push    0; c
    lea     eax, [ebp+s]
    push    eax; s
    call    _memset
    add     esp, 10h
    sub     esp, 4
    push    600h
    lea     eax, [ebp+s]
    push    eax
    push    0
    call    sub_804869C
    add     esp, 10h
    mov     eax, ds:stdout
    push    eax; s
    push    17h; n
    push    1; size
    push    offset aGiveYourPostsc; "Give your postscript : "
    call    _fwrite
    add     esp, 10h
    sub     esp, 4
    push    64h ; 'd'; n
    push    0; c
    push    offset unk_804A060; s
    call    _memset
    add     esp, 10h
    sub     esp, 4
    push    600h
    push    offset unk_804A060
    push    0
    call    sub_804869C
    add     esp, 10h
    mov     eax, ds:stdout
    push    eax; s
    push    1Bh; n
    push    1; size
    push    offset aGiveYourNotebo; "\nGive your notebook size : "
    call    _fwrite
    add     esp, 10h
    call    sub_8048656
    mov     [ebp+size], eax
    mov     eax, [ebp+size]
    sub     esp, 0Ch
    push    eax; size
    call    _malloc
    add     esp, 10h
    mov     [ebp+var_4C], eax
    mov     eax, [ebp+size]
    sub     esp, 4
    push    eax; n
    push    0; c
    push    [ebp+var_4C]; s
    call    _memset
    add     esp, 10h
    mov     eax, ds:stdout
    push    eax; s
    push    17h; n
    push    1; size
    push    offset aGiveYourTitleS; "Give your title size : "
    call    _fwrite
    add     esp, 10h
    call    sub_8048656
    mov     [ebp+var_48], eax
    mov     eax, [ebp+var_48]
    mov     [ebp+var_44], eax
    mov     eax, [ebp+var_48]
    mov     [ebp+var_54], eax
    mov     eax, [ebp+size]
    sub     eax, 20h ; ' '
    cmp     eax, [ebp+var_48]
    jge     short loc_80488A9
loc_804887F:
    mov     eax, ds:stdout
    push    eax; s
    push    1Ch; n
    push    1; size
    push    offset aInvalidPleaseR; "invalid ! please re-enter :\n"
    call    _fwrite
    add     esp, 10h
    call    sub_8048656
    mov     [ebp+var_54], eax
    mov     eax, [ebp+size]
    sub     eax, 20h ; ' '
    cmp     eax, [ebp+var_54]
    jl      short loc_804887F
loc_80488A9:
    mov     eax, ds:stdout
    push    eax; s
    push    13h; n
    push    1; size
    push    offset aGiveYourTitle; "\nGive your title : "
    call    _fwrite
    add     esp, 10h
    sub     esp, 4
    push    [ebp+var_54]
    push    [ebp+var_4C]
    push    0
    call    sub_804869C
    add     esp, 10h
    mov     eax, ds:stdout
    push    eax; s
    push    11h; n
    push    1; size
    push    offset aGiveYourNote; "Give your note : "
    call    _fwrite
    add     esp, 10h
    mov     eax, [ebp+size]
    sub     eax, [ebp+var_44]
    sub     eax, 10h
    mov     ecx, eax
    mov     eax, [ebp+var_44]
    lea     edx, [eax+10h]
    mov     eax, [ebp+var_4C]
    add     eax, edx
    sub     esp, 4
    push    ecx; nbytes
    push    eax; buf
    push    0; fd
    call    _read
    add     esp, 10h
    mov     eax, ds:stdout
    push    eax; s
    push    1Dh; n
    push    1; size
    push    offset aNowCheckYourNo; "\nnow , check your notebook :\n"
    call    _fwrite
    add     esp, 10h
    mov     eax, ds:stdout
    sub     esp, 4
    push    [ebp+var_4C]
    push    offset format; "title : %s"
    push    eax; stream
    call    _fprintf
    add     esp, 10h
    mov     eax, [ebp+var_44]
    lea     edx, [eax+10h]
    mov     eax, [ebp+var_4C]
    add     edx, eax
    mov     eax, ds:stdout
    sub     esp, 4
    push    edx
    push    offset aNoteS; "note : %s"
    push    eax; stream
    call    _fprintf
    add     esp, 10h
    nop
    mov     eax, [ebp+var_C]
    xor     eax, large gs:14h
    jz      short loc_8048973
    call    ___stack_chk_fail
loc_8048973:
    mov     ecx, [ebp+var_4]
    leave
    lea     esp, [ecx-4]
    retn
main endp

