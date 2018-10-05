uses crt,alles;

type Tvoc=string[40];

var fdeu,feng : File of TVoc;
    taste : Char;
    MaxEintrag : LONGINT;

procedure maxeintrage;
var a : TVoc;
begin
 maxeintrag:=0;
 repeat
  read(fdeu,a);
  maxeintrag:=maxeintrag+1;
 until eof(fdeu);
end;

procedure alarm;
var lauf,b : Laufvar;
begin
 lauf:=0;
 repeat
 for b:= 1 to 300 do
                  begin
                   sound(b);
                   delay (30);
                  end;
 nosound;
 lauf:=lauf+1;
 until lauf=8;
end;

procedure DeutschEnglisch;

var Deu, Eng : TVoc;
    welche : LONGINT;
    Antwort : String[40];

begin
 clrscr;
 repeat
  Antwort:='';
  welche:=Zufall(0,MaxEintrag);
  seek(fdeu,welche);
  seek(feng,welche);
  read(fdeu,deu);
  read(feng,eng);
  write(Deu, ' - ');
  readln(antwort);
  if antwort=eng then writeln('Richtig !');
  if (antwort<>eng) and (Antwort<>'') then begin
   writeln('Falsch ! Die richtige Antwort wÑre gewesen : ',eng,'.');
   alarm;
  end;
 until (Antwort='');
 seek(fdeu,0);
 seek(feng,0);
end;

procedure EnglischDeutsch;

var Deu, Eng : TVoc;
    welche : LONGINT;
    Antwort : String[40];

begin
 clrscr;
 repeat
  Antwort:='';
  welche:=Zufall(0,MaxEintrag);
  seek(fdeu,welche);
  seek(feng,welche);
  read(fdeu,deu);
  read(feng,eng);
  write(Eng, ' - ');
  readln(antwort);
  if antwort=Deu then writeln('Richtig !');
  if (antwort<>Deu) and (Antwort<>'') then begin
   writeln('Falsch ! Die richtige Antwort wÑre gewesen : ',Deu,'.');
   alarm;
  end;
 until (Antwort='');
 seek(fdeu,0);
 seek(feng,0);
end;

procedure neuworter;
var deu,eng : TVOC;

begin
 clrscr;
 seek(fdeu,maxeintrag);
 seek(feng,maxeintrag);
 repeat
  write('Deutsch : ');
  readln(Deu);
  write('English : ');
  readln(eng);
  if (deu <>'') and (eng <>'') then begin
   write(fdeu,deu);
   write(feng,eng);
  end;
 until (deu='') or (eng='');
 close(fdeu);
 close(feng);
 reset(fdeu);
 reset(feng);
 seek(fdeu,0);
 seek(feng,0);
 maxeintrage;
end;

begin
 assign(fdeu,'Deutsch.dat');
 assign(feng,'Englisch.dat');
 reset(fdeu);
 reset(feng);
 maxeintrage;
 repeat
  clrscr;
  gotoxy(25,1);
  write('1. FÅr Deutsch - Englisch');
  gotoxy(25,2);
  write('2. FÅr Englisch - Deutsch');
  gotoxy(26,3);
  write('3. Neue Wîrter eingeben');
  gotoxy(35,24);
  write('ESC = ENDE');
  taste:=readkey;
  taste:=upcase(taste);
  if taste='1' then DeutschEnglisch;
  if taste='2' then EnglischDeutsch;
  if taste='3' then neuworter;
 until Esc;
 close(fdeu);
 close(feng);
end.