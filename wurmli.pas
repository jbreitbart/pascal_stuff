{$A-,B-,D+,E+,F-,G+,I+,L+,N-,O-,R-,S+,V+,X-}
{$M 16384,0,655360}
program wurmli;
uses crt,graph,alles;

Var grd,grm :integer;
    spielerx,spielery,spielerxold,spieleryold:Integer;
    taste : char;
    Voll : array [0..2666] of boolean;
    weg  : array [0..2666] of word;
    wegzaehler,aktuellerpunkt : word;

Procedure Spielfeld;
Begin
 setfillstyle(1,9);
 bar(0,0,10,getmaxy-40);
 bar(0,0,getmaxx,10); {300 runder 620 rÅber}
 bar(getmaxx-10,10,getmaxx,getmaxy-40);
 bar(0,getmaxy-40,getmaxx,getmaxy-30);
end;

Procedure Spieler;
begin
 setfillstyle(1,5);
 bar(spielerx,spielery,spielerx+10,spielery+10);
end;

function aktuell:Word;
var x,y,zaehler:word;
begin
 y:=10;
 zaehler:=1;
 repeat
  x:=10;
  repeat
   if (spielerx=x) and (spielery=y) then aktuell:=zaehler;
   x:=x+10;
   zaehler:=zaehler+1;
  until x>=620;
  y:=y+10;
 until y>=getmaxy-30;
end;

procedure Spur;
begin
 wegzaehler:=wegzaehler+1;
 weg[wegzaehler]:=aktuell;
 setfillstyle(1,13);
 bar(spielerx,spielery,spielerx+10,spielery+10);
end;

procedure spielerweg;
 
begin
 setfillstyle(1,9);
 bar(spielerx,spielery,spielerx+10,spielery+10);
 for grd := 1 to 2666 DO weg[grd]:=0;
 wegzaehler:=0;
end;

procedure vollen;
var lv1,zwischenvar : Word;
begin
 if weg[1]=0 then exit;
 lv1:=1;
 zwischenvar:=0;
 repeat
  zwischenvar:=weg[lv1];
  voll[zwischenvar]:=true;
  lv1:=lv1+1;
 until weg[lv1]=0;
end;

procedure abgeschlossen;

procedure fullen;
var lv1,nummery : Laufvar;
    x,y,min,max,xwert,werty,schonwasda : word;
begin
 lv1:=1;
 repeat
  if voll[lv1]=true then begin
   x:=0;
   min:=1;
   max:=61;
   xwert:=10;
   repeat
    if (lv1>=min) and (lv1<=max) then x:=xwert
    else begin
     xwert:=xwert+10;
     min:=min+61;
     max:=max+61;
    end;
   until x<>0;
   nummery:=1;
   y:=0;
   werty:=10;
   repeat
    if (lv1=nummery) then y:=werty;
    if (nummery/61)=ROUND(nummery/61) then werty:=10
    else werty:=werty+10;
    nummery:=nummery+1;
   until y<>0;
   setfillstyle(1,2);
   schonwasda:=getpixel(y+1,x+1);
   if schonwasda<>2 then bar(y,x,y+10,x+10);
  end;
  lv1:=lv1+1;
 until lv1=2661+62;








end;

begin
 if spielerxold=0 then exit;
 if spieleryold=0 then exit;
 if spielerxold=630 then exit;
 if spieleryold=getmaxy-40 then exit;
 fullen;
end;

Begin
 checkbreak:=false;
 taste:='a';
 FOR grd := 1 to 2666 DO voll[grd]:=false;
 for grd := 1 to 2666 DO weg[grd]:=0;
 aktuellerpunkt:=0;
 wegzaehler:=0;
 grd:=detect;
 grm:=1;
 initgraph (grd,grm,'');
 spielerxold:=0;
 spieleryold:=0;
 spielerx:=10;
 spielery:=0;
 spielfeld;
 spieler;
 repeat
  if keypressed then taste:=readkey;
  if taste=funktiontaste then taste:=readkey;
  if (taste=rechts) or (taste=links) or (taste=hoch) or (taste=runter) then begin
   if (spielerx<>0) and (spielerx<>630) and (spielery<>0) and (spielery<>getmaxy-40) then spur;
   if (spielerx=0) or (spielerx=630) or (spielery=0) or (spielery=getmaxy-40) then spielerweg;
   if taste = rechts then spielerx :=spielerx+10;
   if taste = links  then spielerx :=spielerx-10;
   if taste = hoch   then spielery:=spielery-10;
   if taste = runter then spielery:=spielery+10;
   if spielerx>=630 then spielerx:=630;
   if spielerx<=0  then spielerx:=0;
   if spielery>=getmaxy-40 then spielery:=getmaxy-40;
   if spielery<=0  then spielery:=0;
   if (spielerx=0) or (spielerx=630) or (spielery=0) or (spielery=getmaxy-40) then vollen;
   if (spielerx=0) then abgeschlossen;
   if (spielerx=630) then abgeschlossen;
   if (spielery=0) then abgeschlossen;
   if (spielery=getmaxy-40) {and (spielerxold<>getmaxy-40)} then abgeschlossen;
   spielfeld;
   spieler;
   delay(5);
   taste:='a';
   spielerxold:=spielerx;
   spieleryold:=spielery;
  end;
 until taste=escape;
 closegraph;
 for grd := 1 to 2000 DO begin
                          writeln(weg[grd]);
                          if weg[grd]=0 then readln;
                         end;
end.

felder runter = 43
felder rÅber  = 62