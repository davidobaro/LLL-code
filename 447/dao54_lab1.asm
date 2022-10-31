
#David Obaro dao54
.data
	x: .word 0
	y: .word 0
.text

.global main
main:
	# loading immediates into registers
	li t0, 1
	li t1, 2
	li t2, 3
	
	# moving values between registers
	move a0, t0
	move v0, t1
	move t2, zero
	
	# print 123
	li a0, 123
	li v0, 1
	syscall
	
	#print 456
	li a0, '\n'
	li v0, 11
	syscall
	
	li a0, 456
	li v0, 1
	syscall
	
	li a0, '\n'
	li v0, 11
	syscall
	
	li v0, 5
	syscall
	sw v0, x
	
	li v0, 5
	syscall
	sw v0, y 
	
	#loading x and y into registers
	lw a0, x
	lw a1, y
	add a0, a0, a1
	
	#printing the sum of the variables
	li v0, 1
	syscall
	
li v0, 10
syscall

	
