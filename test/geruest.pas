{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 25.09.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Auch bereits vor dem Programmkopf darf 'Text' stehen, wenn er    º
 º als 'Kommentar' (zwischen geschweiften Klammern) gekennzeichnet  º
 º ist.                                                             º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄProgrammkopfÄÄ}
Program ProgrammBezeichner;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄUses-Anweisung zur Aufnahme von BibliothekenÄÄ}
uses
  Crt,Dos;                             {Bibliotheken aus Turbo Pascal}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄHier beginnt der VereinbarungsteilÄÄ}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄVereinbarung der KonstantenÄÄ}
const
  MWSt = 0.14;                        {Konstante erh„lt den Wert 0.14}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄVereinbarung der DatentypenÄÄ}
type
  Adresse = record
    Vorname: string[10];
    Name: string[15];
    Strasse: string[25];
    Ort: string[20];
  end;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄVereinbarung der VariablenÄÄ}
var
  Person: Adresse;                     {Variable vom Datentyp Adresse}
  i: integer;                          {Variable vom Datentyp Integer}

{ÄÄÄÄÄÄÄÄÄÄVereinbarung der Unterprogramme (Prozeduren + FunktionenÄÄ}

procedure Schreiben;
begin
  {Anweisungen der procedure Schreiben}
end;

function Lesen: string;
begin
  {Anweisungen der function Lesen}
end;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄHier endet der VereinbarungsteilÄÄ}

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄHier beginnt das HauptprogrammÄÄ}
begin
  ClrScr;                                         {Bildschirm l”schen}
  write('Name: ');                                  {Ausgabeanweisung}
  readln(Person.Name);                              {Eingabeanweisung}

  {Weitere Anweisungen des Hauptprogramms}

end.
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄHier endet das HauptprogrammÄÄ}
