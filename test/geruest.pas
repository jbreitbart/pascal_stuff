{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 25.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Auch bereits vor dem Programmkopf darf 'Text' stehen, wenn er    �
 � als 'Kommentar' (zwischen geschweiften Klammern) gekennzeichnet  �
 � ist.                                                             �
 ������������������������������������������������������������������ͼ}

{������������������������������������������������������Programmkopf��}
Program ProgrammBezeichner;

{����������������������Uses-Anweisung zur Aufnahme von Bibliotheken��}
uses
  Crt,Dos;                             {Bibliotheken aus Turbo Pascal}

{��������������������������������Hier beginnt der Vereinbarungsteil��}

{���������������������������������������Vereinbarung der Konstanten��}
const
  MWSt = 0.14;                        {Konstante erh�lt den Wert 0.14}

{���������������������������������������Vereinbarung der Datentypen��}
type
  Adresse = record
    Vorname: string[10];
    Name: string[15];
    Strasse: string[25];
    Ort: string[20];
  end;

{����������������������������������������Vereinbarung der Variablen��}
var
  Person: Adresse;                     {Variable vom Datentyp Adresse}
  i: integer;                          {Variable vom Datentyp Integer}

{����������Vereinbarung der Unterprogramme (Prozeduren + Funktionen��}

procedure Schreiben;
begin
  {Anweisungen der procedure Schreiben}
end;

function Lesen: string;
begin
  {Anweisungen der function Lesen}
end;

{����������������������������������Hier endet der Vereinbarungsteil��}

{������������������������������������Hier beginnt das Hauptprogramm��}
begin
  ClrScr;                                         {Bildschirm l�schen}
  write('Name: ');                                  {Ausgabeanweisung}
  readln(Person.Name);                              {Eingabeanweisung}

  {Weitere Anweisungen des Hauptprogramms}

end.
{��������������������������������������Hier endet das Hauptprogramm��}
