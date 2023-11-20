main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 1B0h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    mov     rax, 676F6C2F706D742Fh
    mov     qword ptr [rbp+dest], rax
    mov     [rbp+var_C8], 2F726567h
    mov     [rbp+var_C0], 0
    mov     [rbp+var_B8], 0
    mov     [rbp+var_B0], 0
    mov     [rbp+var_A8], 0
    mov     [rbp+var_A0], 0
    mov     rax, cs:_edata
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     rax, cs:stdout@@GLIBC_2_2_5
    mov     ecx, 0; n
    mov     edx, 2; modes
    mov     esi, 0; buf
    mov     rdi, rax; stream
    call    _setvbuf
    mov     edi, offset aWelcomeToLoggi; "Welcome to logging service."
    call    _puts
    mov     edi, offset aLogFileWillBeR; "Log file will be removed every 5 minite"...
    call    _puts
    mov     edi, offset a1Login2Exit; "1. Login\n2. exit"
    call    _puts
    lea     rax, [rbp+size]
    mov     rsi, rax
    mov     edi, offset aLd; "%ld"
    mov     eax, 0
    call    ___isoc99_scanf
    call    _getchar
    mov     rax, [rbp+size]
    cmp     rax, 1
    jz      short loc_400F78
    mov     edi, 0; status
    call    _exit
loc_400F78:
    mov     esi, offset aName; "Name    :"
    mov     edi, offset aS; "%s"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_90]
    mov     rsi, rax
    mov     edi, offset a63s; "%63s"
    mov     eax, 0
    call    ___isoc99_scanf
    mov     esi, offset aPassword; "Password:"
    mov     edi, offset aS; "%s"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_50]
    mov     rsi, rax
    mov     edi, offset a63s; "%63s"
    mov     eax, 0
    call    ___isoc99_scanf
    lea     rdx, [rbp+var_100]
    lea     rcx, [rbp+var_50]
    lea     rax, [rbp+var_90]
    mov     rsi, rcx
    mov     rdi, rax
    call    calc_filename
    mov     rdx, rax
    lea     rax, [rbp+dest]
    mov     rsi, rdx; src
    mov     rdi, rax; dest
    call    _strcat
    mov     eax, 0
    call    check_dir
    test    eax, eax
    jnz     short loc_401023
    mov     edi, offset aTmpLoggerDirec; "/tmp/logger directory not exists"
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_401023:
    lea     rax, [rbp+dest]
    mov     esi, offset modes; "a+"
    mov     rdi, rax; filename
    call    _fopen
    mov     cs:fp, rax
    mov     rax, cs:fp
    test    rax, rax
    jnz     short loc_40105E
    mov     edi, offset aOpenError; "open error."
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_40105E:
    lea     rdx, [rbp+var_190]
    lea     rax, [rbp+dest]
    mov     rsi, rdx; stat_buf
    mov     rdi, rax; filename
    call    stat
    mov     rax, [rbp+n]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+buf], rax
loc_40108F:
    mov     edi, offset a1ReadLog2Appen; "1. Read log\n2. Append log\n3. Display "...
    call    _puts
    lea     rax, [rbp+size]
    mov     rsi, rax
    mov     edi, offset aLd; "%ld"
    mov     eax, 0
    call    ___isoc99_scanf
    call    _getchar
    mov     rax, [rbp+size]
    cmp     rax, 1
    jnz     short loc_401134
    mov     [rbp+var_1A8], 0
    jmp     short loc_4010F1
loc_4010D0:
    mov     rdx, [rbp+buf]
    mov     eax, [rbp+var_1A8]
    cdqe
    add     rdx, rax
    mov     eax, [rbp+var_1A4]
    mov     [rdx], al
    add     [rbp+var_1A8], 1
loc_4010F1:
    mov     rax, cs:fp
    mov     rdi, rax; stream
    call    _fgetc
    mov     [rbp+var_1A4], eax
    cmp     [rbp+var_1A4], 0FFFFFFFFh
    jnz     short loc_4010D0
    mov     rdx, [rbp+n]; n
    mov     rax, [rbp+buf]
    mov     rsi, rax; buf
    mov     edi, 1; fd
    mov     eax, 0
    call    _write
    jmp     loc_40130B
loc_401134:
    mov     rax, [rbp+size]
    cmp     rax, 2
    jnz     loc_40127D
    mov     esi, offset aLogSizeMax128b; "Log size(max 128byte):"
    mov     edi, offset aS; "%s"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+size]
    mov     rsi, rax
    mov     edi, offset aLd; "%ld"
    mov     eax, 0
    call    ___isoc99_scanf
    call    _getchar
    mov     rax, [rbp+size]
    cmp     rax, 80h
    jle     short loc_40119A
    mov     edi, offset aSizeError; "Size error."
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_40119A:
    mov     rax, [rbp+size]
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+ptr], rax
    mov     rdx, [rbp+size]; nbytes
    mov     rax, [rbp+ptr]
    mov     rsi, rax; buf
    mov     edi, 0; fd
    mov     eax, 0
    call    _read
    mov     [rbp+var_1A8], eax
    mov     rdx, cs:fp
    mov     eax, [rbp+var_1A8]
    movsxd  rsi, eax; size
    mov     rax, [rbp+ptr]
    mov     rcx, rdx; s
    mov     edx, 1; n
    mov     rdi, rax; ptr
    call    _fwrite
    mov     rax, cs:fp
    mov     rdi, rax; stream
    call    _fclose
    lea     rdx, [rbp+var_190]
    lea     rax, [rbp+dest]
    mov     rsi, rdx; stat_buf
    mov     rdi, rax; filename
    call    stat
    lea     rax, [rbp+dest]
    mov     esi, offset modes; "a+"
    mov     rdi, rax; filename
    call    _fopen
    mov     cs:fp, rax
    mov     rax, cs:fp
    test    rax, rax
    jnz     short loc_401260
    mov     edi, offset aOpenError; "open error."
    call    _puts
    mov     edi, 1; status
    call    _exit
loc_401260:
    mov     rax, [rbp+n]
    cdqe
    mov     rdi, rax; size
    call    _malloc
    mov     [rbp+buf], rax
    jmp     loc_40130B
loc_40127D:
    mov     rax, [rbp+size]
    cmp     rax, 3
    jnz     short loc_4012E8
    mov     edi, offset aInfo; "=====Info====="
    call    _puts
    lea     rax, [rbp+var_90]
    mov     rsi, rax
    mov     edi, offset aYourNameS; "Your Name: %s"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_50]
    mov     rsi, rax
    mov     edi, offset aYourPasswordS; "Your Password: %s"
    mov     eax, 0
    call    _printf
    lea     rax, [rbp+var_100]
    mov     rsi, rax
    mov     edi, offset aFilenameS; "filename: %s"
    mov     eax, 0
    call    _printf
    mov     edi, offset asc_4015E9; "=============="
    call    _puts
    jmp     short loc_40130B
loc_4012E8:
    mov     rax, cs:fp
    mov     rdi, rax; stream
    call    _fclose
    mov     edi, offset aThankYouForYou; "Thank you for your logging :)"
    call    _puts
    mov     edi, 0; status
    call    _exit
loc_40130B:
    jmp     loc_40108F
main endp

