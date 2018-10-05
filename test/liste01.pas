{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autorin: Gabi Rosenbaum    12.10.92              º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Programm fr einfach verkettete Listen                           º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program  Liste01;  {Liste01.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

type
  PPerson = ^person;
  person = record
             Vorname,
             Name, 
             Alter : String[20];
             next  : PPerson;
           end;
var
   PLetzter,                           {Untypisierte  Zeiger fr die}
                                         {Markierung des letzten und}
   Wurzel : Pointer;                            {des ersten Elements}

   PAkt,               {Zeigt auf die aktuelle Posisition der Liste.} 
   PHilf : PPerson;                                      {Hilfzeiger}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure ListeInitialsieren                                      ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Initialisiert die Zeiger Wurzel und PLetzter mit Nil              ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ListeInitialisieren;
begin
  wurzel := Nil;
  PLetzter := Nil;
  PHilf := Nil;
  PAkt := Nil;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure ListeEingeben                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Liest Listenelemente ber die Tastatur ein und fr ein neues      ³
 ³Element jeweils am Ende der Liste ein.                            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

procedure ListeEingeben;
var
  Auswahl : char;
begin
  writeln ('Im folgenden soll eine Liste mit beliebig vielen');
  writeln ('verschiedenen Elementen eingegeben werden');
  new(PAkt);                                      {PAkt wird erzeugt.}
  pAkt^.next := Nil;                {PAkt wird mit Nil initialisiert.}
  wurzel := PAkt;                    {Wurzel wird auf PAkt gerichtet.}

  With PAkt^ do        {Einlesen der Daten in das erste Listenelement}
  begin
    write('Bitte den ersten Vornamen eingeben: ');
    readln(Vorname);
    write('Bitte den ersten Nachnamen eingeben: ');
    readln(Name);
    write('Bitte das Alter eingeben: ');
    readln(Alter);
  end;
  Auswahl := '1';
                       {Einlesen der Daten in weitere Listenelemente}
  repeat
    clrscr;
    writeln('[1] fr weiteres Element in die Liste eingeben.');
    writeln('[2] fr Eingabe beenden.');

    repeat
      Auswahl := readkey;
    until Auswahl in ['1','2'];

    if Auswahl = '1' then
    begin
      New (PHilf);                                  {PHilf erzeugen.}
      PHilf^.Next := Nil;                        {und initialisieren}

      with PHilf^ do                                 {Daten einlesen}
      begin
        write('Vorname: ');
        readln(Vorname);
        write('Nachname: ');
        readln(Name);
        write('Alter: ');
        readln(Alter);
      end;                                                  {von with}

      PAkt^.Next:= PHilf;                 {Verkettung der Liste durch
                                                     Nachfolgezeiger}
      PAkt := PHilf;               {Verschieben des aktuellen Zeigers
                                          aufs n„chste Listenelement}
    end;                                          {von Auswahl = '1'}
  until Auswahl = '2';
  PLetzter := PAkt;                      {Zeiger fr das Kennzeichnen
                                               des letzten Elementes}
end;                                             {von Liste eingeben}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure ListeAusgeben                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Gibt Listenelemente auf dem Bildschirm aus.                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ListeAusgeben;
begin
  clrscr;
  Writeln('Ausgabe der Listenelemente');
  PAkt := wurzel;          {PAkt wird auf das erste Element gesetzt.}

  while PAkt <> Nil do       {Solange noch ein Element in der Liste.}
  begin                      
    with PAkt^ do
               Writeln(Vorname:20,Name:20,Alter:5);
    PAkt := PAkt^.Next;     {Verschiebe PAkt auf das n„chste Element}
  end;                                                    {von while}

  writeln ('Bitte [Return] drcken');
  readln;
end;                                              {von ListeAusgeben}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure ElementLoeschen                                         ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³L”scht Listenelemente aus der Liste.                              ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ElementLoeschen;
var
  Vorname, Name : string;
  gefunden : boolean;

begin
  clrscr;
                             {Einlesen der Daten die zu l”schen sind.}
  writeln('Bitte Vor- und Nachname der zu l”schenden Person eingeben');
  Write('Vorname: ');
  readln(Vorname);
  write('Nachname: ');
  readln(Name);
  pAkt := Wurzel;
  if PAkt <> Nil then        {Abfrage ob ein Listenelement existiert.}
  begin
    if (PAkt^.Vorname = Vorname) and (PAkt^.Name = Name) then
    begin                   
      Wurzel := PAkt^.Next;       {Setzt Wurzel aufs n„chste Element.}
      dispose(PAkt);             {Gibt den Speicherplatz wieder frei.}
    end                                                       {von if}
    else
    begin
      gefunden := false;                {Initialisierung von gefunden}

      while (PAkt^.Next <> Nil) and (not gefunden) do
      begin
        PHilf := PAkt^.Next;           {PHilf auf das n„chste Element}

        if (PHilf^.Vorname = Vorname) and (PHilf^.Name = Name) then
        begin
          PAkt^.Next := PHilf^.Next; {Laufzeiger von PAkt wird auf das
                                        bern„chste Element verbogen.}
          dispose(PHilf);        {Gibt den Speicherplatz wieder frei.}
          gefunden := true;
        end;                                                  {von if}

        if PAkt^.Next <> Nil then    {PAkt um ein Element verschieben}
                 PAkt := PAkt^.Next
        else                          {Zeiger auf das letzte Element.}
                 PLetzter := PAkt;
      end;                                                 {von while}
    end;                                                    {von else}
  end;                                                        {von if}
  if not gefunden then
  begin
    writeln('Element in der Liste nicht vorhanden');
    readln;
  end;                                                        {von if}
end;                                             {Von ElementLoeschen}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure ElementEinfuegen                                        ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Fuegt Listenelemente in die Liste ein.                            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ElementEinfuegen;
var
  Vorname,Name,Alter: string;

begin
  clrscr;
  new(PHilf);                                   {PHilf wird erzeugt.}
  PHilf^.Next := Nil;                            {und initialisiert.}
  Writeln('Es soll ein Element in die Liste eingefgt werden');
  writeln('Bitte die Daten der Person eingeben');

  with PHilf^ do
  begin
    write('Vorname: ');                 {Einlesen der Daten in PHilf}
    readln(Vorname);
    write('Name: ');
    readln(Name);
    write('Alter: ');
    readln(Alter);
  end;                                                      {von with}
  PAkt := PLetzter;               {PAkt auf das letzte Listenelement.}

  if PAkt = Nil then         {Abfrage ob ein Listenelement existiert.}
     wurzel := PAkt;
  PAkt^.next := PHilf;                   {Nachfolgezeiger auf PHilf.}
  PLetzter := PHilf                      {Letztes Element markieren.}
end;                                          {von ElementEinfuegen.}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³procedure ListeLoeschen                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Gibt den im Heap belegten Speicherplatz wieder frei               ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure ListeLoeschen;
begin
  while wurzel <> Nil do     {Abfrage ob weiteres Element vorhanden.}
  begin
    PAkt := Wurzel;                    {Aktueller Zeiger auf Wurzel.}
    Wurzel := PAkt^.Next;      {Wurzel auf Nachfolgezeiger von PAkt.}
    dispose (PAkt);             {Gibt den Speicherplatz wieder frei.}
  end;                                                    {von while}
end;                                              {von ListeLoeschen}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Hauptprogramm                                                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
begin
  ClrScr;
  ListeInitialisieren;
  ListeEingeben;
  ListeAusgeben;
  ElementLoeschen;
  ListeAusgeben;
  ElementEinfuegen;
  ListeAusgeben;
  ListeLoeschen
end.
