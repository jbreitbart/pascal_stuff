PROGRAM MiniWindowsApp1;

USES OWindows;

TYPE TMyApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow;
                 virtual;
     END;

PROCEDURE TMyApp.InitMainWindow;
BEGIN
  MainWindow := New (PWindow, Init (nil, 'Mini-Applikation'));
END;

VAR  MiniApp : TMyApp;

BEGIN
  MiniApp.Init ('TEST');
  MiniApp.Run;
  MiniApp.Done;
END.
