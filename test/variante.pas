{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 19.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Demoprogramm zu Varianten Records.                               º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program VarianteRecords;                         {Datei: Variante.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
type
  Person = record
    Name,Vorname,
    Strasse,Wohnort: string[25];
    Telefon: string[15];
    case Alter: integer of
      14,15,
      16,17: (Erziehungsber: string[50]);
  end;

var
  AN: person;

begin
  ClrScr;
  writeln('Demo zu Varianten Records');
  writeln;

  with AN do
  begin
    write('Name ...............: '); readln(Name);
    write('Vorname ............: '); readln(Vorname);
    write('Strasse ............: '); readln(Strasse);
    write('Wohnort ............: '); readln(Wohnort);
    write('Telefon ............: '); readln(Telefon);
    write('Alter (14-65).......: ');

    repeat
      readln(Alter);
    until (Alter >= 14) and (Alter <= 65);

    if (Alter >= 14) and (Alter <= 17) then
      begin
        write('Erziehungsberechtigt: ');
        readln(Erziehungsber);
      end; {if}

  end; {with}

  GotoXY(1,25);
  write('Bitte [Return] drcken...');
  readln;                                        {Auf [Return] warten}
end.