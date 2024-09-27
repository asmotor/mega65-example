VECTOR_IRQ_BRK	EQU	$FFFE
VECTOR_RESET	EQU	$FFFC
VECTOR_NMI	EQU	$FFFA


	SECTION	"Main",CODE

Entry::
	sei

	; Ensure we're in 40 MHz mode
	lda	#$41
	sta	$00

	jsr	initMemoryMap

.flash
	inc	$d021
	bra	.flash

	rts

initMemoryMap:
	; Clear C65 memory map
	lda	#$00
	tax
	tay
	taz
	map

	; Bank I/O in via C64 mechanism
	lda	#$35
	sta	$01

	; Do MEGA65 / VIC-IV I/O knock
	lda	#$47
	sta	$d02f
	lda	#$53
	sta	$d02f

	; Set IRQ vectors
	ldx	#<emptyIrq
	ldy	#>emptyIrq
	stx	VECTOR_IRQ_BRK
	sty	VECTOR_IRQ_BRK+1
	stx	VECTOR_NMI
	sty	VECTOR_NMI+1
	stx	VECTOR_RESET
	sty	VECTOR_RESET+1

	; End MAP sequence, thus allowing interrupts to occur again
	eom

	rts


emptyIrq:
	rti
