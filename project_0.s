.data
id: .asciiz "@03100118" My unique Howard ID

.text
.globl main

main:
#Let's Initialize the hard-coded N value 
    li $s0, 6 #$s0 = N = 03100118 % 8 = 6

    #Print the forward strings
    li $t0, 1 #Lets Initialize the m-counter (1-9)
