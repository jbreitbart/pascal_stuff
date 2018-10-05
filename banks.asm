
	include	model.h

;
;	VGAKIT Version 3.4
;
;	Copyright 1988,89,90 John Bridges
;	Free for use in commercial, shareware or freeware applications
;
;	BANKS.ASM
;
.data

OSEG	equ	DS:			;segment override for variable access

bankadr	dw	?
bankseg	dw	?

	EXTRN	curbk:WORD,vga512:WORD,VGATYP:WORD

	EXTRN	cirrus:WORD,video7:WORD,tseng:WORD,tseng4:WORD
	EXTRN	paradise:WORD,chipstech:WORD,trident:WORD,ativga:WORD
	EXTRN	everex:WORD,aheada:WORD,aheadb:WORD,oaktech:WORD

retval	dw	?		;first return value from whichvga()

.code

	public	newbank
	public	whichvga

newbank	proc	FAR	BANK:WORD	;bank number is in AX
	cli
	MOV	AX,[BANK]
	mov	OSEG[curbk],ax
	jmp	dword ptr OSEG[bankadr]

_tseng:				;Tseng
	push	ax
	push	dx
	and	al,7
	mov	ah,al
	shl	al,1
	shl	al,1
	shl	al,1
	or	al,ah
	or	al,01000000b
	mov	dx,3cdh
	out	dx,al
	sti
	pop	dx
	pop	ax
	ret


_tseng4:			;Tseng 4000 series
	push	ax
	push	dx
	mov	ah,al
	mov	dx,3bfh			;Enable access to extended registers
	mov	al,3
	out	dx,al
	mov	dl,0d8h
	mov	al,0a0h
	out	dx,al
	and	ah,15
	mov	al,ah
	shl	al,1
	shl	al,1
	shl	al,1
	shl	al,1
	or	al,ah
	mov	dl,0cdh
	out	dx,al
	sti
	pop	dx
	pop	ax
	ret


_trident:			;Trident
	push	ax
	push	dx
	mov	dx,3ceh		;set page size to 64k
	mov	al,6
	out	dx,al
	inc	dl
	in	al,dx
	dec	dl
	or	al,4
	mov	ah,al
	mov	al,6
	out	dx,ax

	mov	dl,0c4h		;switch to BPS mode
	mov	al,0bh
	out	dx,al
	inc	dl
	in	al,dx
	dec	dl

	mov	ah,byte ptr OSEG[curbk]
	xor	ah,2
	mov	dx,3c4h
	mov	al,0eh
	out	dx,ax
	sti
	pop	dx
	pop	ax
	ret


_video7:			;Video 7
	push	ax
	push	dx
	push	cx
	and	ax,15
	mov	ch,al
	mov	dx,3c4h
	mov	ax,0ea06h
	out	dx,ax
	mov	ah,ch
	and	ah,1
	mov	al,0f9h
	out	dx,ax
	mov	al,ch
	and	al,1100b
	mov	ah,al
	shr	ah,1
	shr	ah,1
	or	ah,al
	mov	al,0f6h
	out	dx,al
	inc	dx
	in	al,dx
	dec	dx
	and	al,not 1111b
	or	ah,al
	mov	al,0f6h
	out	dx,ax
	mov	ah,ch
	mov	cl,4
	shl	ah,cl
	and	ah,100000b
	mov	dl,0cch
	in	al,dx
	mov	dl,0c2h
	and	al,not 100000b
	or	al,ah
	out	dx,al
	sti
	pop	cx
	pop	dx
	pop	ax
	ret


_paradise:			;Paradise
	push	ax
	push	dx
	mov	dx,3ceh
	mov	ax,50fh		;turn off write protect on VGA registers
	out	dx,ax
	mov	ah,byte ptr OSEG[curbk]
	shl	ah,1
	shl	ah,1
	shl	ah,1
	shl	ah,1
	mov	al,9
	out	dx,ax
	sti
	pop	dx
	pop	ax
	ret


_chipstech:			;Chips & Tech
	push	ax
	push	dx
	mov     dx,46e8h	;place chip in setup mode
	mov     ax,1eh
	out     dx,ax
	mov     dx,103h		;enable extended registers
	mov     ax,0080h
	out     dx,ax
	mov     dx,46e8h	;bring chip out of setup mode
	mov     ax,0eh
	out     dx,ax
	mov	ah,byte ptr OSEG[curbk]
	shl	ah,1		;change 64k bank number into 16k bank number
	shl	ah,1
	mov	al,10h
	mov	dx,3d6h
	out	dx,ax
	sti
	pop	dx
	pop	ax
	ret


_ativga:			;ATI VGA Wonder
	push	ax
	push	dx
	mov	ah,al
	mov	dx,1ceh
	mov	al,0b2h
	out	dx,al
	inc	dl
	in	al,dx
	shl	ah,1
	and	al,0e1h
	or	ah,al
	mov	al,0b2h
	dec	dl
	out	dx,ax
	sti
	pop	dx
	pop	ax
	ret


_everex:			;Everex
	push	ax
	push	dx
	push	cx
	mov	cl,al
	mov	dx,3c4h
	mov	al,8
	out	dx,al
	inc	dl
	in	al,dx
	dec	dl
	shl	al,1
	shr	cl,1
	rcr	al,1
	mov	ah,al
	mov	al,8
	out	dx,ax
	mov	dl,0cch
	in	al,dx
	mov	dl,0c2h
	and	al,0dfh
	shr	cl,1
	jc	nob2
	or	al,20h
nob2:	out	dx,al
	sti
	pop	cx
	pop	dx
	pop	ax
	ret


_aheada:			;Ahead Systems Ver A
	push	ax
	push	dx
	push	cx
	mov	ch,al
        mov     dx,3ceh		;Enable extended registers
        mov     ax,200fh
        out     dx,ax
	mov	dl,0cch		;bit 0
	in	al,dx
	mov	dl,0c2h
	and	al,11011111b
	shr	ch,1
	jnc	skpa
	or	al,00100000b
skpa:	out	dx,al
	mov	dl,0cfh		;bits 1,2,3
	mov	al,0
	out	dx,al
	inc	dx
	in	al,dx
	dec	dx
	and	al,11111000b
	or	al,ch
	mov	ah,al
	mov	al,0
	out	dx,ax
	sti
	pop	cx
	pop	dx
	pop	ax
	ret


_aheadb:			;Ahead Systems Ver A
	push	ax
	push	dx
	push	cx
	mov	ch,al
        mov     dx,3ceh		;Enable extended registers
        mov     ax,200fh
        out     dx,ax
	mov	ah,ch
	mov	cl,4
	shl	ah,cl
	or	ah,ch
	mov	al,0dh
	out	dx,ax
	sti
	pop	cx
	pop	dx
	pop	ax
	ret


_oaktech:			;Oak Technology Inc OTI-067
	push	ax
	push	dx
	and	al,15
	mov	ah,al
	shl	al,1
	shl	al,1
	shl	al,1
	shl	al,1
	or	al,ah
	mov	dx,3dfh
	out	dx,al
	sti
	pop	dx
	pop	ax
	ret


_nobank:
	sti
	ret

newbank	endp

bkadr	macro	func,NR
	mov	[func],1
	mov	[bankadr],offset _&func
	mov	[bankseg],seg _&func
	MOV	[VGATYP],NR
	endm

nojmp	macro
	local	lbl
	jmp	lbl
lbl:
	endm


whichvga proc	FAR	uses si
	cmp	CS:[first],0
	jz	gotest
	mov	ax,[retval]
	ret
gotest:	mov	[bankadr],offset _nobank
	mov	[bankseg],seg _nobank
	mov	[curbk],0
	mov	[vga512],0
	MOV	[VGATYP],0
	mov	[cirrus],0
	mov	[video7],0
	mov	[tseng],0
	mov	[tseng4],0
	mov	[paradise],0
	mov	[chipstech],0
	mov	[trident],0
	mov	[ativga],0
	mov	[everex],0
	mov	[aheada],0
	mov	[aheadb],0
	mov	[oaktech],0
	mov	CS:[first],1
	mov	si,1
	mov	ax,0c000h
	mov	es,ax
	cmp	word ptr es:[40h],'13'
	jnz	noati
	bkadr	ativga,1
	cli
	mov	dx,1ceh
	mov	al,0bbh
	out	dx,al
	inc	dl
	in	al,dx
	sti
	and	al,20h
	jz	no512
	mov	[vga512],1
no512:	jmp	fini

noati:	mov	ax,7000h		;Test for Everex
	xor	bx,bx
	cld
	int	10h
	cmp	al,70h
	jnz	noev
	bkadr	everex,2
	and	ch,11000000b
	jz	skp
	mov	[vga512],1
skp:	and	dx,0fff0h
	cmp	dx,6780h
	jz	yeste
	cmp	dx,2360h
	jnz	note
yeste:	bkadr	trident,3
note:	jmp	fini

noev:	mov	dx,3c4h			;Test for Trident
	mov	al,0bh
	out	dx,al
	inc	dl
	in	al,dx
	cmp	al,0fh
	ja	notri
	cmp	al,2
	jb	notri
	bkadr	trident,3
	mov	[vga512],1
	jmp	fini

notri:	mov	ax,6f00h		;Test for Video 7
	xor	bx,bx
	cld
	int	10h
	cmp	bx,'V7'
	jnz	nov7
	bkadr	video7,4
	mov	ax,6f07h
	cld
	int	10h
	and	ah,7fh
	cmp	ah,1
	jbe	skp2
	mov	[vga512],1
skp2:	jmp	fini

nov7:	call	_cirrus			;Test for Cirrus
	cmp	[cirrus],0
	je	noci
	jmp	fini

noci:	mov	dx,3ceh			;Test for Paradise
	mov	al,9			;check Bank switch register
	out	dx,al
	inc	dx
	in	al,dx
	dec	dx
	or	al,al
	jnz	nopd

	mov	ax,50fh			;turn off write protect on VGA registers
	out	dx,ax
	mov	dx,offset _pdrsub
	mov	cx,1
	call	_chkbk
	jc	nopd			;if bank 0 and 1 same not paradise
	bkadr	paradise,5
;	mov	cx,64
;	call	_chkbk
;	jc	skp3			;if bank 0 and 64 same only 256k
	mov	[vga512],1
skp3:	jmp	fini

nopd:	mov	ax,5f00h		;Test for Chips & Tech
	xor	bx,bx
	cld
	int	10h
	cmp	al,5fh
	jnz	noct
	bkadr	chipstech,6
	cmp	bh,1
	jb	skp4
	mov	[vga512],1
skp4:	jmp	fini

noct:	mov	ch,0
	mov	dx,3d4h			;check for Tseng 4000 series
	mov	al,33h
	out	dx,al
	inc	dx
	in	al,dx
	dec	dx
	mov	cl,al
	mov	ax,00a33h
	out	dx,ax
	mov	al,33h
	out	dx,al
	inc	dx
	in	al,dx
	and 	al,0fh
	dec	dx
	cmp	al,00ah
	jnz	skp5
	mov	ax,00533h
	out	dx,ax
	mov	al,33h
	out	dx,al
	inc	dx
	in	al,dx
	dec	dx
	and 	al,0fh
	cmp	al,005h
	jnz	skp5
	mov	al,33h
	mov	ah,cl
	out	dx,ax
	mov	ch,1

	mov	dx,3bfh			;Enable access to extended registers
	mov	al,3
	out	dx,al
	mov	dl,0d8h
	mov	al,0a0h
	out	dx,al

skp5:	mov	dx,3cdh			;Test for Tseng
	in	al,dx			;save bank switch register
	mov	cl,al
	mov	al,0aah			;test register with 0aah
	out	dx,al
	in	al,dx
	cmp	al,0aah
	jnz	nots
	mov	al,055h			;test register with 055h
	out	dx,al
	in	al,dx
	cmp	al,055h
	jnz	nots
	mov	al,cl
	out	dx,al
	bkadr	tseng,7
	mov	[vga512],1

	cmp	ch,0
	jz	oldts
	bkadr	tseng4,8
        MOV     [TSENG],0
oldts:	jmp	fini

nots:
        mov     dx,3ceh		;Test for Above A or B chipsets
        mov     ax,200fh
        out     dx,ax
        inc	dx
	nojmp
        in      al,dx
	cmp	al,21h
	jz	verb
	cmp	al,20h
	jnz	noab
	bkadr	aheada,9
	mov	[vga512],1
	jmp	short fini

verb:	bkadr	aheadb,10
	mov	[vga512],1
	jmp	short fini

noab:	mov	dx,3deh
	in	al,dx
	and	al,11100000b
	cmp	al,01100000b
	jnz	nooak
	bkadr	oaktech,11
	mov	al,0dh
	out	dx,al
	inc	dx
	nojmp
	in	al,dx
	test	al,80h
	jz	no4ram
	mov	[vga512],1
no4ram:	jmp	short fini

nooak:	mov	si,0

fini:	mov	ax,si
	mov	[retval],ax
	ret

first	DB	0		;flag so whichvga() is only called once

whichvga endp


_cirrus	proc	near
	mov	dx,3d4h		; assume 3dx addressing
	mov	al,0ch		; screen a start address hi
	out	dx,al		; select index
	inc	dx		; point to data
	mov	ah,al		; save index in ah
	in	al,dx		; get screen a start address hi
	xchg	ah,al		; swap index and data
	push	ax		; save old value
	push	dx		; save crtc address
	xor	al,al		; clear crc
	out	dx,al		; and out to the crtc

	mov	al,1fh		; Eagle ID register
	dec	dx		; back to index
	out	dx,al		; select index
	inc	dx		; point to data
	in	al,dx		; read the id register
	mov	bh,al		; and save it in bh

	mov	cl,4		; nibble swap rotate count
	mov	dx,3c4h		; sequencer/extensions
	mov	bl,6		; extensions enable register

	ror	bh,cl		; compute extensions disable value
	mov	ax,bx		; extensions disable
	out	dx,ax		; disable extensions
	inc	dx		; point to data
	in	al,dx		; read enable flag
	or	al,al		; disabled ?
	jnz	exit		; nope, not an cirrus

	ror	bh,cl		; compute extensions enable value
	dec	dx		; point to index
	mov	ax,bx		; extensions enable
	out	dx,ax		; enable extensions
	inc	dx		; point to data
	in	al,dx		; read enable flag
	cmp	al,1		; enabled ?
	jne	exit		; nope, not an cirrus
	mov	[cirrus],1
	mov	[bankadr],offset _nobank
	mov	[bankseg],seg _nobank
	MOV	[VGATYP],12
exit:	pop	dx		; restore crtc address
	dec	dx		; point to index
	pop	ax		; recover crc index and data
	out	dx,ax		; restore crc value
	ret
_cirrus	endp

_chkbk	proc	near		;paradise bank switch check
	mov	di,0b800h
	mov	es,di
	xor	di,di
	mov	bx,1234h
	call	_gochk
	jnz	badchk
	mov	bx,4321h
	call	_gochk
	jnz	badchk
	clc
	ret
badchk:	stc
	ret
_chkbk	endp

_gochk	proc	near
	push	si
	mov	si,bx

	mov	al,cl
	call	dx
	xchg	bl,es:[di]
	mov	al,ch
	call	dx
	xchg	bh,es:[di]

	xchg	si,bx

	mov	al,cl
	call	dx
	xor	bl,es:[di]
	mov	al,ch
	call	dx
	xor	bh,es:[di]

	xchg	si,bx

	mov	al,ch
	call	dx
	mov	es:[di],bh
	mov	al,cl
	call	dx
	mov	es:[di],bl

	mov	al,0
	call	dx
	or	si,si
	pop	si
	ret
_gochk	endp


_pdrsub	proc	near		;Paradise
	push	dx
	mov	ah,al
	mov	dx,3ceh
	mov	al,9
	out	dx,ax
	pop	dx
	ret
_pdrsub	endp

	end

