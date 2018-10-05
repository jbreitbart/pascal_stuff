PROGRAM Kontrollobjekt1;

USES WinTypes, WinProcs, OWindows, ODialogs;

CONST ID_Info  = 100;
      ID_Knopf = 101;

TYPE TKontrollApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;


     PKontrollWin = ^TKontrollWin;

     TKontrollWin = OBJECT (TWindow)
       Knopf : PButton;
       Info  : PStatic;

       CONSTRUCTOR Init (AParent : PWindowsObject; ATitle : PChar);
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
  Attr.h := 150;

  {
    Wir ändern das Aussehen des Fensters ein wenig, so daß
    keine Ränder mehr erscheinen. Eine Titelzeile (Caption)
    gibt es aber dennoch:
  }

  Attr.Style := ws_PopupWindow or ws_Caption or ws_Visible;

  {
    Erstellen der Kontrollobjekte;
  }

  Knopf := New (PButton, Init (@self, ID_Knopf, 'OK',
                80, 70, 90, 30, true));

  Info := New (PStatic, Init (@self, ID_Info,
               'Klicken Sie bitte auf OK!',
               45, 20, 160, 20, 28));

END;


PROCEDURE TKontrollWin.HandleKnopf (VAR Msg : TMessage);
BEGIN
  CloseWindow;
END;


VAR KontrollApp : TKontrollApp;

BEGIN
  KontrollApp.Init ('KONTROLLDEMO');
  KontrollApp.Run;
  KontrollApp.Done;
END.
