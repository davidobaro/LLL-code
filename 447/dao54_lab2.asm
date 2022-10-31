# DAVID OBARO
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
.data
	display: .word 0
	operation: .word 0
.text

.globl main
main:
	print_str "Hello! Welcome!\n"
	
	_loop:
		#printing the value of display
		lw a0, display
		li v0, 1
		syscall
		
		print_str "\nOperation (=,+,-,*,/,c,q): "
		
		#storing the values into operation
		# operation = read_char();
		li v0, 12
		syscall
		sw v0, operation
		
		#new line
		print_str "\n"
		
		# switch(operation) {
		lw  t0, operation
		beq t0, 'q', _quit
		beq t0, 'c', _clear
		beq t0, '+', _get_operand
		beq t0, '-', _get_operand
		beq t0, '*', _get_operand
		beq t0, '/', _get_operand
		beq t0, '=',  _get_operand
		j   _default
		
		# case '=':

		_get_operand:
			print_str "Value: "
			li v0, 5
			syscall
			
			move a0, v0
			li v0, 1
			syscall
			print_str "\n"
			
			# switch(operation) { no. 2
			lw  t0, operation
			beq t0, '-', _minus
			beq t0, '+', _plus
			beq t0, '*', _mult
			beq t0, '/', _div
			beq t0, '=', _equal
			
				#case: '='
				_equal:
					sw a0, display
					j _break
				#case: '-'
				_minus:
					lw a1, display
					sub a0, a1, a0
					sw a0, display
					j _break
				#case: '+'
				_plus:
					lw a1, display
					add a0, a0, a1
					sw a0, display
					j _break
				#case: '*'
				_mult:
					lw a1, display
					mul a0, a0, a1
					sw a0, display	
					j _break
				#case: '/'
				_div:	
						lw a1, display
						bne a0, 0, _else
						print_str "Math Error: Cannot divide by 0!\n"
						j _endif 
					_else:	
						div a0, a1, a0
						sw a0, display
					_endif:
				j _break
									
		j _break
				
		# case 'q':
		_quit:
			print_str "program is finished running "
			#j _break
			li v0, 10
			syscall
	
		# case 'c'
		_clear:
			print_str "clear\n"
			#storing zero in display
			sw, zero, display
			j _break
	
		# default:
		_default:
			print_str "Huh?\n"
	_break:
		# }
		
		j _loop
	
