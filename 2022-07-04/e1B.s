.globl count_matching_vars

count_matching_vars:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $8,%esp

    movl 28(%esp),%ebx
    movl 32(%esp),%esi

    cmpl $0,%ebx 
    je N

    cmpl $0,%esi
    je N

    xorl %edi,%edi

    E:
        cmpl $0,(%ebx)
        je F

        movl (%ebx),%eax
        movl %eax,(%esp)
        call getenv
        movl %eax,%ebp

        cmpl $0,%ebp
        je A

        movl %ebp,(%esp)
        movl %esi,4(%esp)
        call strstr
        cmpl $0,%eax
        je A

        incl %edi

        A:
            addl $4,%ebx
            jmp E
    F:
        movl %edi,%eax
        jmp R
    N:
        movl $-1,%eax
    R:
    #EPILOGO
        addl $8,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
