sub_401070 proc
    addiu   $sp, -0x28
    sw      $fp, 0x24+var_s0($sp)
    move    $fp, $sp
    sw      $a0, 0x24+arg_0($fp)
    sw      $a1, 0x24+arg_4($fp)
    sw      $a2, 0x24+arg_8($fp)
    sw      $a3, 0x24+arg_C($fp)
    lw      $v0, 0x24+arg_0($fp)
    mtc1    $v0, $f0
    move    $at, $at
    cvt.d.w $f2, $f0
    lui     $v0, 0x40  # '@'
    ldc1    $f0, dbl_4013E8
    mul.d   $f2, $f0
    lw      $v0, 0x24+arg_4($fp)
    mtc1    $v0, $f4
    move    $at, $at
    cvt.d.w $f0, $f4
    add.d   $f0, $f2, $f0
    sdc1    $f0, 0x24+var_1C($fp)
    lw      $v0, 0x24+arg_8($fp)
    mtc1    $v0, $f0
    move    $at, $at
    cvt.d.w $f2, $f0
    lui     $v0, 0x40  # '@'
    ldc1    $f0, dbl_4013E8
    mul.d   $f2, $f0
    lw      $v0, 0x24+arg_C($fp)
    mtc1    $v0, $f4
    move    $at, $at
    cvt.d.w $f0, $f4
    add.d   $f0, $f2, $f0
    sdc1    $f0, 0x24+var_14($fp)
    ldc1    $f2, 0x24+var_14($fp)
    ldc1    $f0, 0x24+var_1C($fp)
    sub.d   $f0, $f2, $f0
    sdc1    $f0, 0x24+var_C($fp)
    ldc1    $f0, 0x24+var_C($fp)
    move    $sp, $fp
    lw      $fp, 0x24+var_s0($sp)
    addiu   $sp, 0x28
    jr      $ra
    move    $at, $at
sub_401070 endp

