################################################################################
#                                _____                     _                   #
#        /\/\   __ _ _ __ ___    \_   \_ ____   ____ _  __| | ___ _ __         #
#       /    \ / _` | '__/ __|    / /\/ '_ \ \ / / _` |/ _` |/ _ \ '__|        #
#      / /\/\ \ (_| | |  \__ \ /\/ /_ | | | \ V / (_| | (_| |  __/ |           #
#      \/    \/\__,_|_|  |___/ \____/ |_| |_|\_/ \__,_|\__,_|\___|_|           #
#                                                                              #
#                                                                              #
#                              ▄▄████▄▄                                        #
#                            ▄██████████▄                                      #
#                          ▄██▄██▄██▄██▄██▄                                    #
#                            ▀█▀  ▀▀  ▀█▀                                      #
#                                                                              #
################################################################################

#
# Vous n'avez pas besoin de modifier ou de comprendre le code qui vous est fourni.
#
# Les paramètres et valeur de retour des fonctions sont indiqués pour chaque
# fonction.
#
# Pour appeler les fonctions, passez les paramètres dans les registres de $a0 à
# $a3, dans cet ordre, pour les arguments des fonctions.
# Si la fonction renvoie une valeur, elle se trouvera dans $v0.
#
#
# Partie .text (Le programme)
# ** Ne pas modifier **

.text

j main

# Fonction cleanPartOfScreen
# Arguments : $a0 Abscisse du bord haut_gauche à effacer
#           : $a1 Ordonnée du bord haut_gauche à effacer
#           : $a2 Taille à effacer en abscisse (positif)
#           : $a3 Taille à effacer en ordonnée (positif)
# Retour : Aucun
# Condition : Rester dans les bornes [0,128[ en abscisse et  [0,64[ en ordonnée.
# Effet de bord : Dessine du noir sur la partie ciblée

 .globl cleanPartOfScreen       # -- Begin function cleanPartOfScreen
cleanPartOfScreen:                      # @cleanPartOfScreen
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 beqz $7, $BB0_5
 sll $1, $4, 2
 sll $2, $5, 9
 addu $1, $2, $1
 lui $2, 4097
 addu $2, $1, $2
 addiu $3, $zero, 0
$BB0_2:
 move $4, $2
 move $5, $6
 beqz $6, $BB0_4
$BB0_3:
 sw $zero, 0($4)
 addiu $5, $5, -1
 addiu $4, $4, 4
 bnez $5, $BB0_3
$BB0_4:
 addiu $3, $3, 1
 addiu $2, $2, 512
 bne $3, $7, $BB0_2
$BB0_5:
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra

# Fonction clean_screen
# Arguments : Aucun
# Retour : Aucun
# Effet de bord : Dessine du noir sur tout l'écran

 .globl clean_screen            # -- Begin function clean_screen
clean_screen:                           # @clean_screen
 addiu $sp, $sp, -24
 sw $ra, 20($sp)
 sw $fp, 16($sp)
 move $fp, $sp
 addiu $4, $zero, 0
 addiu $5, $zero, 0
 addiu $6, $zero, 128
 addiu $7, $zero, 64
 jal cleanPartOfScreen
 move $sp, $fp
 lw $fp, 16($sp)
 lw $ra, 20($sp)
 addiu $sp, $sp, 24
 jr $ra

# Fonction enemyBoxPosY
# Arguments : $a0 Le numéro de la ligne de l'extraterrestre dont on veut connaître la position
# Retour : $v0 La ligne du coin supérieur droit de l'extraterrestre
# En relation : enemyRows (Partie .data) pour la longueur d'un extraterrestre

 .globl enemyBoxPosY            # -- Begin function enemyBoxPosY
enemyBoxPosY:                           # @enemyBoxPosY
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 sll $1, $4, 1
 sll $2, $4, 3
 addu $1, $2, $1
 lui $2, %hi(boxTopPosY)
 lw $2, %lo(boxTopPosY)($2)
 addu $2, $2, $1
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra


# Fonction enemyBoxPosX
# Arguments : $a0 Le numéro de la colonne de l'extraterrestre dont on veut connaître la position
# Retour : $v0 La colonne du coin supérieur droit de l'extraterrestre
# En relation : enemyCols (Partie .data) pour la largeur d'un extraterrestre

 .globl enemyBoxPosX            # -- Begin function enemyBoxPosX
enemyBoxPosX:                           # @enemyBoxPosX
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 sll $1, $4, 4
 subu $1, $1, $4
 lui $2, %hi(boxTopPosX)
 lw $2, %lo(boxTopPosX)($2)
 addu $2, $2, $1
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra

# Fonction random_int_range
# Arguments : $a0 Borne inférieure
#           : $a1 Borne supérieure
# Retour : $v0 Un entier dans l'intervalle [$a0,$a1[
# Condition : $a0 < $a1

 .globl random_int_range        # -- Begin function random_int_range
random_int_range:                       # @random_int_range
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 move $3, $4
 subu $6, $5, $4
 addiu $2, $zero, 42
 addiu $4, $zero, 0
 addu $5, $zero, $6
 syscall
 move $2, $4
 addu $2, $2, $3
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra

# Fonction print_int
# Arguments : $a0 Un entier à afficher
# Retour : Aucun
# Effet de bord : Affiche un entier dans la console de MARS

 .globl print_int               # -- Begin function print_int
print_int:                              # @print_int
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 move $3, $4
 addiu $2, $zero, 1
 addu $4, $zero, $3
 syscall
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra

# Fonction print_string
# Arguments : $a0 L'adresse d'une chaîne de caractère.
# Retour : Aucun
# Effet de bord : Affiche la chaîne de caractère dans la console de MARS

 .globl print_string            # -- Begin function print_string
print_string:                           # @print_string
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 move $3, $4
 addiu $2, $zero, 4
 addu $4, $zero, $3
 syscall
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra

# Fonction read_int
# Arguments : Aucun
# Retour : $v0 L'entier entré au clavier par l'utilisateur

 .globl read_int                # -- Begin function read_int
read_int:                               # @read_int
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 addiu $2, $zero, 5
 syscall
 move $2, $2
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra

# Fonction keyStroke
# Arguments : Aucun
# Retour : $v0 La valeur 1 si la touche '4' a été la dernière pressée dans le simulateur de clavier MARS.
#              La valeur 2 si la touche '6' a été la dernière pressée dans le simulateur de clavier MARS.
#              La valeur 3 si la touche '5' a été la dernière pressée dans le simulateur de clavier MARS.
#              La valeur 0 sinon.
# Attention : La touche n'est consommée qu'une fois, après quoi la valeur retournée est 0.
#             Si plusieurs touches ont été pressées entre deux appels à keyStroke, seul la dernière sera prise en compte.

 .globl keyStroke               # -- Begin function keyStroke
keyStroke:                              # @keyStroke
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 lui $1, %hi(inputKeyboard)
 lw $1, %lo(inputKeyboard)($1)
 lw $2, 0($1)
 sw $zero, 0($1)
 addiu $2, $2, -52
 sltiu $1, $2, 3
 beqz $1, $BB6_2
 sll $1, $2, 2
 lui $2, %hi($switch.table.keyStroke)
 addiu $2, $2, %lo($switch.table.keyStroke)
 addu $1, $2, $1
 lw $2, 0($1)
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra
$BB6_2:
 addiu $2, $zero, 0
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra

# Fonction alienTurn
# Arguments : Aucun
# Retour : Aucun
# Effet de bord : Déplace les extraterrestres et crée un projectile en direction du joueur aléatoirement.

 .globl alienTurn               # -- Begin function alienTurn
alienTurn:                              # @alienTurn
 addiu $sp, $sp, -56
 sw $ra, 52($sp)
 sw $fp, 48($sp)
 sw $23, 44($sp)
 sw $22, 40($sp)
 sw $21, 36($sp)
 sw $20, 32($sp)
 sw $19, 28($sp)
 sw $18, 24($sp)
 sw $17, 20($sp)
 sw $16, 16($sp)
 move $fp, $sp
 lui $1, %hi(boxDirX)
 lw $2, %lo(boxDirX)($1)
 addiu $1, $zero, 2
 beq $2, $1, $BB7_7
$BB7_1:
 addiu $1, $zero, 1
 bne $2, $1, $BB7_22
$BB7_2:
 lui $1, %hi(boxTopPosX)
 lw $2, %lo(boxTopPosX)($1)
 beqz $2, $BB7_18
 lui $16, %hi(boxMovementX)
 lw $17, %lo(boxMovementX)($16)
 subu $1, $2, $17
 sltiu $1, $1, 129
 move $3, $17
 movz $3, $2, $1
 lui $18, %hi(enemiesPerRow)
 lw $1, %lo(enemiesPerRow)($18)
 sw $3, %lo(boxMovementX)($16)
 beqz $1, $BB7_6
 addiu $19, $zero, 0
 addiu $20, $zero, 12
 lui $21, %hi(boxTopPosX)
 lui $22, %hi(boxSizeY)
 lui $23, %hi(boxTopPosY)
$BB7_5:
 lw $6, %lo(boxMovementX)($16)
 lw $1, %lo(boxTopPosX)($21)
 subu $1, $1, $6
 addu $4, $20, $1
 lw $7, %lo(boxSizeY)($22)
 lw $5, %lo(boxTopPosY)($23)
 jal cleanPartOfScreen
 addiu $19, $19, 1
 lw $1, %lo(enemiesPerRow)($18)
 sltu $1, $19, $1
 addiu $20, $20, 15
 bnez $1, $BB7_5
$BB7_6:
 lw $1, %lo(boxMovementX)($16)
 sw $17, %lo(boxMovementX)($16)
 lui $2, %hi(boxTopPosX)
 lw $3, %lo(boxTopPosX)($2)
 subu $1, $3, $1
 sw $1, %lo(boxTopPosX)($2)
 j $BB7_22
$BB7_7:
 lui $1, %hi(boxTopPosX)
 lw $2, %lo(boxTopPosX)($1)
 lui $1, %hi(boxSizeX)
 lw $3, %lo(boxSizeX)($1)
 addu $5, $3, $2
 addiu $1, $zero, 127
 bne $5, $1, $BB7_12
 lui $16, %hi(enemiesRows)
 lw $1, %lo(enemiesRows)($16)
 beqz $1, $BB7_11
 addiu $17, $zero, 0
 lui $18, %hi(boxTopPosY)
 lui $19, %hi(boxMovementY)
 lui $20, %hi(boxSizeX)
 lui $21, %hi(boxTopPosX)
 addiu $22, $zero, 0
$BB7_10:
 lw $1, %lo(boxTopPosY)($18)
 addu $5, $17, $1
 lw $7, %lo(boxMovementY)($19)
 lw $6, %lo(boxSizeX)($20)
 lw $4, %lo(boxTopPosX)($21)
 jal cleanPartOfScreen
 addiu $22, $22, 1
 lw $1, %lo(enemiesRows)($16)
 sltu $1, $22, $1
 addiu $17, $17, 10
 bnez $1, $BB7_10
$BB7_11:
 lui $1, %hi(boxDirX)
 addiu $2, $zero, 1
 sw $2, %lo(boxDirX)($1)
 lui $1, %hi(boxMovementY)
 lw $1, %lo(boxMovementY)($1)
 lui $2, %hi(boxTopPosY)
 lw $3, %lo(boxTopPosY)($2)
 addu $1, $3, $1
 sw $1, %lo(boxTopPosY)($2)
 j $BB7_22
$BB7_12:
 lui $4, %hi(boxMovementX)
 lw $16, %lo(boxMovementX)($4)
 addu $1, $16, $5
 sltiu $1, $1, 128
 move $5, $16
 bnez $1, $BB7_14
 addiu $1, $zero, 128
 subu $1, $1, $2
 not $2, $3
 addu $5, $1, $2
$BB7_14:
 lui $17, %hi(enemiesPerRow)
 lw $1, %lo(enemiesPerRow)($17)
 sw $5, %lo(boxMovementX)($4)
 beqz $1, $BB7_17
 addiu $18, $zero, 0
 lui $19, %hi(boxTopPosX)
 lui $20, %hi(boxSizeY)
 lui $21, %hi(boxMovementX)
 lui $22, %hi(boxTopPosY)
 addiu $23, $zero, 0
$BB7_16:
 lw $1, %lo(boxTopPosX)($19)
 addu $4, $18, $1
 lw $7, %lo(boxSizeY)($20)
 lw $6, %lo(boxMovementX)($21)
 lw $5, %lo(boxTopPosY)($22)
 jal cleanPartOfScreen
 addiu $23, $23, 1
 lw $1, %lo(enemiesPerRow)($17)
 sltu $1, $23, $1
 addiu $18, $18, 15
 bnez $1, $BB7_16
$BB7_17:
 lui $1, %hi(boxMovementX)
 lw $2, %lo(boxMovementX)($1)
 sw $16, %lo(boxMovementX)($1)
 lui $1, %hi(boxTopPosX)
 lw $3, %lo(boxTopPosX)($1)
 addu $2, $3, $2
 sw $2, %lo(boxTopPosX)($1)
 j $BB7_22
$BB7_18:
 lui $16, %hi(enemiesRows)
 lw $1, %lo(enemiesRows)($16)
 beqz $1, $BB7_21
 addiu $17, $zero, 0
 lui $18, %hi(boxTopPosY)
 lui $19, %hi(boxMovementY)
 lui $20, %hi(boxSizeX)
 lui $21, %hi(boxTopPosX)
 addiu $22, $zero, 0
$BB7_20:
 lw $1, %lo(boxTopPosY)($18)
 addu $5, $17, $1
 lw $7, %lo(boxMovementY)($19)
 lw $6, %lo(boxSizeX)($20)
 lw $4, %lo(boxTopPosX)($21)
 jal cleanPartOfScreen
 addiu $22, $22, 1
 lw $1, %lo(enemiesRows)($16)
 sltu $1, $22, $1
 addiu $17, $17, 10
 bnez $1, $BB7_20
$BB7_21:
 lui $1, %hi(boxDirX)
 addiu $2, $zero, 2
 sw $2, %lo(boxDirX)($1)
 lui $1, %hi(boxMovementY)
 lw $1, %lo(boxMovementY)($1)
 lui $2, %hi(boxTopPosY)
 lw $3, %lo(boxTopPosY)($2)
 addu $1, $3, $1
 sw $1, %lo(boxTopPosY)($2)
$BB7_22:
 lui $2, %hi(enemiesRows)
 lw $1, %lo(enemiesRows)($2)
 beqz $1, $BB7_43
 addiu $3, $zero, 0
 lui $4, 4097
 lui $5, %hi(enemiesPerRow)
 lui $1, %hi(enemyRowType)
 addiu $6, $1, %lo(enemyRowType)
 lui $1, %hi(enemiesLife)
 addiu $7, $1, %lo(enemiesLife)
 lui $8, %hi(boxTopPosY)
 lui $9, %hi(boxTopPosX)
 lui $10, %hi(enemies_shape)
 lui $11, %hi(enemyColor)
 addiu $12, $zero, 48
 addiu $13, $zero, 8
 addiu $16, $zero, 0
$BB7_24:
 lw $1, %lo(enemiesPerRow)($5)
 beqz $1, $BB7_33
 sll $14, $3, 2
 addu $15, $6, $14
 addiu $24, $zero, 0
 move $25, $4
$BB7_26:
 sll $1, $3, 4
 addu $1, $1, $14
 addu $1, $7, $1
 sll $gp, $24, 2
 addu $1, $1, $gp
 lw $1, 0($1)
 beqz $1, $BB7_32
 lw $1, %lo(boxTopPosY)($8)
 sll $1, $1, 9
 addu $1, $25, $1
 lw $gp, %lo(boxTopPosX)($9)
 sll $gp, $gp, 2
 addu $gp, $1, $gp
 addiu $16, $10, %lo(enemies_shape)
 addiu $17, $zero, 0
$BB7_28:
 addiu $18, $zero, 0
$BB7_29:
 lw $1, 0($15)
 sll $19, $1, 7
 sll $1, $1, 8
 addu $1, $1, $19
 addu $1, $18, $1
 addu $1, $16, $1
 lw $1, 0($1)
 addiu $19, $18, 4
 lw $20, %lo(enemyColor)($11)
 movz $20, $zero, $1
 addu $1, $gp, $18
 sw $20, 0($1)
 move $18, $19
 bne $19, $12, $BB7_29
 addiu $16, $16, 48
 addiu $17, $17, 1
 addiu $gp, $gp, 512
 bne $17, $13, $BB7_28
 addiu $16, $zero, 1
$BB7_32:
 lw $1, %lo(enemiesPerRow)($5)
 addiu $24, $24, 1
 sltu $1, $24, $1
 addiu $25, $25, 60
 bnez $1, $BB7_26
$BB7_33:
 lw $1, %lo(enemiesRows)($2)
 addiu $3, $3, 1
 sltu $1, $3, $1
 addiu $4, $4, 5120
 bnez $1, $BB7_24
 beqz $16, $BB7_43
 lui $17, %hi(enemiesPerRow)
 lui $18, %hi(enemiesRows)
 lui $1, %hi(enemiesLife)
 addiu $19, $1, %lo(enemiesLife)
$BB7_36:
 lw $5, %lo(enemiesPerRow)($17)
 addiu $4, $zero, 0
 jal random_int_range
 lw $4, %lo(enemiesRows)($18)
 sll $1, $4, 2
 addu $1, $1, $4
 addu $1, $2, $1
 sll $1, $1, 2
 addu $1, $19, $1
 addiu $5, $1, -20
 sll $1, $4, 1
 sll $3, $4, 3
 addu $1, $3, $1
 addiu $3, $1, 8
 move $6, $4
$BB7_37:
 addiu $6, $6, -1
 sltu $1, $6, $4
 beqz $1, $BB7_40
 addiu $1, $5, -20
 addiu $3, $3, -10
 lw $7, 0($5)
 move $5, $1
 beqz $7, $BB7_37
 j $BB7_42
$BB7_40:
 bnez $16, $BB7_36
 j $BB7_43
$BB7_42:
 lui $1, %hi(shotsInFlight)
 lw $4, %lo(shotsInFlight)($1)
 sll $5, $4, 2
 sll $4, $4, 3
 addu $4, $4, $5
 lui $5, %hi(shootingPosition)
 addiu $5, $5, %lo(shootingPosition)
 addu $4, $5, $4
 sll $5, $2, 4
 subu $2, $5, $2
 lui $5, %hi(boxTopPosX)
 lw $5, %lo(boxTopPosX)($5)
 addu $2, $2, $5
 addiu $2, $2, 6
 sw $2, 0($4)
 lui $5, %hi(boxTopPosY)
 lw $5, %lo(boxTopPosY)($5)
 lui $6, %hi(projectileColor)
 lui $7, 4097
 addu $3, $5, $3
 sw $3, 4($4)
 sw $zero, 8($4)
 sll $2, $2, 2
 sll $3, $3, 9
 addu $2, $3, $2
 addu $2, $2, $7
 lw $3, %lo(projectileColor)($6)
 sw $3, 0($2)
 lw $2, %lo(shotsInFlight)($1)
 addiu $2, $2, 1
 sw $2, %lo(shotsInFlight)($1)
$BB7_43:
 move $sp, $fp
 lw $16, 16($sp)
 lw $17, 20($sp)
 lw $18, 24($sp)
 lw $19, 28($sp)
 lw $20, 32($sp)
 lw $21, 36($sp)
 lw $22, 40($sp)
 lw $23, 44($sp)
 lw $fp, 48($sp)
 lw $ra, 52($sp)
 addiu $sp, $sp, 56
 jr $ra

# Fonction printBuilding
# Arguments : Aucun
# Retour : Aucun
# Effet de bord : Affiche les bâtiments à l'écran

 .globl printBuilding           # -- Begin function printBuilding
printBuilding:                          # @printBuilding
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 lui $1, %hi(building)
 addiu $2, $1, %lo(building)
 addiu $3, $zero, 0
 lui $1, %hi(buildingPosX)
 addiu $4, $1, %lo(buildingPosX)
 lui $1, 4097
 ori $5, $1, 25088
 lui $6, %hi(buildingColor)
 addiu $7, $zero, 32
 addiu $8, $zero, 6
 addiu $9, $zero, 4
$BB8_1:
 sll $1, $3, 2
 addu $1, $4, $1
 lw $1, 0($1)
 sll $1, $1, 2
 addu $10, $1, $5
 move $11, $2
 addiu $12, $zero, 0
$BB8_2:
 addiu $13, $zero, 0
$BB8_3:
 addu $1, $11, $13
 lw $1, 0($1)
 lw $14, %lo(buildingColor)($6)
 movz $14, $zero, $1
 addu $1, $10, $13
 addiu $13, $13, 4
 sw $14, 0($1)
 bne $13, $7, $BB8_3
 addiu $10, $10, 512
 addiu $12, $12, 1
 addiu $11, $11, 32
 bne $12, $8, $BB8_2
 addiu $3, $3, 1
 addiu $2, $2, 192
 bne $3, $9, $BB8_1
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra

# Fonction printShooter
# Arguments : $a0 Valeur 1 si le canon doit se déplacer à gauche
#                 Valeur 2 si le canon doit se déplacer à droite
#                 Valeur 3 si le canon doit tirer un laser de la mort qui tue.
# Retour : Aucun
# Effet de bord : Met à jour la position du joueur, l'affiche à l'écran et crée un projectile si nécessaire.

 .globl printShooter            # -- Begin function printShooter
printShooter:                           # @printShooter
 addiu $sp, $sp, -32
 sw $ra, 28($sp)
 sw $fp, 24($sp)
 sw $17, 20($sp)
 sw $16, 16($sp)
 move $fp, $sp
 addiu $1, $zero, 2
 move $16, $4
 beq $4, $1, $BB9_4
$BB9_1:
 addiu $1, $zero, 1
 bne $16, $1, $BB9_8
$BB9_2:
 lui $17, %hi(shooterPosX)
 lw $2, %lo(shooterPosX)($17)
 beqz $2, $BB9_8
 addiu $4, $2, 12
 addiu $5, $zero, 58
 addiu $6, $zero, 1
 addiu $7, $zero, 5
 jal cleanPartOfScreen
 lw $1, %lo(shooterPosX)($17)
 addiu $1, $1, -1
 sw $1, %lo(shooterPosX)($17)
 j $BB9_8
$BB9_4:
 lui $17, %hi(shooterPosX)
 lw $4, %lo(shooterPosX)($17)
 addiu $1, $4, 14
 sltiu $1, $1, 129
 beqz $1, $BB9_6
 addiu $5, $zero, 58
 addiu $6, $zero, 1
 addiu $7, $zero, 5
 jal cleanPartOfScreen
 lw $1, %lo(shooterPosX)($17)
 addiu $1, $1, 1
 sw $1, %lo(shooterPosX)($17)
 j $BB9_8
$BB9_6:
 addiu $17, $zero, 115
 beq $4, $17, $BB9_8
 subu $6, $17, $4
 addiu $5, $zero, 58
 addiu $7, $zero, 5
 jal cleanPartOfScreen
 lui $1, %hi(shooterPosX)
 sw $17, %lo(shooterPosX)($1)
$BB9_8:
 lui $1, %hi(shooter)
 addiu $2, $1, %lo(shooter)
 addiu $3, $zero, 0
 lui $4, %hi(shooterPosX)
 lui $5, %hi(shooterColor)
 lui $6, 4097
 addiu $7, $zero, 13
 addiu $8, $zero, 5
$BB9_9:
 addiu $9, $3, 58
 move $10, $2
 addiu $11, $zero, 0
$BB9_10:
 lw $1, %lo(shooterPosX)($4)
 addu $1, $11, $1
 lw $12, %lo(shooterColor)($5)
 lw $13, 0($10)
 movz $12, $zero, $13
 sll $1, $1, 2
 sll $13, $9, 9
 addu $1, $13, $1
 addu $1, $1, $6
 sw $12, 0($1)
 addiu $11, $11, 1
 addiu $10, $10, 4
 bne $11, $7, $BB9_10
 addiu $3, $3, 1
 addiu $2, $2, 52
 bne $3, $8, $BB9_9
 addiu $1, $zero, 3
 bne $16, $1, $BB9_14
 lui $1, %hi(shotsInFlight)
 lw $2, %lo(shotsInFlight)($1)
 sll $3, $2, 2
 sll $2, $2, 3
 addu $2, $2, $3
 lui $3, %hi(shootingPosition)
 addiu $3, $3, %lo(shootingPosition)
 addu $2, $3, $2
 lui $3, %hi(shooterPosX)
 lw $3, %lo(shooterPosX)($3)
 addiu $3, $3, 6
 addiu $4, $zero, 57
 sw $4, 4($2)
 sw $3, 0($2)
 addiu $4, $zero, 1
 sw $4, 8($2)
 lui $2, 4097
 ori $2, $2, 29184
 sll $3, $3, 2
 addu $2, $3, $2
 lui $3, %hi(projectileColor)
 lw $3, %lo(projectileColor)($3)
 sw $3, 0($2)
 lw $2, %lo(shotsInFlight)($1)
 addiu $2, $2, 1
 sw $2, %lo(shotsInFlight)($1)
$BB9_14:
 move $sp, $fp
 lw $16, 16($sp)
 lw $17, 20($sp)
 lw $fp, 24($sp)
 lw $ra, 28($sp)
 addiu $sp, $sp, 32
 jr $ra

# Fonction sleep
# Argument : $a0 Un entier
# Retour : Aucun
# Crée un délai en répétant une opération qui ne fait rien.

 .globl sleep                   # -- Begin function sleep
sleep:                                  # @sleep
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 sll $1, $4, 3
 sll $2, $4, 4
 addu $1, $2, $1
 sll $2, $4, 10
 subu $2, $2, $1
 sw $zero, 0($fp)
 lw $1, 0($fp)
 sltu $1, $1, $2
 beqz $1, $BB10_2
$BB10_1:
 lw $1, 0($fp)
 addiu $1, $1, 1
 sw $1, 0($fp)
 lw $1, 0($fp)
 sltu $1, $1, $2
 bnez $1, $BB10_1
$BB10_2:
 move $sp, $fp
 lw $fp, 4($sp)
 addiu $sp, $sp, 8
 jr $ra

# Fonction resolveAndPrintShots
# Argument : Aucun
# Retour : Aucun
# Effet de bord : Met à jour le tableau enemiesLife si un extraterrestre est touché.
#                 Met la valeur 1 dans l'entier has_lost si le joueur se fait toucher.
#                 Met à jour le tableau "building" avec la valeur zéro si un projectile percute un bâtiment.
#                 Met à jour la position des projectiles.

 .globl resolveAndPrintShots    # -- Begin function resolveAndPrintShots
resolveAndPrintShots:                   # @resolveAndPrintShots
 addiu $sp, $sp, -104
 sw $ra, 100($sp)
 sw $fp, 96($sp)
 sw $23, 92($sp)
 sw $22, 88($sp)
 sw $21, 84($sp)
 sw $20, 80($sp)
 sw $19, 76($sp)
 sw $18, 72($sp)
 sw $17, 68($sp)
 sw $16, 64($sp)
 move $fp, $sp
 lui $15, %hi(shotsInFlight)
 lw $1, %lo(shotsInFlight)($15)
 beqz $1, $BB11_76
 lui $1, %hi(shootingPosition)
 addiu $21, $1, %lo(shootingPosition)
 addiu $18, $zero, 0
 lui $1, %hi(enemies_shape)
 addiu $1, $1, %lo(enemies_shape)
 sw $1, 28($fp)
 lui $24, %hi(building)
 addiu $1, $24, %lo(building)
 sw $1, 24($fp)
 lui $1, %hi(buildingPosX)
 addiu $20, $1, %lo(buildingPosX)
 addiu $19, $zero, 12
 lui $1, %hi(shooter)
 addiu $1, $1, %lo(shooter)
 sw $1, 40($fp)
 lui $1, %hi(enemyRowType)
 addiu $1, $1, %lo(enemyRowType)
 sw $1, 60($fp)
 sw $21, 32($fp)
 j $BB11_17
$BB11_2:
 lw $3, 44($fp)
 sltiu $1, $3, 64
 bnez $1, $BB11_9
 lw $1, %lo(shotsInFlight)($15)
 beqz $1, $BB11_75
 lw $1, 0($23)
 sll $1, $1, 2
 lw $2, 56($fp)
 lw $2, 0($2)
 sll $2, $2, 9
 addu $1, $2, $1
 lui $2, 4097
 addu $1, $1, $2
 sw $zero, 0($1)
 lw $1, %lo(shotsInFlight)($15)
 addiu $2, $1, -1
 sltu $1, $18, $2
 move $3, $21
 move $4, $18
 beqz $1, $BB11_8
$BB11_5:
 addiu $4, $4, 1
 addiu $5, $zero, 0
$BB11_6:
 addu $1, $3, $5
 lw $6, 12($1)
 addiu $5, $5, 4
 sw $6, 0($1)
 bne $5, $19, $BB11_6
 addiu $3, $3, 12
 bne $4, $2, $BB11_5
$BB11_8:
 sw $2, %lo(shotsInFlight)($15)
 j $BB11_75
$BB11_9:
 sll $1, $2, 9
 lw $4, 36($fp)
 addu $1, $1, $4
 lui $2, 4097
 addu $1, $1, $2
 sw $zero, 0($1)
 sll $1, $3, 9
 addu $1, $1, $4
 addu $1, $1, $2
 lui $2, %hi(projectileColor)
 lw $2, %lo(projectileColor)($2)
 sw $2, 0($1)
 lw $1, 56($fp)
 sw $3, 0($1)
 j $BB11_75
$BB11_10:
 lw $1, %lo(shotsInFlight)($15)
 beqz $1, $BB11_16
 lw $1, 0($23)
 sll $1, $1, 2
 lw $2, 56($fp)
 lw $2, 0($2)
 sll $2, $2, 9
 addu $1, $2, $1
 lui $2, 4097
 addu $1, $1, $2
 sw $zero, 0($1)
 lw $1, %lo(shotsInFlight)($15)
 addiu $2, $1, -1
 sltu $1, $18, $2
 move $3, $21
 move $4, $18
 beqz $1, $BB11_15
$BB11_12:
 addiu $4, $4, 1
 addiu $5, $zero, 0
$BB11_13:
 addu $1, $3, $5
 lw $6, 12($1)
 addiu $5, $5, 4
 sw $6, 0($1)
 bne $5, $19, $BB11_13
 addiu $3, $3, 12
 bne $4, $2, $BB11_12
$BB11_15:
 sw $2, %lo(shotsInFlight)($15)
$BB11_16:
 addiu $1, $zero, 1
 lui $2, %hi(has_lost)
 sw $1, %lo(has_lost)($2)
 j $BB11_75
$BB11_17:
 sll $1, $18, 2
 sll $2, $18, 3
 addu $1, $2, $1
 lw $2, 32($fp)
 addu $23, $2, $1
 lw $6, 0($23)
 lw $2, 4($23)
 sll $1, $2, 3
 addu $1, $6, $1
 lw $3, 8($23)
 sll $4, $2, 4
 sll $5, $2, 5
 addu $4, $5, $4
 sll $1, $1, 2
 xori $3, $3, 1
 addiu $8, $zero, 1
 addiu $5, $zero, -1
 movz $8, $5, $3
 lw $3, 24($fp)
 addu $1, $3, $1
 addu $5, $8, $2
 lw $3, 28($fp)
 addu $3, $3, $4
 sll $7, $6, 2
 sll $4, $8, 4
 sll $9, $8, 5
 addu $25, $9, $4
 sw $7, 36($fp)
 addu $11, $3, $7
 addiu $3, $23, 4
 sw $3, 56($fp)
 sw $5, 44($fp)
 addu $gp, $5, $8
 addiu $13, $1, -1568
 move $14, $2
 sw $9, 48($fp)
 sw $gp, 52($fp)
$BB11_18:
 beq $14, $gp, $BB11_2
 sltiu $1, $14, 64
 beqz $1, $BB11_2
 addiu $4, $14, -49
 sltiu $1, $4, 6
 addiu $5, $zero, 0
 beqz $1, $BB11_49
 addiu $7, $zero, 0
 move $3, $13
$BB11_22:
 sll $1, $7, 2
 addu $1, $20, $1
 lw $10, 0($1)
 subu $5, $6, $10
 sltiu $1, $5, 8
 beqz $1, $BB11_24
 sll $1, $7, 6
 sll $12, $7, 7
 addu $1, $12, $1
 addiu $12, $24, %lo(building)
 addu $1, $12, $1
 sll $12, $4, 5
 addu $1, $1, $12
 sll $12, $5, 2
 addu $1, $1, $12
 lw $1, 0($1)
 bnez $1, $BB11_26
$BB11_24:
 addiu $7, $7, 1
 sltiu $1, $7, 4
 addiu $3, $3, 192
 bnez $1, $BB11_22
 addiu $5, $zero, 0
 j $BB11_49
$BB11_26:
 sw $25, 20($fp)
 lui $1, %hi(shotRadiusBuilding)
 lw $15, %lo(shotRadiusBuilding)($1)
 sll $1, $15, 3
 sll $7, $15, 5
 addu $1, $7, $1
 sll $gp, $10, 2
 sll $16, $15, 1
 addu $24, $16, $15
 subu $1, $3, $1
 subu $3, $3, $7
 subu $7, $6, $16
 subu $25, $7, $10
 subu $12, $3, $gp
 subu $ra, $1, $gp
 ori $16, $16, 1
 addiu $17, $zero, 0
$BB11_27:
 sltu $1, $15, $17
 beqz $1, $BB11_35
 subu $3, $17, $15
 subu $7, $24, $17
 sltu $1, $7, $3
 bnez $1, $BB11_41
 addu $1, $17, $4
 subu $10, $1, $15
 move $22, $25
 move $gp, $ra
$BB11_30:
 sltiu $1, $10, 6
 beqz $1, $BB11_33
 sltiu $1, $22, 8
 beqz $1, $BB11_33
 sw $zero, 0($gp)
$BB11_33:
 addiu $3, $3, 1
 sltu $1, $7, $3
 addiu $22, $22, 1
 addiu $gp, $gp, 4
 beqz $1, $BB11_30
 j $BB11_41
$BB11_35:
 subu $3, $15, $17
 addu $7, $17, $15
 sltu $1, $7, $3
 bnez $1, $BB11_41
 addu $1, $17, $4
 subu $10, $1, $15
 move $22, $5
 move $gp, $12
$BB11_37:
 sltiu $1, $10, 6
 beqz $1, $BB11_40
 sltiu $1, $22, 8
 beqz $1, $BB11_40
 sw $zero, 0($gp)
$BB11_40:
 addiu $3, $3, 1
 sltu $1, $7, $3
 addiu $22, $22, 1
 addiu $gp, $gp, 4
 beqz $1, $BB11_37
$BB11_41:
 addiu $25, $25, 1
 addiu $ra, $ra, 36
 addiu $5, $5, -1
 addiu $17, $17, 1
 addiu $12, $12, 28
 bne $17, $16, $BB11_27
 lui $15, %hi(shotsInFlight)
 lw $1, %lo(shotsInFlight)($15)
 addiu $5, $zero, 1
 beqz $1, $BB11_48
 lw $1, 0($23)
 sll $1, $1, 2
 lw $3, 56($fp)
 lw $3, 0($3)
 sll $3, $3, 9
 addu $1, $3, $1
 lui $3, 4097
 addu $1, $1, $3
 sw $zero, 0($1)
 lw $1, %lo(shotsInFlight)($15)
 addiu $3, $1, -1
 sltu $1, $18, $3
 move $4, $21
 move $7, $18
 lw $25, 20($fp)
 lw $gp, 52($fp)
 lui $24, %hi(building)
 beqz $1, $BB11_47
$BB11_44:
 addiu $7, $7, 1
 addiu $10, $zero, 0
$BB11_45:
 addu $1, $4, $10
 lw $12, 12($1)
 addiu $10, $10, 4
 sw $12, 0($1)
 bne $10, $19, $BB11_45
 addiu $4, $4, 12
 bne $7, $3, $BB11_44
$BB11_47:
 sw $3, %lo(shotsInFlight)($15)
 j $BB11_49
$BB11_48:
 lui $24, %hi(building)
 lw $25, 20($fp)
 lw $gp, 52($fp)
$BB11_49:
 addiu $3, $14, -58
 sltiu $1, $3, 5
 beqz $1, $BB11_53
 bnez $5, $BB11_53
 lui $1, %hi(shooterPosX)
 lw $1, %lo(shooterPosX)($1)
 subu $4, $6, $1
 sltiu $1, $4, 13
 beqz $1, $BB11_53
 sll $1, $3, 2
 sll $7, $3, 3
 addu $1, $7, $1
 sll $3, $3, 6
 subu $1, $3, $1
 lw $3, 40($fp)
 addu $1, $3, $1
 sll $3, $4, 2
 addu $1, $1, $3
 lw $1, 0($1)
 bnez $1, $BB11_10
$BB11_53:
 bnez $5, $BB11_67
 lui $1, %hi(enemiesRows)
 lw $1, %lo(enemiesRows)($1)
 beqz $1, $BB11_67
 move $9, $25
 lui $1, %hi(boxTopPosY)
 lw $15, %lo(boxTopPosY)($1)
 sll $1, $15, 4
 sll $3, $15, 5
 addu $1, $3, $1
 subu $1, $11, $1
 lui $3, %hi(boxTopPosX)
 lw $24, %lo(boxTopPosX)($3)
 sll $3, $24, 2
 subu $10, $1, $3
 lui $1, %hi(enemiesLife)
 addiu $gp, $1, %lo(enemiesLife)
 lui $1, %hi(enemiesRows)
 lw $16, %lo(enemiesRows)($1)
 lui $1, %hi(enemiesPerRow)
 lw $17, %lo(enemiesPerRow)($1)
 addiu $ra, $zero, 0
$BB11_56:
 sll $1, $ra, 1
 sll $3, $ra, 3
 addu $1, $3, $1
 addu $5, $15, $1
 addiu $1, $5, 8
 sltu $1, $14, $1
 beqz $1, $BB11_65
 sltu $1, $14, $5
 bnez $1, $BB11_65
 beqz $17, $BB11_65
 sll $1, $ra, 2
 lw $3, 60($fp)
 addu $7, $3, $1
 addiu $3, $zero, 0
 move $25, $10
 move $4, $24
 move $22, $gp
$BB11_60:
 sltu $1, $6, $4
 bnez $1, $BB11_64
 lw $1, 0($22)
 beqz $1, $BB11_64
 addiu $1, $4, 12
 sltu $1, $6, $1
 beqz $1, $BB11_64
 lw $1, 0($7)
 sll $12, $1, 7
 sll $1, $1, 8
 addu $1, $1, $12
 addu $1, $25, $1
 lw $1, 0($1)
 bnez $1, $BB11_69
$BB11_64:
 addiu $3, $3, 1
 sltu $1, $3, $17
 addiu $25, $25, -60
 addiu $4, $4, 15
 addiu $22, $22, 4
 bnez $1, $BB11_60
$BB11_65:
 addiu $ra, $ra, 1
 sltu $1, $ra, $16
 addiu $10, $10, -480
 addiu $gp, $gp, 20
 bnez $1, $BB11_56
 addiu $5, $zero, 0
 lui $15, %hi(shotsInFlight)
 lui $24, %hi(building)
 move $25, $9
 lw $9, 48($fp)
 lw $gp, 52($fp)
$BB11_67:
 addu $11, $11, $25
 addu $13, $13, $9
 addu $14, $14, $8
 beqz $5, $BB11_18
 j $BB11_75
$BB11_69:
 addiu $6, $zero, 12
 addiu $7, $zero, 8
 jal cleanPartOfScreen
 sw $zero, 0($22)
 lui $15, %hi(shotsInFlight)
 lw $1, %lo(shotsInFlight)($15)
 lui $24, %hi(building)
 beqz $1, $BB11_75
 lw $1, 0($23)
 sll $1, $1, 2
 lw $2, 56($fp)
 lw $2, 0($2)
 sll $2, $2, 9
 addu $1, $2, $1
 lui $2, 4097
 addu $1, $1, $2
 sw $zero, 0($1)
 lw $1, %lo(shotsInFlight)($15)
 addiu $2, $1, -1
 sltu $1, $18, $2
 move $3, $21
 move $4, $18
 beqz $1, $BB11_74
$BB11_71:
 addiu $4, $4, 1
 addiu $5, $zero, 0
$BB11_72:
 addu $1, $3, $5
 lw $6, 12($1)
 addiu $5, $5, 4
 sw $6, 0($1)
 bne $5, $19, $BB11_72
 addiu $3, $3, 12
 bne $4, $2, $BB11_71
$BB11_74:
 sw $2, %lo(shotsInFlight)($15)
$BB11_75:
 lw $1, %lo(shotsInFlight)($15)
 addiu $18, $18, 1
 sltu $1, $18, $1
 addiu $21, $21, 12
 bnez $1, $BB11_17
$BB11_76:
 move $sp, $fp
 lw $16, 64($sp)
 lw $17, 68($sp)
 lw $18, 72($sp)
 lw $19, 76($sp)
 lw $20, 80($sp)
 lw $21, 84($sp)
 lw $22, 88($sp)
 lw $23, 92($sp)
 lw $fp, 96($sp)
 lw $ra, 100($sp)
 addiu $sp, $sp, 104
 jr $ra

# Fonction quit
# Argument : Aucun
# Retour : Ne retourne jamais **insérer rire diabolique** !
# Effet de bord : Fin du programme

quit:                                   # @quit
 addiu $sp, $sp, -8
 sw $fp, 4($sp)
 move $fp, $sp
 addiu $2, $zero, 10
 syscall

################################################################################
#                                                                              #
# Partie .data (Les données globales)                                          #
#                                                                              #
# Vous pouvez jouer avec certains paramètres pour voir ce qu'il se passe :D    #
# Avant de toucher à ces valeurs, faites une version fonctionnelle de votre    #
# projet.                                                                      #
#                                                                              #
################################################################################

# Bitmap de l'écran. Chaque pixel correspond à une valeur sur 32bits 0xaabbccdd
# où bb est la couleur rouge, cc la verte et dd la bleue sur 256 valeurs.
.data







 .globl frameBuffer
 .align 2
frameBuffer:
 .space 32768

# L'adresse où lire les données clavier virtuel
 .data
 .globl inputKeyboard
 .align 2
inputKeyboard:
 .word 4294901764

# Perdu ou pas perdu, tel est la question!
 .globl has_lost
 .align 2
has_lost:
 .word 0                       # 0x0

# Le nombre de lignes maximum prise par un extraterrestre
 .globl enemyRows
 .align 2
enemyRows:
 .word 8                       # 0x8

# Le nombre de colonnes maximum prise par un extraterrestre
 .globl enemyCols
 .align 2
enemyCols:
 .word 12                      # 0xc

# Le rayon d'explosion, quand un projectile explose sur un bâtiment
 .data
 .globl shotRadiusBuilding
 .align 2
shotRadiusBuilding:
 .word 2                       # 0x2

# Le nombre de déplacement horizontal parcouru par les ennemies
 .globl boxMovementX
 .align 2
boxMovementX:
 .word 3                       # 0x3

# Le nombre de déplacement vertical parcouru par les ennemies
 .globl boxMovementY
 .align 2
boxMovementY:
 .word 2                       # 0x2

# La position horizontale de la boîte invisible des ennemies
 .globl boxTopPosX
 .align 2
boxTopPosX:
 .word 0                       # 0x0

# La position verticale de la boîte invisible des ennemies
 .globl boxTopPosY
 .align 2
boxTopPosY:
 .word 0                       # 0x0

# Le nombre d'ennemies par ligne
 .data
 .globl enemiesPerRow
 .align 2
enemiesPerRow:
 .word 5                       # 0x5

# Le nombre de lignes d'ennemies
 .globl enemiesRows
 .align 2
enemiesRows:
 .word 3                       # 0x3

# Le type d'extraterrestre sur une ligne donnée (Entier 0, 1 ou 2)
 .globl enemyRowType
 .align 2
enemyRowType:
 .word 1                       # 0x1
 .word 2                       # 0x2
 .word 0                       # 0x0

lol: .asciiz "lolol"



# La vie des extraterrestres (Tableau [enemiesRows][enemiesPerRow])
 .globl enemiesLife
 .align 2
enemiesLife:
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1

# La couleur des extraterrestres
 .globl enemyColor
 .align 2
enemyColor:
 .word 16777215                # 0xffffff

# La couleur du canon du joueur
 .globl shooterColor
 .align 2
shooterColor:
 .word 16777215                # 0xffffff

# La couleur des projectiles
 .globl projectileColor
 .align 2
projectileColor:
 .word 16777215                # 0xffffff

# La couleur des bâtiments
 .globl buildingColor
 .align 2
buildingColor:
 .word 16777215                # 0xffffff

# La vie des bâtiments
 .globl building
 .align 2
building:
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1


# Le nombre de projectiles dans le jeu en ce moment
# ** Ne pas modifier **
 .globl shotsInFlight
 .align 2
shotsInFlight:
 .word 0                       # 0x0

# La structure de donnée des projectiles
# ** Ne pas modifier **
 .globl shootingPosition
 .align 2
shootingPosition:
 .space 1200

# La taille horizontale de la boîte invisible des extraterrestres
 .globl boxSizeX
 .align 2
boxSizeX:
 .word 0                       # 0x0

# La taille verticale de la boîte invisible des extraterrestres
 .globl boxSizeY
 .align 2
boxSizeY:
 .word 0                       # 0x0

# La direction de la boîte des extraterrestres (2 = droite, 1 = gauche)
 .data
 .globl boxDirX
 .align 2
boxDirX:
 .word 2                       # 0x2

# Les formes des ennemies pour l'affichage (Tableau [3][8][12])
# ** Modifier si vous avez du style, sinon laissez cela aux professionnels **
  .data
 .align 2
enemies_shape:
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0


# La position horizontale du coin supérieur gauche des bâtiments
  .data
 .align 2
buildingPosX:
 .word 19                      # 0x13
 .word 46                      # 0x2e
 .word 73                      # 0x49
 .word 100                     # 0x64

# La position horizontale du coin supérieur gauche du canon du joueur.
 .data
 .align 2
shooterPosX:
 .word 58                      # 0x3a

# La forme du joueur (Tableau [5][13])
# ** Modifier si vous avez du style, sinon laissez cela aux professionnels **
  .data
 .align 2
shooter:
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 0                       # 0x0
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1
 .word 1                       # 0x1

# Table branchement du switch
# ** Ne pas modifier **
  .data
 .align 2
$switch.table.keyStroke:
 .word 1                       # 0x1
 .word 3                       # 0x3
 .word 2                       # 0x2

################################################################################
# Partie .text (le programme)
#
# La boucle de jeu.
# Ici c'est à vous d'ajouter les fonctions pour détecter la fin de partie et de remplir la boucle de jeu
#
################################################################################

.text

 .globl main                    # -- Begin function main
main:                                   # @main

# Quelques initialisations
# ** Ne pas modifier **
 addiu $sp, $sp, -24
 sw $ra, 20($sp)
 sw $fp, 16($sp)
 move $fp, $sp
 lui $1, %hi(enemiesPerRow)
 lw $1, %lo(enemiesPerRow)($1)
 sll $2, $1, 4
 subu $1, $2, $1
 lui $2, %hi(boxTopPosX)
 lw $2, %lo(boxTopPosX)($2)
 addu $1, $1, $2
 addiu $1, $1, -4
 lui $2, %hi(enemiesRows)
 lw $2, %lo(enemiesRows)($2)
 sll $3, $2, 1
 sll $2, $2, 3
 lui $4, %hi(boxSizeX)
 sw $1, %lo(boxSizeX)($4)
 addu $1, $2, $3
 lui $2, %hi(boxTopPosY)
 lw $2, %lo(boxTopPosY)($2)
 addu $1, $1, $2
 addiu $1, $1, -3
 lui $2, %hi(boxSizeY)
 sw $1, %lo(boxSizeY)($2)
 jal clean_screen

# À partir d'ici, c'est à vous de jouer :





la $a0 lol
li $v0 4
syscall


# Créez la boucle de jeu ici
boucle_jeu:



 jal fonction_etudiant

 j boucle_jeu

# Ajoutez vos fonctions en dessous :

fonction_etudiant:

# Bah ça va, j'ai le temps, je vais faire le projet le jour avant le rendu ;-)

 j quit
