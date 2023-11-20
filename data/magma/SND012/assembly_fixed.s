psf_binheader_writef proc
    push    rbp
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 0D8h
    mov     r14, format
    mov     rbp, psf
    test    al, al
    jz      short loc_432B42
    movaps  [rsp+108h+var_B8], xmm0
    movaps  [rsp+108h+var_A8], xmm1
    movaps  [rsp+108h+var_98], xmm2
    movaps  [rsp+108h+var_88], xmm3
    movaps  [rsp+108h+var_78], xmm4
    movaps  [rsp+108h+var_68], xmm5
    movaps  [rsp+108h+var_58], xmm6
    movaps  [rsp+108h+var_48], xmm7
loc_432B42:
    mov     [rsp+108h+var_D8], rdx
    mov     [rsp+108h+var_D0], rcx
    mov     [rsp+108h+var_C8], r8
    mov     [rsp+108h+var_C0], r9
    test    format, format
    jz      loc_4334E2
    lea     rax, [rsp+108h+var_E8]
    mov     [rsp+108h+var_108.reg_save_area], rax
    lea     rax, [rsp+108h+argptr]
    mov     [rsp+108h+var_108.overflow_arg_area], rax
    mov     rax, 3000000010h
    mov     qword ptr [rsp+108h+var_108.gp_offset], rax
    mov     bl, [r14]
    test    bl, bl
    jz      loc_4334EF
    xor     r13d, r13d
    xor     r15d, r15d
    jmp     short loc_432BBB
    mov     esi, offset aInvalidFormatS; jumptable 0000000000432BF3 default case, cases 33-48,53-55,57-68,70-82,85-97,99,103,105,107,108,110,113,114,117-121
    mov     rdi, psf; psf
    xor     eax, eax
    call    psf_log_printf
    mov     dword ptr [psf+1D78h], 1Dh
loc_432BB0:
    mov     bl, [format]; jumptable 0000000000432BF3 case 32
    test    bl, bl
    jz      loc_4334F2
loc_432BBB:
    mov     rax, [psf+1B30h]
    add     rax, 10h
    cmp     rax, [psf+1B40h]
    jl      short loc_432BE4
    mov     esi, 10h; needed
    mov     rdi, psf; psf
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_4334F2
loc_432BE4:
    add     r14, 1
    movsx   edx, bl
    lea     eax, [rdx-20h]; switch 91 cases
    cmp     eax, 5Ah
    ja      short def_432BF3; jumptable 0000000000432BF3 default case, cases 33-48,53-55,57-68,70-82,85-97,99,103,105,107,108,110,113,114,117-121
def_432BF3:
    jmp     ds:jpt_432BF3[rax*8]; switch jump
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 49
    cmp     rcx, 28h ; '('
    ja      loc_432F68
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432F76
    movsxd  rcx, [rsp+108h+var_108.fp_offset]; jumptable 0000000000432BF3 case 100
    cmp     rcx, 0A0h
    ja      loc_432E68
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 10h
    mov     [rsp+108h+var_108.fp_offset], ecx
    jmp     loc_432E76
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 104
    cmp     rcx, 28h ; '('
    ja      loc_432EA2
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432EB0
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 115
    cmp     rcx, 28h ; '('
    mov     [rsp+108h+var_EC], r13d
    ja      loc_432ED9
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432EE7
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 50
    cmp     rcx, 28h ; '('
    ja      loc_432F8A
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432F98
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 51
    cmp     rcx, 28h ; '('
    ja      loc_432FBB
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432FC9
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 52
    cmp     rcx, 28h ; '('
    ja      loc_432FEC
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_432FFA
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 56
    cmp     rcx, 28h ; '('
    ja      loc_43301D
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_43302B
    mov     dword ptr [psf+1B48h], 20000000h; jumptable 0000000000432BF3 case 69
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 83
    cmp     rcx, 28h ; '('
    mov     [rsp+108h+var_EC], r13d
    ja      loc_433055
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_433063
    xor     r13d, r13d; jumptable 0000000000432BF3 case 84
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 98
    cmp     rcx, 29h ; ')'
    jnb     loc_4330CB
    mov     rdx, [rsp+108h+var_108.reg_save_area]
    mov     rax, rcx
    add     rax, 8
    mov     [rsp+108h+var_108.gp_offset], eax
    mov     r12, [rdx+rcx]
    cmp     eax, 28h ; '('
    ja      loc_4330DC
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 10h
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_4330EA
    mov     dword ptr [psf+1B48h], 10000000h; jumptable 0000000000432BF3 case 101
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
    movsxd  rcx, [rsp+108h+var_108.fp_offset]; jumptable 0000000000432BF3 case 102
    cmp     rcx, 0A0h
    ja      loc_43313C
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 10h
    mov     [rsp+108h+var_108.fp_offset], ecx
    jmp     loc_43314A
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 106
    cmp     rcx, 28h ; '('
    ja      loc_43317A
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_433188
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 109
    cmp     rcx, 28h ; '('
    ja      loc_4331CA
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_4331D8
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 111
    cmp     rcx, 28h ; '('
    ja      loc_4331EB
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_4331F9
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 112
    cmp     rcx, 28h ; '('
    ja      loc_433224
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_433232
    mov     r13d, 1; jumptable 0000000000432BF3 case 116
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
    movsxd  rcx, [rsp+108h+var_108.gp_offset]; jumptable 0000000000432BF3 case 122
    cmp     rcx, 28h ; '('
    ja      loc_4332B6
    mov     rax, rcx
    add     rax, [rsp+108h+var_108.reg_save_area]
    add     ecx, 8
    mov     [rsp+108h+var_108.gp_offset], ecx
    jmp     loc_4332C4
loc_432E68:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432E76:
    movsd   xmm0, qword ptr [rax]
    mov     rdi, [psf+1B28h]
    add     rdi, [psf+1B30h]; out
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_432F52
    call    double64_be_write
    jmp     loc_432F57
loc_432EA2:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432EB0:
    mov     rax, [rax]
    mov     rcx, [psf+1B28h]
    mov     rdx, [psf+1B30h]
    movups  xmm0, xmmword ptr [bindata]
    movups  xmmword ptr [rcx+rdx], xmm0
    add     qword ptr [psf+1B30h], 10h
    add     r15d, 10h
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_432ED9:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432EE7:
    mov     r12, [rax]
    mov     rdi, strptr; s
    call    _strlen
    lea     c, [rax+1]
    mov     rdx, [psf+1B30h]
    mov     ecx, ebx
    and     ecx, 1
    lea     r13, [rcx+rax]
    add     r13, 1
    add     rdx, size
    add     rdx, 4
    cmp     rdx, [psf+1B40h]
    jle     short loc_432F32
    lea     rsi, [rax+rcx]
    add     rsi, 5; needed
    mov     rdi, psf; psf
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_43309F
loc_432F32:
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_43338C
    mov     rdi, psf; psf
    mov     esi, r13d; x
    call    header_put_be_int
    jmp     loc_433397
loc_432F52:
    call    double64_le_write
loc_432F57:
    add     qword ptr [psf+1B30h], 8
    add     r15d, 8
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_432F68:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432F76:
    movsx   esi, byte ptr [rax]; x
    mov     rdi, psf; psf
    call    header_put_byte
    add     r15d, 1
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_432F8A:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432F98:
    mov     esi, [rax]; x
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_43331B
    mov     rdi, psf; psf
    call    header_put_be_short
    add     r15d, 2
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_432FBB:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432FC9:
    mov     esi, [rax]; x
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_43332C
    mov     rdi, psf; psf
    call    header_put_be_3byte
    add     r15d, 3
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_432FEC:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_432FFA:
    mov     esi, [rax]; x
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_43333D
    mov     rdi, psf; psf
    call    header_put_be_int
    add     r15d, 4
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_43301D:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_43302B:
    mov     rsi, [rax]; x
    mov     eax, [psf+1B48h]
    test    r13d, r13d
    jnz     loc_43334E
    cmp     eax, 20000000h
    jnz     loc_43334E
    mov     rdi, psf; psf
    call    header_put_be_8byte
    jmp     loc_43336A
loc_433055:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_433063:
    mov     r13, [rax]
    mov     rdi, strptr; s
    call    _strlen
    mov     c, rax
    mov     r12d, ebx
    and     r12d, 1
    lea     rsi, [r12+rax]
    add     rsi, 4; needed
    mov     rax, [psf+1B30h]
    add     rax, rsi
    cmp     rax, [psf+1B40h]
    jle     short loc_4330A9
    mov     rdi, psf; psf
    call    psf_bump_header_allocation
    test    eax, eax
    jz      short loc_4330A9
loc_43309F:
    mov     r13d, [rsp+108h+var_EC]
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_4330A9:
    add     r12, size
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_4333DF
    mov     rdi, psf; psf
    mov     esi, ebx; x
    call    header_put_be_int
    jmp     loc_4333E9
loc_4330CB:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
    mov     r12, [rax]
loc_4330DC:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_4330EA:
    mov     c, [rax]
    mov     rdi, [psf+1B30h]
    lea     rax, [rdi+size]
    cmp     rax, [psf+1B40h]
    jle     short loc_43311B
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432BB0; jumptable 0000000000432BF3 case 32
    mov     rdi, [psf+1B30h]
loc_43311B:
    add     rdi, [psf+1B28h]; dest
    mov     rsi, r12; src
    mov     rdx, size; n
    call    _memcpy
    add     [psf+1B30h], size
    add     r15d, ebx
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_43313C:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_43314A:
    movsd   xmm0, qword ptr [rax]
    cvtsd2ss xmm0, xmm0
    mov     rdi, [psf+1B28h]
    add     rdi, [psf+1B30h]; out
    cmp     dword ptr [psf+1B48h], 20000000h
    jnz     loc_433376
    call    float32_be_write
    jmp     loc_43337B
loc_43317A:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_433188:
    mov     c, [rax]
    mov     rax, [psf+1B30h]
    add     rax, size
    cmp     rax, [psf+1B40h]
    jle     short loc_4331BB
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432BB0; jumptable 0000000000432BF3 case 32
    mov     rax, [psf+1B30h]
    add     rax, size
loc_4331BB:
    mov     [psf+1B30h], rax
    add     r15d, ebx
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_4331CA:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_4331D8:
    mov     esi, [rax]; x
    mov     rdi, psf; psf
    call    header_put_marker
    add     r15d, 4
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_4331EB:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_4331F9:
    mov     c, [rax]
    cmp     size, [psf+1B40h]
    jl      short loc_433218
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_433218:
    mov     [psf+1B30h], size
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_433224:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_433232:
    mov     r12, [rax]
    mov     rdi, strptr; s
    call    _strlen
    mov     ebx, eax
    not     ebx
    and     ebx, 1
    add     rbx, size
    cmp     size, 0FEh
    mov     eax, 0FEh
    cmovnb  size, rax
    lea     rsi, [size+1]; needed
    mov     rax, [psf+1B30h]
    add     rax, rsi
    cmp     rax, [psf+1B40h]
    jle     short loc_43327E
    mov     rdi, psf; psf
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_43327E:
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
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_4332B6:
    mov     rax, [rsp+108h+var_108.overflow_arg_area]
    lea     rcx, [rax+8]
    mov     [rsp+108h+var_108.overflow_arg_area], rcx
loc_4332C4:
    mov     c, [rax]
    mov     rax, [psf+1B30h]
    add     rax, size
    cmp     rax, [psf+1B40h]
    jle     short loc_4332ED
    mov     rdi, psf; psf
    mov     rsi, size; needed
    call    psf_bump_header_allocation
    test    eax, eax
    jnz     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_4332ED:
    add     r15d, ebx
    test    size, size
    jz      loc_432BB0; jumptable 0000000000432BF3 case 32
    mov     rax, [psf+1B30h]
    test    bl, 1
    jnz     loc_43343D
    mov     rcx, size
    cmp     size, 1
    jnz     loc_433470
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_43331B:
    mov     rdi, psf; psf
    call    header_put_le_short
    add     r15d, 2
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_43332C:
    mov     rdi, psf; psf
    call    header_put_le_3byte
    add     r15d, 3
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_43333D:
    mov     rdi, psf; psf
    call    header_put_le_int
    add     r15d, 4
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_43334E:
    test    r13d, r13d
    jnz     loc_43341B
    cmp     eax, 10000000h
    jnz     loc_43341B
    mov     rdi, psf; psf
    call    header_put_le_8byte
loc_43336A:
    add     r15d, 8
    xor     r13d, r13d
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_433376:
    call    float32_le_write
loc_43337B:
    add     qword ptr [psf+1B30h], 4
    add     r15d, 4
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_43338C:
    mov     rdi, psf; psf
    mov     esi, r13d; x
    call    header_put_le_int
loc_433397:
    mov     rdi, [psf+1B28h]
    add     rdi, [psf+1B30h]; dest
    mov     rsi, strptr; src
    mov     rdx, rbx; n
    call    _memcpy
    mov     rax, size
    add     rax, [psf+1B30h]
    mov     [psf+1B30h], rax
    mov     rcx, [psf+1B28h]
    mov     byte ptr [rcx+rax-1], 0
    lea     r15d, [count+size]
    add     r15d, 4
    mov     r13d, [rsp+108h+var_EC]
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_4333DF:
    mov     rdi, psf; psf
    mov     esi, ebx; x
    call    header_put_le_int
loc_4333E9:
    mov     rdi, [psf+1B28h]
    add     rdi, [psf+1B30h]; dest
    mov     rsi, strptr; src
    mov     rdx, size; n
    call    _memcpy
    add     [psf+1B30h], size
    lea     r15d, [count+size]
    add     r15d, 4
    mov     r13d, [rsp+108h+var_EC]
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_43341B:
    cmp     r13d, 1
    jnz     loc_4334B6
    cmp     eax, 20000000h
    jnz     loc_4334B6
    mov     rdi, psf; psf
    call    header_put_be_int
    jmp     loc_4334D3
loc_43343D:
    mov     rcx, [psf+1B28h]
    mov     byte ptr [rcx+rax], 0
    mov     rax, [psf+1B30h]
    add     rax, 1
    mov     [psf+1B30h], rax
    lea     rcx, [size-1]
    cmp     rbx, 1
    jz      loc_432BB0; jumptable 0000000000432BF3 case 32
    nop     dword ptr [rax+rax+00000000h]
loc_433470:
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
    jnz     short loc_433470
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_4334B6:
    cmp     r13d, 1
    jnz     loc_432BB0; jumptable 0000000000432BF3 case 32
    cmp     eax, 10000000h
    jnz     loc_432BB0; jumptable 0000000000432BF3 case 32
    mov     rdi, psf; psf
    call    header_put_le_int
loc_4334D3:
    add     r15d, 4
    mov     r13d, 1
    jmp     loc_432BB0; jumptable 0000000000432BF3 case 32
loc_4334E2:
    mov     rdi, psf; psf
    call    psf_ftell
    mov     r15, rax
    jmp     short loc_4334F2
loc_4334EF:
    xor     r15d, r15d
loc_4334F2:
    mov     eax, r15d
    add     rsp, 0D8h
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    pop     psf
    retn
psf_binheader_writef endp

