main proc
    lea     ecx, [esp+4]
    and     esp, 0FFFFFFF0h
    push    dword ptr [ecx-4]
    push    ebp
    mov     ebp, esp
    push    ecx
    sub     esp, 114h
    call    sub_80485FB
    call    sub_8048853
loc_8048899:
    sub     esp, 0Ch
    push    offset aEnterYourComma; "Enter your command: "
    call    _printf
    add     esp, 10h
    mov     eax, ds:stdin
    sub     esp, 4
    push    eax; stream
    push    100h; n
    lea     eax, [ebp+s]
    push    eax; s
    call    _fgets
    add     esp, 10h
    lea     eax, [ebp+s]
    movzx   edx, byte ptr [eax]
    mov     eax, offset a0; "0"
    movzx   eax, byte ptr [eax]
    cmp     dl, al
    jnz     short loc_80488E5
    call    sub_80486DC
    jmp     loc_8048A54
loc_80488E5:
    lea     eax, [ebp+s]
    movzx   edx, byte ptr [eax]
    mov     eax, offset a1; "1"
    movzx   eax, byte ptr [eax]
    cmp     dl, al
    jnz     short loc_8048904
    call    sub_8048742
    jmp     loc_8048A54
loc_8048904:
    lea     eax, [ebp+s]
    movzx   edx, byte ptr [eax]
    mov     eax, offset a2; "2"
    movzx   eax, byte ptr [eax]
    cmp     dl, al
    jnz     loc_80489E1
    sub     esp, 0Ch
    push    offset aWhichTweetWoul; "Which tweet would you like to overwrite"...
    call    _printf
    add     esp, 10h
    mov     eax, ds:stdin
    sub     esp, 4
    push    eax; stream
    push    100h; n
    lea     eax, [ebp+s]
    push    eax; s
    call    _fgets
    add     esp, 10h
    sub     esp, 0Ch
    lea     eax, [ebp+s]
    push    eax; nptr
    call    _atoi
    add     esp, 10h
    mov     [ebp+var_C], eax
    mov     eax, ds:dword_8049FB4
    cmp     [ebp+var_C], eax
    jb      short loc_804897E
    sub     esp, 0Ch
    push    offset aInvalidTweetIn; "Invalid tweet index."
    call    _puts
    add     esp, 10h
    jmp     loc_8048A54
loc_804897E:
    sub     esp, 0Ch
    push    offset aEnterANewTweet; "Enter a new tweet: "
    call    _printf
    add     esp, 10h
    mov     eax, ds:stdin
    sub     esp, 4
    push    eax; stream
    push    100h; n
    lea     eax, [ebp+s]
    push    eax; s
    call    _fgets
    add     esp, 10h
    sub     esp, 8
    push    offset reject; "\n"
    lea     eax, [ebp+s]
    push    eax; s
    call    _strcspn
    add     esp, 10h
    mov     [ebp+eax+s], 0
    sub     esp, 8
    lea     eax, [ebp+s]
    push    eax; s
    push    [ebp+var_C]; int
    call    sub_8048680
    add     esp, 10h
    jmp     short loc_8048A54
loc_80489E1:
    lea     eax, [ebp+s]
    movzx   edx, byte ptr [eax]
    mov     eax, offset a3; "3"
    movzx   eax, byte ptr [eax]
    cmp     dl, al
    jnz     short loc_8048A54
    sub     esp, 0Ch
    push    offset aEnterANewTweet; "Enter a new tweet: "
    call    _printf
    add     esp, 10h
    mov     eax, ds:stdin
    sub     esp, 4
    push    eax; stream
    push    100h; n
    lea     eax, [ebp+s]
    push    eax; s
    call    _fgets
    add     esp, 10h
    sub     esp, 8
    push    offset reject; "\n"
    lea     eax, [ebp+s]
    push    eax; s
    call    _strcspn
    add     esp, 10h
    mov     [ebp+eax+s], 0
    sub     esp, 0Ch
    lea     eax, [ebp+s]
    push    eax; src
    call    sub_80487A7
    add     esp, 10h
loc_8048A54:
    jmp     loc_8048899
main endp

