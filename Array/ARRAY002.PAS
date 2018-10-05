program Liste001;

uses crt,graph,alles;

var z :    BYTE;
    Name : ARRAY[1..5] OF STRING;
    taste: char;
    grdriver,grmode : Integer;

Procedure Menu(var c:char);
begin
 cleardevice;
 SetTextJustify(CenterText,CenterText);
 OutTextXY(Succ(GetMaxX) div 2,10,'SuperListe 2000');
 OutTextXY(Succ(GetMaxX) div 2,50,'1. Liste eingeben');
 OutTextXY(Succ(GetMaxX) div 2,70,'2. Liste zeigen  ');
 OutTextXY(Succ(GetMaxX) div 2,90,'3. Verbessern    ');
 OutTextXY(Succ(GetMaxX) div 2,470,'Q. Ende          ');
 c:=readkey;
end;

procedure eingeben;
var x,y : Integer;
    zs : String;
begin
 x:=20;
 y:=20;
 cleardevice;
 setcolor(white);
 for z := 1 to 5 do
     begin
       outtextxy(x,y,'Bitte geben Sie den ');
       str (z,zs);
       outtextxy(x+170,y,zs);
       outtextxy(x+180,y,'. Namen ein : ');
       Name[z]:=readtext(x+290,y);
       y:=y+20;
     end;
end;

procedure zeigen;
begin
 clrscr;
 for z := 1 to 5 do writeln ('Der ', z, '. Name ist: ', Name[z]);
end;

procedure verbessern;
begin
 clrscr;
 zeigen;
 write('Welchen Namen wollen sie „ndern ? ');
 readln(z);
 write('Bitte den neuen Namen ',z,' eingeben ');
 readln(Name[z]);
end;

begin
 for z := 1 to 5 DO name[z]:='Unbekannt';
 grdriver:=Detect;
 initgraph(grdriver,grmode,' ');
 repeat
  menu(taste);
  case taste of
   '1' : eingeben;
   '2' : begin
          zeigen;
          readln;
         end;
   '3' : Verbessern;
  end;
 until (taste = 'q') or (taste='Q');
 closegraph;
 clrscr;
 for z := 1 to 5 do writeln ('Der ', z, '. Name ist: ', Name[z]);
 readln;
end.