{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Prozeduren: Alter berechnen und Sternchenkurve ausgeben.         º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program AlterBerechnen;                            {Datei: Alter2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Name: string[35];
  Alter: integer;                                    {Alter in Jahren}

procedure Ueberschrift;
begin
  ClrScr;
  writeln('Alter berechnen');
  writeln;
end; {Ueberschrift}

procedure Eingabe;
const
  MinAlter =  0;
  MaxAlter = 99;

begin
  write('Gib Deinen Vor- und Nachnamen ein:             ');
  readln(Name);

  repeat
    write('Wie alt bist Du (',MinAlter);
    write('..',MaxAlter,' Jahre)?                 ');
    readln(Alter);
  until (Alter >= MinAlter) and (Alter <= MaxAlter);

  writeln;
end; {Eingabe}

procedure Ausgabe;
const
  Zeichen = '*';                             {Darzustellendes Zeichen}
  GrenzAlter = 75;                     { 1 '*' = 1 Jahr oder 2 Jahre?}

var
  Grenze: integer;
  i: integer;                                           {Z„hlvariable}

begin
  Writeln('Grafische Darstellung des Alters fr ',Name);

  if Alter < GrenzAlter
    then writeln('( 1 ''*'' = 1 Jahr )')
    else writeln('( 1 ''*'' = 2 Jahre )');

  writeln;
  write(Alter:3,': ');                             {Alter im Klartext}

  if Alter < GrenzAlter
    then Grenze:= Alter
    else Grenze:= Alter div 2;

  for i:= 1 to Grenze do write(Zeichen);

  writeln;
end; {Ausgabe}

procedure Warten;
begin
  GotoXY(1,25);
  Write('Programmende mit [Return]-Taste...');
  readln;
end; {Warten}

begin
  Ueberschrift;
  Eingabe;
  Ausgabe;
  Warten;
end.