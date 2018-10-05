PROGRAM Welcome1;

USES WinTypes, WinProcs, OWindows;

TYPE TWelcomeApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;


     PWelcomeWin = ^TWelcomeWin;

     TWelcomeWin = OBJECT (TWindow)
       PROCEDURE Paint (PaintDC : HDC; VAR PaintInfo : TPaintStruct);
                 virtual;
     END;


PROCEDURE TWelcomeApp.InitMainWindow;
BEGIN
  MainWindow := New (PWelcomeWin, Init (nil, 'WILLKOMMEN!'));
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
