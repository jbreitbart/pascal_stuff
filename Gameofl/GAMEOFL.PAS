{$A-,B-,D+,E+,F-,G+,I+,L+,N+,O-,R-,S+,V+,X-}
{$M 16384,0,655360}
uses crt,alles;

type TLebensraum = (Bewohnt,nbewohnt);

var Lebensraum : Array [1..19,1..11] of TLebensraum;
    Alter,MaxAlter : Array [1..19,1..11] of 0..40;
    reihe,spalte : 1..19;
    nachbar : 0..8;

procedure zeichnen;
var lv1,x,y,reihe,spalte : Laufvar;
begin
 CLRSCR;
 writeln(' ษอออหอออหอออหอออหอออหอออหอออหอออหอออหอออหอออหอออหอออหอออหอออหอออหอออหอออหอออป');
 for lv1 := 1 to 10 DO begin
  writeln(' บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ');
  writeln(' ฬอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออฮอออน');
 end;
 writeln(' บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ   บ');
 writeln(' ศอออสอออสอออสอออสอออสอออสอออสอออสอออสอออสอออสอออสอออสอออสอออสอออสอออสอออสอออผ');
end;

procedure lebenzeichnen;
var x,y,reihe,spalte : Laufvar;
begin
 setcursor(nocursor);
 reihe:=1;
 spalte:=1;
 x:=4;
 y:=2;
 repeat
  if lebensraum[spalte,reihe]=bewohnt then begin
   gotoxy(x,y);
   write('X');
  end;
  if lebensraum[spalte,reihe]=nbewohnt then begin
   gotoxy(x,y);
   write(' ');
  end;
  spalte:=spalte+1;
  x:=x+4;
  if spalte=20 then begin
   spalte:=1;
   x:=4;
   reihe:=reihe+1;
   y:=y+2;
  end;
 until reihe=12;
{ setcursor(inscursor);}
end;

procedure anfang;
var reihe,spalte : Laufvar;
begin
 RANDOMIZE;
 for reihe:=1 to 11 DO
 for spalte:=1 to 19 DO lebensraum[spalte,reihe]:=nbewohnt;
 for reihe:=1 to 11 DO
 for spalte:=1 to 19 DO alter[spalte,reihe]:=0;
 for reihe:=1 to 11 DO
 for spalte:=1 to 19 DO alter[spalte,reihe]:=13;
 lebensraum[1,1]:=bewohnt;
 lebensraum[1,2]:=bewohnt;
 lebensraum[2,1]:=bewohnt;
 lebensraum[2,2]:=bewohnt;
 lebensraum[15,8]:=bewohnt;
 lebensraum[5,8]:=bewohnt;
 lebensraum[3,2]:=bewohnt;
 lebensraum[9,7]:=bewohnt;
 lebensraum[4,3]:=bewohnt;
 lebensraum[10,9]:=bewohnt;
 lebensraum[11,11]:=bewohnt;
 lebensraum[11,10]:=bewohnt;
 lebensraum[11,9]:=bewohnt;
 lebensraum[13,8]:=bewohnt;
 lebensraum[9,7]:=bewohnt;
 lebensraum[5,9]:=bewohnt;
 lebensraum[16,5]:=bewohnt;
 lebensraum[18,7]:=bewohnt;
 lebensraum[16,9]:=bewohnt;
 lebensraum[19,3]:=bewohnt;
 lebensraum[18,1]:=bewohnt;
end;

begin
 zeichnen;
 anfang;
 repeat
  lebenzeichnen;
  gotoxy (40,24);
  for spalte:=1 to 19 DO
  for reihe:=1 to 11 DO begin
   nachbar:=0;
   if (reihe = 1) and (spalte=1) then begin
    if lebensraum[spalte,reihe+1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe+1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe]=bewohnt then nachbar:=nachbar+1;
   end;
   if (reihe=1) and (spalte<>1) and (spalte<>19) then begin
    if lebensraum[spalte,reihe+1] = bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe+1] = bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe+1] = bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe] = bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe] = bewohnt then nachbar:=nachbar+1;
   end;
   if (spalte=1) and (reihe<>1) and (reihe<>11) then begin
    if lebensraum[spalte,reihe+1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe+1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte,reihe-1]=bewohnt then nachbar:=nachbar+1;
   end;
   if (spalte=1) and (reihe=11) then begin
    if lebensraum[spalte+1,reihe]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte,reihe-1]=bewohnt then nachbar:=nachbar+1;
   end;
   if (spalte<>1) and (spalte<>19) and (reihe=11) then begin
    if lebensraum[spalte-1,reihe]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe]=bewohnt then nachbar:=nachbar+1;
   end;
   if (spalte=19) and (reihe=11) then begin
    if lebensraum[spalte-1,reihe]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte,reihe-1]=bewohnt then nachbar:=nachbar+1;
   end;
   if (spalte=19) and (reihe<>1) and (reihe<>11) then begin
    if lebensraum[spalte,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe+1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte,reihe+1]=bewohnt then nachbar:=nachbar+1;
   end;
   if (spalte=19) and (reihe=1) then begin
    if lebensraum[spalte,reihe+1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe+1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe]=bewohnt then nachbar:=nachbar+1;
   end;
   if (reihe<>1) and (reihe<>11) and (spalte<>1) and (spalte<>19) then begin
    if lebensraum[spalte,reihe+1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe+1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte+1,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe-1]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe]=bewohnt then nachbar:=nachbar+1;
    if lebensraum[spalte-1,reihe+1]=bewohnt then nachbar:=nachbar+1;
   end;
   if nachbar=2 then lebensraum[spalte,reihe]:=bewohnt;
   if nachbar>=5 then begin
    lebensraum[spalte,reihe]:=nbewohnt;
    alter[spalte,reihe]:=0;
    maxalter[spalte,reihe]:=zufall(10,40);
   end;
   if nachbar<=1 then begin
    lebensraum[spalte,reihe]:=nbewohnt;
    alter[spalte,reihe]:=0;
    maxalter[spalte,reihe]:=zufall(10,40);
   end;
   if (alter[spalte,reihe]=maxalter[spalte,reihe]) and (lebensraum[spalte,reihe]=bewohnt) then begin
    alter[spalte,reihe]:=0;
    maxalter[spalte,reihe]:=zufall(10,40);
    lebensraum[spalte,reihe]:=nbewohnt;
   end
   else alter[spalte,reihe]:=alter[spalte,reihe]+1;
  end;
  delay(400);
 until keypressed;
end.