{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Das Programm zeigt die Verschachtelung zweier FOR-Schleifen.     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program VerschachtelteSchleifen;                 {Datei: Schachtl.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  EndeAussen =     3;
  EndeInnen  = 15000;

var
  i,j: integer;                                        {Z�hlvariablen}

begin
  ClrScr;
  writeln('Verschachtelung zweier FOR-Schleifen');
  GotoXY(20,6); write('�u�ere Schleife');
  GotoXY(40,6); write('Innere Schleife');
  GotoXY(27,7); write(chr(31));
  GotoXY(47,7); write(chr(31));

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳��u�ere Schleife陳}
  for i:= 1 to EndeAussen do
  begin
    write(^G);                                             {Signalton}
    GotoXY(25,8);
    write(i:3);

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Innere Schleife陳}
    for j:= 1 to EndeInnen do
    begin
      GotoXY(45,8);
      write(j:5);
    end; {for Innen}

  end; {for Aussen}
  readln;                                        {Auf [Return] warten}
end.