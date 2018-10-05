{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Ermittelt die Anzahl der in einem Satz vorkommenden Selbstlaute. �
 � Der Satz mu� �ber Tastatur eingegeben werden. Verwendet werden   �
 � die For-Schleife und die Case-Anweisung.                         �
 ������������������������������������������������������������������ͼ}
Program Selbstlaute;                                 {Datei: Satz.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Satz: string[79];
  j: byte;                                              {Z�hlvariable}
  ch: char;                                              {Ein Zeichen}
  A,E,I,O,U, Sonst: byte;                         {Anzahl der Zeichen}

begin
  ClrScr;
  writeln(' ':20,'Ermittlung der Anzahl der Selbstlaute');
  writeln;
  write('Bitte gib einen Satz (max. 79 Zeichen) ein ');
  writeln('(Ende mit [Return]):');
  writeln;
  readln(Satz);
  writeln;

  {�������������������������������������������������Initialisierung��}
  A:= 0; E:= 0; I:= 0; O:= 0; U:= 0; Sonst:= 0;

  {��������������������������������Anzahl der Selbstlaute ermitteln��}
  for j:= 1 to Length(Satz) do
  begin
    ch:= Upcase(Satz[j]);
    case ch of
      'A': Inc(A);
      'E': Inc(E);
      'I': Inc(I);
      'O': Inc(O);
      'U': Inc(U);
      else Inc(Sonst);
    end; {case}
  end; {for}

  {���������������������������������������������������������Ausgabe��}
  writeln('Der Satz enth�lt den Selbstlaut');
  writeln;
  writeln('A   ', A:2,' mal,');
  writeln('E   ', E:2,' mal,');
  writeln('I   ', I:2,' mal,');
  writeln('O   ', O:2,' mal,');
  writeln('U   ', U:2,' mal,');
  writeln;
  writeln('und ',Sonst:2,' andere Zeichen.');

  readln;                                        {Auf [Return] warten}
end.