program fliegen;

uses crt,alles;

const anz = 100;
      VGA=$A000;

var x,y,z,bildx,bildy,xalt,yalt: array [1..anz] of Integer;
    color : array [1..anz] of byte;
    min,max : word;
    lv1,zaehler,farbe : Laufvar;

procedure putpixel(x,y: Word;farbe:Byte);
var s : LONGINT;
begin
 if (x<319) and (y<199) then begin
  s:=(y*320)+x;
  mem[VGA:s]:=farbe;
 end;
end;

begin
 {$R-}
 ASM; {Grafikmodus wird aktiviert}
  MOV AX,19;
  INT 16;
 End;
 for lv1 := 1 to anz DO begin
  x[lv1]:=Zufall(1,319);
  y[lv1]:=Zufall(1,199);
  z[lv1]:=Zufall(20,512);
 end;
 For lv1 := 1 to anz DO begin
  zaehler:=0;
  max:=512;
  min:=max-39;
  farbe:=18;
  repeat
   if (z[lv1]<=max) and (z[lv1]>=min) then color[lv1]:=farbe;
   max:=max-39;
   min:=max-39;
   zaehler:=zaehler+1;
   farbe:=farbe+1;
  until farbe=32;
 end;
 repeat
  for lv1:= 1 to anz DO begin
   bildx[lv1]:=((x[lv1] shl 8) div z[lv1])+159;
   bildy[lv1]:=((y[lv1] shl 8) div z[lv1])+99;
  end;
  for lv1:= 1 to anz DO begin
   putpixel(bildx[lv1],bildy[lv1],color[lv1]);
  end;
  for lv1:= 1 to anz DO begin
   xalt[lv1]:=bildx[lv1];
   yalt[lv1]:=bildy[lv1];
  end;
  delay(50);
  for lv1:= 1 to anz DO begin
   if z[lv1]<=50 then begin
    x[lv1]:=Zufall(1,319);
    y[lv1]:=Zufall(1,199);
    z[lv1]:=512;
   end;
   dec(Z[lv1],2);
   zaehler:=0;
   max:=512;
   min:=max-39;
   farbe:=18;
   repeat
    if (z[lv1]<=max) and (z[lv1]>=min) then color[lv1]:=farbe;
    max:=max-39;
    min:=max-39;
    zaehler:=zaehler+1;
    farbe:=farbe+1;
   until farbe=32;
  end;
  for lv1 := 1 to anz DO begin
   if (xalt[lv1]<319) and (yalt[lv1]<199) then begin
    mem[VGA:(yalt[lv1]*320)+xalt[lv1]]:=0;
   end;
  end;
 until port[$60] = 1;
 {$R+}
end.