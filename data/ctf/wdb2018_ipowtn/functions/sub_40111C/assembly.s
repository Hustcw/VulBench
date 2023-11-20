sub_40111C proc
    addiu   $sp, -0x28
    sw      $ra, 0x20+var_s4($sp)
    sw      $fp, 0x20+var_s0($sp)
    move    $fp, $sp
    li      $v0, aCC # " %c%*c"
    move    $a0, $v0
    addiu   $v0, $fp, 0x20+var_8
    move    $a1, $v0
    jal     __isoc99_scanf
    move    $at, $at
    lb      $v1, 0x20+var_8($fp)
    li      $v0, 0x79  # 'y'
    beq     $v1, $v0, loc_401168
    move    $at, $at
    lb      $v1, 0x20+var_8($fp)
    li      $v0, 0x59  # 'Y'
    bne     $v1, $v0, loc_401174
    move    $at, $at
    li      $v0, 1
    j       loc_401178
    move    $at, $at
    move    $v0, $zero
loc_401178:
    move    $sp, $fp
    lw      $ra, 0x20+var_s4($sp)
    lw      $fp, 0x20+var_s0($sp)
    addiu   $sp, 0x28
    jr      $ra
    move    $at, $at
sub_40111C endp

