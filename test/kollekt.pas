PROGRAM Kollektionen;

USES OWindows, Objects, WinCrt, Strings;

TYPE TDatum = RECORD
       Tag, Monat : Byte;
       Jahr       : Word;
     END;

{
  Zunächst erstellen wir uns einen Datentyp, der als Grundlage
  aller weiteren Objekte eingesetzt wird. Er wurde, um alle
  Vorteile der Kollektionen ausnutzen zu können, von TObject
  ebgeleitet:
}

TYPE PAllgemein = ^TAllgemein;

     TAllgemein = OBJECT (TObject)
       Name    : PChar;
       Telefon : PChar;

       CONSTRUCTOR Init (NamePar, TelefonPar : PChar);
       PROCEDURE   Ausgabe; virtual;
       DESTRUCTOR  Done; virtual;
     END;

{
  Nun leiten wir davon zwei weitere Sätze ab: einen für
  persönliche Bekannte und einen für Kunden. Beide
  sollen unterschiedliche Datenfelder besitzen; da diese
  zusätzlichen Felder statisch und nicht dynamisch sind,
  benötigen wir keinen zusätzlichen Destruktor, sondern
  benutzen den von TAllgemeien mit:
}

     PBekannter = ^TBekannter;

     TBekannter = OBJECT (TAllgemein)
       Geburtstag : TDatum;

       CONSTRUCTOR Init (NamePar, TelefonPar : PChar;
                         GeburtstagPar : TDatum);
       PROCEDURE   Ausgabe; virtual;
     END;


     PKunde = ^TKunde;

     TKunde = OBJECT (TAllgemein)
       Jahresumsatz : Real;

       CONSTRUCTOR Init (NamePar, TelefonPar : PChar; Umsatz : Real);
       PROCEDURE   Ausgabe; virtual;
     END;

{
  Methoden des allgemeinen Objektes:
}

CONSTRUCTOR TAllgemein.Init (NamePar, TelefonPar : PChar);
BEGIN
  Name    := StrNew (NamePar);
  Telefon := StrNew (TelefonPar);
END;

PROCEDURE TAllgemein.Ausgabe;
BEGIN
  WriteLn ('-----------------------------------------');
  WriteLn ('Name:       ', Name);
  WriteLn ('Telefon:    ', Telefon);
END;

DESTRUCTOR TAllgemein.Done;
BEGIN
  StrDispose (Name);
  StrDispose (Telefon);
END;

{
  Methoden des Bekannten-Objektes:
}

CONSTRUCTOR TBekannter.Init (NamePar, TelefonPar : PChar;
                             GeburtstagPar : TDatum);
BEGIN
  TAllgemein.Init (NamePar, TelefonPar);
  Geburtstag := GeburtstagPar;
END;

PROCEDURE TBekannter.Ausgabe;
BEGIN
  TAllgemein.Ausgabe;
  WITH Geburtstag DO
    WriteLn ('Geburtstag: ', Tag, '.', Monat, '.', Jahr);
END;

{
  Methoden des Kunden-Objektes:
}

CONSTRUCTOR TKunde.Init (NamePar, TelefonPar : PChar; Umsatz : Real);
BEGIN
  TAllgemein.Init (NamePar, TelefonPar);
  JahresUmsatz := Umsatz;
END;

PROCEDURE TKunde.Ausgabe;
BEGIN
  TAllgemein.Ausgabe;
  WriteLn ('Umsatz: ', JahresUmsatz:12:2);
END;

{
  Die folgende Prozedur gibt alle Datensätze auf dem Bildschirm
  aus. Sie benutzt dazu eine lokale FAR-Prozedur und die ForEach-
  Methode einer jeden Kollektion.
  Beachten Sie bitte, daß durch die Polymorphie der Objekte
  jeweils automatisch die ´richtige´ Ausgabe-Methode für jeden
  Datensazt gewählt wird.
}

PROCEDURE AllesAusgeben (Datensaetze : PCollection);

  PROCEDURE GibSatzAus (Item : PAllgemein); far;
  BEGIN
    Item^.Ausgabe;
  END;

BEGIN
  DatenSaetze^.ForEach (@GibSatzAus);
END;

{
  Eine globale Variable enthält die Kollektion, eine andere
  benötigen wir, um ein Datum zu erzeugen:
}

VAR Daten : PCollection;
    Datum : TDatum;

{
  Hauptprogramm:
  Es werden eine Kollektion und darin mit Insert drei Datensätze
  erzeugt. Anschließend werden alle Daten angezeigt (AllesAusgaben),
  bevor die Kollektion wieder gelöscht wird.
}

BEGIN
  Daten := New (PCollection, Init (10, 5));

  Daten^.Insert (New (PAllgemein, Init ('Meier', '12345')));
  Daten^.Insert (New (PKunde, Init ('Müller', '1122', 75000)));

  WITH Datum DO BEGIN
    Tag   := 22;
    Monat := 1;
    Jahr  := 59;
  END;

  Daten^.Insert (New (PBekannter, Init ('Uwe', '7788', Datum)));

  AllesAusgeben (Daten);

  Dispose (Daten, Done);
END.
