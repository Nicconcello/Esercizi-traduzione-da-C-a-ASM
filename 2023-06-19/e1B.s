.globl rc4_encrypt_rev

rc4_encrypt_rev:
    #PROLOGO
    pushl %ebx
    pushl %esi
    pushl %edi
    pushl %ebp
    subl $12,%esp

    xorl %ebx,%ebx
    xorl %esi,%esi
    movl 40(%esp),%ebp
    movl 36(%esp),%edi
    movl %edi,(%esp)
    call strlen
    addl %eax,%edi
    decl %edi

    E:
        cmpl 36(%esp),%edi
        jb F

        incl %esi
        andl $255,%esi

        movl 32(%esp),%ecx
        addb (%ecx,%esi,1),%bl

        movl %ecx,(%esp)
        movl %esi,4(%esp)
        movl %ebx,8(%esp)
        call rc4_helper
        xorb (%edi),%al

        movb %al,(%ebp)

        decl %edi
        incl %ebp

        jmp E
    F:
    #EPILOGO
        addl $12,%esp
        popl %ebp
        popl %edi
        popl %esi
        popl %ebx

        ret
        