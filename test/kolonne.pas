{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Schreibt die Zahlen von 1 bis 100 in 10er-Kolonnen auf den Bild- �
 � schirm. Verwendet f�r den Zeilenumbruch die If-Anweisung ohne    �
 � Alternative.                                                     �
 ������������������������������������������������������������������ͼ}
Program  Kolonne10er;                             {Datei: Kolonne.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var i: byte;                                            {Z�hlvariable}

begin
  ClrScr;
  writeln(' ':15,'10er-Kolonne');
  writeln;

  for i:= 1 to 100 do
  begin
    write(i:4);
    if i mod 10 = 0 then writeln;
  end; {for}

  readln;                                        {Auf [Return] warten}
end.