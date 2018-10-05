uses dos;

procedure terrain;

begin
 asm
{  mov ax,data}
  mov ds,ax
  mov es,ax
  cld
  in al,21h
  or al,2
  out 21h,al
  xor ah,ah
  int 1ah
  and dh,7fh
{  mov [random_seed],dx}
  mov ax,13h
  int 10h
  xor ax,ax
  int 33h
{  mov si,offset pal_tab}
  mov cx,256*3
  mov dx,3c8h
  xor al,al
  cli  {}
  out dx,al
  inc dx
  rep outsb
  sti
 end;
end;

begin
 terrain;
end.