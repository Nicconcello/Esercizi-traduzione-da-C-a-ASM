.globl most_freq_char

most_freq_char:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $8,%esp

    movl 28(%esp),%ebx
    movl 32(%esp),%esi
    movl $-1,%edi
    xorl %ebp,%ebp

    movl %esi,(%esp)
    movl $256,4(%esp)
    call clear

    W:
        cmpb $0,(%ebx)
        je F

        movsbl (%ebx),%edx
        incl (%esi,%edx,4)
        incl %ebx
        jmp W

    F:
        incl %edi
        cmpl $256,%edi
        jge R

        movl (%esi,%ebp,4),%ecx
        cmpl %ecx,(%esi,%edi,4)
        jle F

        movl %edi,%ebp
        jmp F
    R:
        movl %ebp,%eax
    #EPILOGO
        addl $8,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
        