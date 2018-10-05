{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Demoprogramm zu prozeduralen Typen.                              �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program ProzedurVariablen;                       {Datei: FuncType.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
type
  Berechne = function(x,y: real): real;

var
  x,y: real;
  i: integer;
  Prozent: Berechne;                               {Prozedur-Variable}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Zinsen                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Berechnet die Zinsen und ist als far codiert.                    �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
{$f+}                                    {Routine ist als far codiert}
function Zinsen(x,y: real): real;
begin
  Zinsen:= x + (x*y/100);
end; {Zinsen}
{$f-}                                         {Far-Codierung aufheben}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Kontoauszug                                                      �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Ruft eine Funktion als Parameter auf.                            �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Kontoauszug(x,y: real; Prozente: Berechne);
begin
  write('Ihr letzter Kontoauszug hatte eine H�he von: ');
  writeln(x:6:2,' DM');

  for i:= 1 to 20 do writeln;

  write('Ihr Kontostand betr�gt, bei einem Zinssatz von ');
  write(y:6:2,'%');
  writeln(' ,insgesamt ',Prozente(x,y):6:2,' DM.');

  GotoXY(1,25);
  write('Bitte [Return] dr�cken...');
  readln;
end; {Kontoauszug}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

begin {Hauptprogramm}
  ClrScr;
  Prozent:= Zinsen;             {Berechne Zinsen an Prozedurparameter}
  Kontoauszug(1844.75,2.5,Prozent);
  Kontoauszug(-2783.16,9.7,Prozent);
end.