{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autorin: Gabi Rosenbaum    12.10.92              �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 �                                                                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program  Liste03;  {Liste03.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
type
  PPerson = ^Person;                 {Zeiger auf Record mit den Daten}
  Person = record
             Name : String [20];
             PLinks,
             PRechts : PPerson;
           end;
var
  WurzelRechts,                      {untypisierte Zeiger die auf das}
  WurzelLinks : Pointer;             {erste und letzte Element zeigen}
  PAkt,                                 {Zeiger aufs aktuelle Element}
  PHilf : PPerson;                                       {Hilfszeiger}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure ListeInitialisieren;                                    �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Initialisiert die Zeiger mit dem Wert Nil                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure ListeInitialisieren;
begin
  WurzelRechts := Nil;
  WurzelLinks := Nil;
  PAkt := Nil;
  PHilf := Nil;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure ListeErzeugen                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Erzeugt das erste Listenelement                                   �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure ListeErzeugen;
begin
  clrscr;
  New(PAkt);                                      {PAkt wird erzeugt.}
  Writeln('Die dynamische doppelt verkettete Liste wird erzeugt.');
  Write('Bitte den 1.Namen eingeben: ');
  readln(PAkt^.Name);                     {Dateninhalt in PAkt^.Name.}
  PAkt^.PLinks := nil;                   {Initialisierung der rechten}
  PAkt^.PRechts := nil;                       {und linken Laufzeiger.}
  WurzelLinks := PAkt;                   {Die Wurzeln werden mit PAkt} 
  WurzelRechts := PAkt;                                   {verankert.}
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure HinterWurzelLinks                                       �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Hilfsprozedur,f�gt ein Element hinter der linken Wurzel ein.      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure HinterWurzelLinks;
begin
  PHilf^.PRechts := PAkt;              {Rechter Laufzeiger auf PAkt.}
  WurzelLinks := PHilf;                     {Linke Wurzel auf PHilf.}
  PAkt^.PLinks := PHilf;      {Linker Laufzeiger von PAkt auf PHilf.}
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure VorWurzelRechts                                         �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Hilfsprozedur, f�r ein Element vor der Rechten Wurzel ein.        �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure VorWurzelRechts;
begin;
  PHilf^.PLinks := PAkt;                 {Linker Laufzeiger auf PAkt.}
  WurzelRechts := PHilf;                     {Linke Wurzel auf PHilf.}
  PAkt^.PRechts := PHilf;     {Rechter Laufzeiger von PAkt auf PHilf.}
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure HinterPAkt                                              �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Hilfsprozedur, f�gt ein Elemtent hinter PAkt ein                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure HinterPAkt;
begin
  PHilf^.PRechts := PAkt^.PRechts;     {R. Laufzeiger von PHilf zeigt 
                                         auf das Element, auf das der
                                       r. Laufzeiger von PAkt zeigt.}
  PHilf^.PLinks := PAkt;          {L. Laufzeiger von PHilf auf PAkt.}
  PAkt^.PRechts := PHilf;         {R. Laufzeiger von PAkt auf PHilf.}
  PAkt := PHilf^.PRechts;          {PAkt auf das Element, auf das der
                                      r. Laufzeiger von PHilf zeigt.}
  PAkt^.PLinks := PHilf;          {L. Laufzeiger von PAkt auf PHilf.}
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure Vor PAkt                                                �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Hilfsprozedur, f�gt Element hinter PAkt ein.                      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure VorPAkt;
begin
  PHilf^.PLinks := PAkt^.PLinks;       {L. Laufzeiger von PHilf zeigt
                                         auf das Element, auf das der
                                       l. Laufzeiger von PAkt zeigt.}
  PHilf^.PRechts := PAkt;         {R. Laufzeiger von PHilf auf PAkt.}
  PAkt^.PLinks := PHilf;          {L. Laufzeiger von HAkt auf PHilf.}
  PAkt := PHilf^.PLinks;           {PAkt auf das Element, auf das der
                                      l. Laufzeiger von PHilf zeigt.}
  PAkt^.PRechts := PHilf;         {R. Laufzeiger von PAkt auf PHilf.}
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure ElementEinfuegen                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �F�gt weitere Elemente sortiert in die Liste ein.                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure ElementEinfuegen;
var
  ch : char;
begin
  repeat

    repeat   {Abfrage ob ein weiteres Element eingef�gt werden soll.}
      clrscr;
      write('Soll ein weiteres Element eingef�gt werden? J/N: ');
      ch := Upcase(readkey);
    until ch in ['J','N'];

    if ch ='J' then
    begin
      clrscr;
      new (PHilf);                               {PHilf wird erzeugt}
      PHilf^.PLinks := Nil;              {Initialisierung des linken}
      PHilf^.PRechts := Nil;               {und rechten Laufzeigers.}
      write('Name: ');                     {Daten werden eingelesen.}
      readln (PHilf^.Name);

      if PHilf^.Name <= 'M' then     {Einlesen auf der linken Seite.}
      begin
        PAkt := WurzelLinks;                 {PAkt auf Linke Wurzel.}
                                      {Wenn PHilf erstes Element ist,
			               hinter linker Wurzel einf�gen}
        if PAkt^.Name > PHilf^.Name then   
	                            HinterWurzelLinks

	else                {Schleife f�r PHilf nicht erstes Element}
	begin                {Verschieben von PAkt um ein Element bis
	                         PAkt^.Name > Hilf^.Name ist oder das
			                        Folgeelement Nil ist}
          while (PAkt^.Name < PHilf^.Name) and
	        (PAkt^.PRechts <> Nil) do
	                   PAkt := PAkt^.PRechts;
                                      {Wenn PHilf letztes Element ist,
                                          vor rechter Wurzel einf�gen}
          if PAkt^.PRechts = Nil then
                                VorWurzelRechts
          else
            VorPAkt;                         {PHilf vor PAkt einf�gen}
        end;                                               {von else.}
      end                                 {von if PHilf^.Name <= 'M'.}
      else                           {Schleife f�r PHilf^.Name > 'M'.}
        begin
        PAkt := WurzelRechts;                {PAkt auf rechte Wurzel.}
                                     {Wenn PHilf letztes Element ist,}
                                         {vor rechter Wurzel einf�gen}
        if Pakt^.Name < PHilf^.Name then
                                    VorWurzelRechts
        else               {Schleife wenn PHilf nicht letztes Element}
        begin               {Verschiebe PAkt um ein Element nach links
                             solange bis PAkt^.Name < PHilf^.Name oder
			                    das Folgeelement Nil ist.} 

          while (Pakt^.Name > PHilf^.Name) and
	        (PAkt^.PLinks <> Nil) do
                       PAkt := PAkt^.PLinks;
                                       {Wenn PHilf erstes Element ist,
                                   hinter der linken Wurzel einf�gen.}
	  if PAkt^.PLinks = Nil then
                               HinterWurzelLinks
          else
            HinterPAkt;                  {PHilf hinter PAkt einf�gen.}
        end;                                               {Von else.}
      end;                           {von else f�r PHilf^.Name > 'M'.}
    end;     {von if f�r Abfrage, ob weiteres Element eingef�gt wird.}     
  until ch = 'N';
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure AusgebenRechts                                          �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Die Liste wird von Links nach Rechts ausgegebnen                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure AusgebenRechts;
begin
  clrscr;
  writeln ('Ausgabe der Listenelemente von Links nach Rechts');
  PAkt := WurzelLinks;                       {PAkt auf linke Wurzel.}

  while PAkt <> Nil do                      {Solange PAkt nicht Nil.}
  begin
    writeln (PAkt^.Name);                       {Ausgabe des Namens.}
    PAkt := PAkt^.PRechts;         {PAkt um ein Element nach rechts.}
  end;

  readln;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure AusgebenLinks                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Gibt die Liste von Rechts nach Links aus.                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure AusgebenLinks;
begin
  clrscr;
  writeln ('Ausgabe der Listenelemente von Rechts nach Links');
  PAkt := WurzelRechts;                     {PAkt auf rechte Wurzel.}

  while PAkt <> Nil do                      {Solange PAkt nicht Nil.}
  begin
    writeln (PAkt^.Name);                       {Ausgabe des Namens.}
    PAkt := PAkt^.PLinks;           {PAkt um ein Element nach links.}
  end;

  readln;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure ListeLoeschen                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �L�scht die Liste und gibt den im Heap belegten Speicherplatz      �
 �wieder frei                                                       �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure ListeLoeschen;
begin

  while WurzelLinks <> Nil do
  begin
    PAkt := WurzelLinks;                     {Pakt auf Linke Wurzel.}
    WurzelLinks := PAkt^.PRechts;{Wurzel Links aufs n�chste Element.}
    dispose(PAkt);                                    {PAkt l�schen.}
  end;

    WurzelLinks := Nil;                     {Wurzeln wieder auf Nil.}
    WurzelRechts := Nil;
end;

begin
  ListeInitialisieren;
  ListeErzeugen;
  ElementEinfuegen;
  AusgebenRechts;
  AusgebenLinks;
  ListeLoeschen;
end.
