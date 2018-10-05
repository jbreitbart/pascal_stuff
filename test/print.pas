PROGRAM Print;

USES WinTypes, WinProcs, OWindows, Strings;

TYPE TPrintApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;


     PPrintWin = ^TPrintWin;

     TPrintWin = OBJECT (TWindow)
       CONSTRUCTOR Init (AParent : PWindowsObject; ATitle : PChar);
       PROCEDURE   Paint (PaintDC : HDC; VAR PaintInfo : TPaintStruct);
                   virtual;
       PROCEDURE   WMKeyDown (VAR Msg : TMessage);
                   virtual WM_First + WM_KeyDown;
     END;

{
  Es folgt eine Funktion, die ben�tigt wird, um w�hrend des
  Ausdrucks das Multitasking unter Windows aufrecht zu erhalten.
  Wir werden die Adresse dieser Routine per Escape-Funktion
  an Windows �bergeben, so da� w�hrend des Ausdrucks AbbruchProc
  immer wieder aufgerufen wird.
  AbbruchProc wuerde Ihnen sehr bekannt vorkommen, wenn Sie unter
  Turbo Pascal nicht die Annehmlichkeiten von ObjectWindows
  genie�en k�nnten. Es ist eine Nachrichtenschleife, die pr�ft,
  ob Nachrichten im System anliegen (PeekMessage) und sie dann
  an die Empf�nger verteilt (Dispatch). Nachrichten an andere
  Fenster k�nnen so auch w�hrend des Drucks verarbeitet werden.

  In nCode wird von Windows ein Fehlercode �bergeben:
     0 : kein Fehler
   <>0 : kein Platz auf der Festplatte
}


FUNCTION AbbruchProc (DC : HDC; nCode : Integer) : Boolean; far;
VAR Msg : TMsg;
BEGIN
  WHILE PeekMessage (Msg, 0, 0, 0, PM_REMOVE) DO BEGIN
    TranslateMessage (Msg);
    DispatchMessage (Msg);
  END;

  {
    Als Funktionswert geben wir true zur�ck. Dieser Wert wird von
    Windows ausgewertet, falls kein Speicher mehr auf der Platte
    frei war, der Druckertreiber seine Ausgabe also nicht auf die
    Platte schreiben konnte. In diesem Fall bedeutet true, da� der
    Druck trotzdem nicht abgebrochen werden soll - da wir ja
    Dank der Abbruchfunktion Multitasking haben, kann der Druck-
    manager die Ausgaben von Treiber (soweit schon fertig)
    ausgeben, und damit wird wieder Platz auf der Platte geschaffen.
  }

  AbbruchProc := true;
END;


PROCEDURE TPrintApp.InitMainWindow;
BEGIN
  MainWindow := New (PPrintWin, Init (nil, 'Drucker Testprogramm'));
END;


CONSTRUCTOR TPrintWin.Init (AParent : PWindowsObject; ATitle : PChar);
BEGIN
  TWindow.Init (AParent, ATitle);
  Attr.Style := Attr.Style or ws_VScroll or ws_HScroll;
  Scroller := New (PScroller, Init (@self, 8, 15, 35, 15));
END;


PROCEDURE TPrintWin.Paint (PaintDC : HDC; VAR PaintInfo : TPaintStruct);
BEGIN
  TextOut (PaintDC, 20, 20, 'Dr�cken Sie Taste f�r Ausgabe', 29);
END;

{
  Dr�ckt der Anwender eine Taste, erfolgt der eigentliche Ausdruck:
}

PROCEDURE TPrintWin.WMKeyDown (VAR Msg : TMessage);
VAR Eintrag   : ARRAY [0..64] of Char;
    Drucker,
    Treiber,
    Port      : PChar;
    PrinterDC : HDC;       { Display Context f�r Drucker }
    x, y, i   : Integer;   { Aufl�sung des Druckers }
    Font      : TLogFont;
    FHandle   : HFont;
    Abbruch   : TFarProc;  { Instanzenhandle der Abbruchfunktion }

BEGIN
  {
    Daten des Druckers aus WIN.INI holen. Der
    R�ckgabestring (Eintrag) sieht dann etwa so aus:
    HP DeskJet Familie,DESKJET,LPT1
    (Druckername, Treibername, Port)
  }

  GetProfileString ('windows', 'device', '', Eintrag, 64);

  {
    Zerlegen des Strings in seine drei Bestandteile:
  }

  Drucker := Eintrag;

  Treiber := StrScan (Drucker, ',');
  Treiber^ := #0;
  Inc (Treiber);

  Port := StrScan (Treiber, ',');
  Port^ := #0;
  Inc (Port);

  {
    Nun besorgen wir uns einen Display-
    Context f�r den Drucker:
  }

  PrinterDC := CreateDC (Treiber, Drucker, Port, nil);

  IF PrinterDC = 0
    THEN MessageBox (HWindow, 'Fehler beim Erzeugen eines DCs.',
                     'Druckerfehler!', mb_OK)
    ELSE BEGIN
      {
        Abbruchfunktion anmelden. Dazu wird zun�chst mit
        MakeProcInstance die Prozedurinstanzenadresse von
        AbbruchProc. Diese �bergeben wir dann per Escape-
        Funktion an Windows.
      }

      Abbruch := MakeProcInstance (@AbbruchProc, HInstance);
      Escape (PrinterDC, SETABORTPROC, 0, Abbruch, nil);

      {
        Auftrag beim Druckmanager anmelden:
      }

      Escape (PrinterDC, STARTDOC, 13, PChar ('Test-Ausdruck'), nil);

      {
        Bestimmen der Aufl�sung des Druckers.
        Anschlie�end sichern wir die bisherigen
        Einstellungen des Display-Contextes mit
        SaveDC. So ersparen wir uns das einzelne
        Sichern jedes ge�nderten Wertes.
      }

      x := GetDeviceCaps (PrinterDC, HORZRES);
      y := GetDeviceCaps (PrinterDC, VERTRES);

      SaveDC (PrinterDC);

      {
        Zun�chst wollen wir eine Linie diagonal �ber das ganze
        Blatt ziehen:
      }

      MoveTo (PrinterDC, 50, 100);
      LineTo (PrinterDC, x-50, y-100);

      {
        Wir erzeugen f�r die Ausgabe einen neuen Font,
        der etwas gr��er ist.
      }

      WITH Font DO BEGIN
        lfHeight := 400;    { nun ja, ETWAS gr��er halt :-) }
        lfWidth := 0;
        lfEscapement := 0;
        lfOrientation := 0;
        lfWeight := fw_Bold;
        lfItalic := 0;
        lfUnderline := 0;
        lfStrikeOut := 0;
        lfCharSet := ANSI_Charset;
        lfOutPrecision := Out_Stroke_Precis;
        lfClipPrecision := Clip_Default_Precis;
        lfQuality := Proof_Quality;
        lfPitchAndFamily := Variable_Pitch or ff_Roman;
        StrCopy (@lfFaceName, 'Tms Rmn');
      END;

      FHandle := CreateFontIndirect (Font);
      SelectObject (PrinterDC, FHandle);

      SetTextAlign (PrinterDC, ta_Center);

      {
        Die Textausgabe f�hren wir neun mal durch, jedesmal leicht
        versetzt. Der eingesetzte Vektorfont besteht n�mlich sonst
        nur aus ein paar Strichen. Ausgef�llt sieht die Schrift
        sch�ner aus:
      }

      FOR i:=0 TO 8 DO
        TextOut (PrinterDC, x DIV 2 + i, 200 + i DIV 3, 'Hallo!', 6);

      {
        Dann holen wir die gesicherten Einstellungen wieder zur�ck.
        Den Font brauchen wir auch nicht mehr.
      }

      RestoreDC (PrinterDC, -1);
      DeleteObject (FHandle);

      {
        Seitenvorschub und Ende des Drucks:
      }

      Escape (PrinterDC, NEWFRAME, 0, nil, nil);
      Escape (PrinterDC, ENDDOC, 0, nil, nil);

      {
        Schlie�lich den Display Context wieder freigeben:
      }

      DeleteDC (PrinterDC);
    END;
END;


VAR PrintApp : TPrintApp;

BEGIN
  PrintApp.Init ('DRUCKER');
  PrintApp.Run;
  PrintApp.Done;
END.
