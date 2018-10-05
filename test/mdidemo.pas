PROGRAM MDIDemo;          {MDIDEMO.PAS}

{$R MDIDEMO.RES}

USES OWindows, WinTypes, WinProcs;

CONST ID_KreuzAn  = 100;
      ID_KreuzAus = 101;

TYPE TMDIApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;

     PMDIWin = ^TMDIWin;

     TMDIWin = OBJECT (TMDIWindow)
       CONSTRUCTOR Init (ATitle : PChar; AMenu : HMenu);
       PROCEDURE   SetupWindow; virtual;
       FUNCTION    InitChild : PWindowsObject; virtual;
     END;

     PChildWin = ^TChildWin;

     TChildWin = OBJECT (TWindow)
       Kreuz : Boolean;
       CONSTRUCTOR Init (AParent : PWindowsObject;
                   ATitle : PChar);
       PROCEDURE   KreuzAn (VAR Msg : TMessage);
                   virtual CM_First + ID_KreuzAn;
       PROCEDURE   KreuzAus (VAR Msg : TMessage);
                   virtual CM_First + ID_KreuzAus;
       PROCEDURE   Paint (PaintDC : HDC; VAR PaintInfo :
                   TPaintStruct);   virtual;
       PROCEDURE   WMMDIActivate (VAR Msg : TMessage);
                   virtual WM_First + WM_MDIActivate;
     END;

VAR Menu : HMenu;


PROCEDURE TMDIApp.InitMainWindow;
BEGIN
  Menu := LoadMenu (HInstance, 'MENUE');
    MainWindow := New (PMDIWin, Init ('MDI Demo-Anwendung', Menu));
END;


CONSTRUCTOR TMDIWin.Init (ATitle : PChar; AMenu : HMenu);
BEGIN
  TMDIWindow.Init (ATitle, AMenu);
  ChildMenuPos := 1;
END;

PROCEDURE TMDIWin.SetupWindow;
VAR Fenster : PChildWin;
BEGIN
  TMDIWindow.SetupWindow;
  Application^.MakeWindow (InitChild);
END;


FUNCTION TMDIWin.InitChild : PWindowsObject;
BEGIN
  InitChild := New (PChildWin, Init (@self, 'MDI-Kind'));
END;


CONSTRUCTOR TChildWin.Init (AParent : PWindowsObject;
                            ATitle : PChar);
BEGIN
  TWindow.Init (AParent, ATitle);
  Kreuz := true;
END;


PROCEDURE TChildWin.KreuzAn (VAR Msg : TMessage);
BEGIN
  {
    Variable Kreuz auf true setzen, anschließend
    Neuzeichnen des gesamten Client-Fensters
    veranlassen:
  }

  IF Kreuz = false THEN BEGIN
    Kreuz := true;
    InvalidateRect (HWindow, nil, true);

    {
      Im Menü Checkmark (Haken) bei An setzen, bei
      Aus löschen:
    }

    CheckMenuItem (Menu, ID_KreuzAn, mf_Checked);
    CheckMenuItem (Menu, ID_KreuzAus, mf_UnChecked);
  END;
END;


PROCEDURE TChildWin.KreuzAus (VAR Msg : TMessage);
BEGIN
  IF Kreuz = true THEN BEGIN
    Kreuz := false;
    InvalidateRect (HWindow, nil, true);

    CheckMenuItem (Menu, ID_KreuzAus, mf_Checked);
    CheckMenuItem (Menu, ID_KreuzAn, mf_UnChecked);
  END;
END;


PROCEDURE TChildWin.Paint (PaintDC : HDC; VAR PaintInfo :
                           TPaintStruct);
VAR Rect : TRect;
BEGIN
  GetClientRect (HWindow, Rect);

  WITH Rect DO BEGIN
    MoveTo (PaintDC, left, top);
    LineTo (PaintDC, right, bottom);

    IF Kreuz THEN BEGIN
      MoveTo (PaintDC, left, bottom);
      LineTo (PaintDC, right, top);
    END;
  END;
END;


PROCEDURE TChildWin.WMMDIActivate (VAR Msg : TMessage);
BEGIN
  IF Msg.LParamLo = HWindow THEN
    IF Kreuz THEN BEGIN
      CheckMenuItem (Menu, ID_KreuzAn, mf_Checked);
      CheckMenuItem (Menu, ID_KreuzAus, mf_UnChecked);
    END ELSE BEGIN
      CheckMenuItem (Menu, ID_KreuzAus, mf_Checked);
      CheckMenuItem (Menu, ID_KreuzAn, mf_UnChecked);
    END;
END;


VAR MDIApp : TMDIApp;

BEGIN
  MDIApp.Init('MDIApp');
  MDIApp.Run;
  MDIApp.Done;
END.
