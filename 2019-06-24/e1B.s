.globl has_duplicates

has_duplicates:
    #PROLOGO
    pushl %ebx
    pushl %esi

    movl 12(%esp),%ebx
    movl $-1,%esi

    E:
        movl %esi,%ecx
        incl %ecx
        incl %esi

        cmpl 16(%esp),%esi
        jae F

        S:
            incl %ecx

            cmpl 16(%esp),%ecx
            jae E

            movw (%ebx,%ecx,2),%dx
            cmpw %dx,(%ebx,%esi,2)
            je I

            jmp S
        jmp E
    F:
        xorl %eax,%eax
        jmp R
    I:
        movl $1,%eax
    R:
    #EPILOGO
        popl %esi
        popl %ebx

        ret
