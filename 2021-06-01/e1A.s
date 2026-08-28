.globl  count_tokens

count_tokens:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $8,%esp

    movl 28(%esp),%ebx
    movl 32(%esp),%esi
    xorl %edi,%edi

    movl %ebx,(%esp)
    movl %esi,4(%esp)
    call strtok
    movl %eax,%ebp

    E:
        cmpl $0,%ebp
        je F

        incl %edi

        movl $0,(%esp)
        movl %esi,4(%esp)
        call strtok
        movl %eax,%ebp

        jmp E
    F:
        movl %edi,%eax
    #EPILOGO
        addl $8,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
        