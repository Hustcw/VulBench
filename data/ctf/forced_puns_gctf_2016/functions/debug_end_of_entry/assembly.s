debug_end_of_entry proc
    STP             X29, X30, [SP,#-0x20+var_s0]!
    MOV             X1, X0
    MOV             X29, SP
    STP             X19, X20, [SP,#var_s10]
    MOV             X19, X0
    ADRL            X0, aDebugRootIsP; "[debug] root is %p\n"
    BL              .printf
    LDR             X1, [X19,#0x10]
    CBZ             X1, loc_FAC
    ADRL            X20, aDebugNextIsP; "  [debug] next is %p\n"
    MOV             X0, X20; format
    BL              .printf
    LDR             X19, [X19,#0x10]
    LDR             X1, [X19,#0x10]
    CBNZ            X1, loc_F98
    ADRP            X0, #aDebugReturning@PAGE; "  [debug] returning %p to caller\n"
    MOV             X1, X19
    ADD             X0, X0, #aDebugReturning@PAGEOFF; "  [debug] returning %p to caller\n"
    BL              .printf
    MOV             X0, X19
    LDP             X19, X20, [SP,#var_s10]
    LDP             X29, X30, [SP+var_s0],#0x20
    RET
debug_end_of_entry endp

