	INCLUDE	"mega65.i"
	INCLUDE	"zeropage.i"
	INCLUDE	"display.i"

VECTOR_IRQ_BRK	EQU	$FFFE
VECTOR_RESET	EQU	$FFFC
VECTOR_NMI	EQU	$FFFA

; ---------------------------------------------------------------------------	
; -- Main entry point
; ---------------------------------------------------------------------------	
	SECTION	"Main",CODE
Entry::
	sei

	; Ensure we're in 40 MHz mode
	lda	#$41
	sta	$00

	lda	#<scrollText
	sta	zp.scrolltext
	lda	#>scrollText
	sta	zp.scrolltext+1

	bsr	initMemoryMap
	bsr	initDisplay
	bsr	clearScreen

.main_loop
	bsr	waitSOF
	bsr	scroller
	bra	.main_loop


; ---------------------------------------------------------------------------	
; -- Scroller
; ---------------------------------------------------------------------------	
	SECTION "scroller",CODE
scroller:
	; increase pixel position
	lda	R_TEXTXPOSL
	dea
	cmp	#80-16
	bne	.bit_ok

	; copy chars to the left
	ldq	#TEXT_SCREEN
	bsr	.copy
	ldq	#COLOUR_RAM
	bsr	.copy

	ldq	#TEXT_SCREEN+40
	stq	zp.tl0

	ldz	#0
.next_char
	lda	(zp.scrolltext),z
	bne	.got_char

	lda	#<scrollText
	sta	zp.scrolltext
	lda	#>scrollText
	sta	zp.scrolltext+1

	bra	.next_char	
.got_char
	and	#~$40		; "convert" ASCII to screen code
	sta	[zp.tl0],z
	inw	zp.scrolltext

	lda	#80
.bit_ok
	sta	R_TEXTXPOSL
	
	rts

	; copy CHARS_PER_LINE-1 bytes from Q+1 to Q
.copy
	stq	zp.tl0
	stq	zp.tl1
	inq	zp.tl1
	ldz	#0
.copy_loop
	lda	[zp.tl1],z
	sta	[zp.tl0],z
	inz
	cpz	#CHARS_PER_LINE-1
	bne	.copy_loop

	rts

; ---------------------------------------------------------------------------	
; -- Initialize memory map
; ---------------------------------------------------------------------------	
	SECTION "initMemoryMap",CODE
initMemoryMap:
	; Clear C65 memory map
	lda	#$00
	tax
	tay
	taz
	map

	; Set IRQ vectors
	ldx	#<.emptyIrq
	ldy	#>.emptyIrq
	stx	VECTOR_IRQ_BRK
	sty	VECTOR_IRQ_BRK+1
	stx	VECTOR_NMI
	sty	VECTOR_NMI+1
	stx	VECTOR_RESET
	sty	VECTOR_RESET+1

	; End MAP sequence, thus allowing interrupts to occur again
	eom

	; Bank I/O in via C64 mechanism
	lda	#$35
	sta	$01

	; Do MEGA65 / VIC-IV I/O knock
	lda	#$47
	sta	R_KEY
	lda	#$53
	sta	R_KEY

	; don't map rom
	lda	#$00
	sta	R_ROMEN

	rts

.emptyIrq:
	rti


; ---------------------------------------------------------------------------
; -- Data
; ---------------------------------------------------------------------------

	SECTION "Text",DATA
scrollText:
	DB	"THIS IS A DEMONSTRATION OF HOW TO SET UP A PROJECT USING THE ASMOTOR ASSEMBLER AND LINKER ... ",0
	

		