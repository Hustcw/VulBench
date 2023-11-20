sub_400C30 proc
    addiu   $sp, -0xD8
    sw      $ra, 0xC4+var_s8($sp)
    sw      $fp, 0xC4+var_s4($sp)
    sw      $s0, 0xC4+var_s0($sp)
    sdc1    $f20, 0xC4+var_sC($sp)
    move    $fp, $sp
    li      $v0, 8
    sw      $v0, 0xC4+var_A4($fp)
    sw      $zero, 0xC4+var_9C($fp)
    sw      $zero, 0xC4+var_A0($fp)
    sw      $zero, 0xC4+var_98($fp)
    sw      $zero, 0xC4+var_88($fp)
    sw      $zero, 0xC4+var_84($fp)
    sw      $zero, 0xC4+var_80($fp)
    sw      $zero, 0xC4+var_7C($fp)
    sw      $zero, 0xC4+var_78($fp)
    sw      $zero, 0xC4+var_74($fp)
    sw      $zero, 0xC4+var_70($fp)
    sw      $zero, 0xC4+var_70+4($fp)
    sw      $zero, 0xC4+var_68($fp)
    sw      $zero, 0xC4+var_64($fp)
    sw      $zero, 0xC4+var_60($fp)
    sw      $zero, 0xC4+var_60+4($fp)
    sw      $zero, 0x6C($fp)
    sh      $zero, 0xC4+var_54($fp)
    lui     $v0, 0x40  # '@'
    lhu     $v1, word_401364
    sh      $v1, 0xC4+var_88($fp)
    li      $v0, word_401364
    lbu     $v0, (byte_401366 - 0x401364)($v0)
    sb      $v0, 0xC4+var_88+2($fp)
    sb      $zero, 0xC4+var_88+3($fp)
    sb      $zero, 0xC4+var_84($fp)
    sb      $zero, 0xC4+var_84+1($fp)
    lw      $v0, dword_40136C
    usw     $v0, 0xC4+var_84+2($fp)
    sh      $zero, 0xC4+var_80+2($fp)
    lui     $v0, 0x40  # '@'
    lw      $v1, dword_401374
    sw      $v1, 0xC4+var_7C($fp)
    li      $v0, dword_401374
    lbu     $v0, (byte_401378 - 0x401374)($v0)
    sb      $v0, 0xC4+var_78($fp)
    sb      $zero, 0xC4+var_78+1($fp)
    lui     $v0, 0x40  # '@'
    lw      $v1, dword_40137C
    usw     $v1, 0xC4+var_78+2($fp)
    li      $v0, dword_40137C
    lbu     $v0, (byte_401380 - 0x40137C)($v0)
    sb      $v0, 0xC4+var_74+2($fp)
    sb      $zero, 0xC4+var_74+3($fp)
    lui     $v0, 0x40  # '@'
    lw      $v1, dword_401384
    sw      $v1, 0xC4+var_70($fp)
    li      $v0, dword_401384
    lhu     $v0, (word_401388 - 0x401384)($v0)
    sh      $v0, 0xC4+var_70+4($fp)
    lui     $v0, 0x40  # '@'
    lw      $v1, dword_40138C
    usw     $v1, 0xC4+var_70+6($fp)
    li      $v0, dword_40138C
    lbu     $v0, (byte_401390 - 0x40138C)($v0)
    sb      $v0, 0xC4+var_68+2($fp)
    sb      $zero, 0xC4+var_68+3($fp)
    lw      $v0, dword_401394
    sw      $v0, 0xC4+var_64($fp)
    sh      $zero, 0xC4+var_60($fp)
    lui     $v0, 0x40  # '@'
    lw      $v1, dword_40139C
    usw     $v1, 0xC4+var_60+2($fp)
    li      $v0, dword_40139C
    lhu     $v0, (word_4013A0 - 0x40139C)($v0)
    sh      $v0, 0xC4+var_60+6($fp)
    lui     $v0, 0x40  # '@'
    lw      $v1, dword_4013A4
    sw      $v1, 0x6C($fp)
    li      $v0, dword_4013A4
    lhu     $v0, (word_4013A8 - 0x4013A4)($v0)
    sh      $v0, 0xC4+var_54($fp)
    lui     $v0, 0x40  # '@'
    addiu   $a0, $fp, 0xC4+var_50 # dest
    addiu   $v1, $v0, (unk_4013AC - 0x400000)
    li      $v0, 0x24  # '$'
    move    $a1, $v1 # src
    move    $a2, $v0 # n
    jal     memcpy
    move    $at, $at
    addiu   $v0, $fp, 0xC4+var_2C
    move    $a0, $v0 # tv
    move    $a1, $zero # tz
    jal     gettimeofday
    move    $at, $at
    j       loc_400E34
    move    $at, $at
    lw      $a0, 0xC4+var_A4($fp)
    jal     sub_401020
    move    $at, $at
    sw      $v0, 0xC4+var_9C($fp)
    lw      $v0, 0xC4+var_A4($fp)
    sll     $v0, 2
    addiu   $v1, $fp, 0xC4+var_A4
    addu    $v0, $v1, $v0
    lw      $v0, 0x54($v0)
    sw      $v0, 0xC4+var_98($fp)
    lw      $v0, 0xC4+var_9C($fp)
    sll     $v0, 2
    addiu   $v1, $fp, 0xC4+var_A4
    addu    $v0, $v1, $v0
    lw      $v1, 0x54($v0)
    lw      $v0, 0xC4+var_A4($fp)
    sll     $v0, 2
    addiu   $a0, $fp, 0xC4+var_A4
    addu    $v0, $a0, $v0
    sw      $v1, 0x54($v0)
    lw      $v0, 0xC4+var_9C($fp)
    sll     $v0, 2
    addiu   $v1, $fp, 0xC4+var_A4
    addu    $v0, $v1, $v0
    lw      $v1, 0xC4+var_98($fp)
    sw      $v1, 0x54($v0)
    lw      $v0, 0xC4+var_A4($fp)
    addiu   $v0, -1
    sw      $v0, 0xC4+var_A4($fp)
loc_400E34:
    lw      $v0, 0xC4+var_A4($fp)
    bgtz    $v0, loc_400DC0
    move    $at, $at
    sw      $zero, 0xC4+var_A0($fp)
    j       loc_400F04
    move    $at, $at
    addiu   $v0, $fp, 0xC4+var_94
    move    $a0, $v0
    li      $a1, 9
    jal     sub_400B38
    move    $at, $at
    lw      $v0, 0xC4+var_A0($fp)
    sll     $v0, 2
    addiu   $v1, $fp, 0xC4+var_A4
    addu    $v0, $v1, $v0
    lw      $v0, 0x54($v0)
    sll     $v0, 1
    sll     $v1, $v0, 2
    subu    $v0, $v1, $v0
    addiu   $v1, $fp, 0xC4+var_88
    addu    $v0, $v1, $v0
    addiu   $v1, $fp, 0xC4+var_94
    move    $a0, $v1 # s1
    move    $a1, $v0 # s2
    jal     strcmp
    move    $at, $at
    beqz    $v0, loc_400EB4
    move    $at, $at
    lui     $v0, 0x40  # '@'
    addiu   $a0, $v0, (aNoGuessIt - 0x400000) # "no!!! guess it!!!!!!"
    jal     puts
    move    $at, $at
    lw      $v0, 0xC4+var_A0($fp)
    sll     $v0, 2
    addiu   $v1, $fp, 0xC4+var_A4
    addu    $v0, $v1, $v0
    lw      $v0, 0x54($v0)
    sll     $v0, 1
    sll     $v1, $v0, 2
    subu    $v0, $v1, $v0
    addiu   $v1, $fp, 0xC4+var_88
    addu    $v0, $v1, $v0
    addiu   $v1, $fp, 0xC4+var_94
    move    $a0, $v1 # s1
    move    $a1, $v0 # s2
    jal     strcmp
    move    $at, $at
    bnez    $v0, loc_400E4C
    move    $at, $at
    lw      $v0, 0xC4+var_A0($fp)
    addiu   $v0, 1
    sw      $v0, 0xC4+var_A0($fp)
loc_400F04:
    lw      $v0, 0xC4+var_A0($fp)
    slti    $v0, 9
    bnez    $v0, loc_400E4C
    move    $at, $at
    addiu   $v0, $fp, 0xC4+var_24
    move    $a0, $v0 # tv
    move    $a1, $zero # tz
    jal     gettimeofday
    move    $at, $at
    lui     $v0, 0x40  # '@'
    addiu   $s0, $v0, (a0lfSec0lfUsec - 0x400000) # "\n\n%.0lf sec, %.0lf usec\n"
    lw      $a0, 0xC4+var_2C($fp)
    lw      $a1, 0xC4+var_28($fp)
    lw      $a2, 0xC4+var_24($fp)
    lw      $a3, 0xC4+var_20($fp)
    jal     sub_401070
    move    $at, $at
    mov.d   $f2, $f0
    lui     $v0, 0x40  # '@'
    ldc1    $f0, dbl_4013D8
    mul.d   $f20, $f2, $f0
    lw      $a0, 0xC4+var_2C($fp)
    lw      $a1, 0xC4+var_28($fp)
    lw      $a2, 0xC4+var_24($fp)
    lw      $a3, 0xC4+var_20($fp)
    jal     sub_401070
    move    $at, $at
    sdc1    $f0, 0xC4+var_B4($sp)
    move    $a0, $s0 # format
    mfc1    $a3, $f20
    mfc1    $a2, $f21
    jal     printf
    move    $at, $at
    lw      $a0, 0xC4+var_2C($fp)
    lw      $a1, 0xC4+var_28($fp)
    lw      $a2, 0xC4+var_24($fp)
    lw      $a3, 0xC4+var_20($fp)
    jal     sub_401070
    move    $at, $at
    mov.d   $f2, $f0
    lui     $v0, 0x40  # '@'
    ldc1    $f0, dbl_4013D8
    mul.d   $f2, $f0
    li      $v0, 1
    lui     $v1, 0x40  # '@'
    ldc1    $f0, dbl_4013E0
    c.lt.d  $f2, $f0
    move    $at, $at
    bc1t    loc_400FD0
    move    $at, $at
    move    $v0, $zero
    andi    $v0, 0xFF
    beqz    $v0, loc_401000
    move    $at, $at
    lui     $v0, 0x40  # '@'
    addiu   $a0, $v0, (aGo - 0x400000) # "... go!"
    jal     puts
    move    $at, $at
    addiu   $v0, $fp, 0xC4+var_1C
    move    $a0, $v0
    li      $a1, 0x400
    jal     sub_400B38
    move    $at, $at
    move    $sp, $fp
    lw      $ra, 0xC4+var_s8($sp)
    lw      $fp, 0xC4+var_s4($sp)
    lw      $s0, 0xC4+var_s0($sp)
    ldc1    $f20, 0xC4+var_sC($sp)
    addiu   $sp, 0xD8
    jr      $ra
    move    $at, $at
sub_400C30 endp

