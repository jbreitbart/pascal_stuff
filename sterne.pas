Program Sterne;
Uses crt,graph, alles;
Var grm,grd,a:integer;
    y,x :array [0..100] of word;
    lv1:Laufvar;
    rot,geschwindig : array[0..100] of byte;
    farbe : byte;
Begin
 Grd:=detect;
 initgraph (grd,grm,'');
 a:=0;
 for lv1:= 0 to 60 DO Putpixel(RANDOM(640),RANDOM(480),white);
 for lv1:= 0 to 100 DO y[lv1]:=RANDOM(480);
 for lv1:= 0 to 100 DO x[lv1]:=RANDOM(640);
 for lv1:= 0 to 100 DO rot[lv1]:=RANDOM(4);
 for lv1:= 0 to 100 DO geschwindig[lv1]:=zufall(1,4);
 repeat
  for lv1:= 0 to 100 DO begin
   if rot [lv1]=1 then putpixel (x[lv1],y[lv1],lightred)
   else putpixel (x[lv1],y[lv1],white);
  end;
  delay(50);
  for lv1:= 0 to 100 DO putpixel(x[lv1],y[lv1],black);
  for lv1:= 0 to 100 DO x[lv1]:=x[lv1]+geschwindig[lv1];
  for lv1:=0 to 100 DO begin
   if x[lv1]>=640 then begin
    y[lv1]:=RANDOM(480);
    x[lv1]:=0;
    rot[lv1]:=RANDOM(3);
    geschwindig[lv1]:=zufall(1,4);
   end;
  end;
 until keypressed;
end.
