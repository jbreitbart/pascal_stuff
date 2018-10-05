PROGRAM Welcome2;

USES WinTypes, WinProcs, OWindows;

TYPE TWelcomeApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;


     PWelcomeWin = ^TWelcomeWin;

     TWelcomeWin = OBJECT (TWindow)
       CONSTRUCTOR Init (AParent : PWindowsObject; ATitle : PChar);
       PROCEDURE   Paint (PaintDC : HDC; VAR PaintInfo : TPaintStruct);
                   virtual;
     END;


PROCEDURE TWelcomeApp.InitMainWindow;
BEGIN
  MainWindow := New (PWelcomeWin, Init (nil, 'WILLKOMMEN!'));
END;


CONSTRUCTOR TWelcomeWin.Init (AParent : PWindowsObject; ATitle : PChar);
BEGIN
  TWindow.Init (AParent, ATitle);
  Attr.Style := Attr.Style or ws_VScroll or ws_HScroll;
  Scroller := New (PScroller, Init (@self, 8, 15, 35, 15));
END;


PROCEDURE TWelcomeWin.Paint (PaintDC : HDC; VAR PaintInfo : TPaintStruct);
VAR x1, y1, i : Integer;
BEGIN
  FOR i:=0 TO 30 DO
    TextOut (PaintDC, 10 + i * 20, 30 + i * 15, 'Willkommen!', 11);
END;


VAR WelcomeApp : TWelcomeApp;

BEGIN
  WelcomeApp.Init ('WILLKOMMEN');
  WelcomeApp.Run;
  WelcomeApp.Done;
END.