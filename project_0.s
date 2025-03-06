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

end_forward:
    #Now we print the Backward Strings
    li t0, 1 #We have to reset the m-counter (1-9)
backward_loop: #This is essentially like the first loop it needs to be iterated the opposite was
    bgt $t0, 9, end_backward #Exit loop when m>9 
    #Calculate starting index: (N + 20 -m) %9
    addi $t2, $s0, 20 #$t2 = N + 20
    sub $t2, $t2, $t0 #$t2 = N + 20 - m
    li $t3, 9 #Modulus base
    div $t2, $t3 #Divide by 9
    mfhi $t2 #$t2 = remainder = (N+20-m) %9

    li $t4, 0 #Character counter (0-8)
backward_char_loop:
    bgt $t4, 8, end_backward_char #Exit after 9 characters
    #Calculate reversed position: 8 - ((start + i) %9)
    add $t5, $t2, $t4  #$t5 = start_index + char_offset
    div $t5, $t3 #Divide by 9 
    mfhi $t5 #$t5 = effective position(0-8)
    li $t6, 8 #Max index for reversal 
    sub $t6, $t6, $t5 #Reverse position: 8 - position

    #Load and print character 
    la $t7, id #Load ID string address
    add $t7, $t7, $t6 #Calculate reversed character address
    lb $a0, 0($t7) #Load character from memory
    li $v0, 11 #Syscall for printing character
    syscall 

    addi $t4, $t4, 1 #Increment character counter
    j backward_char_loop
end_backward_char:
    #Print newlinw after each string
    li $a0, 10 #ASCII code for newline
    li $v0, 11
    syscall

    addi $t0, $t0, 1 #Increment m-counter
    j backward_char_loop
    
    
