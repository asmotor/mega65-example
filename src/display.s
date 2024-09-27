	INCLUDE "mega65.i"
	INCLUDE "zeropage.i"
	INCLUDE "display.i"

SCREEN_HEIGHT		EQU	200

TOP_BORDER_POS		EQU	42	
BOTTOM_BORDER_POS	EQU	TOP_BORDER_POS+SCREEN_HEIGHT*2-1

BORDER_WIDTH		EQU	80
	
		
; ---------------------------------------------------------------------------	
; -- Wait for start of field
; ---------------------------------------------------------------------------	
	SECTION "waitSOF",CODE
waitSOF::
	; test MSB of raster Y position
	bit	R_YSCL
	bpl	waitSOF
.loop
	bit	R_YSCL
	bmi	.loop
	rts
	
; ---------------------------------------------------------------------------	
; -- Initialize the first line of text and colour RAM.
; ---------------------------------------------------------------------------	
	SECTION "clearScreen",CODE
clearScreen::
	; colour RAM
	ldq	#COLOUR_RAM
	stq	zp.tl0
	lda	#$01
	bsr	.clear

	; text screen
	ldq	#TEXT_SCREEN
	stq	zp.tl0
	lda	#32	; space screen code
.clear
	ldz	#CHARS_PER_LINE-1
.loop
	sta	[zp.tl0],z
	dez
	bpl	.loop

	rts


; ---------------------------------------------------------------------------	
; -- Initialise display registers to NTSC
; ---------------------------------------------------------------------------	
	SECTION "initDisplay",CODE
initDisplay::
	ldz	#0

	stz	R_BORDERCOL
	stz	R_SCREENCOL

	; 40 column
	stz	R_VMODE
	lda	#CHARS_PER_LINE
	sta	R_CHRCOUNT
	stz	R_LINESTEPL

	; set border position
	lda	#<TOP_BORDER_POS
	sta	R_TBDRPOSL
	stz	R_TBDRPOSH
	lda	#<BOTTOM_BORDER_POS
	sta	R_BBDRPOSL
	lda	#>BOTTOM_BORDER_POS
	sta	R_BBDRPOSH

	; charset

	; ROM charset at $001000
	stz	R_CHARPTRLSB
	lda	#$10
	sta	R_CHARPTRMSB
	stz	R_CHARPTRBNK

	; text screen at TEXT_SCREEN
	lda	#<TEXT_SCREEN
	sta	R_SCRNPTRLSB
	lda	#>TEXT_SCREEN
	sta	R_SCRNPTRMSB
	lda	#^TEXT_SCREEN
	sta	R_SCRNPTRBNK

	; set text position
	lda	#<BORDER_WIDTH
	sta	R_TEXTXPOSL
	lda	#>BORDER_WIDTH
	sta	R_TEXTXPOSH

	; set borders
	lda	#<TOP_BORDER_POS
	sta	R_TEXTYPOSL
	lda	#>TOP_BORDER_POS
	sta	R_TEXTYPOSH

	lda	#<BORDER_WIDTH
	sta	R_SDBDRWDL
	lda	#>BORDER_WIDTH
	sta	R_SDBDRWDH

	; Scaling
	lda	#120
	sta	R_CHRXSCL
	lda	#1
	sta	R_CHRYSCL

	; set NTSC mode
	lda	#R_RASLINE0.PALNTSC
	sta	R_RASLINE0

	; set display generation
	lda	#R_FNRASTERH.UPSCALE
	sta	R_FNRASTERH
	stz	R_MISC

	rts
