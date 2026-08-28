.globl is_prefix

is_prefix:
    #PROLOG
    pushl %ebx
    pushl %esi

    movl 12(%esp),%ebx
    movl 16(%esp),%esi

    W:
        cmpb $0,(%ebx)
        je R
        cmpb $0,(%esi)
        je R
        movb (%esi),%cl
        cmpb %cl,(%ebx)
        jne R

        incl %ebx
        incl %esi
        jmp W
    R:
        cmpb $0,(%ebx)
        je I
        xorl %eax,%eax
        jmp F
    I:
        movl $1,%eax
    F:
    #EPILOGO
        popl %esi
        popl %ebx

        ret
