uses crt,alles;

type TCheat = record
               Titel : String[76];
               Text  : array [1..18] of String[76];
              end;

const anzahl = 2;

var pos          : Word;
    y            : Byte;
    taste        : Char;
    Anzeige      : array [1..18] of string[76];
    Alle         : Array [1..Anzahl] of TCheat;

procedure hintergrund;
var x,y,lv1 : Laufvar;

begin
 textcolor(white);
 textbackground(darkgray);
 for x:= 1 to 80 DO
 FOR y:= 2 to 24 DO begin
  gotoxy(x,y);
  write('ฐ');
 end;
 textcolor(lightgray);
 for y:=4 to 22 DO begin
  gotoxy(80,y);
  write('ฐ');
 end;
 for x:=4 to 80 DO begin
  gotoxy(x,23);
  write('ฐ');
 end;
 textcolor(2);
 for x:=1 to 80 DO begin
  gotoxy(x,1);
  writeln('Û');
 end;
 textcolor(11);
 gotoxy(29,1);
 textbackground(2);
 writeln('Jensman''s Helper !');
 textbackground(blue);
 textcolor(lightblue);
 gotoxy(2,3);
 writeln('ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
 lv1:=1;
 for y:=4 to 21 DO begin
  gotoxy(2,y);
  write('บ');
  textbackground(1);
  gotoxy(3,y);
  write(alle[lv1].titel);
  textbackground(blue);
  write('บ');
  lv1:=lv1+1;
 end;
 gotoxy(2,22);
 writeln('ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
end;

procedure cheatanzeigen;
var y1 : Byte;
begin
 textbackground(blue);
 textcolor(9);
 for y1:= 4 to 21 DO begin
  gotoxy(3,y1);
  write('                                                                            ');
  gotoxy(3,y1);
  write(alle[pos].text[y1-3]);
 end;
 waitkey;
 hintergrund;
 textbackground(white);
 gotoxy(3,y);
 writeln(alle[pos].titel);
end;

procedure titel(n : Word;s : String);
begin
 alle[n].titel:=s+('                                                                            ');
end;

procedure text(n : Word;Reihe : Byte; s : String);
begin
 alle[n].Text[Reihe]:=s+('                                                                            ');
end;
begin
 text(1,1,'1');
 text(1,2,'2');
 text(1,3,'3');
 text(1,4,'4');
 text(1,5,'5');
 text(1,6,'6');
 text(1,7,'7');
 text(1,8,'8');
 text(1,9,'9');
 text(1,10,'10');
 text(1,11,'11');
 text(1,12,'12');
 text(1,13,'13');
 text(1,14,'14');
 text(1,15,'15');
 text(1,16,'16');
 text(1,17,'17');
 text(1,18,'18');
 titel(1,'Jensman');
 titel(2,'Test');
 titel(3,'');
 titel(4,'');
 titel(5,'');
 titel(6,'');
 titel(7,'');
 titel(8,'');
 titel(9,'');
 titel(10,'');
 titel(11,'');
 titel(12,'');
 titel(13,'');
 titel(14,'');
 titel(15,'');
 titel(16,'');
 titel(17,'');
 titel(18,'');
 highvideo;
 ClrScr;
 hintergrund;
 setcursor(nocursor);
 pos:=1;
 y:=4;
 textbackground(white);
 gotoxy(3,y);
 writeln(alle[1].titel);
 repeat
  if keypressed then begin
   taste:=readkey;
   if taste = Return then begin
    cheatanzeigen;
   end;
   if taste = Funktiontaste then begin
    taste:=readkey;
    if (taste = Hoch) and (pos>1) then begin
     textbackground(blue);
     gotoxy(3,y);
     writeln(alle[pos].titel);
     pos:=pos-1;
     if y<> 4 then y:=y-1;
     textbackground(white);
     gotoxy(3,y);
     writeln(alle[pos].titel);
    end;
    if (taste = Runter) and (pos<Anzahl) then begin
     textbackground(blue);
     gotoxy(3,y);
     writeln(alle[pos].titel);
     pos:=pos+1;
     if y<> 21 then y:=y+1;
     textbackground(white);
     gotoxy(3,y);
     writeln(alle[pos].titel);
    end;
   end;
  end;
 until taste=Escape;
end.

76