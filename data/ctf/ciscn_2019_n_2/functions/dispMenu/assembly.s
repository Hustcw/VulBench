dispMenu proc
    push    rbp
    mov     rbp, rsp
    mov     edi, offset asc_4011A0; "$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    call    puts
    mov     edi, offset aBabyTcache; "$       Baby Tcache       $"
    call    puts
    mov     edi, offset asc_4011A0; "$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    call    puts
    mov     edi, offset a1CreateUser; "$   1. Create user        $"
    call    puts
    mov     edi, offset a2DeleteUser; "$   2. Delete user        $ "
    call    puts
    mov     edi, offset a3EditUser; "$   3. Edit user          $ "
    call    puts
    mov     edi, offset a4DisplayUser; "$   4. Display user       $ "
    call    puts
    mov     edi, offset a5AddMoney; "$   5. Add money          $ "
    call    puts
    mov     edi, offset a6BuyGift; "$   6. Buy gift           $ "
    call    puts
    mov     edi, offset a7Exit; "$   7. Exit               $ "
    call    puts
    mov     edi, offset asc_4011A0; "$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    call    puts
    mov     edi, offset format; "Your choice: "
    mov     eax, 0
    call    printf
    pop     rbp
    retn
dispMenu endp

