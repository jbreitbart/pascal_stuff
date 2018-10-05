PROGRAM Kontrollobjekt2;

USES WinTypes, WinProcs, OWindows, ODialogs;

CONST ID_Box   = 100;
      ID_Knopf = 101;

TYPE TKontrollApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;


     PKontrollWin = ^TKontrollWin;

     TKontrollWin = OBJECT (TWindow)
       Knopf : PButton;
       Box   : PListBox;

       CONSTRUCTOR Init (AParent : PWindowsObject; ATitle : PChar);
       PROCEDURE   SetupWindow; virtual;
       PROCEDURE   HandleKnopf (VAR Msg : TMessage);
                   virtual ID_First + ID_Knopf;
     END;


PROCEDURE TKontrollApp.InitMainWindow;
BEGIN
  MainWindow := New (PKontrollWin, Init (nil, 'Kontroll-Objekte'));
END;


CONSTRUCTOR TKontrollWin.Init (AParent : PWindowsObject; ATitle : PChar);
BEGIN
  {
    Aufruf der Vorgänger-Methode:
  }

  TWindow.Init (AParent, ATitle);

  {
    Setzen der Anfangsgröße:
  }

  Attr.x := 50;
  Attr.y := 50;
  Attr.w := 250;
  Attr.h := 160;

  {
    Wir ändern das Aussehen des Fensters ein wenig, so daß
    keine Ränder mehr erscheinen. Eine Titelzeile (Caption)
    gibt es aber dennoch:
  }

  Attr.Style := ws_Overlapped or ws_Caption or ws_Visible;


  {
    Erstellen der Kontrollobjekte;
  }

  Box := New (PListBox, Init (@self, ID_Box,
                40, 15, 170, 70));

  Knopf := New (PButton, Init (@self, ID_Knopf,
               'Annehmen', 80, 90, 90, 30, true));
END;


PROCEDURE TKontrollWin.SetupWindow;
BEGIN
  {
    Vorgänger-Methode aufrufen:
  }

  TWindow.SetupWindow;

  {
    Auswahlbox mit Inhalt füllen:
  }

  Box^.AddString ('MS-DOS');
  Box^.AddString ('Windows');
  Box^.AddString ('OS/2');
  Box^.AddString ('UNIX');
  Box^.AddString ('Finder');
  Box^.AddString ('X-Window');

  {
    Setze den ersten Eintrag (Index 0) als Default-Auswahl:
  }

  Box^.SetSelIndex (0);
END;



PROCEDURE TKontrollWin.HandleKnopf (VAR Msg : TMessage);
VAR Auswahl : ARRAY [0..30] of Char;
BEGIN
  {
    Lies den aktuell selektierten String aus.
    Zeige dann eine Message-Box mit diesem String an.
  }

  Box^.GetSelString (Auswahl, 30);
  MessageBox (HWindow, Auswahl, 'Ihre Wahl:', mb_OK);

  {
    Anschließend soll unser MainWindow zerstört werden.
    Damit ist die Anwendung beendet.
  }

  CloseWindow;
END;


VAR KontrollApp : TKontrollApp;

BEGIN
  KontrollApp.Init ('KONTROLLDEMO');
  KontrollApp.Run;
  KontrollApp.Done;
END.
