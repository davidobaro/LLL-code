# David Obaro
# DAO54

.include "lab4_include.asm"

.eqv NUM_DOTS 3

.data
	dotX: .word 10, 30, 50
	dotY: .word 20, 30, 40
	curDot: .word 0
.text
.globl main
main:
	# when done at the beginning of the program, clears the display
	# because the display RAM is all 0s (black) right now.
	jal display_update_and_clear
		
	_loop:
		# code goes here!
		jal check_input
		jal wrap_dot_position 
		jal draw_dots
		
		
		jal display_update_and_clear
		jal sleep
	j _loop

	li v0, 10
	syscall

#-----------------------------------------

# new functions go here!
	draw_dots:
		push ra
		push s0
		li s0, 0
		_loop:
			mul t0, s0, 4
			lw a0, dotX(t0) 
			lw a1, dotY(t0)
			lw a3, curDot
			
			bne s0, a3, _else
			li a2, COLOR_ORANGE
			j _endif 
		_else:	
			li a2, COLOR_WHITE
		_endif:
					
			jal display_set_pixel
		
		
		add s0, s0, 1	
		blt s0, NUM_DOTS, _loop
		
		pop s0
		pop ra
		jr ra
#------------------------------------------------
	check_input:
		push ra
		jal input_get_keys_held
		
		 # if((v0 & KEY_Z) != 0) curDot = 0
		and t0, v0, KEY_Z
		beq t0, 0, _endif_z
			li t0, 0
			sw t0, curDot
		_endif_z:
		
		# if((v0 & KEY_X) != 0) curDot = 1
		and t0, v0, KEY_X
		beq t0, 0, _endif_x
			li t0, 1
			sw t0, curDot
		_endif_x:
		
		# if((v0 & KEY_C) != 0) curDot = 2
		and t0, v0, KEY_C
		beq t0, 0, _endif_c
			li t0, 2
			sw t0, curDot
		_endif_c:
		
		lw a1, curDot
		mul t5, a1, 4
		#DO NOT CHANGE  
		
		# if((v0 & KEY_R) != 0) dotX[curDot]++
		and t0, v0, KEY_R
		beq t0, 0, _endif_r
			lw a1, dotX(t5)
			add a1, a1, 1
			sw a1, dotX(t5)
		_endif_r:
		
		# if((v0 & KEY_U) != 0) dotY[curDot]--
		and t0, v0, KEY_U
		beq t0, 0, _endif_u
			lw a1, dotY(t5)
			sub a1, a1, 1
			sw a1, dotY(t5)
		_endif_u:
		
		# if((v0 & KEY_L) != 0) dotX[curDot]--
		and t0, v0, KEY_L
		beq t0, 0, _endif_l
			lw a1, dotX(t5)
			sub a1, a1, 1
			sw a1, dotX(t5)
		_endif_l:
		
		# if((v0 & KEY_D) != 0) dotY[curDot]++
		and t0, v0, KEY_D
		beq t0, 0, _endif_d
			lw a1, dotY(t5)
			add a1, a1, 1
			sw a1, dotY(t5)
		_endif_d:
		
		pop ra
		jr ra
#--------------------------------------------------
	wrap_dot_position:
		push ra
		
		lw a1, dotX(t5)
		lw a2, dotY(t5)
		
		#using bitwise AND to get the new postion
		and a1, a1, 63
		and a2, a2, 63
		
		sw a1, dotX(t5)
		sw a2, dotY(t5)
		
		pop ra
		jr ra
		


