main proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 2850h
    mov     eax, 3Ch ; '<'
    mov     rcx, fs:28h
    mov     [rbp+var_8], rcx
    mov     [rbp+var_2664], 0
    mov     [rbp+var_2668], edi
    mov     [rbp+var_2670], rsi
    mov     [rbp+var_2678], rdx
    mov     edi, eax; seconds
    call    _alarm
    xor     edi, edi
    mov     ecx, edi; n
    mov     edx, 2; modes
    mov     rsi, cs:stdin_ptr
    mov     rdi, [rsi]; stream
    mov     rsi, rcx; buf
    mov     [rbp+var_26B4], eax
    call    _setvbuf
    xor     edx, edx
    mov     ecx, edx; n
    mov     edx, 2; modes
    mov     rsi, cs:stdout_ptr
    mov     rdi, [rsi]; stream
    mov     rsi, rcx; buf
    mov     [rbp+var_26B8], eax
    call    _setvbuf
    lea     rdi, path; "/sandbox/"
    mov     [rbp+var_26BC], eax
    call    _chdir
    lea     rdi, name; "REMOTE_HOST"
    mov     [rbp+var_26C0], eax
    call    _getenv
    mov     edx, 0FFFh
    mov     esi, edx; maxlen
    lea     rdx, aSS; "%s%s/"
    lea     rcx, path; "/sandbox/"
    lea     rdi, [rbp+s]; s
    mov     [rbp+var_2688], rax
    mov     r8, [rbp+var_2688]
    mov     al, 0
    call    _snprintf
    mov     esi, 1C0h; mode
    lea     rdi, [rbp+s]; path
    mov     [rbp+var_26C4], eax
    call    _mkdir
    mov     esi, 0FFFh; maxlen
    lea     rdx, aSSPending; "%s%s/pending"
    lea     rcx, path; "/sandbox/"
    lea     rdi, [rbp+filename]; s
    mov     r8, [rbp+var_2688]
    mov     [rbp+var_26C8], eax
    mov     al, 0
    call    _snprintf
    lea     rsi, modes; "w+"
    lea     rdi, [rbp+filename]; filename
    mov     [rbp+var_26CC], eax
    call    _fopen
    mov     cs:stream, rax
    mov     rdi, cs:stream; stream
    call    _fileno
    mov     esi, 6; operation
    mov     edi, eax; fd
    call    _flock
    mov     dword ptr [rbp+size+4], eax
    cmp     dword ptr [rbp+size+4], 0FFFFFFFFh
    jnz     loc_1627
    lea     rdi, aNope; "Nope!\n"
    mov     al, 0
    call    _printf
    mov     edi, 1; status
    mov     [rbp+var_26D0], eax
    call    _exit
loc_1627:
    jmp     $+5
loc_162C:
    cmp     cs:dword_203128, 2
    jle     loc_1652
    lea     rdi, aThisIsDemoVers; "This is DEMO version\nPlease purchase a"...
    mov     al, 0
    call    _printf
    mov     [rbp+var_26D4], eax
    jmp     loc_1E02
loc_1652:
    call    sub_12D0
    call    sub_11F0
    dec     eax; switch 4 cases
    mov     ecx, eax
    sub     eax, 3
    mov     [rbp+var_26E0], rcx
    mov     [rbp+var_26E4], eax
    ja      def_168B; jumptable 000000000000168B default case
    lea     rax, jpt_168B
    mov     rcx, [rbp+var_26E0]
    movsxd  rdx, ds:(jpt_168B - 1F10h)[rax+rcx*4]
    add     rdx, rax
def_168B:
    jmp     rdx; switch jump
    cmp     cs:qword_203130, 0; jumptable 000000000000168B case 1
    jnz     loc_16A8
    cmp     cs:dword_203124, 0
    jle     loc_16AD
loc_16A8:
    jmp     loc_1DFD
loc_16AD:
    mov     eax, cs:dword_203128
    mov     ecx, eax
    add     ecx, 1
    mov     cs:dword_203128, ecx
    cmp     eax, 1
    jle     loc_16CC
    jmp     loc_1DFD
loc_16CC:
    lea     rdi, aEnterFileName; "Enter file name: "
    mov     al, 0
    call    _printf
    xor     ecx, ecx
    mov     edx, 0FFh
    lea     rdi, [rbp+var_510]; s
    mov     esi, 100h
    mov     r8d, esi
    mov     [rbp+var_26F0], rdi
    mov     esi, ecx; c
    mov     [rbp+var_26F8], rdx
    mov     rdx, r8; n
    mov     [rbp+var_26FC], eax
    mov     [rbp+var_2700], ecx
    call    _memset
    mov     edi, [rbp+var_2700]
    mov     rsi, [rbp+var_26F0]
    mov     rdx, [rbp+var_26F8]
    call    sub_1050
    lea     rdx, [rbp+var_510]
    mov     rdi, rdx; s
    mov     [rbp+var_2708], rax
    mov     [rbp+var_2710], rdx
    call    _strlen
    mov     ecx, eax
    mov     rdi, [rbp+var_2710]
    mov     esi, ecx
    call    sub_1380
    mov     ecx, 0FFFh
    mov     esi, ecx; maxlen
    lea     rdx, aSSS; "%s%s/%s"
    lea     rcx, path; "/sandbox/"
    lea     rdi, [rbp+s]; s
    mov     [rbp+var_2680], rax
    mov     r8, [rbp+var_2688]
    mov     r9, [rbp+var_2680]
    mov     al, 0
    call    _snprintf
    lea     rdi, aWritingS; "Writing: %s\n"
    lea     rsi, [rbp+s]
    mov     [rbp+var_2714], eax
    mov     al, 0
    call    _printf
    lea     rsi, modes; "w+"
    lea     rdi, [rbp+s]; filename
    mov     [rbp+var_2718], eax
    call    _fopen
    mov     cs:qword_203130, rax
    cmp     cs:qword_203130, 0
    jnz     loc_17F2
    lea     rdi, aCanTOpenFile; "Can't open file"
    call    _puts
    mov     [rbp+var_271C], eax
    jmp     loc_1E02
loc_17F2:
    mov     cs:dword_203124, 1
    jmp     loc_1DFD
    cmp     cs:qword_203130, 0; jumptable 000000000000168B case 2
    jnz     loc_181C
    cmp     cs:dword_203124, 0
    jle     loc_1821
loc_181C:
    jmp     loc_1DFD
loc_1821:
    mov     eax, cs:dword_203128
    mov     ecx, eax
    add     ecx, 1
    mov     cs:dword_203128, ecx
    cmp     eax, 1
    jle     loc_1840
    jmp     loc_1DFD
loc_1840:
    lea     rdi, aEnterFileName; "Enter file name: "
    mov     al, 0
    call    _printf
    xor     ecx, ecx
    mov     edx, 0FFh
    lea     rdi, [rbp+var_510]; s
    mov     esi, 100h
    mov     r8d, esi
    mov     [rbp+var_2728], rdi
    mov     esi, ecx; c
    mov     [rbp+var_2730], rdx
    mov     rdx, r8; n
    mov     [rbp+var_2734], eax
    mov     [rbp+var_2738], ecx
    call    _memset
    mov     edi, [rbp+var_2738]
    mov     rsi, [rbp+var_2728]
    mov     rdx, [rbp+var_2730]
    call    sub_1050
    lea     rdx, [rbp+var_510]
    mov     rdi, rdx; s
    mov     [rbp+var_2740], rax
    mov     [rbp+var_2748], rdx
    call    _strlen
    mov     ecx, eax
    mov     rdi, [rbp+var_2748]
    mov     esi, ecx
    call    sub_1380
    mov     ecx, 0FFFh
    mov     esi, ecx; maxlen
    lea     rdx, aSSS; "%s%s/%s"
    lea     rcx, path; "/sandbox/"
    lea     rdi, [rbp+s]; s
    mov     [rbp+var_2680], rax
    mov     r8, [rbp+var_2688]
    mov     r9, [rbp+var_2680]
    mov     al, 0
    call    _snprintf
    lea     rdi, aReadingS; "Reading: %s\n"
    lea     rsi, [rbp+s]
    mov     [rbp+var_274C], eax
    mov     al, 0
    call    _printf
    lea     rsi, aR; "r"
    lea     rdi, [rbp+s]; filename
    mov     [rbp+var_2750], eax
    call    _fopen
    mov     cs:qword_203130, rax
    cmp     cs:qword_203130, 0
    jnz     loc_1966
    lea     rdi, aNoSuchFile; "No such file"
    call    _puts
    mov     [rbp+var_2754], eax
    jmp     loc_1E02
loc_1966:
    mov     cs:dword_203124, 2
    jmp     loc_1DFD
    jmp     loc_1E02; jumptable 000000000000168B case 4
    cmp     cs:dword_203124, 1; jumptable 000000000000168B case 3
    jnz     loc_1B84
    lea     rdi, aSizeData; "Size data"
    mov     al, 0
    call    _printf
    mov     [rbp+var_2758], eax
    call    sub_11F0
    mov     dword ptr [rbp+size], eax
    cmp     dword ptr [rbp+size], 400h
    jle     loc_19C0
    mov     dword ptr [rbp+size], 400h
loc_19C0:
    lea     rdi, aData; "Data> "
    mov     al, 0
    call    _printf
    xor     ecx, ecx
    lea     rdi, [rbp+ptr]; s
    mov     edx, 400h; n
    mov     [rbp+var_2760], rdi
    mov     esi, ecx; c
    mov     [rbp+var_2764], eax
    mov     [rbp+var_2768], ecx
    call    _memset
    mov     eax, dword ptr [rbp+size]
    mov     edx, eax
    mov     edi, [rbp+var_2768]
    mov     rsi, [rbp+var_2760]
    call    sub_1050
    xor     ecx, ecx
    mov     esi, ecx; off
    xor     edx, edx; whence
    mov     rdi, cs:qword_203130; stream
    mov     [rbp+var_2770], rax
    call    _fseek
    mov     ecx, 1
    mov     edx, ecx; n
    lea     rdi, [rbp+ptr]; ptr
    mov     ecx, dword ptr [rbp+size]
    mov     esi, ecx; size
    mov     rcx, cs:qword_203130; s
    mov     [rbp+var_2774], eax
    call    _fwrite
    lea     rdi, aKey; "Key> "
    mov     [rbp+var_2780], rax
    mov     al, 0
    call    _printf
    xor     r8d, r8d
    mov     r9d, 10h
    mov     edx, r9d
    lea     rcx, [rbp+var_540]
    mov     r9d, 21h ; '!'
    mov     esi, r9d
    mov     rdi, rcx; s
    mov     [rbp+n], rsi
    mov     esi, r8d; c
    mov     r10, [rbp+n]
    mov     [rbp+var_2790], rdx
    mov     rdx, r10; n
    mov     [rbp+var_2794], eax
    mov     [rbp+var_2798], r8d
    mov     [rbp+var_27A0], rcx
    call    _memset
    mov     edi, [rbp+var_2798]
    mov     rsi, [rbp+var_27A0]
    mov     rdx, [rbp+var_2790]
    call    sub_1050
    mov     esi, 10h
    lea     rdi, [rbp+var_540]
    mov     [rbp+var_27A8], rax
    call    sub_1380
    mov     esi, 1; size
    mov     r8d, 20h ; ' '
    mov     edx, r8d; n
    mov     [rbp+var_2698], rax
    mov     rdi, [rbp+var_2698]; ptr
    mov     rcx, cs:qword_203130; s
    call    _fwrite
    mov     rdi, cs:qword_203130; stream
    mov     [rbp+var_27B0], rax
    call    _fclose
    lea     rsi, [rbp+stat_buf]; stat_buf
    lea     rdi, [rbp+s]; filename
    mov     cs:qword_203130, 0
    mov     cs:dword_203124, 0
    mov     [rbp+var_27B4], eax
    call    sub_1EF0
    lea     rdi, aDWrittenBytes; "%d written bytes\n"
    mov     rcx, [rbp+stat_buf.st_size]
    mov     r8d, ecx
    mov     dword ptr [rbp+var_26A0+4], r8d
    mov     esi, dword ptr [rbp+var_26A0+4]
    mov     [rbp+var_27B8], eax
    mov     al, 0
    call    _printf
    mov     [rbp+var_27BC], eax
loc_1B84:
    cmp     cs:dword_203124, 2
    jnz     loc_1DF3
    lea     rsi, [rbp+var_2660]; stat_buf
    lea     rdi, [rbp+s]; filename
    call    sub_1EF0
    xor     edx, edx; whence
    mov     rsi, [rbp+var_2660.st_size]
    mov     ecx, esi
    mov     dword ptr [rbp+var_26A0], ecx
    mov     rdi, cs:qword_203130; stream
    mov     ecx, dword ptr [rbp+var_26A0]
    sub     ecx, 20h ; ' '
    movsxd  rsi, ecx; off
    mov     [rbp+var_27C0], eax
    call    _fseek
    mov     ecx, 1
    mov     esi, ecx
    mov     ecx, 20h ; ' '
    mov     edx, ecx
    lea     rdi, [rbp+ptr]; s
    xor     ecx, ecx
    mov     r8d, 400h
    mov     r9d, r8d
    mov     [rbp+var_27C8], rdi
    mov     [rbp+var_27D0], rsi
    mov     esi, ecx; c
    mov     [rbp+var_27D8], rdx
    mov     rdx, r9; n
    mov     [rbp+var_27DC], eax
    call    _memset
    mov     rcx, cs:qword_203130; stream
    mov     rdi, [rbp+var_27C8]; ptr
    mov     rsi, [rbp+var_27D0]; size
    mov     rdx, [rbp+var_27D8]; n
    call    _fread
    lea     rdi, aEnterKey; "Enter key> "
    mov     [rbp+var_27E8], rax
    mov     al, 0
    call    _printf
    xor     r8d, r8d
    mov     r10d, 10h
    mov     edx, r10d
    lea     rcx, [rbp+var_540]
    mov     r10d, 21h ; '!'
    mov     esi, r10d
    mov     rdi, rcx; s
    mov     [rbp+var_27F0], rsi
    mov     esi, r8d; c
    mov     r9, [rbp+var_27F0]
    mov     [rbp+var_27F8], rdx
    mov     rdx, r9; n
    mov     [rbp+var_27FC], eax
    mov     [rbp+var_2800], r8d
    mov     [rbp+var_2808], rcx
    call    _memset
    mov     edi, [rbp+var_2800]
    mov     rsi, [rbp+var_2808]
    mov     rdx, [rbp+var_27F8]
    call    sub_1050
    mov     esi, 10h
    lea     rdi, [rbp+var_540]
    mov     [rbp+var_2810], rax
    call    sub_1380
    mov     esi, 20h ; ' '
    mov     edx, esi; n
    lea     rsi, [rbp+ptr]; s2
    mov     [rbp+s1], rax
    mov     rdi, [rbp+s1]; s1
    call    _strncmp
    cmp     eax, 0
    jz      loc_1D13
    lea     rdi, aWrongKey; "Wrong key"
    call    _puts
    mov     [rbp+var_2814], eax
    jmp     loc_1DA6
loc_1D13:
    xor     eax, eax
    mov     esi, eax; off
    xor     edx, edx; whence
    mov     rdi, cs:qword_203130; stream
    call    _fseek
    mov     edx, dword ptr [rbp+var_26A0]
    add     edx, 1
    movsxd  rdi, edx; size
    mov     [rbp+var_2818], eax
    call    _malloc
    mov     edx, 1
    mov     esi, edx; size
    mov     [rbp+var_26B0], rax
    mov     rdi, [rbp+var_26B0]; ptr
    mov     edx, dword ptr [rbp+var_26A0]; n
    mov     rcx, cs:qword_203130; stream
    call    _fread
    lea     rdi, aYourDataSizeD; "Your data (size: %d):\n"
    mov     esi, dword ptr [rbp+var_26A0]
    mov     [rbp+var_2820], rax
    mov     al, 0
    call    _printf
    mov     edi, 1
    mov     rsi, [rbp+var_26B0]
    mov     r8d, dword ptr [rbp+var_26A0]
    mov     edx, r8d
    mov     [rbp+var_2824], eax
    call    sub_1150
    mov     [rbp+var_2830], rax
loc_1DA6:
    mov     rdi, cs:qword_203130; stream
    call    _fclose
    lea     rdi, aNowYourFileIsG; "\n--------------\nNow your file is goin"...
    mov     [rbp+var_2834], eax
    mov     al, 0
    call    _printf
    lea     rdi, [rbp+s]; name
    mov     [rbp+var_2838], eax
    call    _unlink
    mov     cs:qword_203130, 0
    mov     cs:dword_203124, 0
    mov     [rbp+var_283C], eax
loc_1DF3:
    jmp     loc_1DFD
    jmp     $+5; jumptable 000000000000168B default case
loc_1DFD:
    jmp     loc_162C
loc_1E02:
    lea     rdi, aBye; "\nBye!\n"
    xor     eax, eax
    mov     cl, al
    mov     al, cl
    call    _printf
    mov     rdi, cs:stream; stream
    mov     [rbp+var_2840], eax
    call    _fileno
    mov     esi, 8; operation
    mov     edi, eax; fd
    call    _flock
    mov     rdi, cs:stream; stream
    mov     [rbp+var_2844], eax
    call    _fclose
    mov     rdi, fs:28h
    mov     rdx, [rbp+var_8]
    cmp     rdi, rdx
    mov     [rbp+var_2848], eax
    jnz     loc_1E6B
    xor     eax, eax
    add     rsp, 2850h
    pop     rbp
    retn
loc_1E6B:
    call    ___stack_chk_fail
main endp

