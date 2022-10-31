# David Obaro
# dao54

# preserves a0, v0
.macro print_str %str
	.data
	print_str_message: .asciiz %str
	.text
	push a0
	push v0
	la a0, print_str_message
	li v0, 4
	syscall
	pop v0
	pop a0
.end_macro

# -------------------------------------------
.eqv ARR_LENGTH 5
.data
	arr: .word 100, 200, 300, 400, 500
	message: .asciiz "testing!"
.text
# -------------------------------------------
.globl main
main:
	jal input_arr
	jal print_arr
	jal print_chars
	
	
	# exit()
	li v0, 10
	syscall
# -------------------------------------------

	input_arr:
		push ra
			_loop:
				print_str "enter value: "
				
				mul t1, t0, 4
				li v0, 5
				syscall 
				sw v0, arr(t1)
				
			#incrementing t0
			add t0, t0, 1	
			blt t0, ARR_LENGTH, _loop
		
		pop ra
		jr ra
# -------------------------------------------
	print_arr:
		push ra
		li t0, 0
		_loop:
			print_str "arr["
			
			move a0, t0
			li v0, 1
			syscall
			
			print_str "] = "
			
			#printing out the value at arr(t0)
			mul t1, t0, 4
			lw a0, arr(t1)
			li v0, 1
			syscall
			
			
			print_str "\n"
			
		#incrementing t0
		add t0, t0, 1	
		blt t0, ARR_LENGTH, _loop
		
		pop ra
		jr ra

# -------------------------------------------
	print_chars:
		push ra
		li t0, 0
		_loop:
			lb a0, message(t0)
			li v0, 11
			syscall
			print_str"\n"
			
		#incrementing t0
		add t0, t0, 1
		bne a0, zero, _loop
		
		pop ra
		jr ra
