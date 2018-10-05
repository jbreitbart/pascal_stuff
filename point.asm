
	include	model.h

;
;	VGAKIT Version 3.4
;
;	Copyright 1988,89,90 John Bridges
;	Free for use in commercial, shareware or freeware applications
;
;	POINT.ASM
;
;
.data

	extrn	curbk:word
	EXTRN	XWID:WORD,YWID:WORD
	EXTRN	MINX:WORD,MINY:WORD
	extrn	maxx:word,maxy:word

.code

	extrn	newbank:proc

	public	point,XPOINT
	public	point13x,XPOINT13X

point	proc	FAR xpos:word,ypos:word,color:word
	mov	bx,[xpos]
	mov	ax,[ypos]
	mov	dx,[XWID]
	cmp	bx,[MINX]
	jl	nope1
	cmp	bx,DX		;[XWID]
	jge	nope1
	cmp	ax,[MINY]
	jl	nope1
	cmp	ax,[YWID]
	jge	nope1
	mul	dx			;640 dots wide in most cases
	add	bx,ax
	adc	dx,0
	mov	ax,dx
	cmp	ax,[curbk]
	jz	nonew
	PUSH	AX
	call	newbank			;switch banks if a new bank entered
nonew:	mov	ax,0a000h		;setup screen segment A000
	mov	es,ax
	mov	al,byte ptr [color]	;get color of pixel to plot
	mov	es:[bx],al
nope1:	ret
point	endp

Xpoint	proc	FAR xpos:word,ypos:word,color:word
	mov	bx,[xpos]
	mov	ax,[ypos]
	mov	dx,[XWID]
	cmp	bx,[MINX]
	jl	Xnope1
	cmp	bx,DX		;[MAXX]
	jge	Xnope1
	cmp	ax,[MINY]
	jl	Xnope1
	cmp	ax,[YWID]
	jge	Xnope1
	mul	dx			;640 dots wide in most cases
	add	bx,ax
	adc	dx,0
	mov	ax,dx
	cmp	ax,[curbk]
	jz	Xnonew
	PUSH	AX
	call	newbank			;switch banks if a new bank entered
Xnonew:	mov	ax,0a000h		;setup screen segment A000
	mov	es,ax
	mov	al,byte ptr [color]	;get color of pixel to plot
	XOR	es:[bx],al
Xnope1:	ret
Xpoint	endp

point13x proc	FAR xpos:word,ypos:word,color:word
	mov	bx,[xpos]
	mov	ax,[ypos]
	mov	dx,[XWID]
	cmp	bx,[MINX]
	jl	nope2
	cmp	bx,[MAXX]
	jge	nope2
	cmp	ax,[MINY]
	jl	nope2
	cmp	ax,[maxy]
	jge	nope2
	shr	dx,1
	shr	dx,1
	mul	dx		;360 dots wide (for 360x480 mode)
	mov	cx,bx
	shr	bx,1
	shr	bx,1
	add	bx,ax
	mov	ax,102h	
	and	cl,3
	shl	ah,cl			;create bit plane mask
	mov	dx,3c4h
	out	dx,ax			;set EGA bit plane mask register
	mov	ax,0a000h		;setup screen segment A000
	mov	es,ax
	mov	al,byte ptr [color]	;get color of pixel to plot
	mov	es:[bx],al
nope2:	ret
point13x endp

xpoint13x proc	FAR xpos:word,ypos:word,color:word
	mov	bx,[xpos]
	mov	ax,[ypos]
	mov	dx,[XWID]
	cmp	bx,[MINX]	;0
	jl	nope4
	cmp	bx,[MAXX]	;dx
	jge	nope4
	cmp	ax,[MINY]	;0
	jl	nope4
	cmp	ax,[YWID]	;[maxy]
	jge	nope4
	shr	dx,1
	shr	dx,1
	mul	dx		;360 dots wide (for 360x480 mode)
	mov	cx,bx
	shr	bx,1
	shr	bx,1
	add	bx,ax
	mov	ax,102h	
	and	cl,3
	shl	ah,cl			;create bit plane mask
	mov	dx,3c4h
	out	dx,ax			;set EGA bit plane mask register
	mov	dl,0ceh
	mov	al,4
	mov	ah,cl
	out	dx,ax			;set EGA bit plane read regsiter
	mov	ax,0a000h		;setup screen segment A000
	mov	es,ax
	mov	al,byte ptr [color]	;get color of pixel to plot
	xor	es:[bx],al
nope4:	ret
xpoint13x endp

	end

