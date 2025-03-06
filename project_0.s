.data
id: .asciiz "@03100118" My unique Howard ID

.text
.globl main

main:
#Let's Initialize the hard-coded N value 
    li $s0, 6 #$s0 = N = 03100118 % 8 = 6

    #Print the forward strings
    li $t0, 1 #Lets Initialize the m-counter (1-9)
forward_loop:
    bgt $t0, 9, end_forward #Exit loop when m > 9 (branch if greater than)
    #Lets calculate the starting index: (n + N) % 9
    add $t2, $t0, $s0 #$t2 = m + N
    li $t3, 9 #Modulus base
    div $t2, $t3 #Divide by 9
    mfhi $t2 #$t2 = remainder of (m + N)%9

    li $t4, 0 #This keeps track of how many characters were counted 
forward_char_loop:
    bgt $t4, 8, end_forward_char #This exits after 9 characters(branch if greater than)
    #Lets calculate circular position: (start + i) % 9
    add $t5, $t2, $t4 #$t5 = start_index + char_offset
    div $t5, $t3 #here we divide by 9
    mfhi $t5 #$t5 is the effective position (0-8)

    #Load and print Character
    la $t6, id #Load ID string address
    add $t6, $t6, $t5 #Calculate character address
    lb $a0, 0($t6) #Load character from memory
    li $v0, 11 #Syscall for printing character

    addi $t4, $t4, 1 #Increment character counter
    j forward_char_loop #Jump 
