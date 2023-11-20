sub_AFE proc
    sub     rsp, 58h
    mov     rax, fs:28h
    mov     [rsp+58h+var_10], rax
    xor     eax, eax
    mov     rax, 74616D726F294628h
    mov     qword ptr [rsp+58h+var_58], rax
    mov     rax, 20676E6972745320h
    mov     qword ptr [rsp+58h+var_58+8], rax
    mov     rax, 722941280A677542h
    mov     qword ptr [rsp+58h+var_58+10h], rax
    mov     rax, 2079726172746962h
    mov     qword ptr [rsp+58h+var_58+18h], rax
    mov     rax, 53280A6574697257h
    mov     qword ptr [rsp+58h+var_58+20h], rax
    mov     rax, 764F206B63617429h
    mov     qword ptr [rsp+58h+var_58+28h], rax
    mov     rax, 280A776F6C667265h
    mov     qword ptr [rsp+58h+var_58+30h], rax
    mov     dword ptr [rsp+58h+var_58+38h], 69782945h
    mov     word ptr [rsp+58h+var_58+3Ch], 0A74h
    mov     [rsp+58h+var_58+3Eh], 0
    mov     rdi, rsp; s
    call    puts
    lea     rsi, aYourChoice; "Your choice: "
    mov     edi, 1
    mov     eax, 0
    call    __printf_chk
    mov     rax, [rsp+58h+var_10]
    xor     rax, fs:28h
    jz      short loc_BC1
    call    __stack_chk_fail
loc_BC1:
    add     rsp, 58h
    retn
sub_AFE endp

