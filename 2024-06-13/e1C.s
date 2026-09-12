.globl hextodec_sum

hextodec_sum:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $12,%esp

    movl 32(%esp),%ebx
    movl 36(%esp),%esi
    xorl %edi,%edi
    xorl %ebp,%ebp

    E:
        cmpb $0,(%ebx)
        je F

        movl %ebx,(%esp)
        leal 8(%esp),%eax
        movl %eax,4(%esp)
        call hextodec_helper

        movl 8(%esp),%eax
        cmpl $0,%eax
        jle A

        addl %eax,%edi

        A:
            movl %eax,(%esi,%ebp,4)
            addl $2,%ebx
            incl %ebp
            jmp E
    F:
        movl %edi,%eax
        #EPILOGO
        addl $12,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
