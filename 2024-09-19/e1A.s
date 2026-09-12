.globl _slice

_slice:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $12,%esp

    movl 32(%esp),%ebx
    movl 36(%esp),%esi
    xorl %edi,%edi
    movl 40(%esp),%ebp
    subl %esi,%ebp
    decl %ebp

    E:
        cmpb $0,(%ebx)
        je I

        cmpl %esi,%edi
        jne C

        movl %ebx,(%esp)
        movl %ebp,4(%esp)
        movl 44(%esp),%edx
        movl %edx,8(%esp)
        call _slice_helper

        C:
            incl %ebx
        incl %edi
        jmp E
    I:
        cmpl %esi,%edi
        jge F
        xorl %ebp,%ebp
    F:
        movl %ebp,%eax
    #EPILOGO
        addl $12,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
