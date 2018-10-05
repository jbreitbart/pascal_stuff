PROGRAM StreamDemo;

USES OWindows, Strings, Objects;

{
  Beispielobjekt, das im Stream gespeichert werden soll.
  Objekte, die in Sreams gespeichert werden sollen, müssen
  von TObject abgeleitet sein:
}

TYPE PBeispiel = ^TBeispiel;

     TBeispiel = OBJECT (TObject)
       Zahl : LongInt;

       CONSTRUCTOR Init  (ZahlPar : LongInt);
       CONSTRUCTOR Load  (VAR S : TStream);
       PROCEDURE   Store (VAR S : TStream);
     END;

{
  Der folgende Record legt die Daten fest, mit
  denen das Beispiel-Objekt registiert wird.
}

CONST RBeispiel : TStreamRec = (
        ObjType : 1000;
        VmtLink : Ofs (TypeOf (TBeispiel)^);
        Load    : @TBeispiel.Load;
        Store   : @TBeispiel.Store
      );


CONSTRUCTOR TBeispiel.Init (ZahlPar : LongInt);
BEGIN
  Zahl := ZahlPar;
END;


CONSTRUCTOR TBeispiel.Load (VAR S : TStream);
BEGIN
  S.Read (Zahl, SizeOf (Zahl));
END;


PROCEDURE TBeispiel.Store (VAR S : TStream);
BEGIN
  S.Write (Zahl, SizeOf (Zahl));
END;


VAR Stream : PBufStream;
    Objekt : PBeispiel;

BEGIN
  {
    Registrierung des Beispiel-Objekts:
  }

  RegisterType (RBeispiel);

  {
    Anlegen einer Objekt-Instanz
  }

  Objekt := New (PBeispiel, Init (12345678));

  {
    Öffnen eines gepufferten DOS-Streams.
    Dateiname TEST.DAT, Datei neu erstellen
    (stCreate), Puffergröße: 512 Bytes
  }
  Stream := New (PBufStream, Init ('TEST.DAT', stCreate, 512));

  Stream^.Put (Objekt);    { Objekt in den Stream schreiben }

  Dispose (Stream, Done);  { Stream schließen }
END.
