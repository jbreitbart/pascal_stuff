{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 25.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Auch bereits vor dem Programmkopf darf 'Text' stehen, wenn er    �
 � als 'Kommentar' (zwischen geschweiften Klammern) gekennzeichnet  �
 � ist.                                                             �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Programmkopf陳}
Program ProgrammBezeichner;

{陳陳陳陳陳陳陳陳陳陳陳Uses-Anweisung zur Aufnahme von Bibliotheken陳}
uses
  Crt,Dos;                             {Bibliotheken aus Turbo Pascal}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Hier beginnt der Vereinbarungsteil陳}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Vereinbarung der Konstanten陳}
const
  MWSt = 0.14;                        {Konstante erh�lt den Wert 0.14}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Vereinbarung der Datentypen陳}
type
  Adresse = record
    Vorname: string[10];
    Name: string[15];
    Strasse: string[25];
    Ort: string[20];
  end;

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Vereinbarung der Variablen陳}
var
  Person: Adresse;                     {Variable vom Datentyp Adresse}
  i: integer;                          {Variable vom Datentyp Integer}

{陳陳陳陳陳Vereinbarung der Unterprogramme (Prozeduren + Funktionen陳}

procedure Schreiben;
begin
  {Anweisungen der procedure Schreiben}
end;

function Lesen: string;
begin
  {Anweisungen der function Lesen}
end;

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Hier endet der Vereinbarungsteil陳}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Hier beginnt das Hauptprogramm陳}
begin
  ClrScr;                                         {Bildschirm l�schen}
  write('Name: ');                                  {Ausgabeanweisung}
  readln(Person.Name);                              {Eingabeanweisung}

  {Weitere Anweisungen des Hauptprogramms}

end.
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Hier endet das Hauptprogramm陳}
