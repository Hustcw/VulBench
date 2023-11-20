do_send_record proc
    push    ebx
    sub     esp, 28h
    mov     [esp+2Ch+protocol], 0; protocol
    mov     [esp+2Ch+type], 1; type
    mov     [esp+2Ch+domain], 2; domain
    call    _socket
    mov     ebx, eax
    mov     eax, ds:cp
    mov     [esp+2Ch+domain], eax; cp
    call    _inet_addr
    mov     dword ptr [esp+2Ch+addr.sa_data+2], eax
    mov     [esp+2Ch+addr.sa_family], 2
    mov     word ptr [esp+2Ch+addr.sa_data], 697Ah
    mov     [esp+2Ch+protocol], 10h; len
    lea     eax, [esp+2Ch+addr]
    mov     [esp+2Ch+type], eax; addr
    mov     [esp+2Ch+domain], ebx; fd
    call    _connect
    test    eax, eax
    jns     short loc_8049C91
    mov     [esp+2Ch+domain], offset aErrorFailToSen; "[Error] Fail to send your record. Make "...
    call    _puts
    jmp     short loc_8049CB5
loc_8049C91:
    mov     eax, [esp+2Ch+n]
    mov     [esp+2Ch+protocol], eax; n
    mov     eax, [esp+2Ch+buf]
    mov     [esp+2Ch+type], eax; buf
    mov     [esp+2Ch+domain], ebx; fd
    call    _write
    mov     [esp+2Ch+domain], offset aInfoRecordSend; "[Info] Record sended."
    call    _puts
loc_8049CB5:
    mov     [esp+2Ch+domain], ebx; fd
    call    _close
    add     esp, 28h
    pop     ebx
    retn
do_send_record endp

