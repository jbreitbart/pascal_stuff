{$G+}
program Ant;

uses crt,graph;

var x,y,warte : Word;
    dx,dy : Shortint;
    t : Integer;
    Regel : String;
    dir, len : Byte;

function draw(x,y : word) : Byte; assembler;
asm mov ax, 0a00h
 mov es, ax
 mov bx, y; mov ax, bx; shl bx,6
 add bh, al
 add bx, x
 mov al, es:[bx]
 cmp al, len
 je @1; inc al
 jmp @2
 @1: xor al, al
 @2: mov es:[bx], al
end;

procedure init;

begin
 x:=160;
 y:=100;
 dir:=2;
 asm xor ax, ax
 int 16h
 mov ax, 13h; int 10h
 end
end;

begin
 regel:='RR';
 warte:=2;
 x:=paramcount;
 while x > 0 DO begin
  val (paramstr(x), y, t);
  {t>0, neue Regelkette angegeben}
  if t = 0 then warte:=y else regel:=paramstr(x);
  dec(x);
 end;
 len:=byte(Regel[0]) -1;
 init;
 repeat delay(warte);
 if regel[1+draw(x,y)]='L' then begin if dir>0 then dec(dir)
 else dir:=3; end else begin if dir < 3 then inc(dir) else dir:=0 end;
 case dir of
  0: begin dx:=0; dy:=-1 end;
  1: begin dx:=1; dy:=0 end;
  2: begin dx:=0; dy:=1 end;
  3: begin dx:=-1; dy:=0 end;
 end;
 if (t>=0) and (t<=320) then y:=t else init
 until port[$60] = 1; {Bis Esc}
 readln;
 asm mov ax, 3; int 10h end
end.