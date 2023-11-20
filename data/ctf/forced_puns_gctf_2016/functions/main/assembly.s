main proc
    ADRP            X0, #stdout_ptr@PAGE
    MOV             X3, #0; n
    STP             X29, X30, [SP,#-0x30+var_s0]!
    MOV             W2, #2; modes
    MOV             X1, #0; buf
    MOV             X29, SP
    LDR             X0, [X0,#stdout_ptr@PAGEOFF]
    STP             X19, X20, [SP,#var_s10]
    STP             X21, X22, [SP,#var_s20]
    LDR             X0, [X0]; stream
    ADRP            X19, #fp_ptr@PAGE
    BL              .setvbuf
    ADRP            X0, #stderr_ptr@PAGE
    MOV             X3, #0; n
    MOV             W2, #2; modes
    MOV             X1, #0; buf
    LDR             X0, [X0,#stderr_ptr@PAGEOFF]
    LDR             X0, [X0]; stream
    BL              .setvbuf
    MOV             X0, #8; size
    BL              .malloc
    LDR             X19, [X19,#fp_ptr@PAGEOFF]
    STR             X0, [X19]
    CBZ             X0, loc_DF0
    ADRL            X0, aDebug; "DEBUG"
    BL              .getenv
    LDR             X1, [X19]
    CBZ             X0, loc_DE0
    ADRL            X0, debug_end_of_entry
    STR             X0, [X1]
    BL              display_banner
    MOV             W21, #0
    ADRP            X20, #line.4718@PAGE
    MOV             W0, W21
    MOV             X22, #0x800
    BL              print_menu
    LDR             X5, [X20,#line.4718@PAGEOFF]
    CBZ             X5, loc_DC8
    MOV             X19, #0
    MOV             X1, X5; buf
    SUB             X2, X22, X19; nbytes
    MOV             W0, #0; fd
    BL              .read
    CBZ             X0, loc_E00
    LDR             X5, [X20,#line.4718@PAGEOFF]
    ADD             X4, X5, X19
    LDRB            W2, [X5,X19]
    CMP             W2, #0xA
    B.EQ            loc_DA4
    ADD             X2, X19, #1
    ADD             X19, X19, X0
    ADD             X2, X5, X2
    ADD             X1, X5, X19
    B               loc_D80
    MOV             X4, X2
    LDRB            W3, [X2],#1
    CMP             W3, #0xA
    B.EQ            loc_DA4
    CMP             X2, X1
    B.NE            loc_D70
    CMP             X19, #0x7FF
    B.LS            loc_D38
    ADRP            X1, #aExpectedNewlin@PAGE; "expected newline in < %d bytes\n"
    MOV             W2, #0x800
    ADD             X1, X1, #aExpectedNewlin@PAGEOFF; "expected newline in < %d bytes\n"
    MOV             W0, #1; status
    BL              .err
    MOV             X1, X5; nptr
    STRB            WZR, [X4]
    MOV             W0, W21; int
    BL              parse_line
    MOV             W21, W0
    MOV             W0, W21
    BL              print_menu
    LDR             X5, [X20,#line.4718@PAGEOFF]
    CBNZ            X5, loc_D30
    MOV             X0, #0x800; size
    BL              .malloc
    STR             X0, [X20,#line.4718@PAGEOFF]
    CBZ             X0, loc_E10
    MOV             X5, X0
    B               loc_D30
    ADRL            X0, end_of_entry
    STR             X0, [X1]
    B               loc_D10
    ADRP            X1, #aUhhh@PAGE; "uhhh?"
    MOV             W0, #1; status
    ADD             X1, X1, #aUhhh@PAGEOFF; "uhhh?"
    BL              .err
    ADRP            X1, #aRemoteEndDisap@PAGE; "remote end disappeared"
    MOV             W0, #1; status
    ADD             X1, X1, #aRemoteEndDisap@PAGEOFF; "remote end disappeared"
    BL              .err
    ADRP            X1, #aMalloc_0@PAGE; "malloc"
    MOV             W0, #1; status
    ADD             X1, X1, #aMalloc_0@PAGEOFF; "malloc"
    BL              .err
main endp

