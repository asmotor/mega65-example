	INCLUDE ONCE

; ---------------------------------------------------------------------------
; -- Memory map
; ---------------------------------------------------------------------------

COLOUR_RAM		EQU	$FF80000
COLOUR_RAM_SIZE	EQU	64*1024


; ---------------------------------------------------------------------------
; -- VIC-II
; ---------------------------------------------------------------------------

R_S0X		EQU	$D000	; Sprite 0 horizontal position
R_S0Y		EQU	$D001	; Sprite 0 vertical postion
R_S1X		EQU	$D002	; Sprite 1 horizontal position
R_S1Y		EQU	$D003	; Sprite 1 vertical position
R_S2X		EQU	$D004	; Sprite 2 horizontal position
R_S2Y		EQU	$D005	; Sprite 2 vertical position
R_S3X		EQU	$D006	; Sprite 3 horizontal position
R_S3Y		EQU	$D007	; Sprite 3 vertical position
R_S4X		EQU	$D008	; Sprite 4 horizontal position
R_S4Y		EQU	$D009	; Sprite 4 vertical position
R_S5X		EQU	$D00A	; Sprite 5 horizontal position
R_S5Y		EQU	$D00B	; Sprite 5 vertical position
R_S6X		EQU	$D00C	; Sprite 6 horizontal position
R_S6Y		EQU	$D00D	; Sprite 6 vertical position
R_S7X		EQU	$D00E	; Sprite 7 horizontal position
R_S7Y		EQU	$D00F	; Sprite 7 vertical position
R_SXMSB		EQU	$D010	; Sprite horizontal position MSBs

R_YSCL		EQU	$D011
.RC8			EQU	$80		; Raster compare bit 8
.ECM			EQU	$40		; Extended background mode
.BMM			EQU	$20		; Bitmap mode
.BLNK		EQU	$10		; Enable display: 0 = blank the display, 1 = show the display
.RSEL		EQU	$08		; 24/25 row select
.YSCL		EQU	$07		; 24/25 vertical smooth scroll

R_RC			EQU	$D012	; Raster compare bits 0 to 7

R_LPX		EQU	$D013	; Coarse horizontal beam position (was lightpen X)
R_LPY		EQU	$D014	; Coarse vertical beam position (was lightpen Y)
	
R_SE			EQU	$D015	; Sprite enable bits

R_XSCL		EQU	$D016
.RST			EQU	$20		; Disables video output on MAX Machine(tm) VIC-II 6566.
						; Ignored on normal C64s and the MEGA65
.MCM			EQU	$10		; Multi-colour mode
.CSEL		EQU	$08		; 38/40 column select
.XSCL		EQU	$07		; horizontal smooth scroll

R_SEXY		EQU	$D017	; Sprite vertical expansion enable bits

R_VS			EQU	$D018
.VS			EQU	$F0		; Screen address (x 1KiB)
.CB			EQU	$0E		; Character set address location (x 1KiB)

R_IIND		EQU	$D019
.ILP			EQU	$08		; Light pen indicate or acknowledge
.ISSC		EQU	$04		; Sprite:sprite collision indicate or acknowledge
.ISBC		EQU	$02		; Sprite:bitmap collision indicate or acknowledge
.RIRQ		EQU	$01		; Raster compare indicate or acknowledge

R_IENA		EQU	$D01A
.MISSC		EQU	$04		; Mask sprite:sprite collision IRQ
.MISBC		EQU	$02		; Mask sprite:bitmap collision IRQ
.MRIRQ		EQU	$01		; Mask raster IRQ

R_BSP		EQU	$D01B	; Sprite background priority bits

R_SCM		EQU	$D01C	; Sprite multicolour enable bits

R_SEXX		EQU	$D01D	; Sprite horizontal expansion enable bits

R_SSC		EQU	$D01E	; Sprite/sprite collision indicate bits

R_SBC		EQU	$D01F	; Sprite/foreground collision indicate bits


; ---------------------------------------------------------------------------
; -- VIC-IV
; ---------------------------------------------------------------------------

R_BORDERCOL	EQU	$D020
R_SCREENCOL	EQU	$D021
R_MC1		EQU	$D022	; multi-colour 1 (256 colour)
R_MC2		EQU	$D023	; multi-colour 2 (256 colour)
R_MC3		EQU	$D024	; multi-colour 3 (256 colour)
R_SPRMC0		EQU	$D025	; sprite multi-colour 1
R_SPRMC1		EQU	$D026	; sprite multi-colour 2
R_KEY		EQU	$D02F	; key/knock register, select VIC

R_ROMEN		EQU	$D030
.ROME		EQU	$80		; map C65 ROM $E000
.CROM9		EQU	$40		; select between C64/C65 charset
.ROMC		EQU	$20		; map C65 ROM $C000
.ROMA		EQU	$10		; map C65 ROM $A000
.ROM8		EQU	$08		; map C65 ROM $8000
.PAL			EQU	$04		; use PALETTE ROM (0) or RAM (1) entries for colours 0 - 15
.EXTSYNC		EQU	$02		; enable external video sync (genlock input)
.CRAM2K		EQU	$01		; map 2nd KiB of colour RAM $DC00-$DFFF

R_VMODE		EQU	$D031
.H640		EQU	$80		; enable C64 640 horizontal pixels / 80 column mode
.FAST		EQU	$40		; enable C65 FAST mode (∼3.5MHz)
.ATTR		EQU	$20		; enable extended attributes and 8 bit colour entries
.BPM			EQU	$10		; bit-plane mode
.V400		EQU	$08		; enable 400 vertical pixels
.H1280		EQU	$04		; enable 1280 horizontal pixels (not implemented)
.MONO		EQU	$02		; enable VIC-III MONO composite video output (colour if disabled)
.INT			EQU	$01		; enable VIC-III interlaced mode
	
R_B0AD		EQU	$D033
.B0ADODD		EQU	$E0		; bitplane X address, odd lines
.B0ADEVEN		EQU	$0E		; bitplane X address, even lines

R_B1AD		EQU	$D034
.B1ADODD		EQU	$E0		; bitplane X address, odd lines
.B1ADEVEN		EQU	$0E		; bitplane X address, even lines

R_B2AD		EQU	$D035
.B2ADODD		EQU	$E0		; bitplane X address, odd lines
.B2ADEVEN		EQU	$0E		; bitplane X address, even lines

R_B3AD		EQU	$D036
.B3ADODD		EQU	$E0		; bitplane X address, odd lines
.B3ADEVEN		EQU	$0E		; bitplane X address, even lines

R_B4AD		EQU	$D037
.B4ADODD		EQU	$E0		; bitplane X address, odd lines
.B4ADEVEN		EQU	$0E		; bitplane X address, even lines

R_B5AD		EQU	$D038
.B5ADODD		EQU	$E0		; bitplane X address, odd lines
.B5ADEVEN		EQU	$0E		; bitplane X address, even lines

R_B6AD		EQU	$D039
.B6ADODD		EQU	$E0		; bitplane X address, odd lines
.B6ADEVEN		EQU	$0E		; bitplane X address, even lines

R_B7AD		EQU	$D03A
.B7ADODD		EQU	$E0		; bitplane X address, odd lines
.B7ADEVEN		EQU	$0E		; bitplane X address, even lines

R_BPCOMP		EQU	$D03B	; complement bitplane flags

R_BPX		EQU	$D03C	; bitplane X

R_BPY		EQU	$D03D	; bitplane Y

R_HPOS		EQU	$D03E	; bitplane X offset

R_VPOS		EQU	$D03F	; bitplane Y offset

R_B0PIX		EQU	$D040	; display address translater (DAT) bitplane 0 port
R_B1PIX		EQU	$D041	; display address translater (DAT) bitplane 1 port
R_B2PIX		EQU	$D042	; display address translater (DAT) bitplane 2 port
R_B3PIX		EQU	$D043	; display address translater (DAT) bitplane 3 port
R_B4PIX		EQU	$D044	; display address translater (DAT) bitplane 4 port
R_B5PIX		EQU	$D045	; display address translater (DAT) bitplane 5 port
R_B6PIX		EQU	$D046	; display address translater (DAT) bitplane 6 port
R_B7PIX		EQU	$D047	; display address translater (DAT) bitplane 7 port

R_TBDRPOSL	EQU	$D048	; top border position
R_TBDRPOSH	EQU	$D049	; top border position
.SPRBPMEN		EQU	$F0
.TBDRPOSH		EQU	$0F

R_BBDRPOSL	EQU	$D04A	; bottom border position
R_BBDRPOSH	EQU	$D04B	; bottom border position
.SPRBPMEN		EQU	$F0
.BBDRPOSH		EQU	$0F

R_TEXTXPOSL	EQU	$D04C	; character generator horizontal position
R_TEXTXPOSH	EQU	$D04D	; character generator horizontal position
.SPRTILEN		EQU	$F0
.TEXTXPOSH	EQU	$0F

R_TEXTYPOSL	EQU	$D04E	; character generator vertical position
R_TEXTYPOSH	EQU	$D04F	; character generator vertical position
.SPRTILEN		EQU	$F0
.TEXTYPOSH	EQU	$0F

R_XPOSL		EQU	$D050	; read horizontal raster scan position LSB
R_XPOSH		EQU	$D051	; read horizontal raster scan position MSB
.NORRDEL		EQU	$80		; When clear, raster rewrite double buffering is used
.DBLRR		EQU	$40		; When set, the Raster Rewrite Buffer is only
						; updated every 2nd raster line, limiting
						; resolution to V200, but allowing more cycles for
						; Raster-Rewrite actions.
.XPOSH		EQU	$3F

R_FNRASTERL	EQU	$D052	; Read physical raster position LSB
R_FNRASTERH	EQU	$D053	; Read physical raster position MSB
.FNRST		EQU	$80		; Read raster compare source (0=VIC-IV fine raster,
						; 1=VIC-II raster), provides same value as set in
						; FNRSTCMP
.SHDEMU		EQU	$40		; Enable simulated shadow-mask (PALEMU must also be enabled)
.UPSCALE		EQU	$20		; Enable integrated low-latency (130usec) 720p upscaler
.FNRASTERH	EQU	$07

R_MISC		EQU	$D054
.ALPHEN		EQU	$80		; Alpha compositor enable
.VFAST		EQU	$40		; C65GS FAST mode (48MHz)
.PALEMU		EQU	$20		; Enable PAL CRT-like scan-line emulation
.SPRH640		EQU	$10		; Sprite H640 enable
.SMTH		EQU	$08		; video output horizontal smoothing enable
.FCLRHI		EQU	$04		; enable full-colour mode for character numbers > $FF
.FCLRLO		EQU	$02		; enable full-colour mode for character numbers <= $FF
.CHR16		EQU	$01		; enable 16-bit character numbers (two screen bytes per character)

R_SPRHGHTEN	EQU	$D055	; sprite extended height enable (one bit per sprite)
R_SPRHGHT		EQU	$D056	; sprite extended height size (sprite pixels high)
R_SPRX64EN	EQU	$D057	; Sprite extended width enables (8 bytes per sprite row = 64 pixels
						; wide for normal sprites or 16 pixels wide for 16-colour sprite mode

R_LINESTEPL	EQU	$D058	; number of bytes to advance between each text row (LSB)
R_LINESTEPH	EQU	$D059	; number of bytes to advance between each text row (MSB)

R_CHRXSCL		EQU	$D05A	; Horizontal hardware scale of text mode (pixel 120ths per pixel)
R_CHRYSCL		EQU	$D05B	; Vertical scaling of text mode (number of physical rasters per char text row)

R_SDBDRWDL	EQU	$D05C	; Width of single side border
R_SDBDRWDH	EQU	$D05D
.HOTREG		EQU	$80		; Enable VIC-II hot registers. When enabled, touching many VIC-II registers
						; causes the VIC-IV to recalculate display parameters, such as border positions
						; and sizes. Touching registers while this is disabled will trigger a change
						; when reenabling. Setting this to 0 will clear the recalc flag, canceling the
						; recalculation.
.RSTDELEN		EQU	$40		; Enable raster delay (delays raster counter and interrupts by one line
						; to match output pipeline latency)
.SDBDRWD		EQU	$3F		; Width of single side border

R_CHRCOUNT	EQU	$D05E	; Number of characters to display per row (LSB)

R_SPRXSMSBS	EQU	$D05F	; Sprite H640 X Super-MSBs

R_SCRNPTRLSB	EQU	$D060	; screen RAM precise base address (bits 0 - 7)	
R_SCRNPTRMSB	EQU	$D061	; screen RAM precise base address (bits 15 - 8)
R_SCRNPTRBNK	EQU	$D062	; screen RAM precise base address (bits 23 - 16)
R_SCRNPTRMB	EQU	$D063
.EXGLYPH		EQU	$80		; source full-colour character data from expansion RAM
.FCOLMCM		EQU	$40		; enable 256 colours in multicolour text mode
.CHRCOUNT		EQU	$30		; number of characters to display per row (MSB)
.SCRNPTRMB	EQU	$0F		; screen RAM precise base address (bits 27 - 24)

R_COLPTRLSB	EQU	$D064	; colour RAM base address (bits 0 - 7)
R_COLPTRMSB	EQU	$D065	; colour RAM base address (bits 15 - 8)

R_CHARPTRLSB	EQU	$D068	; character set precise base address (bits 0 - 7)
R_CHARPTRMSB	EQU	$D069	; character set precise base address (bits 15 - 8)
R_CHARPTRBNK	EQU	$D06A	; character set precise base address (bits 23 - 16)

R_SPR16EN		EQU	$D06B	; sprite 16-colour mode enables

R_SPRPTRADRLSB	EQU	$D06C	; sprite pointer address (bits 7 - 0)
R_SPRPTRADRMSB	EQU	$D06D	; sprite pointer address (bits 15 - 8)
R_SPRPTRBNK	EQU	$D06E
.SPRPTR16		EQU	$80		; 16-bit sprite pointer mode (allows sprites to be located on any 64
						; byte boundary in chip RAM)
.SPRPTRBNK	EQU	$7F		; sprite pointer address (bits 22 - 16)

R_RASLINE0	EQU	$D06F
.PALNTSC		EQU	$80		; NTSC emulation mode (1) (max raster = 262)
.VGAHDTV		EQU	$40		; set for "more compatible" VGA
.RASLINE0		EQU	$3F		; first VIC-II raster line

R_PALSEL		EQU	$D070
.MAPEDPAL		EQU	$C0		; palette bank mapped at $D100-$D3FF
.BTPALSEL		EQU	$30		; bitmap/text palette bank
.SPRPALSEL	EQU	$0C		; sprite palette bank
.ABTPALSEL	EQU	$03		; VIC-IV bitmap/text palette bank (alternate palette)

R_BP16ENS		EQU	$D071	; VIC-IV 16-colour bitplane enable flags

R_SPRYADJ		EQU	$D072	; Sprite Y position adjustment

R_RASTERHEIGHT	EQU	$D073
.RASTERHEIGHT	EQU	$F0		; physical rasters per VIC-II raster (1 to 16)
.ALPHADELAY	EQU	$0F		; Alpha delay for compositor

R_SPRENALPHA	EQU	$D074	; Sprite alpha-blend enable

R_SPRALPHAVAL	EQU	$D075	; Sprite alpha-blend value

R_SPRENV400	EQU	$D076	; Sprite V400 enables

R_SPRYMSBS	EQU	$D077	; Sprite V400 Y position MSBs
R_SPRYSMSBS	EQU	$D078	; Sprite V400 Y position super MSBs

R_RASCMP		EQU	$D079	; Physical raster compare value to be used if FNRSTCMP is clear
R_RSCMPMSB	EQU	$D07A
.FNRSTCMP		EQU	$80		; Raster compare is in physical rasters if clear, or VIC-II rasters if set
.EXTIRQS		EQU	$40		; Enable additional IRQ sources, e.g., raster X position
.NOBUGCOMPAT	EQU	$20		; Disables VIC-III / C65 Bug Compatibility Mode if set
.CHARY16		EQU	$10		; Alternate char ROM bank on alternate raster lines in V200
.SPTR_CONT	EQU	$08		; Continuously monitor sprite pointer, to allow changing sprite data
						; source while a sprite is being drawn
.RASCMPMSB	EQU	$07		; Raster compare value MSB

R_DISPROWS	EQU	$D07B	; Number of text rows to display

R_MISC2		EQU	$D07C
.DEBUGC		EQU	$C0		; VIC-IV debug pixel select red(01), green(10) or blue(11) channel visible in $D07D
.VSYNCP		EQU	$20		; vsync polarity
.HSYNCP		EQU	$10		; hsync polarity
.BITPBANK		EQU	$07		; Set which 128KB bank bitplanes

R_PALRED		EQU	$D100	; red palette values (reversed nybl order)
R_PALGREEN	EQU	$D200	; green palette values (reversed nybl order)
R_PALBLUE		EQU	$D300	; blue palette values (reversed nybl order)
