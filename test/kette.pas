{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demonstriert den Datentyp String und verwendet dabei die         �
 � Routinen Concat, Copy, Delete, Insert, Length, Pos, Str und Val. �
 ������������������������������������������������������������������ͼ}
Program DatentypString;                             {Datei: Kette.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  S,S1,S2: string;                                  {String-Variablen}
  x: real;                                             {Real-Variable}
  I: integer;                                       {Integer-Variable}

begin
  ClrScr;
  writeln('Demoprogramm zum Datentyp STRING');
  writeln;

  {����������������������������������������������������������Concat��}
  S1:= 'Turbo ';
  S2:= 'Pascal';
  S:= Concat(S1,S2);
  write('S1 = Turbo , S2 = Pascal,     S:= Concat(S1,S2);');
  writeln(' --> S = ',S);
  writeln;

  {������������������������������������������������������������Copy��}
  S1:= 'Turbo Pascal 7.0';
  S:= Copy(S1,1,5);
  write('S1 = Turbo Pascal 7.0,        S:= Copy(S1,1,5); ');
  writeln(' --> S = ',S);
  writeln;

  {����������������������������������������������������������Delete��}
  S:= 'Turbo Pascal 7.0';
  Delete(S,7,7);
  write('S = Turbo Pascal 7.0,         Delete(S,7,7);    ');
  writeln(' --> S = ',S);
  writeln;

  {����������������������������������������������������������Insert��}
  S:= 'Turbo 7.0';
  S1:= 'Pascal ';
  Insert(S1,S,7);
  write('S = Turbo 7.0, S1 = Pascal ,  Insert(S1,S,7);   ');
  writeln(' --> S = ',S);
  writeln;

  {����������������������������������������������������������Length��}
  S:= 'Pascal';
  I:= Length(S);
  write('S = Pascal,                   I:= Length(S);    ');
  writeln(' --> I = ',I);
  writeln;

  {�������������������������������������������������������������Pos��}
  S1:= 'pas';
  s:= 'Bsp.pas';
  I:= Pos(S1,S);
  write('S1 = pas, S = Bsp.pas,        I:= Pos(S1,S);    ');
  writeln(' --> I = ',I);
  writeln;

  {�������������������������������������������������������������Str��}
  X:= 125.333;
  Str(X:7:2,S);
  write('X = 125.333,                  Str(X:7:2,S);     ');
  writeln(' --> S = ',S);
  writeln;

  {�������������������������������������������������������������Val��}
  S:= '1.414';
  Val(S,X,I);
  write('S = 1.414,                    Val(S,X,I);       ');
  writeln(' --> X = ',X:5:3,', I = ',I);

  readln;                                        {Auf [Return] warten}
end.