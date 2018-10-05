{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                Autorin: Gabi Rosenbaum  22.10.1992               �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 �      Programmierung eines bin�ren Baum                           �
 ������������������������������������������������������������������ͼ}
Program Baum;                                             {Baum01.pas}
Uses Crt;                                {Bibliothek aus Turbo-Pascal}

Type
   PPerson = ^TPerson;
   TPerson = Record
      Name    : String;
      Vorname : String;
      Alter   : String[3];
      Links   : PPerson;
      Rechts  : PPerson;
   end;

Var
  Wurzel      : PPerson;                       {Der erste Baumeintrag}
  HeapBeginn  : Pointer;                      {Merken des Heapbeginns}

{������������������������������������������������������������������Ŀ
 �Procedure PersonEinfuegen                                         �
 ������������������������������������������������������������������Ĵ
 �F�gt ein neues Element in den Baum ein.                           �
 ��������������������������������������������������������������������}
Procedure PersonEinfuegen(Var NeuePerson, AktuellePosition: PPerson);
Begin
                           {Wenn  AktuellePosition NIL ist, dann kann
                             das Element anstelle des NIL-Zeigers an-
                                                     geh�ngt werden.}
  If AktuellePosition = NIL then
  Begin
    AktuellePosition := NeuePerson;
    exit;                                     {Verl��t die Prozedur.}
 end;

                         {Ansonsten mu� in der richtigen Richtung des
                            Baumes weitergesucht werden, bis ein NIL-
                                               Zeiger gefunden wird.}
  If NeuePerson^.Name > AktuellePosition^.Name
  then
    PersonEinfuegen(NeuePerson,AktuellePosition^.Rechts)

    else
      PersonEinfuegen(NeuePerson,AktuellePosition^.Links);
end;                                           {von PersonEinfuegen.}

{������������������������������������������������������������������Ŀ
 �Procedure Einfuegen                                               �
 ������������������������������������������������������������������Ĵ
 �Prozedur zum Einlesen der Daten in das Element.                   �
 �Ruft nach dem Einlesen die Prozedur PersonEinfuegen auf.          �
 ��������������������������������������������������������������������}
Procedure Einfuegen;
Var
  Ch   : Char;     
  PAkt : PPerson;                       {Aktuell bearbeitetes Element}
Begin
  Repeat              {Schleife f�r wiederholte Eingabe eines Namens.}
    ClrScr;
    PAkt := New(PPerson);                {Neuen Zeiger PAkt erzeugen.}
    Writeln;                 {Einlesen der Daten in das neue Element.}
    Write('Bitte den Nachnamen eingeben  :  ');
    Readln(PAkt^.Name);
    Write('Bitte den Vornamen eingeben   :  ');
    Readln(PAkt^.Vorname);
    Write('Bitte das Alter eingeben      :  ');
    Readln(PAkt^.Alter);
    PAkt^.Links  := NIL;             {Initialisierung des rechten und}
    PAkt^.Rechts := NIL;                    {linken Zeigers von PAkt.}
    PersonEinfuegen(PAkt,Wurzel);        {Aufruf von PersonEinfuegen.}
    Writeln;
    Writeln('Eine weitere Person einf�gen ? <J/N>');

    Repeat                                       {Wartet auf J oder N}
      Ch := Upcase(ReadKey);
    until ch in ['J','N'];

  Until (ch = 'N');                  {Kein weiteres Element einf�gen.}
end;                                                  {von Einfuegen.}

{������������������������������������������������������������������Ŀ
 �Function PersonSuchen                                             �
 ������������������������������������������������������������������Ĵ
 �Sucht ein Element nach einem eingegebenen Nachnamen.              �
 �Enth�lt der Baum zweimal den gleichen Namen, wird in Zeiger auf   �
 �den zur�ckgegeben, der in der Hierarchie an erster Stelle steht.  �
 ��������������������������������������������������������������������}
Function PersonSuchen(SuchName: String;
                      Var AktuellePosition: PPerson): PPerson;
Var
  AktPerson    : PPerson;{Funktionsergebnis f�r den Rekursiven Aufruf}
Begin
  PersonSuchen := NIL;                   {Initialisierung der Zeiger.} 
  AktPerson    := NIL;
                              {Wenn das gesuchte Element gefunden ist,
                        wird der Zeiger auf das Element als Funktions-
                      ergebnis zur�ckgegeben und die Routine beendet.}
  If SuchName = AktuellePosition^.Name then
  Begin
    PersonSuchen := AktuellePosition;
    exit                                       {Verl��t die Funktion.}
  end

  else             {Sonst wird in der richtigen Richtung weitergesucht
                   bis ein Zeiger gefunden ist, oder NIL zur�ckgegeben
                           wird, weil er Eintrag nicht vorhanden ist.}
  Begin
    If ((AktuellePosition^.Links <> NIL) and
       (SuchName < AktuellePosition^.Name)) then 
           AktPerson := PersonSuchen(SuchName,AktuellePosition^.Links)

      Else
      if (AktuellePosition^.Rechts <> NIL) then
         AktPerson := PersonSuchen(SuchName,AktuellePosition^.Rechts);

  end;                                                     {von else.}
  PersonSuchen := AktPerson;
end;                                               {von PersonSuchen.}

{������������������������������������������������������������������Ŀ
 �Procedure Suche                                                   �
 ������������������������������������������������������������������Ĵ
 �Prozedur zum Einlesen des Nachnamens der gesuchten Person.        �
 �Ruft die Funktion PersonSuchen auf.                               �
 ��������������������������������������������������������������������}
Procedure Suche;
Var
  SuchPerson: String;               {Zur Eingabe der gesuchten Person}
  Gefunden  : PPerson;            {Funktionsergebnis von PersonSuchen}
  ch        : Char;                                 {F�r die Abfrage.}
Begin
  Repeat              {Schleife f�r wiederholte Eingabe eines Namens.}

    ClrScr;
    Write('Welche Person soll gesucht werden ? --> '); {Eingabe Name.}
    ReadLn(SuchPerson);
    Gefunden := PersonSuchen(SuchPerson,Wurzel);    {Sucht Element und
                  gibt einen Zeiger auf das gefundene Element zur�ck.}

    if Gefunden <> NIL then                  {Element wurde gefunden.}
    Begin
      Writeln;
      Writeln(Gefunden^.Name,Gefunden^.Vorname:30,Gefunden^.Alter:30)
    end

    else                               {Element wurde nicht gefunden.}
    Writeln('Die gesuchte Person ist noch nicht eingegeben worden!!');

    Writeln;
    Writeln('Soll eine weitere Person gesucht werden ? <J/N>');
    ch := UpCase(ReadKey);

  Until (ch = 'N');
end;                                                     {von Suche.}

{������������������������������������������������������������������Ŀ
 �Function PersonLoeschen                                           �
 ������������������������������������������������������������������Ĵ
 �L�scht ein Element, in dem die beiden Zeigers des Elements in     �
 �zwei Zeigervariablen 'gerettet' und anschlie�end wieder           �
 �an die Liste angeh�ngt werden.                                    �
 ��������������������������������������������������������������������}
Function PersonLoeschen(SuchName: String;
                        Var AktuellePosition: PPerson): String;
Var
  AktPerson    : String;{Funktionsergebnis f�r den Rekursiven Aufruf.}
  RetteLinks   : PPerson;  {Retten des l. Zeigers des gel. Elementes.}
  RetteRechts  : PPerson;  {Retten des r. Zeigers des gel. Elementes.}
Begin
  AktPerson := '';
                 {Wenn die gesuchte Person gefunden ist dann l�schen.}
  If (SuchName = AktuellePosition^.Name)  then
  Begin
    RetteLinks   := AktuellePosition^.Links;
    RetteRechts  := AktuellePosition^.Rechts;
    PersonLoeschen := AktuellePosition^.Name;
    Dispose(AktuellePosition);
    AktuellePosition := NIL;
                       {Die beiden geretteten Zeiger wieder einf�gen.}
    If RetteLinks <> NIL then
       PersonEinfuegen(RetteLinks,Wurzel);
    If RetteRechts <> NIL then
       PersonEinfuegen(RetteRechts,Wurzel);
    Exit;                                      {Verl��t die Funktion.}
  end;                                                       {von if.}
                       {Sonst in der richtigen Richtung weitersuchen.}
  If SuchName > AktuellePosition^.Name then
  Begin
   If (AktuellePosition^.Rechts <> NIL) then
       AktPerson := PersonLoeschen(Suchname,AktuellePosition^.Rechts)
  end
                                                             {von if.}
  else
  Begin
   If AktuellePosition^.Links <> NIL then
      AktPerson := PersonLoeschen(Suchname,AktuellePosition^.Links);
  end;
  PersonLoeschen := AktPerson;                             {von else.}
end;                                             {von PersonLoeschen.}

{������������������������������������������������������������������Ŀ
 �Procedure Loeschen                                                �
 ������������������������������������������������������������������Ĵ
 �Prozedur zum Einlesen der Daten des Elements, das gel�scht        �
 �werden soll. Ruft die Funktion PersonLoeschen auf.                �
 ��������������������������������������������������������������������}
Procedure Loeschen;
Var
  Gefunden  : String;            {Gefundener und gel�schter Eintrage.}
  SuchPerson: String;              {Zur Eingabe der gesuchten Person.}
  ch        : Char;                                 {f�r die Abfrage.}
Begin

  Repeat                {Schleife f�r wiederholte Eingabe des Namens.}
    ClrScr;
    Write('Welche Person soll gel�scht werden ? --> ');
    ReadLn(SuchPerson);
    Gefunden := PersonLoeschen(SuchPerson,Wurzel);  {Sucht Element und
                  gibt einen Zeiger auf das gefundene Element zur�ck.}
    if Gefunden <> '' then                    {Wenn gefunden l�schen.}
    Begin
      Writeln;
      Writeln('Folgende Person wurde gel�scht:');
      Writeln(Gefunden)
    end                                                      {von if.}

    else
      Writeln('Die gesuchte Person ist noch nicht eingegeben worden');

    Writeln;
    Writeln('Soll eine weitere Person gel�scht werden ? <J/N>');
    ch := UpCase(ReadKey);

  Until (ch = 'N');                                {Schleife beenden.}
end;                                                    {von Loesche.}

{������������������������������������������������������������������Ŀ
 �Procedure Ausgeben                                                �
 ������������������������������������������������������������������Ĵ
 �Gibt alle Elemente aus.                                           �
 ��������������������������������������������������������������������}
Procedure Ausgeben(AktuellePosition: PPerson);
Var
  AktPerson    : PPerson;
Begin
                        {Wenn Links nicht NIL ist dann weitersuchen.}
  If (AktuellePosition^.Links <> NIL) then
              Ausgeben(AktuellePosition^.Links);
                                {Bis es links nicht mehr weitergeht.}
  If (AktuellePosition^.Rechts <> NIL) then
              Ausgeben(AktuellePosition^.Rechts);
                               {Bis es Rechts nicht mehr weitergeht.}

                     {Und Aktuelle Position auf Bildschirm ausgeben.}
  If (AktuellePosition <> NIL) then
  Writeln(AktuellePosition^.Name:30,
          AktuellePosition^.Vorname:30,
	  AktuellePosition^.Alter:19);
end;                                                  {von ausgeben.}

{������������������������������������������������������������������Ŀ
 �Procedure Hauptschleife                                           �
 ������������������������������������������������������������������Ĵ
 �Erstellt ein Men�, in dem gew�hlt werden kann, welche der         �
 �oben vereinbarten Routinen aufgerufen wird.                       �
 ��������������������������������������������������������������������}
Procedure Hauptschleife;
Var
  ch : Char;
Begin
  Repeat;                             {Schleife zum Aufbau des Men�s.}
    ClrScr;
    Gotoxy(1,6);                               {Cursor positionieren.}
    Writeln('Demonstration eines Bin�ren Baumes');
    Writeln;
    Writeln(' Eine Person einf�gen   :  1');
    Writeln(' Eine Person suchen     :  2');
    Writeln(' Eine Person l�schen    :  3');
    Writeln(' Alle Personen ausgeben :  4');
    Writeln(' Programm beenden       :  5');

    ch := ReadKey;
    Case ch of
      '1' :  Einfuegen;
      '2' :  Suche;
      '3' :  Loeschen;
      '4' :  Begin
               ClrScr;
               Ausgeben(Wurzel);
               Writeln;
               Writeln('Weiter mit einem Tastendruck');
               ReadKey;
             end;
      '5' :  Begin
               Clrscr;
               Gotoxy(10,5);
               Writeln('Programm wirklich beenden werden ? <J/N>');
               ch := Upcase(ReadKey);
               If (ch = 'J') then
                   ch := '5';
             end;                                      {von ch = '5'.}
        else ch := 'A';
  end;                                                     {von case.}
  Until (ch = '5');
end;                                              {von Hauptschleife.}


Begin
  Mark(HeapBeginn);           {Zeiger auf den Anfang des freien Heaps.
                              Alles was ab jetzt erzeugt wird, mu� zum
                      Schlu� des Programms wieder freigegeben werden.}
  HauptSchleife;
  Release(HeapBeginn);                        {Heap wieder freigeben.}
  ClrScr;                              {Bildschirm wieder freimachen.}
end.                                              {vom Programm Baum.}