main proc
    addiu   $sp, -0x28
    sw      $ra, 0x20+var_s4($sp)
    sw      $fp, 0x20+var_s0($sp)
    move    $fp, $sp
    jal     sub_400A00
    move    $at, $at
    addiu   $v0, $fp, 0x20+var_8
    move    $a0, $v0 # tv
    move    $a1, $zero # tz
    jal     gettimeofday
    move    $at, $at
    lw      $v0, 0x20+var_4($fp)
    move    $a0, $v0 # seed
    jal     srand
    move    $at, $at
    jal     sub_400C30
    move    $at, $at
    jal     sub_40111C
    move    $at, $at
    move    $v1, $v0
    li      $v0, 1
    beq     $v1, $v0, loc_400AD8
    move    $at, $at
    move    $v0, $zero
    move    $sp, $fp
    lw      $ra, 0x20+var_s4($sp)
    lw      $fp, 0x20+var_s0($sp)
    addiu   $sp, 0x28
    jr      $ra
    move    $at, $at
main endp

