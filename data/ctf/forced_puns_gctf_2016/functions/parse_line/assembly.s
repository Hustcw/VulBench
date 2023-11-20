parse_line proc
    STP             X29, X30, [SP,#-0x40+var_s0]!
    MOV             X29, SP
    STP             X19, X20, [SP,#var_s10]
    STP             X21, X22, [SP,#var_s20]
    STP             X23, X24, [SP,#var_s30]
    MOV             W19, W0
    MOV             X20, X1
    CBZ             W0, loc_1138
    CMP             W0, #1
    B.EQ            loc_1258
    CMP             W0, #2
    B.EQ            loc_1348
    CMP             W0, #3
    B.EQ            loc_1198
    CMP             W0, #4
    B.EQ            loc_12F8
    MOV             W0, W19
    LDP             X19, X20, [SP,#var_s10]
    LDP             X21, X22, [SP,#var_s20]
    LDP             X23, X24, [SP,#var_s30]
    LDP             X29, X30, [SP+var_s0],#0x40
    RET
    MOV             X1, #0; endptr
    MOV             W2, #0xA; base
    MOV             X0, X20; nptr
    BL              .strtol
    CMP             W0, #1
    MOV             X1, X0
    B.EQ            loc_12B4
    CMP             W0, #2
    B.EQ            loc_11E8
    CMP             W0, #3
    B.EQ            loc_13C8
    ADRP            X1, #aWhatIsTheFaste@PAGE; "\nWhat is the fastest liquid on earth?"...
    MOV             X2, #0x7B ; '{'; n
    ADD             X1, X1, #aWhatIsTheFaste@PAGEOFF; "\nWhat is the fastest liquid on earth?"...
    MOV             W0, #0; fd
    BL              .write
    CMP             X0, #0x7B ; '{'
    B.NE            loc_12A4
    MOV             W0, W19
    LDP             X19, X20, [SP,#var_s10]
    LDP             X21, X22, [SP,#var_s20]
    LDP             X23, X24, [SP,#var_s30]
    LDP             X29, X30, [SP+var_s0],#0x40
    RET
    ADRP            X1, #fp_ptr@PAGE
    ADRP            X0, #root_ptr@PAGE
    LDR             X1, [X1,#fp_ptr@PAGEOFF]
    LDR             X0, [X0,#root_ptr@PAGEOFF]
    LDR             X1, [X1]
    LDR             X0, [X0]
    LDR             X1, [X1]
    BLR             X1
    MOV             X19, X0
    MOV             X0, X20
    BL              .__strdup
    STR             X0, [X19,#8]
    CBZ             X0, loc_13D0
    MOV             W19, #1
    MOV             W0, W19
    LDP             X19, X20, [SP,#var_s10]
    LDP             X21, X22, [SP,#var_s20]
    LDP             X23, X24, [SP,#var_s30]
    LDP             X29, X30, [SP+var_s0],#0x40
    RET
    ADRP            X0, #root_ptr@PAGE
    LDR             X0, [X0,#root_ptr@PAGEOFF]
    LDR             X20, [X0]
    CBZ             X20, loc_1120
    ADRP            X23, #aNameS@PAGE; "Name: %s\n"
    ADRP            X22, #aSmallS@PAGE; "Small: %s\n"
    ADRP            X21, #aLargeP@PAGE; "Large: %p\n"
    ADRP            X24, #aNext@PAGE; "-- next --"
    ADD             X23, X23, #aNameS@PAGEOFF; "Name: %s\n"
    ADD             X22, X22, #aSmallS@PAGEOFF; "Small: %s\n"
    ADD             X21, X21, #aLargeP@PAGEOFF; "Large: %p\n"
    ADD             X24, X24, #aNext@PAGEOFF; "-- next --"
    ADD             X1, X20, #0x18
    MOV             X0, X23; format
    BL              .printf
    LDR             X1, [X20,#8]
    MOV             X0, X22; format
    BL              .printf
    LDR             X1, [X20]
    MOV             X0, X21; format
    BL              .printf
    LDR             X1, [X20,#0x10]
    CBZ             X1, loc_1120
    MOV             X0, X24; s
    BL              .puts
    LDR             X20, [X20,#0x10]
    CBNZ            X20, loc_1218
    B               loc_1120
    MOV             W2, #0xA; base
    MOV             X1, #0; endptr
    MOV             X0, X20; nptr
    BL              .strtol
    CMP             W0, #1
    B.EQ            loc_1384
    CMP             W0, #2
    B.EQ            loc_138C
    CMP             W0, #3
    B.EQ            loc_137C
    CMP             W0, #4
    B.EQ            loc_1394
    ADRP            X1, #aWhoIsGeneralFa@PAGE; "\nWho is General Failure, and why is he"...
    MOV             X2, #0x61 ; 'a'; n
    ADD             X1, X1, #aWhoIsGeneralFa@PAGEOFF; "\nWho is General Failure, and why is he"...
    MOV             W0, #0; fd
    BL              .write
    CMP             X0, #0x61 ; 'a'
    B.EQ            loc_11CC
    ADRP            X1, #aWritingErrorMe@PAGE; "writing error message"
    MOV             W0, #1; status
    ADD             X1, X1, #aWritingErrorMe@PAGEOFF; "writing error message"
    BL              .err
    ADRP            X21, #root_ptr@PAGE
    LDR             X21, [X21,#root_ptr@PAGEOFF]
    LDR             X20, [X21]
    CBNZ            X20, loc_12CC
    B               loc_139C
    MOV             X20, X0
    LDR             X0, [X20,#0x10]
    CBNZ            X0, loc_12C8
    MOV             X0, #0x100; size
    MOV             W19, #1
    BL              .malloc
    STR             X0, [X20,#0x10]
    CBNZ            X0, loc_1120
    ADRP            X1, #aOutOfMemory@PAGE; "out of memory"
    MOV             W0, W19; status
    ADD             X1, X1, #aOutOfMemory@PAGEOFF; "out of memory"
    BL              .err
    ADRP            X1, #fp_ptr@PAGE
    ADRP            X0, #root_ptr@PAGE
    LDR             X1, [X1,#fp_ptr@PAGEOFF]
    LDR             X0, [X0,#root_ptr@PAGEOFF]
    LDR             X1, [X1]
    LDR             X0, [X0]
    LDR             X1, [X1]
    BLR             X1
    MOV             X19, X0
    MOV             W2, #0xA; base
    MOV             X1, #0; endptr
    MOV             X0, X20; nptr
    BL              .strtoll
    BL              .malloc
    STR             X0, [X19]
    CBNZ            X0, loc_11CC
    ADRP            X1, #aOutOfMemorySet@PAGE; "out of memory setting tmp->large"
    MOV             W0, #1; status
    ADD             X1, X1, #aOutOfMemorySet@PAGEOFF; "out of memory setting tmp->large"
    BL              .err
    ADRP            X1, #fp_ptr@PAGE
    ADRP            X0, #root_ptr@PAGE
    MOV             W19, #1
    LDR             X1, [X1,#fp_ptr@PAGEOFF]
    LDR             X0, [X0,#root_ptr@PAGEOFF]
    LDR             X1, [X1]
    LDR             X0, [X0]
    LDR             X1, [X1]
    BLR             X1
    ADD             X0, X0, #0x18; dest
    MOV             X1, X20; src
    BL              .strcpy
    B               loc_1120
    MOV             W19, #4
    B               loc_1120
    MOV             W19, #2
    B               loc_1120
    MOV             W19, #3
    B               loc_1120
    MOV             W19, #0
    B               loc_1120
    MOV             X0, #0x100; size
    MOV             W19, W1
    BL              .malloc
    STR             X0, [X21]
    BL              .malloc_usable_size
    MOV             X1, X0
    ADRP            X0, #aMallocUsableSi_0@PAGE; "malloc_usable_size is %d, and sizeof(st"...
    MOV             X2, #0x100
    ADD             X0, X0, #aMallocUsableSi_0@PAGEOFF; "malloc_usable_size is %d, and sizeof(st"...
    BL              .printf
    B               loc_1120
    MOV             W0, #1; status
    BL              .exit
    ADRP            X1, #aOutOfMemorySet_0@PAGE; "out of memory setting tmp->small"
    MOV             W0, #1; status
    ADD             X1, X1, #aOutOfMemorySet_0@PAGEOFF; "out of memory setting tmp->small"
    BL              .err
parse_line endp

