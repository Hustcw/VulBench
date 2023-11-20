psf_binheader_writef proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0D8h
    mov     rbp, format
    mov     r14, psf
    test    al, al
    jz      short loc_432A42
    movaps  [rsp+108h+var_B8], xmm0
    movaps  [rsp+108h+var_A8], xmm1
    movaps  [rsp+108h+var_98], xmm2
    movaps  [rsp+108h+var_88], xmm3
    movaps  [rsp+108h+var_78], xmm4
    movaps  [rsp+108h+var_68], xmm5
    movaps  [rsp+108h+var_58], xmm6
    movaps  [rsp+108h+var_48], xmm7
loc_432A42:
    mov     [rsp+108h+var_D8], rdx
    mov     [rsp+108h+var_D0], rcx
    mov     [rsp+108h+var_C8], r8
    mov     [rsp+108h+var_C0], r9
    test    format, format
    jz      short loc_432A9E
    lea     rax, [rsp+108h+var_E8]
    mov     [rsp+108h+var_108.reg_save_area], rax
    lea     rax, [rsp+108h+argptr]
    mov     [rsp+108h+var_108.overflow_arg_area], rax
    mov     rax, 3000000010h
    mov     qword ptr [rsp+108h+var_108.gp_offset], rax
    mov     bl, [rbp+0]
    test    bl, bl
    jz      loc_433403
    mov     r13d, 0FEh
    mov     [rsp+108h+var_EC], 0
    xor     r15d, r15d
    jmp     short loc_432ADF
loc_432A9E:
    mov     rdi, psf; psf
    call    psf_ftell
    mov     r15, rax
    jmp     loc_433406
    mov     esi, offset aInvalidFormatS; jumptable 0000000000432B13 default case, cases 33-48,53-55,57-68,70-82,85-97,99,103,105,107,108,110,113,114,117-121
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     dword ptr [psf+1D78h], 1Dh
    nop     dword ptr [rax+rax+00000000h]
loc_432AD0:
    add     rbp, 1; jumptable 0000000000432B13 case 32
    mov     bl, [format+0]
    test    bl, bl
    jz      loc_433406
loc_432ADF:
    mov     rax, [psf+1B30h]
    add     rax, 10h
    cmp     rax, [psf+1B40h]
    jl      short loc_432B08
    mov     esi, 10h; needed
    mov     rdi, psf; psf
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_433406
loc_432B08:
    movsx   edx, bl
    lea     eax, [rdx-20h]; switch 91 cases
    cmp     eax, 5Ah
    ja      short def_432B13; jumptable 0000000000432B13 default case, cases 33-48,53-55,57-68,70-82,85-97,99,103,105,107,108,110,113,114,117-121
def_432B13:
    jmp     ds:jpt_432B13[rax*8]; switch jump
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 49
    cmp     rcx, 28h ; '('
    ja      loc_432E80
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432E8E
    movsxd  rcx, [rsp+108h+var_108.fp_offset]; jumptable 0000000000432B13 case 100
    cmp     rcx, 0A0h
    ja      loc_432D87
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 10h
    mov     [rsp+108h+var_108.fp_offset], ecx
    jmp     loc_432D95
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 104
    cmp     rcx, 28h ; '('
    ja      loc_432DC2
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432DD0
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 115
    cmp     rcx, 28h ; '('
    ja      loc_432DF9
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432E07
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 50
    cmp     rcx, 28h ; '('
    ja      loc_432EA2
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432EB0
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 51
    cmp     rcx, 28h ; '('
    ja      loc_432ED4
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432EE2
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 52
    cmp     rcx, 28h ; '('
    ja      loc_432F06
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432F14
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 56
    cmp     rcx, 28h ; '('
    ja      loc_432F38
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432F46
    mov     dword ptr [psf+1B48h], 20000000h; jumptable 0000000000432B13 case 69
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 83
    cmp     rcx, 28h ; '('
    ja      loc_432F74
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432F82
    mov     [rsp+108h+var_EC], 0; jumptable 0000000000432B13 case 84
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 98
    cmp     rcx, 29h ; ')'
    jnb     loc_432FD7
    mov     rdx, [rsp+108h+var_108.reg_save_area]
    mov     rax, rcx
    add     rax, 8
    mov     [rsp+108h+var_108.gp_offset], eax
    mov     r12, [rdx+rcx]
    cmp     eax, 28h ; '('
    ja      loc_432FE8
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 10h
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432FF6
    mov     dword ptr [psf+1B48h], 10000000h; jumptable 0000000000432B13 case 101
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
    movsxd  rcx, [rsp+108h+var_108.fp_offset]; jumptable 0000000000432B13 case 102
    cmp     rcx, 0A0h
    ja      loc_433048
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 10h
    mov     [rsp+108h+var_108.fp_offset], ecx
    jmp     loc_433056
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 106
    cmp     rcx, 28h ; '('
    ja      loc_433087
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_433095
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 109
    cmp     rcx, 28h ; '('
    ja      loc_4330D7
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_4330E5
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 111
    cmp     rcx, 28h ; '('
    ja      loc_4330F8
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_433106
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 112
    cmp     rcx, 28h ; '('
    ja      loc_433131
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_43313F
    mov     [rsp+108h+var_EC], 1; jumptable 0000000000432B13 case 116
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432B13 case 122
    cmp     rcx, 28h ; '('
    ja      loc_4331BD
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_4331CB
loc_432D87:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432D95:
    movsd   xmm0, qword ptr [rax]
    mov     rdi, [psf+1B28h]
    add     rdi, [psf+1B30h]; out
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_432E6A
    call    double64_be_write
    jmp     loc_432E6F
loc_432DC2:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432DD0:
    mov     rax, [rax]
    mov     rcx, [psf+1B28h]
    mov     rdx, [psf+1B30h]
    movups  xmm0, xmmword ptr [bindata]
    movups  xmmword ptr [rcx+rdx], xmm0
    add     qword ptr [psf+1B30h], 10h
    add     r15d, 10h
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_432DF9:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432E07:
    mov     r12, [rax]
    mov     rdi, strptr; s
    call    _strlen
    lea     rcx, [rax+1]
    and     ecx, 1
    lea     r13, [rcx+rax]
    add     r13, 1
    mov     rax, [psf+1B30h]
    add     rax, size
    cmp     rax, [psf+1B40h]
    jl      short loc_432E49
    mov     esi, 10h; needed
    mov     rdi, psf; psf
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_433406
loc_432E49:
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_433222
    mov     rdi, psf; psf
    mov     esi, r13d; x
    call    header_put_be_int
    jmp     loc_43322D
loc_432E6A:
    call    double64_le_write
loc_432E6F:
    add     qword ptr [psf+1B30h], 8
    add     r15d, 8
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_432E80:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432E8E:
    movsx   esi, byte ptr [rax]; x
    mov     rdi, psf; psf
    call    header_put_byte
    add     r15d, 1
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_432EA2:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432EB0:
    mov     esi, [rax]; x
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_433276
    mov     rdi, psf; psf
    call    header_put_be_short
    add     r15d, 2
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_432ED4:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432EE2:
    mov     esi, [rax]; x
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_433287
    mov     rdi, psf; psf
    call    header_put_be_3byte
    add     r15d, 3
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_432F06:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432F14:
    mov     esi, [rax]; x
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_433298
    mov     rdi, psf; psf
    call    header_put_be_int
    add     r15d, 4
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_432F38:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432F46:
    mov     ecx, [rsp+108h+var_EC]
    mov     rsi, [rax]; x
    mov     eax, [psf+1B48h]
    test    ecx, ecx
    jnz     loc_4332A9
    cmp     eax, 20000000h
    jnz     loc_4332A9
    mov     rdi, psf; psf
    call    header_put_be_8byte
    jmp     loc_4332C4
loc_432F74:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432F82:
    mov     c, [rax]
    mov     rdi, strptr; s
    call    _strlen
    mov     r12, rax
    mov     rax, [psf+1B30h]
    add     rax, size
    cmp     rax, [psf+1B40h]
    jle     short loc_432FB6
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432AD0; jumptable 0000000000432B13 case 32
loc_432FB6:
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_4332EB
    mov     rdi, psf; psf
    mov     esi, r12d; x
    call    header_put_be_int
    jmp     loc_4332F6
loc_432FD7:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
    mov     r12, [rax]
loc_432FE8:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432FF6:
    mov     c, [rax]
    mov     rdi, [psf+1B30h]
    lea     rax, [rdi+size]
    cmp     rax, [psf+1B40h]
    jle     short loc_433027
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432AD0; jumptable 0000000000432B13 case 32
    mov     rdi, [psf+1B30h]
loc_433027:
    add     rdi, [psf+1B28h]; dest
    mov     rsi, r12; src
    mov     rdx, size; n
    call    _memcpy
    add     [psf+1B30h], size
    add     r15d, ebx
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433048:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_433056:
    movsd   xmm0, qword ptr [rax]
    cvtsd2ss xmm0, xmm0
    mov     rdi, [psf+1B28h]
    add     rdi, [psf+1B30h]; out
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_4332D5
    call    float32_be_write
    jmp     loc_4332DA
loc_433087:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_433095:
    mov     c, [rax]
    mov     rax, [psf+1B30h]
    add     rax, size
    cmp     rax, [psf+1B40h]
    jle     short loc_4330C8
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432AD0; jumptable 0000000000432B13 case 32
    mov     rax, [psf+1B30h]
    add     rax, size
loc_4330C8:
    mov     [psf+1B30h], rax
    add     r15d, ebx
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_4330D7:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_4330E5:
    mov     esi, [rax]; x
    mov     rdi, psf; psf
    call    header_put_marker
    add     r15d, 4
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_4330F8:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_433106:
    mov     c, [rax]
    cmp     size, [psf+1B40h]
    jl      short loc_433125
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433125:
    mov     [psf+1B30h], size
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433131:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_43313F:
    mov     r12, [rax]
    mov     rdi, strptr; s
    call    _strlen
    mov     ebx, eax
    not     ebx
    and     ebx, 1
    add     rbx, size
    cmp     size, 0FEh
    cmovnb  size, r13
    mov     rax, [psf+1B30h]
    add     rax, size
    cmp     rax, [psf+1B40h]
    jle     short loc_433185
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433185:
    movsx   esi, bl; x
    mov     rdi, psf; psf
    call    header_put_byte
    mov     rdi, [psf+1B28h]
    add     rdi, [psf+1B30h]; dest
    mov     rsi, strptr; src
    mov     rdx, size; n
    call    _memcpy
    add     [psf+1B30h], size
    lea     r15d, [count+size]
    add     r15d, 1
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_4331BD:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_4331CB:
    mov     c, [rax]
    mov     rax, [psf+1B30h]
    add     rax, size
    cmp     rax, [psf+1B40h]
    jle     short loc_4331F4
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432AD0; jumptable 0000000000432B13 case 32
loc_4331F4:
    add     r15d, ebx
    test    size, size
    jz      loc_432AD0; jumptable 0000000000432B13 case 32
    mov     rax, [psf+1B30h]
    test    bl, 1
    jnz     loc_433364
    mov     rcx, size
    cmp     size, 1
    jnz     loc_433390
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433222:
    mov     rdi, psf; psf
    mov     esi, r13d; x
    call    header_put_le_int
loc_43322D:
    mov     rdi, [psf+1B28h]
    add     rdi, [psf+1B30h]; dest
    mov     rsi, strptr; src
    mov     rdx, size; n
    call    _memcpy
    mov     rax, size
    add     rax, [psf+1B30h]
    mov     [psf+1B30h], rax
    mov     rcx, [psf+1B28h]
    mov     byte ptr [rcx+rax-1], 0
    lea     r15d, [count+size]
    add     r15d, 4
    mov     r13d, 0FEh
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433276:
    mov     rdi, psf; psf
    call    header_put_le_short
    add     r15d, 2
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433287:
    mov     rdi, psf; psf
    call    header_put_le_3byte
    add     r15d, 3
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433298:
    mov     rdi, psf; psf
    call    header_put_le_int
    add     r15d, 4
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_4332A9:
    test    ecx, ecx
    jnz     loc_433343
    cmp     eax, 10000000h
    jnz     loc_433343
    mov     rdi, psf; psf
    call    header_put_le_8byte
loc_4332C4:
    add     r15d, 8
    mov     [rsp+108h+var_EC], 0
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_4332D5:
    call    float32_le_write
loc_4332DA:
    add     qword ptr [psf+1B30h], 4
    add     r15d, 4
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_4332EB:
    mov     rdi, psf; psf
    mov     esi, r12d; x
    call    header_put_le_int
loc_4332F6:
    mov     rdi, [psf+1B28h]
    add     rdi, [psf+1B30h]; dest
    lea     rdx, [size+1]; n
    mov     rsi, strptr; src
    call    _memcpy
    mov     eax, r12d
    and     eax, 1
    add     rax, size
    mov     rcx, [psf+1B30h]
    add     rcx, size
    mov     [psf+1B30h], rcx
    mov     rdx, [psf+1B28h]
    mov     byte ptr [rdx+rcx], 0
    lea     r15d, [count+size]
    add     r15d, 4
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433343:
    cmp     ecx, 1
    jnz     loc_4333D6
    cmp     eax, 20000000h
    jnz     loc_4333D6
    mov     rdi, psf; psf
    call    header_put_be_int
    jmp     loc_4333F2
loc_433364:
    mov     rcx, [psf+1B28h]
    mov     byte ptr [rcx+rax], 0
    mov     rax, [psf+1B30h]
    add     rax, 1
    mov     [psf+1B30h], rax
    lea     rcx, [size-1]
    cmp     rbx, 1
    jz      loc_432AD0; jumptable 0000000000432B13 case 32
    nop
loc_433390:
    mov     rdx, [psf+1B28h]
    mov     byte ptr [rdx+rax], 0
    mov     rax, [psf+1B28h]
    mov     rdx, [psf+1B30h]
    lea     rsi, [rdx+1]
    mov     [psf+1B30h], rsi
    mov     byte ptr [rax+rdx+1], 0
    mov     rax, [psf+1B30h]
    add     rax, 1
    mov     [psf+1B30h], rax
    add     rcx, 0FFFFFFFFFFFFFFFEh
    jnz     short loc_433390
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_4333D6:
    cmp     ecx, 1
    jnz     loc_432AD0; jumptable 0000000000432B13 case 32
    cmp     eax, 10000000h
    jnz     loc_432AD0; jumptable 0000000000432B13 case 32
    mov     rdi, psf; psf
    call    header_put_le_int
loc_4333F2:
    add     r15d, 4
    mov     [rsp+108h+var_EC], 1
    jmp     loc_432AD0; jumptable 0000000000432B13 case 32
loc_433403:
    xor     r15d, r15d
loc_433406:
    mov     eax, r15d
    add     rsp, 0D8h
    pop     rbx
    pop     r12
    pop     r13
    pop     psf
    pop     r15
    pop     rbp
    retn
psf_binheader_writef endp



header_put_le_int proc
    mov     eax, esi
    mov     rcx, [psf+1B28h]
    mov     rdx, [psf+1B30h]
    lea     rsi, [rdx+1]
    mov     [psf+1B30h], rsi
    mov     [rcx+rdx], al
    mov     rcx, [psf+1B28h]
    mov     rdx, [psf+1B30h]
    lea     rsi, [rdx+1]
    mov     [psf+1B30h], rsi
    mov     [rcx+rdx], ah
    mov     ecx, eax
    shr     ecx, 10h
    mov     r8, [psf+1B28h]
    mov     rsi, [psf+1B30h]
    lea     rdx, [rsi+1]
    mov     [psf+1B30h], rdx
    mov     [r8+rsi], cl
    shr     eax, 18h
    mov     rcx, [psf+1B28h]
    mov     rdx, [psf+1B30h]
    lea     rsi, [rdx+1]
    mov     [psf+1B30h], rsi
    mov     [rcx+rdx], al
    retn
header_put_le_int endp



header_put_be_int proc
    mov     eax, esi
    mov     ecx, esi
    shr     ecx, 18h
    mov     r8, [psf+1B28h]
    mov     rsi, [psf+1B30h]
    lea     rdx, [rsi+1]
    mov     [psf+1B30h], rdx
    mov     [r8+rsi], cl
    mov     ecx, eax
    shr     ecx, 10h
    mov     r8, [psf+1B28h]
    mov     rsi, [psf+1B30h]
    lea     rdx, [rsi+1]
    mov     [psf+1B30h], rdx
    mov     [r8+rsi], cl
    mov     rcx, [psf+1B28h]
    mov     rdx, [psf+1B30h]
    lea     rsi, [rdx+1]
    mov     [psf+1B30h], rsi
    mov     [rcx+rdx], ah
    mov     rcx, [psf+1B28h]
    mov     rdx, [psf+1B30h]
    lea     rsi, [rdx+1]
    mov     [psf+1B30h], rsi
    mov     [rcx+rdx], al
    retn
header_put_be_int endp

