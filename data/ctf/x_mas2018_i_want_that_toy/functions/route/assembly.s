route proc
    push    rbp
    mov     rbp, rsp
    sub     rsp, 10h
    mov     rax, fs:28h
    mov     [rbp+var_8], rax
    xor     eax, eax
    lea     rax, uri
    mov     rax, [rax]
    mov     rsi, rax; s2
    lea     rdi, s1; "/"
    call    _strcmp
    test    eax, eax
    jnz     loc_10C2
    lea     rax, method
    mov     rax, [rax]
    mov     rsi, rax; s2
    lea     rdi, aGet; "GET"
    call    _strcmp
    test    eax, eax
    jnz     loc_10C2
    lea     rdi, s; "HTTP/1.1 200 OK\r\n\r"
    call    _puts
    lea     rdi, aToy; "toy"
    call    request_query_var
    mov     [rbp+var_10], rax
    lea     rdi, format; "<html><head><title>X-MAS API</title><he"...
    mov     eax, 0
    call    _printf
    lea     rdi, aH1WelcomeToThe; "<h1>Welcome to the <b>X-MAS</b> wishes "...
    mov     eax, 0
    call    _printf
    cmp     [rbp+var_10], 0
    jnz     short loc_1051
    lea     rdi, aSubmitYourDesi; "Submit your desired toy by using ?toy p"...
    mov     eax, 0
    call    _printf
    lea     rdi, aForEasierDataH; "For easier data handling, Santa wants y"...
    mov     eax, 0
    call    _printf
    lea     rdi, aExampleIGetPar; "Example: <i>GET /?parameter=base64_stri"...
    mov     eax, 0
    call    _printf
    jmp     short loc_1069
loc_1051:
    mov     rax, [rbp+var_10]
    mov     rsi, rax
    lea     rdi, aSantaWillBring; "Santa will bring you the <b>%s</b> this"...
    mov     eax, 0
    call    _printf
loc_1069:
    lea     rdi, aBrBrBrBrFooter; "<br><br><br><br><footer><small> Be care"...
    call    _puts
    lea     rax, uri
    mov     rax, [rax]
    mov     rsi, rax
    lea     rdi, aBrGetS; "<br>[GET] %s - "
    mov     eax, 0
    call    _printf
    lea     rdi, aUserAgent; "User-Agent"
    call    request_header
    mov     rdi, rax; format
    mov     eax, 0
    call    _printf
    lea     rdi, aSmallFooterBod; "</small></footer></body></html>"
    mov     eax, 0
    call    _printf
    jmp     loc_1143
loc_10C2:
    lea     rax, uri
    mov     rax, [rax]
    mov     rsi, rax; s2
    lea     rdi, s1; "/"
    call    _strcmp
    test    eax, eax
    jnz     short loc_1137
    lea     rax, method
    mov     rax, [rax]
    mov     rsi, rax; s2
    lea     rdi, aPost; "POST"
    call    _strcmp
    test    eax, eax
    jnz     short loc_1137
    lea     rdi, s; "HTTP/1.1 200 OK\r\n\r"
    call    _puts
    lea     rax, payload_size
    mov     eax, [rax]
    mov     esi, eax
    lea     rdi, aWowSeemsThatYo; "Wow, seems that you POSTed %d bytes. \r"...
    mov     eax, 0
    call    _printf
    lea     rdi, aFetchTheDataUs; "Fetch the data using `payload` variable"...
    mov     eax, 0
    call    _printf
    jmp     short loc_1143
loc_1137:
    lea     rdi, aHttp11500NotHa; "HTTP/1.1 500 Not Handled\r\n\r\nThe ser"...
    call    _puts
loc_1143:
    nop
    mov     rax, [rbp+var_8]
    xor     rax, fs:28h
    jz      short locret_1158
    call    ___stack_chk_fail
locret_1158:
    leave
    retn
route endp

