PROGRAM Kollektionen;

USES OWindows, Objects, WinCrt, Strings;

TYPE TDatum = RECORD
       Tag, Monat : Byte;
       Jahr       : Word;
     END;

{
  Zun�chst erstellen wir uns einen Datentyp, der als Grundlage
  aller weiteren Objekte eingesetzt wird. Er wurde, um alle
  Vorteile der Kollektionen ausnutzen zu k�nnen, von TObject
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
  Nun leiten wir davon zwei weitere S�tze ab: einen f�r
  pers�nliche Bekannte und einen f�r Kunden. Beide
  sollen unterschiedliche Datenfelder besitzen; da diese
  zus�tzlichen Felder statisch und nicht dynamisch sind,
  ben�tigen wir keinen zus�tzlichen Destruktor, sondern
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
  Die folgende Prozedur gibt alle Datens�tze auf dem Bildschirm
  aus. Sie benutzt dazu eine lokale FAR-Prozedur und die ForEach-
  Methode einer jeden Kollektion.
  Beachten Sie bitte, da� durch die Polymorphie der Objekte
  jeweils automatisch die �richtige� Ausgabe-Methode f�r jeden
  Datensazt gew�hlt wird.
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
  Eine globale Variable enth�lt die Kollektion, eine andere
  ben�tigen wir, um ein Datum zu erzeugen:
}

VAR Daten : PCollection;
    Datum : TDatum;

{
  Hauptprogramm:
  Es werden eine Kollektion und darin mit Insert drei Datens�tze
  erzeugt. Anschlie�end werden alle Daten angezeigt (AllesAusgaben),
  bevor die Kollektion wieder gel�scht wird.
}

BEGIN
  Daten := New (PCollection, Init (10, 5));

  Daten^.Insert (New (PAllgemein, Init ('Meier', '12345')));
  Daten^.Insert (New (PKunde, Init ('M�ller', '1122', 75000)));

  WITH Datum DO BEGIN
    Tag   := 22;
    Monat := 1;
    Jahr  := 59;
  END;

  Daten^.Insert (New (PBekannter, Init ('Uwe', '7788', Datum)));

  AllesAusgeben (Daten);

  Dispose (Daten, Done);
END.
