print_menu proc
    STP             X29, X30, [SP,#var_20]!
    CMP             W0, #4; switch 5 cases
    MOV             X29, SP
    STR             X19, [SP,#0x20+var_10]
    B.LS            loc_103C
    ADRP            X1, #aInvalidStateRe@PAGE; jumptable 0000000000001050 default case
    MOV             W0, #1; status
    ADD             X1, X1, #aInvalidStateRe@PAGEOFF; "invalid state reached?"
    BL              .err
    ADRL            X1, jpt_1050
    LDRB            W0, [X1,W0,UXTW]
    ADR             X1, loc_1054; jumptable 0000000000001050 case 2
    ADD             X0, X1, W0,SXTB#2
    BR              X0; switch jump
    MOV             X19, #0x89; jumptable 0000000000001050 case 2
    ADRP            X1, #aPersonAIOnceMe@PAGE; "\nPerson A: I once met a dog with no no"...
    MOV             X2, X19; n
    ADD             X1, X1, #aPersonAIOnceMe@PAGEOFF; "\nPerson A: I once met a dog with no no"...
    MOV             W0, #1; fd
    BL              .write
    CMP             X0, X19
    B.NE            loc_10D0
    LDR             X19, [SP,#0x20+var_10]
    LDP             X29, X30, [SP+0x20+var_20],#0x20
    RET
    MOV             X19, #0xB9; jumptable 0000000000001050 case 1
    ADRP            X1, #aMyDuckGotArres@PAGE; "\nMy duck got arrested.\n.. Apparently "...
    MOV             X2, X19
    ADD             X1, X1, #aMyDuckGotArres@PAGEOFF; "\nMy duck got arrested.\n.. Apparently "...
    B               loc_1064
    MOV             X19, #0x9A; jumptable 0000000000001050 case 3
    ADRP            X1, #aMyFridgeIsFull@PAGE; "\nMy fridge is full of German sausages."...
    MOV             X2, X19
    ADD             X1, X1, #aMyFridgeIsFull@PAGEOFF; "\nMy fridge is full of German sausages."...
    B               loc_1064
    MOV             X19, #0x58 ; 'X'; jumptable 0000000000001050 case 4
    ADRP            X1, #aWhyDidFredFall@PAGE; "\nWhy did Fred fall off a bike?\nBecaus"...
    MOV             X2, X19
    ADD             X1, X1, #aWhyDidFredFall@PAGEOFF; "\nWhy did Fred fall off a bike?\nBecaus"...
    B               loc_1064
    MOV             X19, #0x74 ; 't'; jumptable 0000000000001050 case 0
    ADRP            X1, #aQWhenDoesAJoke@PAGE; "\nQ. When does a joke become a Dad joke"...
    MOV             X2, X19
    ADD             X1, X1, #aQWhenDoesAJoke@PAGEOFF; "\nQ. When does a joke become a Dad joke"...
    B               loc_1064
    ADRP            X1, #aWritingMenuToS@PAGE; "writing menu to stdout"
    MOV             W0, #1; status
    ADD             X1, X1, #aWritingMenuToS@PAGEOFF; "writing menu to stdout"
    BL              .err
print_menu endp

