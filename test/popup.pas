PROGRAM PopupWindow;                          { POPUP.PAS }

USES WinTypes, WinProcs, OWindows, ODialogs;

CONST ID_Box   = 100;
      ID_Knopf = 101;

      ID_Popup = 102;     { Knopf, der Popup-Window auslöst }

TYPE TPopApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;

     PMainWin = ^TMainWin;     { Hauptfenster der Anwendung }

     TMainWin = OBJECT (TWindow)
       Knopf : PButton;

       CONSTRUCTOR Init (AParent : PWindowsObject;
                         ATitle : PChar);
       PROCEDURE   HandlePopup (VAR Msg : TMessage);
                   virtual ID_First + ID_Popup;
     END;

     PPopWin = ^TPopWin;                     { Popup Window }

     TPopWin = OBJECT (TWindow)
       Knopf : PButton;
       Box   : PListBox;

       CONSTRUCTOR Init (AParent : PWindowsObject;
                         ATitle : PChar);
       PROCEDURE   SetupWindow; virtual;
       PROCEDURE   HandleKnopf (VAR Msg : TMessage);
                   virtual ID_First + ID_Knopf;
     END;

{
  Methoden des Hauptfensters TMainWin:
}

CONSTRUCTOR TMainWin.Init (AParent : PWindowsObject;
                           ATitle : PChar);
BEGIN
  TWindow.Init (AParent, ATitle);

  {
    Erstellen des Kontrollobjekts:
  }

  Knopf := New (PButton, Init (@self, ID_Popup,
              'Popup-Window öffnen', 20, 20, 200, 30, true));
END;


PROCEDURE TMainWin.HandlePopup (VAR Msg : TMessage);
VAR PopupWin : PPopWin;
BEGIN
  PopupWin := New (PPopWin, Init (@self, 'Bitte wählen:'));
  Application^.MakeWindow (PopupWin);
END;

{
  neue Methode des TApplication-Nachfolgers TPopApp:
}

PROCEDURE TPopApp.InitMainWindow;
BEGIN
  MainWindow := New (PMainWin, Init (nil, 'Pop-Objekte'));
END;

{
  Methoden des Popup-Fensters. Sie wurden zum größten Teil
  dem zweiten Beispielprogramm aus dem Kapitel 7.2.3 entnommen.
}

CONSTRUCTOR TPopWin.Init (AParent : PWindowsObject;
                          ATitle : PChar);
BEGIN
  TWindow.Init (AParent, ATitle);

  {
    Popup- oder Kind-Fenster, die nicht gleichzeitig mit ihrem
    Parent auf dem Bildschirm erscheinen, sollten folgende
    Funktion innerhalb ihres Konstruktors aufrufen:
  }

  DisableAutoCreate;

  Attr.x := 80;
  Attr.y := 150;
  Attr.w := 250;
  Attr.h := 160;

  Attr.Style := ws_Popup or ws_Caption or ws_Visible;

  {
    Erstellen der Kontrollobjekte;
  }

  Box := New (PListBox, Init (@self, ID_Box,
                40, 15, 170, 70));

  Knopf := New (PButton, Init (@self, ID_Knopf,
               'Annehmen', 80, 90, 90, 30, true));
END;


PROCEDURE TPopWin.SetupWindow;
BEGIN
  TWindow.SetupWindow;

  Box^.AddString ('MS-DOS');
  Box^.AddString ('Windows');
  Box^.AddString ('OS/2');
  Box^.AddString ('UNIX');
  Box^.AddString ('Finder');
  Box^.AddString ('X-Window');

  Box^.SetSelIndex (0);
END;



PROCEDURE TPopWin.HandleKnopf (VAR Msg : TMessage);
BEGIN
  CloseWindow;         { Schließe das Popup-Fenster }
END;


VAR PopApp : TPopApp;

BEGIN
  PopApp.Init ('POPUPDEMO');
  PopApp.Run;
  PopApp.Done;
END.
