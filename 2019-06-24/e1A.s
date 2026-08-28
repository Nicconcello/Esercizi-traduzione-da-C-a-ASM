.globl init_matrix

init_matrix:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $8,%esp

    movl 28(%esp),%ebx
    movl 32(%esp),%esi
    movl $-1,%edi

    E:
        incl %edi

        cmpl %esi,%edi
        jae F

        xorl %ebp,%ebp

        S:
            cmpl %esi,%ebp
            jae E

            movl %edi,(%esp)
            movl %ebp,4(%esp)
            call value

            movl (%ebx,%edi,4),%ecx
            movw %ax,(%ecx,%ebp,2)

            incl %ebp
            jmp S

        jmp  E
    F:
    #EPILOGO
        addl $8,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
